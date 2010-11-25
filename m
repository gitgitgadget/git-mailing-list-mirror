From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2010, #03; Wed, 24)
Date: Thu, 25 Nov 2010 11:42:50 +0800
Message-ID: <4CEDDB3A.6070201@gmail.com>
References: <7vk4k2rt2m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 25 04:43:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLSjd-0007Dm-RN
	for gcvg-git-2@lo.gmane.org; Thu, 25 Nov 2010 04:43:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484Ab0KYDm4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Nov 2010 22:42:56 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:58757 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237Ab0KYDm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Nov 2010 22:42:56 -0500
Received: by pva4 with SMTP id 4so103669pva.19
        for <git@vger.kernel.org>; Wed, 24 Nov 2010 19:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=u23pbLr0QmwN7UUsu/vGQVazj4bJnm89fp/vFVu7kv4=;
        b=kUTxPMMCwx+2RZ56UYW6tCA6XwpEpkWAQzLUYmfisSpRkv1Fq3qo+btsXtpIDPocXz
         gam3Xb7iI8mnUrr+11VURkEqx0HpvALFSly+9afEzesQCmww916JWM5mQoZvqHZl2js+
         pbbUxkr/PdPoy5XBRmgOR0h/579mRHaDE0tgc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        b=iEvfCNQZlBylLfJu+FnBeXwPoQvE3grC9M00mPim4wA6V9orWSRL4JfXaxpcmygVoP
         sH6zigZwJg9/AjR02SJkpvpI6gncUkk0Nh77fyNbUEFqojCqXqH6U/blpn2oQ6NeLUNu
         kg1AD1jwVzgXScqDyI88ahcqpt9CnRhfZtF9s=
Received: by 10.142.225.1 with SMTP id x1mr190719wfg.0.1290656575621;
        Wed, 24 Nov 2010 19:42:55 -0800 (PST)
Received: from [192.168.0.50] ([123.115.150.125])
        by mx.google.com with ESMTPS id x35sm323435wfd.13.2010.11.24.19.42.52
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 24 Nov 2010 19:42:54 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); zh-CN; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <7vk4k2rt2m.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162102>

=E4=BA=8E 2010=E5=B9=B411=E6=9C=8825=E6=97=A5 11:16, Junio C Hamano =E5=
=86=99=E9=81=93:

> * fc/apply-p2-get-header-name (2010-10-21) 2 commits
>   (merged to 'next' on 2010-11-17 at 05a8e94)
>  + test: git-apply -p2 rename/chmod only
>  + Fix git-apply with -p greater than 1
>=20

I see these commit in next, do the same fix I just send to this list
([PATCH v2] git apply: apply patches with -pN (N>1) properly for some c=
ases).

cefd43b7f9b86b1c5de5216a8a03fac5e611afa9
aae1f6acf1984f4ae4453ad299a1fa4d261fb188
