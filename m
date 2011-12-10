From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Copy resolve_ref() return value for longer use
Date: Sat, 10 Dec 2011 11:48:58 +0700
Message-ID: <CACsJy8Bg1=ESaZq8WQmZufsb6E8DY4RHqG0TWG-7uFX671zO6Q@mail.gmail.com>
References: <CACsJy8Aw4_O_GMiK_D=HTENfxGUXTTzCHqM7FkriqU+mQtVWtA@mail.gmail.com>
 <1320719428-1802-1-git-send-email-pclouds@gmail.com> <7vehxcpns5.fsf@alter.siamese.dyndns.org>
 <CACsJy8ARAzNWjZfXwnNG0AprCFXLCkiDrE+eFj9icbeNX14xKw@mail.gmail.com>
 <7vobwgo3l5.fsf@alter.siamese.dyndns.org> <626C086D699644D181B9FA573EDFFCA6@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Tony Wang <wwwjfy@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 10 05:49:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZEsW-0005iX-Co
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 05:49:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752588Ab1LJEtb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 23:49:31 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50575 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752031Ab1LJEta (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 23:49:30 -0500
Received: by bkbzv3 with SMTP id zv3so3593617bkb.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 20:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=himjx/zbSH1xrl5x5VX23D12l1bA0iXGeFcVHny5u4M=;
        b=G0f5FeRHmkP3oiMn6uXuJLMj1cx8rtX113VwOEA5Q7z0VjDgjcmi7WKFpF32VElXDa
         B96ZCDwbOawbLXInC1sVVed3vB8VAKzAn9TLM6DOeZ94irfWp2/j1gKCkpMzoz5Ak24f
         RoJRuxBBn0B0Lqj0rd+iVXBKEIIbGEJnXrgDg=
Received: by 10.204.155.76 with SMTP id r12mr5208378bkw.115.1323492569361;
 Fri, 09 Dec 2011 20:49:29 -0800 (PST)
Received: by 10.204.129.205 with HTTP; Fri, 9 Dec 2011 20:48:58 -0800 (PST)
In-Reply-To: <626C086D699644D181B9FA573EDFFCA6@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186721>

On Sat, Dec 10, 2011 at 10:43 AM, Tony Wang <wwwjfy@gmail.com> wrote:
> Hi,
>
> I don't know about the procedure, but wonder is any one following this?

This series has been merged in master. I'll resend patches to rename
resolve_ref() to resolve_ref_unsafe() soon.
-- 
Duy
