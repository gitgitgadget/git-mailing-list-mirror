From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH RESEND] gitk: add "--no-replace-objects" option
Date: Sun, 27 Dec 2009 18:26:18 +0100
Message-ID: <200912271826.19058.chriscool@tuxfamily.org>
References: <20091212045240.4249.66874.chriscool@tuxfamily.org> <20091213230923.GB8135@brick.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	bill lam <cbill.lam@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Junio C Hamano <gitster@pobox.com>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Dec 27 18:23:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NOwqL-0001Sc-I3
	for gcvg-git-2@lo.gmane.org; Sun, 27 Dec 2009 18:23:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752584AbZL0RXp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Dec 2009 12:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752580AbZL0RXo
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Dec 2009 12:23:44 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:48506 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752516AbZL0RXo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Dec 2009 12:23:44 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 8874681811B;
	Sun, 27 Dec 2009 18:23:33 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id E4762818096;
	Sun, 27 Dec 2009 18:23:30 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <20091213230923.GB8135@brick.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135707>

On lundi 14 d=E9cembre 2009, Paul Mackerras wrote:
> On Sat, Dec 12, 2009 at 05:52:39AM +0100, Christian Couder wrote:
> > Replace refs are useful to change some git objects after they
> > have started to be shared between different repositories. One
> > might want to ignore them to see the original state, and
> > "--no-replace-objects" option can be used from the command
> > line to do so.
> >
> > This option simply sets the GIT_NO_REPLACE_OBJECTS environment
> > variable, and that is enough to make gitk ignore replace refs.
> >
> > The GIT_NO_REPLACE_OBJECTS is set to "1" instead of "" as it is
> > safer on some platforms, thanks to Johannes Sixt and Michael J
> > Gruber.
> >
> > Tested-by: Michael J Gruber <git@drmicha.warpmail.net>
> > Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>
> Thanks, applied.

Thanks, but it looks like the patch is not in v1.6.6.
Could you ask Junio to pull from you?

Best regards,
Christian.
