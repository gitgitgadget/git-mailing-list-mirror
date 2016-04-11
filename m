From: pedro rijo <pedrorijo91@gmail.com>
Subject: Re: meaning of SP on ls-tree docs
Date: Mon, 11 Apr 2016 18:23:11 +0100
Message-ID: <CAPMsMoA4mr2-OJzNq6iOh8DsjaH+=z_ZMQKEut1f3+drG2hKew@mail.gmail.com>
References: <CAPMsMoDKCwCL17SZt8AZyX_6WyiAMHGWJ2S77QBc983uHtYL6g@mail.gmail.com>
 <20160411201528.f09b4b27259ae84e01d1e5a4@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>
To: Konstantin Khomoutov <kostix+git@007spb.ru>
X-From: git-owner@vger.kernel.org Mon Apr 11 19:23:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apfZ8-0007yf-4J
	for gcvg-git-2@plane.gmane.org; Mon, 11 Apr 2016 19:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752792AbcDKRXy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2016 13:23:54 -0400
Received: from mail-lf0-f46.google.com ([209.85.215.46]:36487 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085AbcDKRXx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2016 13:23:53 -0400
Received: by mail-lf0-f46.google.com with SMTP id g184so167098038lfb.3
        for <git@vger.kernel.org>; Mon, 11 Apr 2016 10:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=t1SiNj1ELfM1n6mFwx1g+WBuyxvWPrri9+CAZal0oPc=;
        b=U5NeAwjmF+ZHZVwJR7JP+vFoiYDj8A5YNhUCt3kh+Lf4Z2LxD/cKLH4Hs3Z6ZhrFHB
         lgZQHyK30nB+FQMuvhQU79V6Dg2xMI86OZsfKOGQjYZ779ohNi3fAozihZI9ygQ6ocW8
         yTSXqFHNwwsv3ivgSe3Z6S9gjsnF72xzNXcAijDonPpRmXvNFhMDbTP/EymJrP82jR+D
         Nr5BcKQN1GDUo/gQ+MM1TcF9z3FGxnMjKD0xgreYzPKzUGD8xOkdMX5vmhWJDEzmu5J7
         BKMn8vIkKoSHVbii8F8fhQrpPts0eyJSk28M3OCDCcv+GpUyvk8DchdDiT72NocTCtlf
         +itw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=t1SiNj1ELfM1n6mFwx1g+WBuyxvWPrri9+CAZal0oPc=;
        b=GN5eGyCpT9vwduTAfaAXUXSsK1tRdlZYjzcv1RketLT/VdQMV05logKYct0uaIMscW
         mIRGqt6S8dALHt1w3FHDA3oOZtSweuqo3HekKZRk6i0dZqlRI5FAXANF1rnQfjj9h7wN
         vDTaEb+l/c9+YsyUoA2MZWs8D6AuPWh6vl6/78GGw0fAp4SLvgsLZkNgrY7YjEnhARL2
         h6Aim0mN3rebMgei/KmwoMI5Zi9LLwoGhf8Y7IMD2lXbQj6o5hH8KJOUKX1GCe9WHVj/
         v0vymYcZgTX5yLF4EQfEETHBiJckb2/qjoczh3qEv9jfdjIkMejzvxrCUO/0JWRw1xE2
         +dSg==
X-Gm-Message-State: AD7BkJIDM9p9JnD0QiOchGWdpDK2kdSA8/xBsHscXVN/S9SZh9EK+57rgjXL1BDlqX9CVgBYMKokFmugftZgAw==
X-Received: by 10.25.20.106 with SMTP id k103mr6728657lfi.149.1460395431528;
 Mon, 11 Apr 2016 10:23:51 -0700 (PDT)
Received: by 10.112.239.6 with HTTP; Mon, 11 Apr 2016 10:23:11 -0700 (PDT)
In-Reply-To: <20160411201528.f09b4b27259ae84e01d1e5a4@domain007.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291223>

ups :) Thanks

2016-04-11 18:15 GMT+01:00 Konstantin Khomoutov <kostix+git@007spb.ru>:
> On Mon, 11 Apr 2016 18:04:42 +0100
> pedro rijo <pedrorijo91@gmail.com> wrote:
>
>> On https://git-scm.com/docs/git-ls-tree#_output_format, the format is
>> presented as <mode> SP <type> SP <object> TAB <file>
>>
>> But what is SP? Couldn't find the meaning. Space? System separator?
>
> A single space character, code 0x20 in HEX or 32 in decimal.
> TAB is a single TAB character, code 9.



-- 
Obrigado,

Pedro Rijo
