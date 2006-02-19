From: Jacob Kroon <jacob.kroon@gmail.com>
Subject: Fixing author/email fields in commit messages
Date: Sun, 19 Feb 2006 19:45:05 +0100
Message-ID: <43F8BCB1.2010701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Feb 19 19:38:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAtSI-0003st-Oy
	for gcvg-git@gmane.org; Sun, 19 Feb 2006 19:38:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWBSSin (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Feb 2006 13:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbWBSSin
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Feb 2006 13:38:43 -0500
Received: from xproxy.gmail.com ([66.249.82.194]:25490 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932200AbWBSSim (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Feb 2006 13:38:42 -0500
Received: by xproxy.gmail.com with SMTP id s8so592613wxc
        for <git@vger.kernel.org>; Sun, 19 Feb 2006 10:38:42 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=bE5FsppKogyNOpXZYeKtiOIz7C850E9sOa7XXUpPvGRbC7f8uQrtKSES4VS98HP3tY6uoujc4uG43t8ai76eLIAUvvEcsf0Ryo9bqb5M8+SkNDgeOH95ILraaBS6qIBuY5kZItwp3uiUZbK4eecQat2twSEf9BQw00mqtu1X8NM=
Received: by 10.70.13.14 with SMTP id 14mr2993636wxm;
        Sun, 19 Feb 2006 10:38:42 -0800 (PST)
Received: from ?192.168.0.3? ( [83.249.217.43])
        by mx.gmail.com with ESMTP id h8sm4436856wxd.2006.02.19.10.38.40;
        Sun, 19 Feb 2006 10:38:41 -0800 (PST)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16442>

When I started my git repository for my project, I never setup 
GIT_AUTHOR_NAME etc. correctly,
so my commit messages used the default information, 
"<jacob@skeletor.(none)>", "skeletor" being the
hostname of the computer I'm working on. I'd like to change it so that 
the messages will contain correct
information about my e-mail and username. I noticed that this question 
has been brought up here before
and that the solution might be to use git-convert-objects, but that it 
might need some modifications.

Has anyone come up with a working tool for this task ?

I know how to make the future commits look as expected.

//Jacob
