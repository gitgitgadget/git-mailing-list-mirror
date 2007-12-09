From: Bo Yang <techrazy.yang@gmail.com>
Subject: What does this error mean?
Date: Sun, 09 Dec 2007 10:24:05 +0800
Message-ID: <475B51C5.9060207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 09 03:24:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1Bqc-0004yG-Qf
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 03:24:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753268AbXLICY3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 21:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753255AbXLICY3
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 21:24:29 -0500
Received: from wa-out-1112.google.com ([209.85.146.181]:34553 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752624AbXLICY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 21:24:28 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2429965wah
        for <git@vger.kernel.org>; Sat, 08 Dec 2007 18:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        bh=I7A55JPdfeBczboblQ6pbkA4RomAmuOasONJr6yBKQI=;
        b=WTIMF8aFErlhTA2puTgUWqTnfHfICVxqAWS0kbsETJMlYruqBNaP8Inz617bH1CYxg8cu1Gk+8aYFfU1e3eDfNkUSjgpiCoRmFMrLbVWpxXyQPr0GP963hLP0kXZM+t2lyshVTU4vdewYGVXuZWdykeldIRiWeiFLLoTkQg1mVI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=ooaUQvjIM5LtK2q4XogK4GjWgVvT44rNBc1emxnTwruR5eEkGO7sy+6FVrtomYg2BQqkaNb6EBJTPyVl2FUeJr1gK9Zuk3P0PZj4YqJ9T9yVHPXnwsgvGvGG0HuE2oyCHrJPWRRaSFuY+NXhkheHylMN6lHkZZP9TsOixrl2Krs=
Received: by 10.114.167.2 with SMTP id p2mr4306276wae.1197167067025;
        Sat, 08 Dec 2007 18:24:27 -0800 (PST)
Received: from ?192.168.1.123? ( [123.57.152.83])
        by mx.google.com with ESMTPS id k26sm3150282waf.2007.12.08.18.24.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 08 Dec 2007 18:24:25 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67586>

Hi,
   I run git pull to pull the recent changes from my http repository. 
And get the error:

Fetching refs/heads/master from http://nkbbs.org/git/mozilla.git using http
walk 5b082f95aa62e032e6bf9e7b4a72d41dcdc209b4
walk 90d82d12ee4a9ab400df9f34f0bfddee14420bf8
walk 1ad49fd5be35acaa572a76ab12d05d297414a9fe
error: Could not read 56edc89ce300e654c7b76c0c421a7a1ee0aaf958
Waiting for 
http://nkbbs.org/git/mozilla.git/objects/9d/b3e42472d01b8e3587a3e4a375e8f368483a81
Getting alternates list for http://nkbbs.org/git/mozilla.git
Waiting for 
http://nkbbs.org/git/mozilla.git/objects/e5/ea160617bcffcb6262a8d8f838ada80b090670
Waiting for 
http://nkbbs.org/git/mozilla.git/objects/e7/7681194544ca87e2bc42bffc21616679410fec
Waiting for 
http://nkbbs.org/git/mozilla.git/objects/48/7cf54d6429467a4e2c2c1eb3608c710e6d9d4f
Waiting for 
http://nkbbs.org/git/mozilla.git/objects/ef/68bd85ca219b1042abd49417571de016b10d05

Could you please tell me that what does this mean and how can I deal 
with this? Thanks!

Regards!
Bo
