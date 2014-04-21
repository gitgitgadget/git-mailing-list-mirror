From: Ilya Bobyr <ilya.bobyr@gmail.com>
Subject: Re: [RTC/PATCH] Add 'update-branch' hook
Date: Mon, 21 Apr 2014 13:02:02 -0700
Message-ID: <5355793A.5020000@gmail.com>
References: <1398047016-21643-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 21 22:02:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcKPy-00071n-GS
	for gcvg-git-2@plane.gmane.org; Mon, 21 Apr 2014 22:02:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754484AbaDUUCN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 16:02:13 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:47293 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754483AbaDUUCM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 16:02:12 -0400
Received: by mail-pd0-f173.google.com with SMTP id z10so4034080pdj.32
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 13:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=2768uYcmFCPPJp7jeHbNvUaiRaIYGM1A2Ulcm97uIgQ=;
        b=SXcAM4lmc5ErSLBeRea3EXZzK0i6ACKS5yakYLGGqED0ap7GDX9NE7EXAAQnplJku3
         sCa/SEsoNTA6JrNO8SI+XBXP4UrEspsff9ntoZVHmaiCM1naCB7GvjdTeQA9LXt1GnSE
         VMfFOh9LO9Y3vaTUzFERdgYtwqbuADH/cxnA18zdvF2fyd+dyybOZvur1YJlDH+q7E8Y
         sgkInwUpA4bm1YG+5mkAqXrvsKILwybSyidJYNX6bT4IXMUdGjWNbU6reRITm0Hjh0pR
         927oSz1ByRf9VJ/DljOwa2E6SMXLwupB81w66JYbU4SwbAG0tu+sqAHlnWyBRKICwmgN
         DNrg==
X-Received: by 10.68.178.66 with SMTP id cw2mr40247124pbc.89.1398110531208;
        Mon, 21 Apr 2014 13:02:11 -0700 (PDT)
Received: from [192.168.1.2] (c-50-136-172-14.hsd1.ca.comcast.net. [50.136.172.14])
        by mx.google.com with ESMTPSA id qw8sm79918496pbb.27.2014.04.21.13.02.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Apr 2014 13:02:10 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:28.0) Gecko/20100101 Thunderbird/28.0
In-Reply-To: <1398047016-21643-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246630>

On 4/20/2014 7:23 PM, Felipe Contreras wrote:
> This hook is invoked whenever a branch is updated, either when a branch
> is created or updated with 'git branch', or when it's rebased with 'git
> rebase'. It receives two parameters; the name of the branch, and the
> SHA-1 of the latest commit, additionally, if there was a base commit the
> branch was rebased onto, a third parameter contains it.

And the old branch SHA could be found from in the reflog, correct?
Maybe it is possible to add it as an extra argument?
Or if reflog could be used, a note in the description that would say so.
