From: Stefan Beller <stefanbeller@googlemail.com>
Subject: error: git-remote-https died of signal 13
Date: Sat, 23 Nov 2013 17:36:36 +0100
Message-ID: <5290D994.9040505@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 23 17:36:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VkGCJ-0007Nk-L3
	for gcvg-git-2@plane.gmane.org; Sat, 23 Nov 2013 17:36:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755795Ab3KWQgk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Nov 2013 11:36:40 -0500
Received: from mail-ea0-f173.google.com ([209.85.215.173]:52591 "EHLO
	mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753922Ab3KWQgj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Nov 2013 11:36:39 -0500
Received: by mail-ea0-f173.google.com with SMTP id g15so1248181eak.32
        for <git@vger.kernel.org>; Sat, 23 Nov 2013 08:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=X8wd3QXYi9D0GiarL7mc84mCOcKjDNQq71rOKOWofcg=;
        b=0kki8XDl7PwisA74w3NMRs3YL/KeUE/YRq+MDDm0WBgX5aGuZzFmBGIGWF3abuKOMX
         V5v3hQoRznj2vdK5FVJjSmYc/q4NTxMWtPn1fIvtkU15mpUt6ugMCZgwan1bfnGgioKG
         O+jiRbNHm1LDGpYN7N7crxOVMYxYYt4Vn0B4ZSCXQmbTYmkax8VpPJ+75qmy6T0l16r1
         MoBIvsKKXjz8BNpPzrTfWogK1YhAgmiaK15tCLrqIKM35j5V3lkMVVQBxaUeSrctbDjA
         EUunGE/0+34t8cpV5Flmf6G8q1FbmQ6obkZ+H3/AnB1279IB78J7WunBEVK6OixwcnI9
         S0Tw==
X-Received: by 10.15.23.206 with SMTP id h54mr24848934eeu.17.1385224598074;
        Sat, 23 Nov 2013 08:36:38 -0800 (PST)
Received: from [192.168.1.9] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id o1sm28589057eea.10.2013.11.23.08.36.37
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 23 Nov 2013 08:36:37 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238242>

Hi,

Using the latest git version (1.8.5.rc3), I get this
this warning/error:

sb@sb:/tmp$ git clone https://github.com/Bertram25/ValyriaTear.git
Cloning into 'ValyriaTear'...
remote: Counting objects: 21346, done.
remote: Compressing objects: 100% (6307/6307), done.
remote: Total 21346 (delta 16463), reused 19820 (delta 15000)
Receiving objects: 100% (21346/21346), 176.39 MiB | 445.00 KiB/s, done.
Resolving deltas: 100% (16463/16463), done.
Checking connectivity... done.
error: git-remote-https died of signal 13

However the repository seems to be cloned fine.
I can clone different repos from github and they are working fine
without the error.
Would that be an issue on my side or on githubs side?

Stefan
