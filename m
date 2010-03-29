From: Gabriel Filion <lelutin@gmail.com>
Subject: Re: [PATCH v7 1/2] Documentation/remote-helpers: Rewrite description
Date: Sun, 28 Mar 2010 21:17:31 -0400
Message-ID: <4BAFFFAB.4080808@gmail.com>
References: <f3271551003281103x68812b3cj806d6235965f0a32@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 29 03:17:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nw3c3-0006iP-1L
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 03:17:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755550Ab0C2BRm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Mar 2010 21:17:42 -0400
Received: from mail-qy0-f188.google.com ([209.85.221.188]:59250 "EHLO
	mail-qy0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755521Ab0C2BRi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Mar 2010 21:17:38 -0400
Received: by mail-qy0-f188.google.com with SMTP id 26so596740qyk.19
        for <git@vger.kernel.org>; Sun, 28 Mar 2010 18:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=GRyZoF9U478cbBbWYDw0XL/SQ3tjoTKj+oUr66Jfbw0=;
        b=sWfcMfeUQI3/kReNvtlvlX6a3E+xcXBwronZVzhgULirNNvJlwl9PCYUemnaMT0i8T
         DOwZYwysZWqLIykStL1ReUxvmgovuOMqbpr2OmL6utHAGx2ToBiWxkHIoDmCJ73dwhkY
         9Lq+wDxpjRF8zHMEqopbgzxsd4EPdBmm2BimQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=XmetQDc4AbamCez7rKep70m+r2j1ocvOCod7xkY7IhW3VjZ006yttjrfeuQvz79UuJ
         zfRlM2kfPjZjGwfnHD25iSdfcV3oyLgWQTP8nJk2x4YLQ3AiRRN4S26T+WgqB2RFEvAl
         JX2G6C4fCJqkwMrDXsTj+SBreBOc2XQTotNOs=
Received: by 10.229.222.205 with SMTP id ih13mr3563148qcb.73.1269825457441;
        Sun, 28 Mar 2010 18:17:37 -0700 (PDT)
Received: from [192.168.2.202] (dsl-148-189.aei.ca [66.36.148.189])
        by mx.google.com with ESMTPS id 20sm2220052qyk.0.2010.03.28.18.17.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 28 Mar 2010 18:17:35 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.5) Gecko/20100108 Lightning/1.0b1 Icedove/3.0
In-Reply-To: <f3271551003281103x68812b3cj806d6235965f0a32@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143425>

Hello,

On 2010-03-28 14:03, Ramkumar Ramachandra wrote:
[...]
> diff --git a/Documentation/git-remote-helpers.txt
> b/Documentation/git-remote-helpers.txt
> index 1b5f61a..1304813 100644
> --- a/Documentation/git-remote-helpers.txt
> +++ b/Documentation/git-remote-helpers.txt
[...]
> @@ -12,11 +12,31 @@ SYNOPSIS
[...]
> +repositories. They implement a subset of the capabilities documented
> +here, and conform to the "remote helper protocol". When git needs
> +needs to interact with a repository served by a remote helper, it

Oops, "needs" is repeated twice here...

Apart from that, it seems nice and helps to better understand what they
should be used for.

It doesn't really concern this patch but If I'm not wrong, there still
is no documentation written on how exactly git invokes the remote
helpers. A good description was given previously by Ilari Liusvaara (so
I've added you, Ilari in the cc list). The description can be seen here:

http://lists.zerezo.com/git/msg712892.html

Should we add this information on this man page?

-- 
Gabriel Filion
