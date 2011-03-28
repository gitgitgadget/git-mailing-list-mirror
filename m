From: Joshua Juran <jjuran@gmail.com>
Subject: Re: Reduce number of changes to pack file.
Date: Mon, 28 Mar 2011 06:29:34 -0700
Message-ID: <3400B460-E01F-477C-AB14-5593BBF39419@gmail.com>
References: <AANLkTikqaD7QPCCw86OgGvCHLz1ySu5CzQXoY2rAojxB@mail.gmail.com> <AANLkTimFKGrSCgBShtERaGfd=9y+=q-aHsN3u5Lvf52v@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Chandra Sukiman <tmcchandra@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 15:29:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4CVt-0006zi-E8
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 15:29:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753906Ab1C1N3k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 09:29:40 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33632 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753156Ab1C1N3j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 09:29:39 -0400
Received: by iwn34 with SMTP id 34so3667724iwn.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 06:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        bh=mT1/CdBB9eyf6Zu9PAP83VdQc0CFOpEbMkfj5QvaySA=;
        b=mrqs9ahIqOlAbhIy9tEbKb9Snby9nXbL4p5ltQdBPU6dRBemmh2vSqItN2VGlJ7TBD
         nofp8YeLM0qLOpMHam8pmjPiWUEKjJgkB+Y0bDPvqIvXLY3/90XYqNjlVGHMSSKwnksY
         lBl7JBRVxcZhW23T9w7GRVC9fKFL9xoJw9AKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=Di0PVbKHaExluk9toJ4EbA79s9HA23TPHiXBgMfcq33+EU/cT310+n6B06BbUQJSoc
         q9vhfh1cNPi5NFHFM85ji/690e4i5SLrC0TAnB3A8MldrW51mM5dfNFtI4xYQM5hAQyV
         CFzXyezluBH8tfQaP3/uEPyN22YoUotwyN68Q=
Received: by 10.42.139.195 with SMTP id h3mr1495801icu.445.1301318978486;
        Mon, 28 Mar 2011 06:29:38 -0700 (PDT)
Received: from zaphod.jjuran.dyndns.org (c-71-227-175-60.hsd1.wa.comcast.net [71.227.175.60])
        by mx.google.com with ESMTPS id g4sm2823036ick.23.2011.03.28.06.29.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Mar 2011 06:29:36 -0700 (PDT)
In-Reply-To: <AANLkTimFKGrSCgBShtERaGfd=9y+=q-aHsN3u5Lvf52v@mail.gmail.com>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170125>

On Mar 27, 2011, at 8:33 PM, Chandra Sukiman wrote:

> I am using git with Dropbox (see
> http://stackoverflow.com/questions/1960799/using-gitdropbox-together-effectively) 
> .

I don't see how this can end any way other than in pain.

> As the repository size is getting bigger, sometime during the git gc,
> it will create a huge .pack file (300 mb) which need to be uploaded
> and downloaded by everyone.

Thank you for making my point for me. :-)

> I tried to limit the size of the pack to 10m (pack.packSizeLimit =
> 10m), but when doing gc, what happens now is that most of the pack
> files will get re-arranged and modified. This will cause the same
> upload/download issue that I want to solve.

:-)

> Is there any way for git gc to reduce the number of file changed?

I'm going to answer a completely different question:  "Where should I  
host my Git repo?".  The answer is, on (a) one of the free hosting  
services like GitHub (if your project is public), (b) one of the pay  
services (like GitHub), or (c) your own Unix server.  I use (a) and (c).

You shouldn't be hosting a Git repository on a file-based  
synchronization service.  It's asking for trouble.

Josh
