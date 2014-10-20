From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: Sources for 3.18-rc1 not uploaded
Date: Mon, 20 Oct 2014 14:37:09 -0400
Organization: Linux Foundation
Message-ID: <54455655.9010406@linuxfoundation.org>
References: <20141020115943.GA27144@gmail.com>	<CA+55aFyDuHskYE66rBVL_P-T2pxg6f2m6mUicfz-mk+ysePBxg@mail.gmail.com> <xmqqoat6389s.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	infra-steering@kernel.org, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Oct 20 20:37:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgHpY-00038h-Qd
	for gcvg-git-2@plane.gmane.org; Mon, 20 Oct 2014 20:37:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125AbaJTShQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2014 14:37:16 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:37348 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751109AbaJTShP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2014 14:37:15 -0400
Received: by mail-ig0-f179.google.com with SMTP id h18so5177142igc.6
        for <git@vger.kernel.org>; Mon, 20 Oct 2014 11:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:date:from:organization:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=EoQ8RNDK5kRizq5mAeITgkwgjapEQMH+SexO5veT4ho=;
        b=HDNdQDyY5QmgZrdMWfWWiQpYFU5GBqnTNrTVKUV8pc90EbK5eO08vMixDzqwk4rouD
         qqnAxswVMqTH5pGVGv6XK+vHVO72LatGQE7NILrurrKL+Kx9Yx9t5fFezm4xNoDMKw4Z
         uUk1UCw+fTuEVrJqOsa7Zgwah/icFzcPv0298=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=EoQ8RNDK5kRizq5mAeITgkwgjapEQMH+SexO5veT4ho=;
        b=kqQx1FvBlXkdJJ60O098fuhai0riJ5DB7Of6rqKxX2U8dCDuupSDe+l/T7CF8SjqXJ
         RK/5YpMIG+ZTs8ZJSDhP7B33JLcSmU2AR6Eak4xrSctl94IBJ02a8bGqthpPQr7+9Gjc
         kcvLnnHoGUgxhGmjg0/exx4/veZLrYAvKqibvWiyEdMWmgR/44tW78NXTOs+GXsR/SzB
         BngnwYT7kbrEAGppg5oXluHzyPv5oo79lD9IHxw8I3jeH9GFr+bszu4LM1SqGqngSMf1
         ViFR2AsUJmQ4oJ2pJzI9VO4M7uUIGT/wtUywJ6Gz/22c4LlZMfFI+JDZYp7z9LgS0RBM
         x3YA==
X-Gm-Message-State: ALoCoQk0TD2NQMIdFhimIQn4lob1R/ZaYTSAX/grYwwRwC48dGenDM8DyyLDk9rL4c+FsOv22nHm
X-Received: by 10.50.143.97 with SMTP id sd1mr20383249igb.8.1413830231513;
        Mon, 20 Oct 2014 11:37:11 -0700 (PDT)
Received: from nikko.mricon.com (69-165-202-194.cable.teksavvy.com. [69.165.202.194])
        by mx.google.com with ESMTPSA id l130sm4889885ioe.9.2014.10.20.11.37.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Oct 2014 11:37:11 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <xmqqoat6389s.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/10/14 02:28 PM, Junio C Hamano wrote:
> I have to wonder why 10f343ea (archive: honor tar.umask even for pax
> headers, 2014-08-03) is a problem but an earlier change v1.8.1.1~8^2
> (archive-tar: split long paths more carefully, 2013-01-05), which
> also should have broken bit-for-bit compatibility, went unnoticed,
> though.  What I am getting at is that correcting past mistakes in
> the output should not be forbidden unconditionally with a complaint
> like this.

I think Greg actually ran into that one, and uses a separate 1.7 git
tree for this reason.

I can update our servers to git 2.1 (which most of them already have),
which should help with previous incompatibilities -- but not the future
ones obviously. :)

-K
