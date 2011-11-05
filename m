From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 00/10] Pulling signed tag
Date: Sat, 5 Nov 2011 16:27:35 +0700
Message-ID: <CACsJy8D8PGbJyTZ-_0quc9s=8B=DxAJyfzuj5F9tu0Oyhy+CvQ@mail.gmail.com>
References: <1320472900-6601-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, "Robin H. Johnson" <robbat2@gentoo.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 05 10:28:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMcXv-0005FC-9j
	for gcvg-git-2@lo.gmane.org; Sat, 05 Nov 2011 10:28:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752276Ab1KEJ2J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Nov 2011 05:28:09 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38890 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121Ab1KEJ2I (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2011 05:28:08 -0400
Received: by bke11 with SMTP id 11so2576465bke.19
        for <git@vger.kernel.org>; Sat, 05 Nov 2011 02:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=xrBAELEaZ8znvJoAT/TuqWXdnPnZFiTJ16//7rhzvD0=;
        b=K47ajrrwi91B52ps3t/wvoQP8uQkl97gCCaVJR0X/VVc2GA2GkCqEt3ccnVoo9paR+
         A/l3GzXiYOTg0zhlFCSwKZX7FLCp3wIZe5yko6l1LLJlZOKlXNiOVFRWMGJjGzsmdRZ0
         a6yxqEa5K6VdRVCZh3PBjZSfwyl4YuGbPEoW8=
Received: by 10.204.142.23 with SMTP id o23mr14282271bku.58.1320485286144;
 Sat, 05 Nov 2011 02:28:06 -0700 (PDT)
Received: by 10.204.177.79 with HTTP; Sat, 5 Nov 2011 02:27:35 -0700 (PDT)
In-Reply-To: <1320472900-6601-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184842>

On Sat, Nov 5, 2011 at 1:01 PM, Junio C Hamano <gitster@pobox.com> wrote:
> This is my fourth iteration to solve the "how can we allow authenticity of
> work by contributors to be validated by the integrator and leave enough
> information for later audit by third parties" topic. What is unusual is
> that this is not a fourth re-roll of one approach re-re-re-polished, but
> these four are all based on different design.
>
> This round is based on Linus's "let the integrator pull signed tag from
> the contributor" design.

That thread is really long and I may have missed pieces here and
there. My understanding is that this topic now, while supports kernel
development model, would not address the problem gentoo has, which is
described by Robbin in the same thread [1]. Is that correct?

[1] http://thread.gmane.org/gmane.linux.ide/50518/focus=1210629
-- 
Duy
