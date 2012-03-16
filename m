From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Re: Edit a rerere conflict resolution
Date: Fri, 16 Mar 2012 17:37:51 +0100
Message-ID: <4F636C5F.1060509@lyx.org>
References: <4F5E4B20.5080709@lyx.org> <7vobs1r3kn.fsf@alter.siamese.dyndns.org> <4F636227.2060102@lyx.org> <7vaa3gilg7.fsf@alter.siamese.dyndns.org> <4F636700.2090105@lyx.org> <7vvcm4h61a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 16 17:38:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8aAC-0002kP-MQ
	for gcvg-git-2@plane.gmane.org; Fri, 16 Mar 2012 17:38:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161519Ab2CPQh4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Mar 2012 12:37:56 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:39279 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161272Ab2CPQhy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2012 12:37:54 -0400
Received: by eekc41 with SMTP id c41so2238312eek.19
        for <git@vger.kernel.org>; Fri, 16 Mar 2012 09:37:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=3KybiCg7WcdsCxgXRYYQqBOKkzbFel9XIzKHwYUuNO8=;
        b=im9St3V1BxxMm5QGCd/0lXsKXqLlNkjw4DphuMhH2ZtUAlnLijOFkUIXoEP++pVEnh
         et3g+vHbfyqxJ4ZcH5pkJUhZVwc2SJtp4YANCnmJXFTbfMCV/mWkSarquDBJrrJ1vHw5
         62mskay6f9w2FGLspZYfzQsmYbLPq0DrQu5PCdyQXNGfeMfXQdmYsU19aZFE+e1SBBGg
         M+YXuLfVHpN3sW6eN4P16FbD0X/LeFgbwSR3rnTDtOqn9+Tn2ea45+C4AWcEmZLL3NmH
         Qa75GsghN0W3QR2vcYz3D9wlF3eedR+aIv4GU3x41DNt04oNpvQaklSjPUQdv3NdJYRj
         GnwQ==
Received: by 10.14.98.206 with SMTP id v54mr413117eef.82.1331915872998;
        Fri, 16 Mar 2012 09:37:52 -0700 (PDT)
Received: from [192.168.1.4] (j175101.upc-j.chello.nl. [24.132.175.101])
        by mx.google.com with ESMTPS id n56sm20180058eeb.4.2012.03.16.09.37.52
        (version=SSLv3 cipher=OTHER);
        Fri, 16 Mar 2012 09:37:52 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <7vvcm4h61a.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQkPuRyS5FtnzhkR/OVuP9BIhGbKX5ZM2zsqxbdDCnV6CrrpDh2dfFhPdak98RyzrFW3euKI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193276>

Op 16-3-2012 17:20, Junio C Hamano schreef:
> Vincent van Ravesteijn<vfr@lyx.org>  writes:
>
>> No, I turned rerere.autoupdate off. Proven in the above by the line
>> "Resolved... " instead of "Staged...".
> Yeah, actually I just tried and the procedure works with or without
> autoupdate for me.
>
> So there is something different between our setup (or the nature of the
> conflict), but I do not know what it is offhand.

Hmm.. The behaviour seems to be different for the "official Git for 
Windows 1.7.9" as for the version I compiled myself with MSVC.

First, the sha1s in the rerere cache differ. Second, when using the MSVC 
version to generate the preimages and resolutions, I can use both 
version to forget the resolution again.

Maybe another EOL-style problem ?

Vincent
