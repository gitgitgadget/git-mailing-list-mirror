From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 6/7] read-cache: refuse to create index referring to
 external objects
Date: Mon, 28 Jan 2013 13:57:57 +0700
Message-ID: <CACsJy8BUhSDEdV3MtoBG1=Xx1OmiYvkvZQffV6cz1_HSAkcf1A@mail.gmail.com>
References: <1359016940-18849-1-git-send-email-pclouds@gmail.com>
 <1359016940-18849-6-git-send-email-pclouds@gmail.com> <7vpq0ubdec.fsf@alter.siamese.dyndns.org>
 <CACsJy8C3tLOHCK4Qc--W630do0M=xLKSMoYUxxv2_GDaUXaRww@mail.gmail.com>
 <7vpq0t3x60.fsf@alter.siamese.dyndns.org> <CACsJy8BJZgyEn1n2GWgAVSGhSkVUO-P=GXwR02OcDf0ziTTRaA@mail.gmail.com>
 <CACsJy8BwCCAZyMZ2w9fyMaNJsHRNp2V3Aen8g3drAkZ4y9mfBg@mail.gmail.com> <7vpq0pyfsq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 07:58:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tzig6-00015F-Qf
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 07:58:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154Ab3A1G6a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 01:58:30 -0500
Received: from mail-ob0-f170.google.com ([209.85.214.170]:54626 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753010Ab3A1G62 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 01:58:28 -0500
Received: by mail-ob0-f170.google.com with SMTP id wc20so792213obb.1
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 22:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=fDWQiPhZvhjj1n2eXM8een7ISKur3xrigwAwaMreZFo=;
        b=Bei67+WnTFNavBPlzrgve+GNdeU6/qbMXOhnTZKv7gwh4c3IPo6B7fQ9CBcM5IPRy3
         sTV+jNdw0C6OX6i6G33DYOBn8IRC/7BsXERdg1kl/jV2x89ipA7+64DknBZtnxg6R2y7
         qM67UtLSt3iLNCSjKIxc0H1lAVRXD9e+BROrVDngSJBqYDYYKTc7vPpxfoKv4opa2QSL
         Zs+X2VhDTL06AVLVb76q6JHoPmFNlIAtLGKdGwV7tn86Yo/ieV/qm8al0yrUKCyZTdRP
         769ntdA2okadxf2IjXPoehCFX+SjkGEokldTR5tquDvO6w7kFXNTrfIR0xu8w79WGSKN
         rKgw==
X-Received: by 10.60.8.134 with SMTP id r6mr10374363oea.53.1359356308224; Sun,
 27 Jan 2013 22:58:28 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Sun, 27 Jan 2013 22:57:57 -0800 (PST)
In-Reply-To: <7vpq0pyfsq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214815>

On Mon, Jan 28, 2013 at 1:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Mon, Jan 28, 2013 at 12:48 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>>> Regardless the submodule odb issue, I think we should prefer
>>> reading local loose objects over alternate packed ones.
>>
>> I think I went from one problem to another and did not make it clear.
>> The reason behind this preference is security.
>
> Reading from ours first would not help you at all if you are lacking
> some that you do need from your local repository and the only
> solution is not to borrow from untrustworthy sources, I think.
>
> You borrow only from a trusted source in the first place, no?

Hmm.. yeah.
-- 
Duy
