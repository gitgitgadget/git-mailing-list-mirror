From: Sam Vilain <sam@vilain.net>
Subject: Re: Looking for SCM that lets me publish part of a repository
Date: Tue, 07 Mar 2006 09:58:40 +1300
Message-ID: <440CA280.6000304@vilain.net>
References: <1141608679.16980.12.camel@mattlaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 06 21:59:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGMn5-0003X6-RW
	for gcvg-git@gmane.org; Mon, 06 Mar 2006 21:58:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005AbWCFU6t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Mar 2006 15:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752012AbWCFU6s
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Mar 2006 15:58:48 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:58795 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S1752005AbWCFU6s (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Mar 2006 15:58:48 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 65534)
	id 801092F62; Tue,  7 Mar 2006 09:58:44 +1300 (NZDT)
Received: from [127.0.0.1] (longdrop.watts.utsl.gen.nz [192.168.255.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id 44ECC1715;
	Tue,  7 Mar 2006 09:58:38 +1300 (NZDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
To: Matt McCutchen <hashproduct@verizon.net>
In-Reply-To: <1141608679.16980.12.camel@mattlaptop>
X-Enigmail-Version: 0.92.1.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.watts.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17304>

Matt McCutchen wrote:

>Dear GIT people,
>
>For the last week or so, I have been looking for a SCM system to hold
>many of my projects, some of which are available to the public and
>others of which are not.  It would be nice if I could use a single large
>private repository on my computer with each project in a separate
>folder.  Then I would like to pull some of the projects (but not all)
>into a world-readable repository on my Web site.  I have looked at
>several SCMs and have not found a way to make any of them do this, but I
>like GIT best on other grounds.  Is there a way I can coerce GIT to
>clone and pull one folder out of a repository but ignore the rest?
>  
>

SVK works like this, you get one (by default) repository in your ~ which
you then mirror published projects to, and it tracks local changes as a
branch which you can then commit back 'upstream' (or to your published
repository) with.

Jeff King also recently posted a script to extract out a part of a
repository into another one, which is a related concept.

Sam.
