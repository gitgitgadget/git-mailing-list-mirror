From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: svnimport problems (abysmal performance and crash) on Cygwin
Date: Wed, 14 Mar 2007 09:03:15 +1300
Message-ID: <46a038f90703131303r6a50c077n7144ddb0045062db@mail.gmail.com>
References: <45F4F58D.2010701@dawes.za.net> <45F50023.9030403@dawes.za.net>
	 <46a038f90703120339j674e15cqe0e0fa587736f9bc@mail.gmail.com>
	 <45F59193.1070608@dawes.za.net> <45F6F724.4080704@dawes.za.net>
	 <46a038f90703131250h1be0507v2feada21ea161362@mail.gmail.com>
	 <45F700D8.80804@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>, normalperson@yhbt.net
To: "Rogan Dawes" <lists@dawes.za.net>
X-From: git-owner@vger.kernel.org Tue Mar 13 21:03:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRDDi-0002Bx-VR
	for gcvg-git@gmane.org; Tue, 13 Mar 2007 21:03:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933082AbXCMUDZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Mar 2007 16:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933097AbXCMUDY
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Mar 2007 16:03:24 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:21207 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933082AbXCMUDX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2007 16:03:23 -0400
Received: by nf-out-0910.google.com with SMTP id o25so2660486nfa
        for <git@vger.kernel.org>; Tue, 13 Mar 2007 13:03:19 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tvzXLAPja4RMViu4mji2eJ5SFhQcxCEgRovzcBWznpNaz6wIfXclvlyjdzDhTshP4wYZ6rSzgu2tzegsmXTVafgF2it64JBs5dQ5bhBGdklBITO9pXBk0MkWUfJJGlhfFbnDu5hysMmQDdeAS1R8tYFm4Q1cPy2HbC5+MLJAthc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WkhPrnMdfnXoScFmdB/2ylmto1wKqG40nGZr/w5XQGIgNrv3mevR6Oaylp2i1A9RYN9ZI5+N8YjvEc2gNYKJ5t84u6dPVNuCk7aNZ7MrDH6VkCscsMNGUHquct4kC9E74cEvHQPHwds/gaHBSndzyb4SW055Q3hFTk5ANDU4Lko=
Received: by 10.82.177.3 with SMTP id z3mr2383853bue.1173816195085;
        Tue, 13 Mar 2007 13:03:15 -0700 (PDT)
Received: by 10.82.183.14 with HTTP; Tue, 13 Mar 2007 13:03:15 -0700 (PDT)
In-Reply-To: <45F700D8.80804@dawes.za.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42150>

On 3/14/07, Rogan Dawes <lists@dawes.za.net> wrote:
> Any suggestions for how *I* can figure it out?

Well -- all my experience with SVN has been when using it with
svnimport ;-) and trying again and again.

>From looking at this url
http://spring-rich-c.svn.sourceforge.net/svnroot/spring-rich-c/ I
suspect that you might want to invoke it like

git-svnimport -T trunk -t tags -b branches
http://spring-rich-c.svn.sourceforge.net/svnroot/spring-rich-c/

(note the shorter url).

If that works but leaves the main project in a subdirectory, but the
trees in branches and tags without the subdirectory, you might want to
try:

git-svnimport -T trunk/spring-richclient -t tags -b branches
http://spring-rich-c.svn.sourceforge.net/svnroot/spring-rich-c/

It might take a couple of tries. NOTE: you should check not only the
main dev track but also the branches and tags for sanity.

cheers


m
