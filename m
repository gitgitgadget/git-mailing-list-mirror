From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Deleting remote branch pointed by remote HEAD
Date: Wed, 21 Jan 2009 14:52:07 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngnedkm.apk.sitaramc@sitaramc.homelinux.net>
References: <e29894ca0901210502n1ed1187bm46669a402ab4fe48@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 21 15:54:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPeT7-0001BR-L6
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 15:54:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755558AbZAUOwY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Jan 2009 09:52:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755140AbZAUOwX
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 09:52:23 -0500
Received: from main.gmane.org ([80.91.229.2]:58809 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755245AbZAUOwW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 09:52:22 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LPeRF-0007s1-Ql
	for git@vger.kernel.org; Wed, 21 Jan 2009 14:52:18 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Jan 2009 14:52:17 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Jan 2009 14:52:17 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106614>

On 2009-01-21, Marc-Andr=E9 Lureau <marcandre.lureau@gmail.com> wrote:

> I deleted a remote branch which was pointed by HEAD, this way: "git
> push origin :master"
>
> Then for almost every git command, I get this error: "error:
> refs/remotes/origin/HEAD points nowhere!".
>
> I found this situation non-friendly. Fortunately, I could understand
> what's going on. But a new user might be confused.

That's a pretty advanced command for a beginner.  I have
people who're only using the GUI (in the presumption that it
will be less confusing or less powerful or whatever) and
have managed to right click on a remote branch, choose
"checkout this branch" and have made commits on it without
knowing they're not on any branch!

I wish I had your problem :-)
