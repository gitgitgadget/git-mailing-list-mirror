From: Drew Northup <drew.northup@maine.edu>
Subject: Re: git show and the --quiet option
Date: Thu, 02 Jun 2011 14:26:09 -0400
Message-ID: <1307039169.28941.35.camel@drew-northup.unet.maine.edu>
References: <4DE12888.1040506@isy.liu.se>
	 <20110528172611.GB28708@centaur.lab.cmartin.tk>
	 <7vhb8eprcb.fsf@alter.siamese.dyndns.org>
	 <20110530093259.GA2990@bee.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Gustaf Hendeby <hendeby@isy.liu.se>, git@vger.kernel.org
To: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Thu Jun 02 20:26:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSCbf-00022b-IN
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 20:26:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754498Ab1FBS0v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Jun 2011 14:26:51 -0400
Received: from basalt.its.maine.edu ([130.111.32.66]:54583 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754188Ab1FBS0t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2011 14:26:49 -0400
Received: from [IPv6:2610:48:100:827::97] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827::97])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id p52IQD1q025215
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 2 Jun 2011 14:26:18 -0400
In-Reply-To: <20110530093259.GA2990@bee.lab.cmartin.tk>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-URT-Metrics: basalt.its.maine.edu 1060; Body=4 Fuz1=4 Fuz2=4
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p52IQD1q025215
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1307643979.2062@V1UljWMNtsgcbdu42wVvow
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174967>


On Mon, 2011-05-30 at 11:32 +0200, Carlos Mart=C3=ADn Nieto wrote:
> On Sat, May 28, 2011 at 12:17:40PM -0700, Junio C Hamano wrote:
> > Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
> >=20

> > How does this patch look?
> >=20
> > It does not fix "git show master~10 master^..master", but instead o=
f just
> > hijacking and ignoring the --quiet option like your patch did, it a=
ctually
> > flips the option the user wanted to affect from the command line.
>=20
> It's fine if that's what we want to do. The reason I blocked --quiet
> instead of converting it to -s is because it seemed less surprising
> than passing --quiet and still getting output (if I pass --quiet, I'd
> expect the application to really be quiet), which doesn't happen in
> the commands that accept --quiet on purpose. Then again, the log
> family doesn't make any sense without any output, so if you argue tha=
t
> way, --quiet means "quieter", which makes the interface less
> consistent, but I don't feel that strongly about it

There's a lot of stuff out there for which --quiet does not imply
--silent. I side with Junio on the solution.

--=20
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
