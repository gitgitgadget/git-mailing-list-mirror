From: Sergio Callegari <sergio.callegari@gmail.com>
Subject: Re: git fsck not identifying corrupted packs
Date: Mon, 19 Oct 2009 12:56:07 +0200
Message-ID: <4ADC45C7.6090907@gmail.com>
References: <loom.20091019T094924-194@post.gmane.org> <4ADC2D45.3020803@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Oct 19 13:01:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mzpus-00050W-Hi
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 12:56:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755954AbZJSK4W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 06:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755930AbZJSK4W
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 06:56:22 -0400
Received: from mail-fx0-f228.google.com ([209.85.220.228]:33339 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755899AbZJSK4P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 06:56:15 -0400
Received: by fxm28 with SMTP id 28so5000714fxm.18
        for <git@vger.kernel.org>; Mon, 19 Oct 2009 03:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=R0DPPyRDzgmTiJqRQSmWd0JsKU++BaiyBrD5wzvi3KM=;
        b=Ha6QxbGNdSqsxOkJBiv1WRjNGOd1kYh/iEEmwnd4Ex2VOO2llLPFotiv+oD+Zu23f1
         GR8+YBkW2gGP+jXDR0PaMrYSEqTQuiNvwwwovoGq5TQ63PAHpnpJxjqgsWpDX1szm9TF
         MjTemJTMeBP76BJqbYhMAN+00+bpBE25pjcQs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=Wq6wuSj93Q31nqwEhIqla8HJ/279R1g3lNw1ShkTQrrmqU8Sz8GOwYZi17f51t0qVO
         0+6d3NwgQHBxPEeQtzODUGYPQOdQA8yAefVwNmNfXSaRAX+FtrXu2Ap67gpVnL1afQXt
         BCVdd6ge4Lt3XmHOw/Cf5Vv6wViPiPRp9aY/E=
Received: by 10.204.148.78 with SMTP id o14mr4770412bkv.83.1255949779528;
        Mon, 19 Oct 2009 03:56:19 -0700 (PDT)
Received: from ?217.202.50.117? ([217.202.50.117])
        by mx.google.com with ESMTPS id 4sm3627738fge.17.2009.10.19.03.56.13
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 19 Oct 2009 03:56:18 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <4ADC2D45.3020803@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130689>

Johannes Sixt wrote:
> Sergio Callegari schrieb:
>   
>> Is there a means to have fsck to a truly full check on the sanity of a repo?
>>     
>
> git fsck --full
>
> RTFM, please.
>
>   
Right... sorry for the noise, I mismatched --strict for --full in a script.

BTW, the short help for fsck at --full only says "consider objects in 
alternate repositories".

My apologize.

Sergio
