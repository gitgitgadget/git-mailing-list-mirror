From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 12/18] Documentation: Preliminary docs on 'git notes merge'
Date: Sat, 02 Oct 2010 01:55:33 -0700
Message-ID: <4CA6F385.7030207@gmail.com>
References: <1285719811-10871-1-git-send-email-johan@herland.net> <1285719811-10871-13-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jrnieder@gmail.com, gitster@pobox.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sat Oct 02 10:55:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1xsj-0007kO-Qx
	for gcvg-git-2@lo.gmane.org; Sat, 02 Oct 2010 10:55:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752992Ab0JBIzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Oct 2010 04:55:43 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:42231 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752071Ab0JBIzn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Oct 2010 04:55:43 -0400
Received: by pzk34 with SMTP id 34so946176pzk.19
        for <git@vger.kernel.org>; Sat, 02 Oct 2010 01:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=VYTh9ljF+a/PTsavBwb/LFYlBaIC3GbpQ8sLMjJIMfg=;
        b=CVUrIxrRAHeUpoEU9g2Au/Eg9lyv5R1dnO2DtqxjhFu+HnMkCD7R8yT16IpmE5B1yB
         ydwYGs7XFQIDlYAy+EeeE3q8dSGnuWCRma8GrB/4PF7t9w3j24FzWs5NweUe4QTIGZS7
         i+d7xCagoTvsSzBjhWuIB/Ndd3QbkPj/Xvx4g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=Wbtvp3NgisDGOlbQxSt2m+pFuhIJl/Ujou0KNkXejp6bN/hNefG13Dv0g7zq4z2fu7
         x9XOZMmgKO5Ckp8vqorktNP+aWij4ujIIaJqCa7cTJIEky9zetNTFgnf/rNa51LfgfpP
         8o9TSGkceCcyHzxPIhuMAbRwzw/H22Aj3ql6Y=
Received: by 10.142.253.21 with SMTP id a21mr5884307wfi.138.1286009742712;
        Sat, 02 Oct 2010 01:55:42 -0700 (PDT)
Received: from [192.168.1.100] ([75.85.182.25])
        by mx.google.com with ESMTPS id v6sm2576516wfg.15.2010.10.02.01.55.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 02 Oct 2010 01:55:41 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.8) Gecko/20100831 Lightning/1.0b2pre Thunderbird/3.1.2
In-Reply-To: <1285719811-10871-13-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157803>

On 09/28/2010 05:23 PM, Johan Herland wrote:
> ++
> +If conflicts arise (and a strategy for automatically resolving
> +conflicting notes (see the -s/--strategy option) is not given,
> +the merge fails (TODO).

Unbalanced '(' here. Can you just drop the first one?
