From: "Jonas Fonseca" <jonas.fonseca@gmail.com>
Subject: Re: Newbie questions regarding jgit
Date: Tue, 11 Nov 2008 22:37:40 +0100
Message-ID: <2c6b72b30811111337v2fe23c75v25251838f721a007@mail.gmail.com>
References: <4919EECB.7070408@wellfleetsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Farrukh Najmi" <farrukh@wellfleetsoftware.com>
X-From: git-owner@vger.kernel.org Tue Nov 11 22:39:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L00wr-0005mK-WF
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 22:38:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751655AbYKKVhq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 16:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752003AbYKKVho
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 16:37:44 -0500
Received: from mu-out-0910.google.com ([209.85.134.184]:35524 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751467AbYKKVhn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 16:37:43 -0500
Received: by mu-out-0910.google.com with SMTP id g7so77778muf.1
        for <git@vger.kernel.org>; Tue, 11 Nov 2008 13:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=4gk9Hsug7+IXlXuBCa2XipniCfjw9uFTCYkgfUwtYJc=;
        b=FISKKUxucYN2i8VtWy26nun+dKPsaiTHfJlFiS22M0zEcBa62dBqxPirOALre6ZcGz
         qUGR91wPHoaiCQwfDlKiscKTGMnBZedfn0g6PqH+kl5OVDm4ba7Oj3xTWrmEInGBhLW6
         nq4S21pYlaOB9Y13kQFCxFIymf4pCxRY0u+Aw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=jmxuSnL4+NI1ZDTwYHuClOYQXYEh6V/Uh0MWvij0yHwvTAk7UYjuFKN41OxVzFiZxE
         UTqHwXhKl1Wlklnrq9WrVfbrTuIuEvmD7rEz1ygoodQmc8CWkk4QsbZ3ZmVBfVE9EQ0M
         SnNzSMyN6drXVdfKrbK6z6v32KNIa5PdZDTMM=
Received: by 10.181.216.12 with SMTP id t12mr2636947bkq.122.1226439460897;
        Tue, 11 Nov 2008 13:37:40 -0800 (PST)
Received: by 10.181.232.9 with HTTP; Tue, 11 Nov 2008 13:37:40 -0800 (PST)
In-Reply-To: <4919EECB.7070408@wellfleetsoftware.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100682>

On Tue, Nov 11, 2008 at 21:44, Farrukh Najmi
<farrukh@wellfleetsoftware.com> wrote:
> Hi all,

Hello,

> I am git newbie and looking to use jgit in a servlet endpoint.

Sounds interesting. I have been thinking about how hard it would be to
write a very simpe jgitweb kind of thing and am very interested to
hear more about your experiences.

> Where can I find a public maven repo for gjit? It seems there is one
> somewhere because of the following file in src tree:

I would also like to have a public available maven repository for
JGit. If Shawn or Robin acks, I can look into hosting one in the SVN
area of the Google Code project page. Given the lack of a real release
cycle it probably only makes sense to have a snapshot repository.

> Now I am wondering where to begin to learn how to do the equivalent of the
> following commands via the gjit Java API:
>
>   * git add /file/
>   * git rm /file/
>   * git mv /file
>   * Whatever is the git way to get a specific version of a file

JGit currently has two APIs for working with the index, which will
allow you to add, remove and move data around in the tree. In nbgit I
ended up using GitIndex, which I found easier to figure out. As I
understand it, in the long run you want to use the DirCache API, but
it is still a work in progress.

> I am hoping that there aremore docs, samples, tutorials etc. somewhere that
> I am missing. Thanks for any help you can provide. Some pointers or code
> fragments would be terrific.

I started working on a tutorial for JGit, but didn't get very far so
it mostly consists of stub pages.

 - http://code.google.com/docreader/#p=egit&s=egit&t=JGitTutorial

I have been working on moving the tutorial to maven project before
starting to write the more code heavy topics. This would make it
possible to include code snippets in the tutorial, while also allowing
to compile and test the examples.

-- 
Jonas Fonseca
