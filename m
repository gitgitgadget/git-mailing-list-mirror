From: Dan Zwell <dzwell@gmail.com>
Subject: Re: $GIT_DIR usage
Date: Sun, 05 Aug 2007 08:22:54 -0400
Message-ID: <46B5C11E.4000101@gmail.com>
References: <46B59F63.8020707@gmail.com> <678E8953ECEB4B72A99DEA2137B05823@ntdev.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Dmitry Kakurin <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 05 14:24:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHf9m-0005ns-5y
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 14:24:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755789AbXHEMYL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 08:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755146AbXHEMYK
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 08:24:10 -0400
Received: from mailhub.lawrence.edu ([143.44.0.14]:40845 "EHLO lawrence.edu"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755709AbXHEMYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 08:24:09 -0400
Received: from [69.140.46.21] (account zwelld HELO [192.168.2.3])
  by lawrence.edu (CommuniGate Pro SMTP 5.1.10)
  with ESMTPSA id 29972478; Sun, 05 Aug 2007 07:24:08 -0500
User-Agent: Thunderbird 2.0.0.4 (X11/20070604)
In-Reply-To: <678E8953ECEB4B72A99DEA2137B05823@ntdev.corp.microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55006>

Dmitry Kakurin wrote:
> I think you also need to set GIT_WORK_TREE.
> This way Git will know the root of directories that it controls.
> 
> - Dmitry
> ----- Original Message ----- From: "Dan Zwell" <dzwell@gmail.com>
> Newsgroups: gmane.comp.version-control.git
> To: <git@vger.kernel.org>
> Sent: Sunday, 5 August 2007 2:58
> Subject: $GIT_DIR usage
> 
> 
>> Hi, I had a question about $GIT_DIR. That is to say, it doesn't seem 
>> to work. I am using Git 1.5.2.4. See the following: (all the commands 
>> I tried besides "git-init" failed).
>>
>> $ export GIT_DIR="`pwd`/.git_public"
>> $ git init
>> warning: templates not found /usr/share//git-core/templates/
>> Initialized empty Git repository in /home/user/temp/.git_public/
>> $ echo > new_file
>> $ git add new_file
>> fatal: add must be run in a work tree
>> $ git commit -a
>> fatal: /usr/bin/git-commit cannot be used without a working tree.
>> $ git commit
>> fatal: /usr/bin/git-commit cannot be used without a working tree.
>> $
>>
>> Is $GIT_DIR not meant to be used this way? Does it have a different 
>> purpose / use case, or is this just a bug?
>>
>> Thanks,
>> Dan
> 

Thank you. I also had to upgrade Git to the as-yet unreleased version 
(this variable doesn't exist in the current stable release), but what 
you said makes sense and seems like it should work.

Dan
