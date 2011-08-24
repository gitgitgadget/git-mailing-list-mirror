From: =?UTF-8?B?QWRhbSBLxYJvYnVrb3dza2k=?= <adamklobukowski@gmail.com>
Subject: Problem with S_IFGITLINK
Date: Wed, 24 Aug 2011 14:49:40 +0200
Message-ID: <4E54F364.7000503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 24 14:49:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwCtw-0004xw-Ic
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 14:49:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752565Ab1HXMto (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 08:49:44 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46176 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028Ab1HXMtn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2011 08:49:43 -0400
Received: by fxh19 with SMTP id 19so936520fxh.19
        for <git@vger.kernel.org>; Wed, 24 Aug 2011 05:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=ISInw4f2Yw4Q7PvR0zZLngfY7oFlMJY/OQXTqd5uUjg=;
        b=sptyPI6H4OoCAymS3RqFY0pT8V45cvg4ayRjPxbsim36g/DeKJ3WuYMZl7X00kV0dR
         7i259ogaaZYDhjFzwkbvQzz1cC9XJB6zn7UGSsIm35vddDrpMzPqYInZJJNZuZJ6BUWz
         GsxF8ylF7cPcE1MChjlDPntH9gzx0HBRbBUAQ=
Received: by 10.223.9.154 with SMTP id l26mr4496993fal.36.1314190182167;
        Wed, 24 Aug 2011 05:49:42 -0700 (PDT)
Received: from [192.168.0.102] (89-72-179-1.dynamic.chello.pl [89.72.179.1])
        by mx.google.com with ESMTPS id r12sm808580fam.38.2011.08.24.05.49.40
        (version=SSLv3 cipher=OTHER);
        Wed, 24 Aug 2011 05:49:41 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.18) Gecko/20110617 Thunderbird/3.1.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179999>

Hello

I'm trying to compile git on some very exotic u*ix flavor (FreeMiNT 
anyone? :)) and I encountered problem with S_IFGITLINK.

Unfortunately, on my system S_IFGITLINK = S_IFLNK, and it breaks build 
in entry.c write_entry.

Should I report a bug? (where?, I could not find any reference to 
bugtracker on git pages)

Can I fix it somehow? Can I change value of S_IFGITLINK to something else?

AdamK
