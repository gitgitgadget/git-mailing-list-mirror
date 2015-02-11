From: Aleksander Boruch-Gruszecki <aleksander.boruchgruszecki@gmail.com>
Subject: Re: [PATCH v2] merge-file: correctly open files when in a subdir
Date: Wed, 11 Feb 2015 22:20:40 +0100
Message-ID: <CAPHKiG6Hbz8fDNbXTN=_5m3bHxHQQfVFJREXyro=HxQPNOQ6=A@mail.gmail.com>
References: <CAPHKiG7vzKbtH7=cXD-7Cta=a-iy-ViMustn98z+VEog5ep2sg@mail.gmail.com>
	<xmqqwq3pv60p.fsf@gitster.dls.corp.google.com>
	<CAPHKiG6M9_fOjpx8Pt8UTpUcrS+tmqL3YcT11WyJJu8m6nkJ4A@mail.gmail.com>
	<xmqqd25gux4r.fsf@gitster.dls.corp.google.com>
	<xmqqtwystgoa.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <stefanbeller@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 22:20:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLeiF-0004Ps-7T
	for gcvg-git-2@plane.gmane.org; Wed, 11 Feb 2015 22:20:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753934AbbBKVUm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2015 16:20:42 -0500
Received: from mail-qc0-f195.google.com ([209.85.216.195]:59806 "EHLO
	mail-qc0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753160AbbBKVUm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2015 16:20:42 -0500
Received: by mail-qc0-f195.google.com with SMTP id l6so1973803qcy.2
        for <git@vger.kernel.org>; Wed, 11 Feb 2015 13:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=nYXwDSyPvJTBTFhu+RvldfFi/wKqbxDFB8HigPGOlrU=;
        b=Fh0RNHofQBgAehWg4EI7wLkHSV5dmR8edfI8zjyXkXKCFE+VJY1DAYxDToPPI7aFAQ
         juFlIGwVY3CrembHYamCcIEpb8NiOMeNhhwu0K8YX8ASAvrFLqHlwhu6e7MNsxyUKKMo
         bueer/XC+vzUeoQYw64W/QYA4GTertmOVH32Ti+7DDfvosNFwnsNNjjaqhihCUZodGV9
         R7ye1GLT0vdh5F4MFc1FTe3x/XN8VYjSrxta9RadDTNGU+YuW9lgRelkKk5C4j6zHSEg
         YC67263l8lm9OnBN+v8Zrd2Oly3Adqb1YkACygzKtJYE96WAnCaC5M56a7TIjPETGfsS
         sA6Q==
X-Received: by 10.229.19.68 with SMTP id z4mr1612352qca.14.1423689641045; Wed,
 11 Feb 2015 13:20:41 -0800 (PST)
Received: by 10.140.83.166 with HTTP; Wed, 11 Feb 2015 13:20:40 -0800 (PST)
In-Reply-To: <xmqqtwystgoa.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263692>

> Here is what I have right now, queued somewhere in 'pu', after
> fixing it up a bit.

That's awesome! Thanks for your help :)
