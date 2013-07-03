From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [RFC/PATCHv3] submodule update: allow custom update command
Date: Wed, 03 Jul 2013 20:50:02 +1200
Message-ID: <51D3E5BA.1090408@gmail.com>
References: <7vehbii6un.fsf@alter.siamese.dyndns.org> <1372759974-19765-1-git-send-email-judge.packham@gmail.com> <51D3064C.80901@web.de> <CAFOYHZC1xMt2eqaNm0vtLVJ3X2TNjRxa3sEjBPmHVeHrQmSc4A@mail.gmail.com> <51D3CAE8.50509@web.de> <51D3D8CD.5090804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: GIT <git@vger.kernel.org>, iveqy@iveqy.com,
	stefan.naewe@atlas-elektronik.com, hvoigt@hvoigt.net,
	Junio C Hamano <gitster@pobox.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Jul 03 10:49:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuIkR-0006EF-63
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 10:49:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462Ab3GCItF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 04:49:05 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:61791 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932342Ab3GCItC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 04:49:02 -0400
Received: by mail-pa0-f46.google.com with SMTP id fa11so7319500pad.33
        for <git@vger.kernel.org>; Wed, 03 Jul 2013 01:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=vTbJQcgy9EeosYjZkLThyHFfx58CyOAdzwB4aNGx+MY=;
        b=nt0dKZS0CiY3Jou5Tx4UXV8h8ze/wYnH5qdcODNRgLaskfhianC6fV2qk/UZ4J3Wid
         YDcDwN8Pr+TlojXWssCTHW7uG/xmXEczgVmvKt7Ib5E92osdaBX/H018RKtRaExCLrZZ
         HswTeL5qgTHFpS9PPZoIee812GjP7UADPA46k6oPSUKE3vZWcC4txM7ASALS39yqHGKo
         paQzRzJkph/1TF5S8ffYNmvrbxiPXenRW+u2bGPW6h03aG66iJ/nw9i9buLGsTRxFkdP
         60bF+TfaYxkovT6ZibWYr/ThzfjZxLjQu0bc02JOgeAKXeDu5WRpSsoFz79TwNesmQ50
         LLcw==
X-Received: by 10.67.2.71 with SMTP id bm7mr1369556pad.144.1372841341492;
        Wed, 03 Jul 2013 01:49:01 -0700 (PDT)
Received: from laptop.site (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPSA id br1sm30897388pbb.4.2013.07.03.01.48.58
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 03 Jul 2013 01:49:00 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <51D3D8CD.5090804@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229468>

On 03/07/13 19:54, Chris Packham wrote:
> On a related note should I be updating Documentation/config.txt as well?
> Even if it's a statement that this feature exists refer to
> git-submodule(1) for details.
> 

Answering my own question. While 'update' is mentioned it's possible
values are not.
