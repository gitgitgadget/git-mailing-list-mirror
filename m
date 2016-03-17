From: Sidhant Sharma <tigerkid001@gmail.com>
Subject: Re: [RFC/GSoC] Introduction
Date: Thu, 17 Mar 2016 20:22:11 +0530
Message-ID: <56EAC49B.6020909@gmail.com>
References: <56E3BE3E.9070105@gmail.com>
 <1924FEBB-46F2-46EE-B190-5289588D4BED@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Kevin Daudt <me@ikke.info>, philipoakley@iee.org
To: Lars Schneider <larsxschneider@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 15:52:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agZHi-0004LY-GM
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 15:52:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031173AbcCQOwU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 10:52:20 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33908 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030437AbcCQOwR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 10:52:17 -0400
Received: by mail-pf0-f173.google.com with SMTP id x3so123950044pfb.1
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 07:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=LurwV8RTwltH03icBBL6K1CSJ1vt2NQ13fGxb0Wm6TY=;
        b=n+hDoiThrJ+K3GOzi2f1nxHvumy0079r9QAZaxMUcRUM4UVoyCt4Z2TCdO65qoxLPx
         n/dgVZ22A11489Nw3VrGtpU5uGnBq08OCzU7jAKEaCyxBfgv+TXU8Lpom5Db5Jwul3Xm
         9/9ewQR7Np2VPwAshgxYpWl8fTAAZEz1UAMKGPlpsPx2stoL7vTIowD1e0lLpS3Ij3jm
         6ZQGXHs1Zj3cnxLc9uyGTMeSvlBJtGiuxfPUfmKAEqjyU35HMtcVaMZv5R/KERXx/MeY
         9cBi1w8Kelrxiz7YrEMyc+NkW/xPqvwpfYvIT1tLmfbvy1JKqK4nuqaP5fT5j0TnFQXT
         eJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=LurwV8RTwltH03icBBL6K1CSJ1vt2NQ13fGxb0Wm6TY=;
        b=TIScJoKBSsnq1AOtZ48w0hmqS3JVVQ9+p5r+5Boom97eZl0lDR1T58KGPRE46uXsNy
         g60oIGQEPsOSHR+88IhXMZSNfLdZtwGVYBIuniziE2Nive55U8zAT4ApS57Hp1b/B5MW
         aqOz3tJXvWIT4tYcsuvBSejCVCtVZdWTF5TwMR6H+0gzmckErwZaQP6/fMFgKaMe3IFA
         2V8z0soSPCKFHinyevszVJyZZepjsAHMnCDHD9cJ1em+fMpsHk1IQQxwgKz3lI6Ji8F6
         moHAjhrEy+rzOv4JwjQhpMsxSIVvrqKOQd3m2lW4q1USqFny9diV/rTx482g1JY+f8Ge
         ymWA==
X-Gm-Message-State: AD7BkJLp1CnvFCDx6fK5ZAWxgwE6JrOyViEmOeFhtM0MsBfV4DcoIIjDxdAi4jc0Fsgx3A==
X-Received: by 10.66.118.108 with SMTP id kl12mr13226764pab.151.1458226336959;
        Thu, 17 Mar 2016 07:52:16 -0700 (PDT)
Received: from [192.168.1.10] ([122.162.48.35])
        by smtp.gmail.com with ESMTPSA id f8sm14034252pfj.49.2016.03.17.07.52.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Mar 2016 07:52:16 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <1924FEBB-46F2-46EE-B190-5289588D4BED@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289119>

Hi,

So to sum up, the list of tasks for the project would be:
1. A wrapper is to be implemented around (called 'ggit') that will scan the
arguments for potentially destructive commands. When none are found, all the
arguments will simply be passed through to git.
2. If such a command is found, 'ggit' will:
    a. Show what the command is actually going to do.
    b. Ask the user if they are sure they want to execute it.
Eg. "You are about to do X which  will permanently destroy Y. Do you want to
continue?"
3. For all commands that are entered, 'ggit' will also show a brief summary of
the command what it will do when executed, explaining it's intended usage.

Is the list correct, or did I miss something?


Thanks and regards,
Sidhant Sharma
