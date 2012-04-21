From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add column layout skeleton and git-column
Date: Fri, 20 Apr 2012 22:40:39 -0700
Message-ID: <xmqqfwbxzlpk.fsf@junio.mtv.corp.google.com>
References: <xmqqlilpzpiz.fsf@junio.mtv.corp.google.com>
	<1334983472-3172-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 21 07:40:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLT3v-0008MW-Mf
	for gcvg-git-2@plane.gmane.org; Sat, 21 Apr 2012 07:40:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751609Ab2DUFkm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Apr 2012 01:40:42 -0400
Received: from mail-wg0-f74.google.com ([74.125.82.74]:37368 "EHLO
	mail-wg0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425Ab2DUFkm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Apr 2012 01:40:42 -0400
Received: by wgbdt11 with SMTP id dt11so546763wgb.1
        for <git@vger.kernel.org>; Fri, 20 Apr 2012 22:40:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=d6BXegm3ACIz+a3TX9a7nIZhXUQhPHT2o4AskFJzEQk=;
        b=LsrK+hwTfdeBufnBv9yeZ+AHTsoNWhmCfLSTXGXaoOSZFnIe3zBMCrCOocS5a5usgR
         vRnZ1tvVbCMewI1A8KBTDU5Duq9Ad/ZQ0JSH0n5FVtHpyvddO9SGTxBdd0fHEhkCnTC7
         3/B7a9LKmiqCDfAcvEuZduJkR7M7VmNqijiED5eYgNLE17TvfT8hqkgBwBh3mjtANhAf
         bm0pIOrVPAqwiPfWxSRtjBX7KLTTdsdQ2Jr10vH3aKOhPKdll9qlMv7LNWWAldKWFlzA
         +5bdwgJ/MXZsIW1rLLVf2cirp4j2VAhWNPC1TvEpRjBHKaQXp6JM9RwGdV23mIWmGZ8S
         AEvw==
Received: by 10.14.188.12 with SMTP id z12mr2445050eem.8.1334986840903;
        Fri, 20 Apr 2012 22:40:40 -0700 (PDT)
Received: by 10.14.188.12 with SMTP id z12mr2445040eem.8.1334986840791;
        Fri, 20 Apr 2012 22:40:40 -0700 (PDT)
Received: from hpza9.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id s9si7456576eei.3.2012.04.20.22.40.40
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Fri, 20 Apr 2012 22:40:40 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza9.eem.corp.google.com (Postfix) with ESMTP id 9393C5C0050;
	Fri, 20 Apr 2012 22:40:40 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id DCE1FE120A; Fri, 20 Apr 2012 22:40:39 -0700 (PDT)
In-Reply-To: <1334983472-3172-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 21
 Apr 2012 11:44:32 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQnLOtPhduu3qrhCEb8KwpAWVlKmaMMbMRnmsXwyhZ7fiAMj/hVOmFn5ZYR7/0m0F4zWcUrX1FsnPuPW6vQyNXkA1psE688adLU9IcJoWgmX8kNY5/VBBtg8N6z1u+UbdnwbPNkYYLN6Qum/UPeImER/HNN12KBcAd05/6yVHVw9gBROTzI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196041>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

>  2012/4/21 Junio C Hamano <gitster@pobox.com>:
>  > Am I looking at the correct version?  Somehow I thought you elimin=
ated
>  > this confusingly named macro in the previous round.  Two steps for=
ward,
>  > one step backward???
>
>  Aah.. the beautiful result of having the same series (but probably
>  different versions) across several machines.. This version should be
>  the right one with fixes.

Yeah, this looks more like it.

Will replace 1/9 with this and requeue.
