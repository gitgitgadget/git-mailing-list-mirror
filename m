From: Dilip M <dilipm79@gmail.com>
Subject: Re: Installing full fledged git on solaris?
Date: Sun, 11 Oct 2009 18:27:47 +0530
Message-ID: <c94f8e120910110557q764dbf19s33c52e7f5120662@mail.gmail.com>
References: <c94f8e120910110526r68e4abe1l269dc4b3ab22bac3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 11 15:03:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mwy4F-0006PH-SZ
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 15:02:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757162AbZJKM6o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2009 08:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754323AbZJKM6o
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 08:58:44 -0400
Received: from mail-pz0-f188.google.com ([209.85.222.188]:48892 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753946AbZJKM6n (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 08:58:43 -0400
Received: by pzk26 with SMTP id 26so7407693pzk.4
        for <git@vger.kernel.org>; Sun, 11 Oct 2009 05:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:content-type;
        bh=MilOysQ33aFNlR3qPXhondMugmh4xM8HJc3fPq4vdLY=;
        b=d9A6FGSzrWu4vYk4MykmijtUtkhD9KFA7mKwqKZ4ReQK4WnjzrRaevN1cjWl1cxRRp
         cK8wW51ueiWhCAAgR0rbi4WcdPKvewhfwnAsAYpkG9Fw7FIb6rcLT8z//qvPn3TRnAQi
         6yuRStqj9Ay3UG0vanSSjuO7SEF2yRXRj/6gw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        b=qvoeGYDA2k/qb9Tj+2+hJGkTikURC6TwE1ixel/noHH5qabwU12zgrtityBW+ZYUSu
         i6ySdBI4J3z3ifLMJldkRaLUInJ/HAPnTVNPR6UhhNgJDm7F21hk+JSLmDoJ6Cde0wSR
         179rj48RrDts9QrRwDBPInlAm8xclWY9gv/Zc=
Received: by 10.140.170.5 with SMTP id s5mr377507rve.6.1255265887320; Sun, 11 
	Oct 2009 05:58:07 -0700 (PDT)
In-Reply-To: <c94f8e120910110526r68e4abe1l269dc4b3ab22bac3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129919>

On Sun, Oct 11, 2009 at 5:56 PM, Dilip M <dilipm79@gmail.com> wrote:
> Hello,
>
>
> Has anyone has the list of pkg's to be installed on solaris 10 sparc,
> to get the GIT compiled (with all features)..
>
> thanks in advance for sharing...

Trying to compile the latest version exit with this error

    CC xdiff/xpatience.o
    AR xdiff/lib.a
    LINK git-fast-import
Undefined                       first referenced
 symbol                             in file
libiconv_close                      libgit.a(utf8.o)
libiconv_open                       libgit.a(utf8.o)
libiconv                            libgit.a(utf8.o)
ld: fatal: Symbol referencing errors. No output written to git-fast-import
collect2: ld returned 1 exit status
gmake: *** [git-fast-import] Error 1


-- 
Dilip
