From: Johan Herland <johan@herland.net>
Subject: Re: How to ignore changes on remote
Date: Tue, 23 Mar 2010 19:02:35 +0100
Message-ID: <201003231902.35962.johan@herland.net>
References: <26ae428a1003230654m50c35caci4a02e2df321f289c@mail.gmail.com> <201003231820.51618.johan@herland.net> <hoaus7$3br$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 23 19:02:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nu8RM-0007Br-T8
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 19:02:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754079Ab0CWSCv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Mar 2010 14:02:51 -0400
Received: from smtp.opera.com ([213.236.208.81]:58812 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754065Ab0CWSCu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Mar 2010 14:02:50 -0400
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o2NI2ah1010488
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 23 Mar 2010 18:02:42 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <hoaus7$3br$1@dough.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143039>

On Tuesday 23 March 2010, Jakub Narebski wrote:
> Johan Herland wrote:
> > I'm rolling out Git at my $DAYJOB to a few hundred developers, and
> > I instruct them to
> >
> > =A0=A0=A0=A0=A0=A0=A0=A0git config --global push.default tracking
> >
> > immediately after installing Git. Which sucks, but is the only sane
> > thing I can do to prevent this problem from haunting us.
>
> Why not have administrator use
>
>          git config --system push.default tracking
>
> once (and/or setup skeleton for /etc/gitconfig)?

Because developers administer their own machines.


=2E..Johan

--=20
Johan Herland, <johan@herland.net>
www.herland.net
