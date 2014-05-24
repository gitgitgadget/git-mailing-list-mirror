From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [ANNOUNCE] git reintegrate v0.3; manager of integration branches
Date: Fri, 23 May 2014 23:24:17 -0500
Message-ID: <53801ef17dfb_e568c52f8d4@nysa.notmuch>
References: <53795175664d5_10da88d308ce@nysa.notmuch>
 <xmqqha4lxyqt.fsf@gitster.dls.corp.google.com>
 <537bc3e1c605c_a6f166b3088f@nysa.notmuch>
 <xmqqtx8krvem.fsf@gitster.dls.corp.google.com>
 <537bcbf7efd4_1d08f2d2f8a7@nysa.notmuch>
 <xmqqa9acrrsv.fsf@gitster.dls.corp.google.com>
 <CAMP44s03--Y8FJigWFw3kniULmUGNA7+8U=fvHn0QoC2K_eO1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 24 06:35:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wo3gM-0007FE-0d
	for gcvg-git-2@plane.gmane.org; Sat, 24 May 2014 06:35:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839AbaEXEfi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2014 00:35:38 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:64931 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713AbaEXEfh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2014 00:35:37 -0400
Received: by mail-oa0-f52.google.com with SMTP id eb12so6497557oac.11
        for <git@vger.kernel.org>; Fri, 23 May 2014 21:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=/ILwOsIbu8esALM/hBL/P9v3F9/pfvjTah9Tyz0pUu8=;
        b=SJXEhJ+zUQOsNyGJpIjCMWqTUW5tO09n1A8kpn8NwNGS3N0JVPeQ1hS/JcRPQCcUbr
         ehwsg+nJnoTbfFKH7r4ZQyVEJbOeFVI92gT2MjDYhALBNxlVe7WSCA3qHFeyBO7Y4dhO
         evU5/5oK0qK15iAYCdQnnUF/XJK+vBfJr1rc/fmLzbK7X/gJcbDjGLL393p1pnfFI7Lm
         X8oklXo2jjog125xk+K5v/Vh9bd0zv46Mf8UJuUIJmtAVVC5r53/O7I0KRr5A4ywpudP
         nrNaKh4OdiVkUcWQepsQIgGEx0OJJCh/3Gh9x7xaEOPOuu2SjVHnfJ4zpF9+7Ll8XP/8
         tyow==
X-Received: by 10.182.18.102 with SMTP id v6mr8237958obd.71.1400906136909;
        Fri, 23 May 2014 21:35:36 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id ny5sm9264295obb.21.2014.05.23.21.35.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 May 2014 21:35:36 -0700 (PDT)
In-Reply-To: <CAMP44s03--Y8FJigWFw3kniULmUGNA7+8U=fvHn0QoC2K_eO1A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250056>

Felipe Contreras wrote:
> Yes, I see how xx/topic~4 would be useful in the instruction sheet, I
> just didn't see it would be useful to generate that from an existing
> integration branch. After the explanation above I see how it could be
> useful to some people (though not all). I'll implement that.

Actually it was already supported.

https://github.com/felipec/git-reintegrate/commit/f3aa558

-- 
Felipe Contreras
