From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] merge: --no-ff configuration setting
Date: Mon, 22 Feb 2010 21:55:26 -0800
Message-ID: <4B836DCE.7010606@gmail.com>
References: <1266807555-86199-1-git-send-email-bryanalves@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Bryan Alves <bryanalves@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 06:55:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Njnk8-0001vz-Ao
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 06:55:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310Ab0BWFzb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 00:55:31 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:43505 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254Ab0BWFza (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 00:55:30 -0500
Received: by gwj16 with SMTP id 16so363809gwj.19
        for <git@vger.kernel.org>; Mon, 22 Feb 2010 21:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=/aW7Qaw78WFXLqllb892pSGTelhrqDcBMocJv083y34=;
        b=hUuaVnLDT827HuR9yRIVy6nZQftbmxeS9Mh+yIOsPvd6lk+7ztJPm2zvurDyxB2CC8
         1WPJTo2KWYDpSprIPTuiQQvdE8YEMNVqL4GhM9KrP5Y3IFPFSlsxJnoD71z0WoKt+eAg
         pknV7aI0N5SByKM4y2AuyTXVnUeXvefvmmeMs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=OccoI/jpKV1WTcMd4zgz+kH6OP1sfekHTXKhpbz0mbidoCG3RF+BQZRqcOQrqHNjVM
         63h/YpWoWTaGDe1++TFW56TkPH9epuQfUOPB7a7JcHkD0MKFGX+lXlmVBMxknujqGysh
         dXSO7Xf6AZjFeJxGtJ0oJ0pPcfy/iTFcB41jw=
Received: by 10.150.120.30 with SMTP id s30mr1892806ybc.284.1266904529327;
        Mon, 22 Feb 2010 21:55:29 -0800 (PST)
Received: from ?192.168.1.5? (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 23sm78249yxe.19.2010.02.22.21.55.27
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 22 Feb 2010 21:55:28 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.7pre) Gecko/20091214 Shredder/3.0.1pre
In-Reply-To: <1266807555-86199-1-git-send-email-bryanalves@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140768>

On 02/21/2010 06:59 PM, Bryan Alves wrote:
> Add a new configuration option, merge.allowfastforward
>
> When set to false, causes --no-ff to be the default behavior
> for merges. When set to true, or not present, the default
> behavior is unchanged, and acts like --ff is set.

The subject says --no-ff configuration but the option is for --ff.
Sounds confusing. In other words, shouldn't it be
merge.disallowfastforward or merge.nofastforward? Or maybe the subject
should be "merge: --ff configuration setting"

Also could you just use branch.<name>.mergeoptions and not introduce yet
another config option? Or maybe there's some reasoning why you always
want to have merge commits in your workflow?

Finally if this goes in please add a description to Documentation/config.txt
