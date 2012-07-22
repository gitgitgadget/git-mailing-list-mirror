From: Alexey Muranov <alexey.muranov@gmail.com>
Subject: Re: [PATCH 1/3] retain reflogs for deleted refs
Date: Sun, 22 Jul 2012 13:12:45 +0200
Message-ID: <E02FA075-94B6-40A0-81E3-26968C1C18AC@gmail.com>
References: <20120719213225.GA20311@sigill.intra.peff.net> <20120719213311.GA20385@sigill.intra.peff.net> <50092993.6010203@alum.mit.edu> <20120720154403.GB2862@sigill.intra.peff.net> <6F148977-4F57-47FF-B43B-0997694F3891@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jul 22 13:12:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ssu5l-0007eX-Ry
	for gcvg-git-2@plane.gmane.org; Sun, 22 Jul 2012 13:12:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216Ab2GVLMt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jul 2012 07:12:49 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:50228 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986Ab2GVLMt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Jul 2012 07:12:49 -0400
Received: by wibhr14 with SMTP id hr14so1974515wib.1
        for <git@vger.kernel.org>; Sun, 22 Jul 2012 04:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=XxaNS7rudxqzP+E0YqsOZsk1aISPshMqQjAJoZd+izA=;
        b=sOBoyUcFLgQilMw6ZDU0h0meDtWxdN2cbzJaTbDnGQJLVOr0EovI9nJtqkqBDQFoaN
         t9JExdqDwLAXiJOZIn0s4vANuhY/qc6E8BNw/9zwkcghpwXOFuPzjwaFnsVooejbkTn1
         t95c6yjNfU2QReUo5iCSmp2vORe5Hf91AfjTYmdkPM+h3L8m486x7/kpgYklV0ysW2k2
         dA4tpiQ1nsw8BuugORx+6DYeoI0u2fdlasJX31ScW0+ra6D1286kQqFM+YdDYd9VEPb1
         204NflnCzFMnvizOunAmGYCmRpeXwRz+c09yABr/wn01Dnw9qH5Qki+K6IudRBmKNoct
         xMGg==
Received: by 10.216.134.216 with SMTP id s66mr863531wei.26.1342955567673;
        Sun, 22 Jul 2012 04:12:47 -0700 (PDT)
Received: from [192.168.6.127] (bi1.roaming.dfn.de. [195.37.234.61])
        by mx.google.com with ESMTPS id j6sm15276760wiy.4.2012.07.22.04.12.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 22 Jul 2012 04:12:47 -0700 (PDT)
In-Reply-To: <6F148977-4F57-47FF-B43B-0997694F3891@gmail.com>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201847>


On 22 Jul 2012, at 13:10, Alexey Muranov wrote:

> Sorry if this idea is stupid or if i miss something, but how about putting deleted reflogs for
> 
> refs/heads/a
> refs/heads/a/b
> refs/heads/a/b/c
> 
> to
> 
> refs/heads/a@yyyy-mm-dd-hhmmss
> refs/heads/a/b@yyyy-mm-dd-hhmmss
> refs/heads/a/b/c@yyyy-mm-dd-hhmmss
> 
> with the time they were deleted?
> 
> -Alexey.

Sorry, i meant to:

logs/refs/heads/a@yyyy-mm-dd-hhmmss
logs/refs/heads/a/b@yyyy-mm-dd-hhmmss
logs/refs/heads/a/b/c@yyyy-mm-dd-hhmmss

-Alexey.