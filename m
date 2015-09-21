From: Luke Diamand <luke@diamand.org>
Subject: Re: git-p4: nicodeDecodeError in ./t9822-git-p4-path-encoding.sh
Date: Mon, 21 Sep 2015 08:52:33 +0100
Message-ID: <55FFB741.4080304@diamand.org>
References: <55FFAB62.8050106@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 21 09:52:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zdvtv-0005ML-5H
	for gcvg-git-2@plane.gmane.org; Mon, 21 Sep 2015 09:52:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755987AbbIUHwf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 03:52:35 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:36348 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755839AbbIUHwe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 03:52:34 -0400
Received: by wicgb1 with SMTP id gb1so102452760wic.1
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 00:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=9robWHhcFGcIV0VHFVMwrWf5xjWqVqyOizKhlvjGe9E=;
        b=Bg3cjMs20ZZ03D6t6N+hd53HctD1mazwJeXNLdNWRE18sfLKRR0h+ngpPU5UmPpgxh
         SzjSuNNq7nqxkyTFAw3auAIXpxUMzgd7rxPmyT5clAkgBJCI98WajxfUAGN4h7HeGRSR
         gyXn9uq5UNO463DTn0TCiQeNsc7a5PoYNtUqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=9robWHhcFGcIV0VHFVMwrWf5xjWqVqyOizKhlvjGe9E=;
        b=Yq/OvLBkErAluPKLWTY23CIYNISA2YVz0G2S0HCGwnDdjykUcGLNGeY2WgRaGMg+07
         Yz6+wlbeHkukise7i7pMiU36fvrTWPS3tFyAZSzciC+aGtGLSL1F8sE8NpfjVhCFXkv3
         bkpEO9uOLg+ly+qYy4qKmDDsTbovlZtfXBdloU4cxmXmEsKduiRUF8IFq14g1tpMBQxM
         R+IaiUU6I32VomoF8A3RdNIJT++vbbpLVCvcg285X7ZgH8QCPDszeGOeHxd9vi+lbxwp
         BLJ58C+uJ4amdobJnSjtuBsMRn2dh28eey3ZXFhDWHqPCqj1SWVofutK6ClCnCa0g3iJ
         qKgw==
X-Gm-Message-State: ALoCoQk1K3Ve9ti923JAkkvsMaahpruiUsccuyT5yus+v78t8VhRLkGz0mjtgxKVVQEYYahA2yG6
X-Received: by 10.180.93.131 with SMTP id cu3mr542742wib.8.1442821953482;
        Mon, 21 Sep 2015 00:52:33 -0700 (PDT)
Received: from [192.168.245.128] (cpc12-cmbg17-2-0-cust914.5-4.cable.virginm.net. [86.30.131.147])
        by smtp.gmail.com with ESMTPSA id qq4sm22632962wjc.14.2015.09.21.00.52.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 21 Sep 2015 00:52:32 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <55FFAB62.8050106@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278286>

On 21/09/15 08:01, Luke Diamand wrote:
> Lars,
>
> When I run t9822-git-p4-path-encoding.sh, the last test fails (it's
> supposed to pass) with the following backtrace.
>
> This is with 'next' at 3dd15c02a81a280c83c8d5e32c6cb71a64177ca6.
>
> Any ideas as to what I'm doing wrong?
>

I think this is probably user error!

Luke
