From: Lea Wiemann <lewiemann@gmail.com>
Subject: gitweb: Smoke test
Date: Wed, 28 May 2008 20:56:33 +0200
Message-ID: <483DAAE1.4000107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 28 20:57:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1QqF-0005VG-Iz
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 20:57:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752381AbYE1S4j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 14:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752505AbYE1S4j
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 14:56:39 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:12393 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752230AbYE1S4i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 14:56:38 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1842909fgg.17
        for <git@vger.kernel.org>; Wed, 28 May 2008 11:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:subject:content-type:content-transfer-encoding:from;
        bh=NyubkQu4Cd3eZ5MMYgVaAXP7Txtj/WIN3LlGEgqWOME=;
        b=iAbeeRMAMwtEr/+f8SJNsyFbNeeZRxLATHpohUP2J5OoU2OLwWnXbFOCak+dqyVL/LGFgnDNWFAboDMnn1lTpP9q0dA+lObO6C0kiespPbIVi17+kSTaPm5cdz6ipJfr27RRadWd42s7ZuSZjd08Id+XkR9E9iezqYE/lDh8upo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:subject:content-type:content-transfer-encoding:from;
        b=Q2vFS8hba+tdDevKzUiOw5KBQrHSJcYhU439BM9zqtv4iHgedNLc7R9Kr4TTOiMxUt0GxJmkh2Aa9oPLNh8Wxilp2GvZCqAFjkk3BBhWEzeE6osh4IO3y3GtEmcF2wcEesIRLAAMgHx1hhtgvO0Xgoh1eqTxoIqLCladCuR1vAI=
Received: by 10.86.89.4 with SMTP id m4mr4325608fgb.16.1212000996860;
        Wed, 28 May 2008 11:56:36 -0700 (PDT)
Received: from ?192.168.23.50? ( [91.33.212.111])
        by mx.google.com with ESMTPS id l12sm14798912fgb.8.2008.05.28.11.56.34
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 28 May 2008 11:56:35 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83129>

FYI and in case you're interested, I've implemented a smoke test for 
gitweb in a branch, here: 
http://repo.or.cz/w/git/gitweb-caching.git?a=tree;f=gitweb/test;h=cccee14b2571200861ffc05fbfae12c6d17e919d;hb=HEAD

It spiders your local gitweb site (which preferably only contains a 
really small test repository) with wget, and reports any problems, i.e. 
broken links or crashes of the CGI script.

The same mechanism might also be usable to view recursive diffs between 
old and new output, to see if anything has changed.  I'll probably 
implement that later when I start doing refactorings on gitweb.  Perhaps 
we should also have a real test suite at some point, though I'm not 
entirely sure yet how to approach that -- I'll have to dig into the code 
first. :)

(If there's any desire to copy the script to mainline, let me know -- 
I'll be happy with leaving it on the branch for now, though.)

-- Lea
