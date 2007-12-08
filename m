From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: git-bisect feature suggestion: "git-bisect diff"
Date: Sat, 8 Dec 2007 06:36:12 +0100
Message-ID: <200712080636.12982.chriscool@tuxfamily.org>
References: <20071207093439.GA21896@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Sat Dec 08 06:30:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0sGV-0002v7-RG
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 06:30:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752418AbXLHF3y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Dec 2007 00:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752245AbXLHF3y
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 00:29:54 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:57033 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752203AbXLHF3x convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Dec 2007 00:29:53 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 8EF391AB2B5;
	Sat,  8 Dec 2007 06:29:49 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 6000E1AB2B3;
	Sat,  8 Dec 2007 06:29:49 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <20071207093439.GA21896@elte.hu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67518>

Le vendredi 7 d=E9cembre 2007, Ingo Molnar a =E9crit :
> would be nice to have:
>
>  git-bisect diff
>
> that enables one to have a look at the currently open bisection windo=
w,
> in git-log -p format. This would often be much faster to analyze than
> looking at git-bisect visualize. (and it could also be used in non-GU=
I
> workflows)
>
> Right now i have this silly git-bisect-diff script:
>
> git-log -p "`git-bisect log | grep good | tail -1 | cut -d' ' -f3`"..=
"\
> `git-bisect log | grep bad | tail -1 | cut -d' ' -f3`"
>

Tell us if you have other scripts or suggestions related to git-bisect.

And thanks for you kind word about it:

http://thread.gmane.org/gmane.linux.kernel.input/3740/focus=3D3764

Christian.
