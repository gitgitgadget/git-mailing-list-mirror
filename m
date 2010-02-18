From: Gabriel Filion <lelutin@gmail.com>
Subject: RFD: git-bzr: anyone interested?
Date: Thu, 18 Feb 2010 13:13:44 -0500
Message-ID: <4B7D8358.1080108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 18 19:14:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiAsv-0008LA-Kp
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 19:13:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753568Ab0BRSNw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 13:13:52 -0500
Received: from qw-out-2122.google.com ([74.125.92.26]:27795 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753349Ab0BRSNv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 13:13:51 -0500
Received: by qw-out-2122.google.com with SMTP id 8so60210qwh.37
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 10:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=zy0MmsHHEHzAq0MAdy8oSVhZUnZIvGEidKGoXFOwsmA=;
        b=NSB8C9xAg5aD6bPgq5vHNeo4teas9G2aBEr2KERQL1FH6cJ2Ctig/AGHX52mwFTSqa
         oLSuKZK5r3voec+tILtXguyRwk/f7xcOFfrefKwVt9pizHpL3y4X/p2TfEpBTvivTq2n
         fSdcRJv7L2RKX2SQkcAM3RnP15j8oXuY6lOPs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=f7V6zOyBGoxRHSJrN237u7bWKYCfkOJt2vPYD+1iAio8l9YVm8fWjMkyzrKe6pKRu1
         hePXZpfVdhYe0CPGyEDwlm0VZcKs7tpT4QXqikiYQwoOBhc9bVnc8Ca1yEF+MDDr9waf
         vFEfDTdYz9kzt4Wr23QlH842ZQvVB+3rUp10c=
Received: by 10.224.86.76 with SMTP id r12mr2750268qal.204.1266516826926;
        Thu, 18 Feb 2010 10:13:46 -0800 (PST)
Received: from ?192.168.10.101? (modemcable074.180-22-96.mc.videotron.ca [96.22.180.74])
        by mx.google.com with ESMTPS id 22sm6839092qyk.10.2010.02.18.10.13.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Feb 2010 10:13:46 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.5) Gecko/20100108 Lightning/1.0b1 Icedove/3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140355>

Hello,

I started collaborating on a script on github that tries to bring
bidirectional integration of git with Bazaar repositories. It is the
script originally written in ruby by Pieter de Bie and converted to a
shell script. You can find it here:

http://github.com/kfish/git-bzr

There is probably much left to be done to call this script functional.
Currently, it is possible to fetch revisions in a local branch, but I've
had problems with pushing revisions.

So, first things first: in order to make this thing see some substantial
progress, I will surely need help from people who are well acquainted
with git's internal plumbing, people from git-svn for their valuable
experience with extraneous vcs integration and also with people
acquainted with bzr's inner workings.

Is there any interest from people of this mailing list to see this
script make it to a usable state?
If so, having some code review would be more than good. What do you
recommend on doing: using this mailing list or putting one up that would
be specific to the project?

-- 
Gabriel Filion
