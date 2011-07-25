From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v3 2/2] Ensure git ls-tree exits with a non-zero exit code
 if read_tree_recursive fails.
Date: Mon, 25 Jul 2011 19:58:26 +0700
Message-ID: <CACsJy8DSLK=-rrtvWQbcoS93mMysy=a0GVUCWh=6srYHZW1-mA@mail.gmail.com>
References: <1311519554-16587-1-git-send-email-jon.seymour@gmail.com>
 <1311519554-16587-3-git-send-email-jon.seymour@gmail.com> <CACsJy8Aa_=BvZOt58sM4dknVzvihH9OtHAS1aRxqPwNLxh0fkg@mail.gmail.com>
 <CAH3Anrrbj93briHKpxEjpoVTOnSikQYQyxa4R=C7QKt=punyVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, gitster@pobox.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 25 14:59:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlKkX-00067v-TL
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jul 2011 14:59:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557Ab1GYM7A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jul 2011 08:59:00 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:33455 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112Ab1GYM65 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2011 08:58:57 -0400
Received: by fxd18 with SMTP id 18so9049224fxd.11
        for <git@vger.kernel.org>; Mon, 25 Jul 2011 05:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=L8FCXYRYC1b9/OZntuaVkzI6vJDCkLrtM5KrUx/Wp4Y=;
        b=jjmAvl6e0yKa+MzW2U3xhOXozg3JEyTIkQ99iUJ0vfByFZJ6pqEAcWsvOc450eS3f9
         xcQ/PoJB3SjRNGTdinGjQxuabSOzIdB9lIpCSzUvbI5LZTMmKcGNdvK0r1QmSzX/7iOy
         SkX8zMf7eacHYUlmzAjTPQxk/ncbDPRS5fjT4=
Received: by 10.223.91.156 with SMTP id n28mr6859184fam.102.1311598736108;
 Mon, 25 Jul 2011 05:58:56 -0700 (PDT)
Received: by 10.223.113.79 with HTTP; Mon, 25 Jul 2011 05:58:26 -0700 (PDT)
In-Reply-To: <CAH3Anrrbj93briHKpxEjpoVTOnSikQYQyxa4R=C7QKt=punyVw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177793>

On Mon, Jul 25, 2011 at 3:45 PM, Jon Seymour <jon.seymour@gmail.com> wrote:
> Fair point.
>
> Everyone ok with this revision? If so, I will re-roll v4.

I'm good.
-- 
Duy
