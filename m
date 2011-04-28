From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH] completion: avoid "words" as variable name for zsh portability
Date: Fri, 29 Apr 2011 00:27:37 +0300
Message-ID: <BANLkTim9h+OrYP6rMN_aWizHiQxZJ60vdg@mail.gmail.com>
References: <1303867612-15975-1-git-send-email-felipe.contreras@gmail.com>
	<20110427013534.GA14286@elie>
	<7v62q0b8e0.fsf@alter.siamese.dyndns.org>
	<20110427064033.GB4226@elie>
	<20110428160115.GA19003@goldbirke>
	<BANLkTikt=Em6kP93aZfuZ3DEXdXN+7sAzg@mail.gmail.com>
	<7v4o5i3xqk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Stefan Haller <lists@haller-berlin.de>,
	Mark Lodato <lodatom@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 23:27:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFYkT-0005YQ-8H
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 23:27:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752847Ab1D1V1k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 17:27:40 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46915 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245Ab1D1V1j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 17:27:39 -0400
Received: by fxm17 with SMTP id 17so2109073fxm.19
        for <git@vger.kernel.org>; Thu, 28 Apr 2011 14:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=BxnrE+VjR9eJcSgjaP98ZWfvSOIMLhWjIf9+A50XtAo=;
        b=ihIVp/XOlJdm8wxBf+yvZWjsh65eQqYXPiig8wsxCux21+vyiemje9xNhB8Hi0kC0B
         elLCklryvn7txF4XFySS3jGeaDdq4S83APH3b3n3g2zAqttKG+jeKgJGuZGG0pSJBdxM
         yjcnr+W3MByNDbpOzr8fPZSf/hVTX3VFpTR2I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=XbCZcMvxvaLtIYxufrJ1VQBUGGm7QGpEFvp5qHX31XAI2wCU+IquXDZ9EmMVsreXKB
         tMhfFX5D7+JsyqgEFCqmgkP0H8PYbVU9A6QDPW06sVgJN4k24wHzaNiQT+53Mps5z8xb
         RkBxAkCf7zj9TaKhCIT7u1BA8YQgaCWdXvr5w=
Received: by 10.223.100.86 with SMTP id x22mr1944334fan.108.1304026058489;
 Thu, 28 Apr 2011 14:27:38 -0700 (PDT)
Received: by 10.223.74.130 with HTTP; Thu, 28 Apr 2011 14:27:37 -0700 (PDT)
In-Reply-To: <7v4o5i3xqk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172410>

On Thu, Apr 28, 2011 at 11:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Nice! Much better approach.
>>
>> I also noticed that behavior when not defining 'words' as local, but
>> though modifying all those instances was overkill.
>>
>> Acked-by: Felipe Contreras <felipe.contreras@gmail.com>
>
> Do you mean reviewed-by or even better tested-by?

Right. Reviewed-by.

-- 
Felipe Contreras
