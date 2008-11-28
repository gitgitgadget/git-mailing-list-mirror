From: "Reece Dunn" <msclrhd@googlemail.com>
Subject: Re: C# Git Implementation
Date: Fri, 28 Nov 2008 13:45:00 +0000
Message-ID: <3f4fd2640811280545m21302134mbde19b074967afc6@mail.gmail.com>
References: <001501c9515e$66e8ac70$34ba0550$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "JD Guzman" <jd@jdguzman.com>
X-From: git-owner@vger.kernel.org Fri Nov 28 14:46:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L63fo-0001I3-Pv
	for gcvg-git-2@gmane.org; Fri, 28 Nov 2008 14:46:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691AbYK1NpD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Nov 2008 08:45:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751528AbYK1NpD
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Nov 2008 08:45:03 -0500
Received: from wf-out-1314.google.com ([209.85.200.175]:6499 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254AbYK1NpB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Nov 2008 08:45:01 -0500
Received: by wf-out-1314.google.com with SMTP id 27so1462482wfd.4
        for <git@vger.kernel.org>; Fri, 28 Nov 2008 05:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=G5Zy3j+JanWna5omUtwVt9gdVRAlV9YQjS9A1chaI9A=;
        b=l+7ivRnCx+UG320RVhJNBhW6PoaGE+glxkk9BMbv/9/hxXHy4pjQnhindDfx6nygPg
         NaRJFrKjskyg6tI47vg5+geSF8EFH+6uc1hBsg2oLzUYyqy8hCqYevlt8bAyQHGgco8O
         56KhFoaO3pYQ2eicrLeFYL2zbwjP6dlFtjRfs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=mkaF2/ldXZ09ehcKAPn9eVqZJICCuBwv83wCaFIRO3OztERXEG0HOTuJ2UMeGdnLtp
         l4lywoYa3XQS0MbuwlqwcOUwpwy3lcSIfilI5rPhaD+OYjwUT8q7obvepffaNAbsVjgi
         VaHJs/0yMIzkZGFCeK2XP7kgQIujXUC/RoIZI=
Received: by 10.142.187.8 with SMTP id k8mr3364642wff.48.1227879900370;
        Fri, 28 Nov 2008 05:45:00 -0800 (PST)
Received: by 10.142.161.21 with HTTP; Fri, 28 Nov 2008 05:45:00 -0800 (PST)
In-Reply-To: <001501c9515e$66e8ac70$34ba0550$@com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101876>

2008/11/28 JD Guzman <jd@jdguzman.com>:
> I read in the archives that there was once talk of porting Git over to C#
> and was wondering if anything ever came of this?  I realize there were some
> that didn't see the use for this but as Git is becoming more and more
> popular a more native implementation of Git for windows users would be a
> good endevour IMHO.

There were several efforts made, but these have fallen by the wayside.

Since then, the mingw/msys port has made progress to the point where
git will use native calls. Most - if not all of this - has been merged
back into upstream git as of version 1.6.

Git works well on Windows and msysGit even provides a native installer
that installs the necessary companion tools and libraries.

Therefore, there is already a native version of Git for Windows that
is always up-to-date with the latest Git functionality (since it is
the same sourcecode!)

BTW: Kudos to everyone involved in the Windows port.

- Reece
