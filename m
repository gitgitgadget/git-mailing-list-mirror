From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: git pull crash
Date: Fri, 11 Jul 2014 13:39:31 +0200
Message-ID: <53BFCCF3.6050708@web.de>
References: <53BFC147.5000509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ronald Bos <ronald.bos.msc@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 11 13:39:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5ZAz-0002m5-Ig
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 13:39:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751943AbaGKLjh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 07:39:37 -0400
Received: from mout.web.de ([212.227.17.11]:65403 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751573AbaGKLjg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 07:39:36 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0MTPel-1XCPAp29Q7-00SMH7; Fri, 11 Jul 2014 13:39:32
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53BFC147.5000509@gmail.com>
X-Provags-ID: V03:K0:2DJuqLlyeyTrWTqCdbi+5BeilIFsx7k4F8VVRIY/KvxKKpGG04r
 zc53OeltyWlbLlK6fkQG1oLsFNB5v9kSsi8I7ANFMr0HgsAN6Y+Ih5iLbT8W2ANJuulJzC5
 llspl0iXWFLTHQEDqQ67QczZGTFfkm/rIiH4lNS3T2nIkbpjFkI4dY3RH/7LhGhfTfihRAZ
 UoSlsapg8Xnk5SyeVSiuA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253274>

On 2014-07-11 12.49, Ronald Bos wrote:
> Hi all,
> 
> I am running git on Windows 8.1 (with all the latest updates installed), and it consequently crashes when I run "git pull" in my cloned working copy.
> 
> I attached a screen shot of the message window (it is in Dutch...)
> 
> This is my git version:
> $ git --version
> git version 1.9.4.msysgit.0
> 
> Is this a known problem? 
I don't know. It may that your repo is triggering a bug which has been fixed
on a later base-line, or it is unfixed because nobody had the very same problem yet.
>Is there something I can do to help find out what is causing the problem?
Try to send what the screen shot does in text, after translating it into english.
Not everybody understands Dutch (or wants to open attachments)


I can think about 2 different things:
- Back up the repo into which you want to pull into, so that the scanrio can be re-run under the same condition,
  But with a different version of msysGit.
- Download the source for msysGit from here: http://msysgit.github.io/
  Compile and test, if the bug is on the latest version, or if it is gone.
  (I remember that some crashes had been fixed, but not all the details)
And/or
- If the repo you try to pull from is public, can you give us the URL ?
  If yes then some helpful people may be able to re-produce it.
  If no, is there a dummy (or better say test) repo, which is public and causes git to crash ?

Anyway, I would suggest to compile and re-test with the latest version of msysGit,
and let us know the results.
  
