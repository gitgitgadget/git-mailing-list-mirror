From: Paul Campbell <pcampbell@kemitix.net>
Subject: Re: [PATCH 0/4] contrib/subtree: general updates
Date: Sun, 24 Mar 2013 00:16:18 +0000
Message-ID: <CALeLG_nPM4TYGAZi0mj7tGSz1hnHQXUUtwhyfodsidR2HZ_VxA@mail.gmail.com>
References: <1363213963-4065-1-git-send-email-pcampbell@kemitix.net>
	<874ngebsm9.fsf@catnip.gol.com>
	<7vvc8uzmht.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Miles Bader <miles@gnu.org>, git <git@vger.kernel.org>,
	David Greene <greened@obbligato.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 24 01:16:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJYcE-0004wk-RJ
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 01:16:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752419Ab3CXAQU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Mar 2013 20:16:20 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:33712 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752296Ab3CXAQT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Mar 2013 20:16:19 -0400
Received: by mail-oa0-f51.google.com with SMTP id g12so2022034oah.38
        for <git@vger.kernel.org>; Sat, 23 Mar 2013 17:16:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type:x-gm-message-state;
        bh=IsrFXWnln9Mqahuw9wqnkr0M571O/rouHu+gUyf/xck=;
        b=Znp9NpGmbiYMuOqU84VrPaWgmSPKvxWORtNhOx0t1j7koaAh0Vk24xxqu0ojFA86yC
         7hbUDGEdc0AzWwdySY/NLu/65p2SVHnXbMqRZNiIBg4oKf2cP5z2FogHKWLiBTvjTjuI
         2iaEcua20g7V2PlDtvCVyKhhUAS86xPK5NZH96Wf4ONCsQY5NQ161HE4H7lGEN+h0bu8
         FJKnTIPbU7+va9cu7t4DcgxZ1SvthzHhGBqP46DZ3wcqiAn+7eRw0U+ADshf9lOlAmu6
         kMeiMppQiKmll0J1RFJUUzqt+tzQWgm0/DwSv3qVoI7v1fjIQhYvesceHxnpomUHzYEY
         +VdA==
X-Received: by 10.60.172.108 with SMTP id bb12mr6636887oec.110.1364084178832;
 Sat, 23 Mar 2013 17:16:18 -0700 (PDT)
Received: by 10.76.13.2 with HTTP; Sat, 23 Mar 2013 17:16:18 -0700 (PDT)
X-Originating-IP: [2.102.87.178]
In-Reply-To: <7vvc8uzmht.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQmiQ5bI+3V7gFro5RZd4EnQtcjCnjh1kX7HDWfdp9E/+dTIRS0mqDJ2fvlRwjKEKMi/VGfg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218926>

On Thu, Mar 14, 2013 at 3:30 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Miles Bader <miles@gnu.org> writes:
>
>> Paul Campbell <pcampbell@kemitix.net> writes:
>>> James and Michael's patches add if clauses that use the
>>> bashism 'if []' rather than 'if test'.
>>
>> "Bashism"...?  I dunno how portable is, but "[" is an old unix alias
>> for "test" ... it certainly predates bash...
>
> Correct. [[ ... ]] is new and spelling out "test" indeed is more
> traditionalist than [ ... ], but for contrib/subtree/ that does not
> work with anything but bash, I do not think such a rewrite has much
> merit in the first place.  Being consistently "bash script" (as
> opposed to being old-style) is more appropriate for it.
>
>

Does no-one have any other comments about these patches?

-- 
Paul [W] Campbell
