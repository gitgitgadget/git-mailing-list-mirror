From: Michael Boutros <me@michaelboutros.com>
Subject: Git - index-pack missing
Date: Wed, 17 Dec 2008 18:40:40 -0500
Message-ID: <54F47863-AF55-4FB7-8A43-A4253E1F782C@michaelbutros.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 18 00:42:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD61k-0004ij-DO
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 00:42:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752257AbYLQXkq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 18:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752268AbYLQXkq
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 18:40:46 -0500
Received: from an-out-0708.google.com ([209.85.132.250]:43349 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256AbYLQXkp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 18:40:45 -0500
Received: by an-out-0708.google.com with SMTP id d40so66637and.1
        for <git@vger.kernel.org>; Wed, 17 Dec 2008 15:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:to
         :content-type:content-transfer-encoding:mime-version:subject:date
         :x-mailer:from;
        bh=+7M+cN0jrFYfuBFmdRBN7BPbyhAB539EKD2YkkNZ3rA=;
        b=VdVU/sNBwV6RHfzsRGYJDPSCn7WXCqIv1WtCKgLhl0p73/N0HCiSLkhnOlnIGDy7/c
         SCr8z0Gc4KJ4dPIF7p1t/5OIyyppjX8IB4WpwP3jZBuG3L23rtdkeYm+CSBJ+oJmEDGl
         wWALM78epxK35ydI781G3pECZUdsCesAslxMU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:to:content-type:content-transfer-encoding
         :mime-version:subject:date:x-mailer:from;
        b=DlTJ6wkWu0zx6ySQAGa6RuBzTOoHQrRK6dvSi4qWn9DLTkn34fmN2RN0IPfqMufJPq
         e9CDONhFb8OpDoNb1z3fgYMwzPlZ3/u/HdmtE06/Hb1YvW6RPTYWMWGzheV15DK38w9q
         V2WeWUo0dv6MtjkpjSbpkGeCGSyPDjbokTrtM=
Received: by 10.64.183.6 with SMTP id g6mr1020678qbf.17.1229557243028;
        Wed, 17 Dec 2008 15:40:43 -0800 (PST)
Received: from ?192.168.1.101? (bas2-unionville55-1279620224.dsl.bell.ca [76.69.116.128])
        by mx.google.com with ESMTPS id 12sm2573261qbw.9.2008.12.17.15.40.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 17 Dec 2008 15:40:42 -0800 (PST)
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103411>

Greetings all,

First of all, thanks for taking the time to read this and help out.  
The problem:

I'm trying to clone a repository for the first time on a hosting  
account that just got setup with Git. However, the problem is that for  
some reason there is no git-index-pack. I cannot find any reason that  
that one particular command would not be installed, but for some  
reason that seems to be the case.

Has anyone ever heard of anything like this? Is my only option to  
completely scrap Git and try again?

Thanks,
Michael Boutros
