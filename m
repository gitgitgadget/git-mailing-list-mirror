From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/2] gitignore, re-inclusion fix
Date: Mon, 21 Sep 2015 11:03:17 -0700
Message-ID: <xmqqmvwfabve.fsf@gitster.mtv.corp.google.com>
References: <1442106945-24080-1-git-send-email-pclouds@gmail.com>
	<1442829375-1926-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 21 20:03:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ze5Qz-0004pn-Lb
	for gcvg-git-2@plane.gmane.org; Mon, 21 Sep 2015 20:03:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753873AbbIUSDV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 14:03:21 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35797 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752857AbbIUSDU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 14:03:20 -0400
Received: by pacfv12 with SMTP id fv12so125351192pac.2
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 11:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=RVRtYp6esfZChW0hbfOgDREHzK0strrkhTRhlA2fwao=;
        b=XbmearfY4wn2kYFsILH+WctRhZ+VnBO0bXItD5EeuXDOBI4hqyY7C4Fg0hvuZG52j3
         y5e3l8Mzw2tZzCDXxVasR6tv8pX75bhlqltQC/8gefrvPr56Pe4EQi6mabs0jW+EBvuh
         FvyfxYU9MwnAyvkVEZ/RaX1Qycs02kbPdGMwEC4DivekL2xHgEctcCOcE/DIS3shkSV7
         4BLHR051zji9e1uMt+r8Ig8UILEz0TPtydtXDhwmpwp2lMKe97em9hkExz+hG9wONH7J
         +EYl/gsLd9gLnEdB0obNws59itboXc1CMV1bL7o4x51VZItgmLVVkBPaAXvr9bUMr/EN
         /LLg==
X-Received: by 10.66.165.106 with SMTP id yx10mr26372607pab.102.1442858600036;
        Mon, 21 Sep 2015 11:03:20 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:89f8:25c:a9fe:f701])
        by smtp.gmail.com with ESMTPSA id lg7sm25740419pbc.1.2015.09.21.11.03.18
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 21 Sep 2015 11:03:18 -0700 (PDT)
In-Reply-To: <1442829375-1926-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 21
 Sep 2015 16:56:13 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278321>

This round is very clearly explained and I like it very much ;-)

Thanks for fixing this.
