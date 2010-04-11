From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] t3507: Make test executable
Date: Sun, 11 Apr 2010 10:36:04 -0700 (PDT)
Message-ID: <m339z1hoyv.fsf@localhost.localdomain>
References: <1270975426-17459-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 11 19:36:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O115I-0003aN-8Z
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 19:36:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752597Ab0DKRgI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Apr 2010 13:36:08 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:48221 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752412Ab0DKRgG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Apr 2010 13:36:06 -0400
Received: by fg-out-1718.google.com with SMTP id 19so994587fgg.1
        for <git@vger.kernel.org>; Sun, 11 Apr 2010 10:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=62ylDOivu5apotCg13er4LLlFp/xUaU8QRhDVkdB6Zc=;
        b=Go8uJ5SvqdgpbDYqyvNDJohw9hu9TfvJCnsAEqygjj2gGAEh7MQUutHi/t3bJLZNkK
         S5a+eqszMgqbvWCOqgIm6AGr5FR4c7t0BODouuTJ3STnsiWNoI7uJLw9+QxdEmHsfZ8t
         /PfgjeVHh7qavlYPFBDJOlJE1fMivqDFKmYVk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=ttMV8oxVSigkVF+OXJYAPKrykzwWwP58q68UGNq0fccSzu/jkTJFGpt9IWDphgdcN1
         uKVoICqafA2qESwDjG66AUoIgD+IfkkQ2f6OOVRCn1GXFQcIwZWr1Nl+erDvFZcDZWyF
         NvzMV5NNInv7jyv0QfXnD/Yl1VZH71oVBWvKs=
Received: by 10.87.47.17 with SMTP id z17mr3166488fgj.39.1271007364603;
        Sun, 11 Apr 2010 10:36:04 -0700 (PDT)
Received: from localhost.localdomain (abwq147.neoplus.adsl.tpnet.pl [83.8.240.147])
        by mx.google.com with ESMTPS id l19sm1040185fgb.13.2010.04.11.10.36.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Apr 2010 10:36:04 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o3BHZbFC009020;
	Sun, 11 Apr 2010 19:35:48 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o3BHZLWk009016;
	Sun, 11 Apr 2010 19:35:21 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1270975426-17459-1-git-send-email-bebarino@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144664>

Stephen Boyd <bebarino@gmail.com> writes:

> Signed-off-by: Stephen Boyd <bebarino@gmail.com>
> ---
>  0 files changed, 0 insertions(+), 0 deletions(-)
>  mode change 100644 => 100755 t/t3507-cherry-pick-conflict.sh
> 
> diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
> old mode 100644
> new mode 100755

While at it: should t/test-lib.sh be executable?  Other t/*lib*.sh
files are not...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
