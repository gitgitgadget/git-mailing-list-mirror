From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: [PATCH 10/12] MINGW: config.mak.uname: drop USE_NED_ALLOCATOR
Date: Mon, 28 Apr 2014 12:39:03 -0500
Message-ID: <535e923776b87_45651483310bf@nysa.notmuch>
References: <1398693097-24651-1-git-send-email-marat@slonopotamus.org>
 <1398693097-24651-11-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: marat@slonopotamus.org,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Marat Radchenko <marat@slonopotamus.org>,
	GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 21:32:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WerIM-0007gt-VL
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 21:32:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932618AbaD1Tcu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 15:32:50 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:61219 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932486AbaD1Tct (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 15:32:49 -0400
Received: by mail-oa0-f42.google.com with SMTP id i7so116639oag.1
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 12:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=YhQRQdBj7/dDMmP9EdlC83XmC48Q5d7HUb1WICcS628=;
        b=TKCs4aJy+WCzOQFPwOZSy2Yvf6vNC+QCSVws6QNTGB8y2lkRKB+ie5lQRl5kJqK8hz
         ag8pj6R92hJcYwRfXzN3jYK+VGF2l/D+I1/SBYiUODGnC7MwKzvkn91HKrpRHhwVGwk6
         4xLMfr2YQjkwvmcxCitoxXBp6BiDGt3/VeEKok6RseUqP+sr25qv6L1NP15eFrql7Zst
         lMrpY9WWtk/zs8SJ07Yqf6eimRm84o0c/nVm8W1rw+PSxxf8nbrvisZa3UoEvTey3GIf
         ManUwhcnsQVBU1Mr9agA86kLroZcUR810KzCnnmW//avDU/ra1qNOCwz45bgsNJ6PwH6
         T+6g==
X-Received: by 10.60.44.135 with SMTP id e7mr2798875oem.63.1398707377474;
        Mon, 28 Apr 2014 10:49:37 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id oz15sm76173222oeb.13.2014.04.28.10.49.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Apr 2014 10:49:36 -0700 (PDT)
In-Reply-To: <1398693097-24651-11-git-send-email-marat@slonopotamus.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247410>

Marat Radchenko wrote:
> nedalloc was initially added in f0ed82 to fix slowness of standard WinXP
> memory allocator. Since WinXP is EOLed, this point is no longer valid.

The fact that WinXP is EOLed doesn't mean people are not using it any more =/

I think it should be supported by Git at least for a while.

-- 
Felipe Contreras
