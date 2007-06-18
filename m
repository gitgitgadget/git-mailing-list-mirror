From: Arkadiusz Miskiewicz <arekm@maven.pl>
Subject: Re: [ANNOUNCE] GIT 1.5.2.2
Date: Mon, 18 Jun 2007 08:35:57 +0200
Organization: SelfOrganizing
Message-ID: <200706180835.57344.arekm@maven.pl>
References: <7vodjf1gxl.fsf@assigned-by-dhcp.pobox.com> <200706180821.59582.arekm@maven.pl> <20070618062902.GL18491@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jun 18 08:36:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0AqO-00064T-Qm
	for gcvg-git@gmane.org; Mon, 18 Jun 2007 08:36:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756256AbXFRGgG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 18 Jun 2007 02:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755957AbXFRGgF
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jun 2007 02:36:05 -0400
Received: from main.carme.maven.pl ([193.239.45.138]:14044 "EHLO
	main.carme.maven.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756028AbXFRGgE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Jun 2007 02:36:04 -0400
Received: from [83.238.65.58] (helo=[192.168.1.157] ident=matrix157)
	by main.carme.maven.pl with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
	(Exim 4.66)
	(envelope-from <arekm@maven.pl>)
	id 1I0AqF-0002nw-7X; Mon, 18 Jun 2007 08:35:59 +0200
User-Agent: PLD Linux KMail/1.9.7
In-Reply-To: <20070618062902.GL18491@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50384>

On Monday 18 of June 2007, Shawn O. Pearce wrote:
> Arkadiusz Miskiewicz <arekm@maven.pl> wrote:
> > On Monday 18 of June 2007, Shawn O. Pearce wrote:
> > > Arkadiusz Miskiewicz <arekm@maven.pl> wrote:
> > > > * FAIL 16: corrupt a pack and see if verify catches
> > > >         cat test-1-${packname_1}.idx >test-3.idx &&
> > > >              cat test-2-${packname_2}.pack >test-3.pack &&
> > >
> > > Hmm.  That is t5300-pack-objects.sh.
> >
> > If anyone is interested in debugging that problem then I can give s=
sh
> > access to this machine.
>
> How about we start with the output of:
>
>   cd t && ./t5300-pack-objects.sh -v
>
> ?  That should be a lot more verbose, as it will include the
> commands we are running and their stdout/stderr.  Sometimes fun
> details about broken tools can be easily obtained from that output.

The reason was... missing /dev/zero! :-) Mystery solved, thanks!

--=20
Arkadiusz Mi=B6kiewicz        PLD/Linux Team
arekm / maven.pl            http://ftp.pld-linux.org/
