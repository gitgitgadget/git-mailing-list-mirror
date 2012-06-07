From: cheng renquan <crquan@gmail.com>
Subject: Re: [PATCH] git fetch one tag only
Date: Wed, 6 Jun 2012 22:47:15 -0700
Message-ID: <CAH5vBdKXaOV3hC0E0s=j3Hc2jZ9otxhXLMhCCKiU4=Rn4Y4COA@mail.gmail.com>
References: <CAH5vBdK_M+7Hjk=juVeP7Phqvs2+npknFD-=45OVR032k5S-0A@mail.gmail.com>
	<CAPc5daVwOuP_dPiHh5zcjV6kTvdb2FNhzXz_capEDhHgE5ZUKw@mail.gmail.com>
	<CAH5vBdKPH_-cn=r-zxQKCOi5PB5D6vuSXrZxPeZJ+HYg-K9Yqw@mail.gmail.com>
	<7vpq9bk7o5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 07:47:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScVZO-0004tT-3t
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 07:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754020Ab2FGFrV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 01:47:21 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:37352 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731Ab2FGFrU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 01:47:20 -0400
Received: by weyu7 with SMTP id u7so128387wey.19
        for <git@vger.kernel.org>; Wed, 06 Jun 2012 22:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=KcBvd0AOgTwE2P4TOYiguJpPArA914PcukNVNTb/dcA=;
        b=uBT/hSSl4PH8y8f4mrdWZcHRopxZotYy+eOVpnrnbGGW+22ZklYWvQVkwnCEnmXI/j
         WAU/a0++2h83QFQaaaSnCzrUCYndtTGbxRMdxmQAGMpe7uIKnQL0QwFchGsrmpBnizZy
         5UXQUFo6eyHgYcZEGvOHlC8UQhKYhKKQRFghvalaXOiHMm1wOIHZYYhM7TxrfZnM6dNf
         Gj7mnmbXRWj0XjWx1yF+mCAxQBFloGTdE3vm735+Ozz02XB22iJCfoiB1M/QrS7Q5Ncx
         CHFZy2ga6yQrIcSFT9DY8q0ENd5YvWTwlH6ZISw+MNMCaq5TGpZ0HV0S3AYE/vLRoORl
         bX7Q==
Received: by 10.216.196.218 with SMTP id r68mr729341wen.122.1339048035885;
 Wed, 06 Jun 2012 22:47:15 -0700 (PDT)
Received: by 10.216.136.80 with HTTP; Wed, 6 Jun 2012 22:47:15 -0700 (PDT)
In-Reply-To: <7vpq9bk7o5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199372>

ok, got it:

$ git fetch -v --no-tags linux-stable tag v3.4.1
From git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable
 = [up to date]      v3.4.1     -> v3.4.1
