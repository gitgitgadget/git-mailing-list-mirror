From: "pradeep singh rautela" <rautelap@gmail.com>
Subject: Re: Why does git track directory listed in .gitignore/".git/info/exclude"?
Date: Wed, 23 Jan 2008 19:34:19 +0530
Message-ID: <6bc632150801230604p2589c893pa05bb6f27e482de8@mail.gmail.com>
References: <6bc632150801230554l3b24e1e4lb4641bf7c16857c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 23 15:05:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHgDk-0001sM-9j
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 15:04:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbYAWOEW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 09:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbYAWOEW
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 09:04:22 -0500
Received: from wx-out-0506.google.com ([66.249.82.234]:61122 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbYAWOEV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2008 09:04:21 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1661154wxd.4
        for <git@vger.kernel.org>; Wed, 23 Jan 2008 06:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=hKhpl2NtoZttrp9sGI3EfvpFGCX7c5V1q5l+uozyzlQ=;
        b=cqs9aVyC7TVFuXD5pVGSyQm8Ho4bmspdky2a/2UfCA3Lt7WFxrSUE5HYsYHNwLNxxlqI/hiOiYYld4AT/TlijjpiLWvJeQJ4S11Q6Nl4aFdvZQGYhSfPdTPtl72aw9leqoI23zhhYMNqfA8PHh/iSQjPUveG9ZORqNKFCt2DmtQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YH/Yk2yUMeLhAhsP7oPGvamKP4VG47j2bNdiWCnBk9woXby8bmS6hVRqfPGWvtD+/sYNdHwxSO2+KnT0ZEo0z5Y9Ei01YXDlkEeyU3bm0IFZL9oBMZixjb4svjVZXVOCQy9HIvnFbZHe27sfQlc9Nw2CKdQqyzjIJUPEEJXa8JM=
Received: by 10.142.154.20 with SMTP id b20mr4911319wfe.13.1201097059944;
        Wed, 23 Jan 2008 06:04:19 -0800 (PST)
Received: by 10.142.102.10 with HTTP; Wed, 23 Jan 2008 06:04:19 -0800 (PST)
In-Reply-To: <6bc632150801230554l3b24e1e4lb4641bf7c16857c0@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71542>

Apologies to all.Kindly pardon my novice experiments with git.
Some more trial and error method led to find that you have to put a *
at the end of the directory too.
i.e xen-3.1.0-src/*

But i still would like to ask git gurus here.
Isn't it fine to include a directory name as

   $directory_name/
    instead of
   $directory_name/*

?
Thoughts?

Thanks,
          --Pradeep
On 23/01/2008, pradeep singh rautela <rautelap@gmail.com> wrote:
> Hi All,
>
> I have an source directory, which in turn has some other directories too.
> I do not want to track one of these directories.
> So i added the directory name in .gitignore as well as in
> .git/info/exclude for my repo.
>
> i.e i have added following line to both of them -
> xen-3.1.0-src/
>
> I copied xen-3.1.0-src from archives in the git repo's base directory.
>
> Now when i do a git-status i get
> # On branch master
> # Untracked files:
> #   (use "git add <file>..." to include in what will be committed)
> #
> #       xen-3.1.0-src/
> nothing added to commit but untracked files present (use "git add" to track)
>
> Why is git seeing xen-3.1.0-src directory at all?
> Is this the expected behaviour?
>
> I thought i should not get this message after adding relevant entries
> in .gitignore or in info/exclude .
>
> What am i doing wrong here?
> Is there a way that this can be done without having to witness this
> message everytime i do a git status?
>
> Please CC me as I am not subscribed to the list.
>
> Thanks,
>          ~Pradeep
> --
> --
> pradeep singh rautela
> http://eagain.wordpress.com
> http://emptydomain.googlepages.com
>


-- 
--
pradeep singh rautela
http://eagain.wordpress.com
http://emptydomain.googlepages.com
