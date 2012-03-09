From: Dominique Quatravaux <domq@google.com>
Subject: Re: [PATCH 2/2] rebase -i: new option --name-rev
Date: Fri, 9 Mar 2012 08:58:05 +0100
Message-ID: <CAJh6GrFRaW7HdRjdxWvt=8cC6qfDz5BJESJGKqR3Bymg7SDb2A@mail.gmail.com>
References: <1331203358-28277-1-git-send-email-domq@google.com>
 <1331203358-28277-2-git-send-email-domq@google.com> <87399jnyxh.fsf@thomas.inf.ethz.ch>
 <CAJh6GrFKJw1506c6nOzh+EcNe7E_UM=NxV_yBPWx9BUCdpAvAg@mail.gmail.com> <7veht2ex7v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 09 08:58:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5uie-0002Qz-6v
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 08:58:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753390Ab2CIH61 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Mar 2012 02:58:27 -0500
Received: from mail-wi0-f178.google.com ([209.85.212.178]:38346 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289Ab2CIH60 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Mar 2012 02:58:26 -0500
X-Greylist: delayed 65039 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Mar 2012 02:58:26 EST
Received: by wibhq7 with SMTP id hq7so242540wib.1
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 23:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding:x-system-of-record;
        bh=hlPR0lAVsU2zUi4zmxShS3XAnT34+ElU5tEf62fw59s=;
        b=CTBdUjXeZ2PoPt+uYCI9V/yG/nLr38r7HpS1LhdeqTuoKI7g61dJZJs+2t+Nq9Pz44
         F/0YD9KJGZPwK9GXfPtKirph2y6ZxKCCM0j2QpiuzZWJFm6t2WjxlfZyE5GNIwka3XIj
         bAJ9v6Xx4OujYYU9JvPjMeOpAizwBNc70AVDNNd47e6FY05lwTNEctJaI1DeNyRC4dLB
         IW9q1ILQKGm2wP/5F69FKfcMe3XSukHOIDoa1K1D1ukPcacPo9ypWR1j2tXchFEans5i
         bOVtB4nGmu+z4U8FZ9+AYMB1I3GyU5GKhh6UZI3azNYY9ZZ0Ej9+6xItLG6rWP4A60v3
         CqqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding:x-system-of-record
         :x-gm-message-state;
        bh=hlPR0lAVsU2zUi4zmxShS3XAnT34+ElU5tEf62fw59s=;
        b=hzQft2H97Z862TaosokQwbMjAvHwxAQ7vHUMHabR+3jx79yWyhCoeWryRwVFdWBmRl
         MLXQ3dqXGb010VpRRR5anKglX3/1zyXncFy5Z6T9yCWuwNoLKyBz4M1fvGVwwNIFdoAC
         g+AqNqsAlfSGa3aMvjFscNhz+No/UT73grTD0NRlxa2CJlAHi8IqrtufZYZiloMI+5e3
         BMAVlQwNN4oTp7EoqHolxOKZoV2Lc3hTPZj64vU8QWwaf5WneP+BZcS2pra0ygNFHeWu
         NYeArb5Qea7JC+9YDzAVVZmq0B9Ps8mRO5UMLKtG/LdQrIQDeL3Ezp5EwTjFaJ1u39a0
         ICUg==
Received: by 10.216.138.17 with SMTP id z17mr850931wei.18.1331279905391;
        Thu, 08 Mar 2012 23:58:25 -0800 (PST)
Received: by 10.216.138.17 with SMTP id z17mr850920wei.18.1331279905241; Thu,
 08 Mar 2012 23:58:25 -0800 (PST)
Received: by 10.227.7.138 with HTTP; Thu, 8 Mar 2012 23:58:05 -0800 (PST)
In-Reply-To: <7veht2ex7v.fsf@alter.siamese.dyndns.org>
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQkDaBWypG4yh8WZj5bxDY/15CbRtjoYrMN1/iNyab3VYHtRXJl3Fn5ayx9Qp366VgnzMlT1sT04BBBcm7eF+carz1SyzSrCjvG7J87ywBJq3mEZfp0laUorrX6VPIBg2ahfSmgjgYU9GgEiLTOaGMlxavm+0Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192688>

On Thu, Mar 8, 2012 at 11:56 AM, Thomas Rast <trast@inf.ethz.ch> wrote:
>>> On a general note: you are submitting a completely new feature touc=
hing
>>> a heavily-used tool (and code path) during -rc0 time. As a rule of
>>> thumb: Don't do that. [..]

Dominique Quatravaux <domq@google.com> writes:
>> Sorry about that, I skimmed Junio's "What's cooking in git.git (Mar
>> 2012, #03; Mon, 5)" and I thought I was in the "high value/damage
>> ratio" category.

On Thu, Mar 8, 2012 at 7:58 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Well, these days, nothing that comes without prior discussion on
> pain points before the feature freeze, be it from seasoned list
> regulars or from people new to this list, can be of so high-value
> that it cannot wait until the next cycle.

ACK. I'm cool with skipping a cycle, they are so fast anyways!

--=20
=A0 Dominique Quatravaux
=A0 +41 79 609 40 72
