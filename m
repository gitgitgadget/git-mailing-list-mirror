From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Re* [PATCH 1/2] clone: allow to clone from .git file
Date: Tue, 23 Aug 2011 11:11:24 +0700
Message-ID: <CACsJy8AGGF8XdfJ0DKn2gt-3FV=5AW6t3=T0Gc6e00n4=kw=Eg@mail.gmail.com>
References: <1313927890-21227-1-git-send-email-pclouds@gmail.com>
 <7v7h66y4s5.fsf@alter.siamese.dyndns.org> <CACsJy8BaCwT+fd-KORsqXqQEtWZUpTDwgoSGU9+pMfNdero5=Q@mail.gmail.com>
 <7vbovhw9pb.fsf@alter.siamese.dyndns.org> <7vty99upn9.fsf_-_@alter.siamese.dyndns.org>
 <CACsJy8ABBB69V3pFjGohJwAQbZ_MwGqv=p27tUHF8HAGRMLpQw@mail.gmail.com> <7v8vqku6le.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 23 06:12:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QviLI-0007Ln-CU
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 06:12:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766Ab1HWEL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Aug 2011 00:11:56 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51080 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698Ab1HWELz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2011 00:11:55 -0400
Received: by bke11 with SMTP id 11so4137414bke.19
        for <git@vger.kernel.org>; Mon, 22 Aug 2011 21:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=c44vYDDCPJCXOLMgyZhACMa/joGLXv4sA1eLyauJAYc=;
        b=qujodIcbC6Um/9FoVNTxuFONQnfbmkqe/OAUrtBThzJt422SgFZZdDrZmW5luSqT+9
         tiV/4fq8UbonVJASDZw6YslN5eaZ9awHIy3qb8NaEJktbK4gMXW5r9HB6W/pFKUv+dXj
         50bc+FPg4Cr2HpJMwj+BXb5Ze94rxsCSfJYbk=
Received: by 10.204.149.15 with SMTP id r15mr1168368bkv.279.1314072714127;
 Mon, 22 Aug 2011 21:11:54 -0700 (PDT)
Received: by 10.204.156.19 with HTTP; Mon, 22 Aug 2011 21:11:24 -0700 (PDT)
In-Reply-To: <7v8vqku6le.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179919>

On Tue, Aug 23, 2011 at 10:53 AM, Junio C Hamano <gitster@pobox.com> wrote:
> But I ended up deciding not to add "gently" variant for now, as nobody
> needs it, and if we were to have "gently", we should also rethink the
> earlier checks in the function if they should give diagnosis. Please check
> what is queued near the tip of tonight's 'pu'.

Looks OK.
-- 
Duy
