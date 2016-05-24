From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [Opinion gathering] Git remote whitelist/blacklist
Date: Tue, 24 May 2016 15:11:02 -0400
Message-ID: <B559ECA4-0C95-4E40-8E2C-22299614E559@gmail.com>
References: <1040142021.5607762.1463753271105.JavaMail.zimbra@ensimag.grenoble-inp.fr> <584027154.5608416.1463754104066.JavaMail.zimbra@ensimag.grenoble-inp.fr> <001001d1b2a3$06d7bbb0$14873310$@nexbridge.com> <1929221963.5686879.1464007899902.JavaMail.zimbra@ensimag.grenoble-inp.fr> <1884904685.12056.1464084750628.JavaMail.zimbra@ensimag.grenoble-inp.fr> <84BDC4A4-FBE1-4542-868C-FA77A25469F3@gmail.com> <vpq37p74nu1.fsf@anie.imag.fr> <CAPc5daURo8SkbeGf0MEsp0sLzdzFfUOxptgusFr58UG9SKmDAA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Francois Beutin <beutinf@ensimag.grenoble-inp.fr>,
	"Randall S. Becker" <rsbecker@nexbridge.com>,
	Git Mailing List <git@vger.kernel.org>,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	wiliam duclot <wiliam.duclot@ensimag.grenoble-inp.fr>,
	antoine queru <antoine.queru@ensimag.grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 24 21:11:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5HjT-0005R6-MV
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 21:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752031AbcEXTLH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 15:11:07 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:35035 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751587AbcEXTLF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 15:11:05 -0400
Received: by mail-qk0-f175.google.com with SMTP id t145so16820133qke.2
        for <git@vger.kernel.org>; Tue, 24 May 2016 12:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YP+68FFyn+7aeUUfKwNFcmgXTg+ARH6pFJpQ36CBGyM=;
        b=lsYBBr1xTPoeKILFZo9pjLh0fPSdbBwinn9fpZZQ4cccO2Yw/YHJZeTLBbxQc71U0+
         gzmYpiSAXAphduStefY9bpiXjHcK4SA7QNY6JjcNDEsRWzdkyGySe6UkkG3wjixevHEH
         riqp5GkF49v2pTtZJVecSLFsFo7bFRtUS8P2YBIIGRM8YKPlKvIoqAukZTb1AXsS6zmx
         lTHYxjdkOUx6a0Um6//2Z+tq2SMeMKfMHya71KRIoftA8oBnYF8CBG7eVrsij07uPMWB
         yjZrH+XACt2CI9LQ9Ybahs8mhKFcBQRFlcV7x9++dszPacNhGNEqS3Y4YWq768BC+V2v
         HMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YP+68FFyn+7aeUUfKwNFcmgXTg+ARH6pFJpQ36CBGyM=;
        b=i13uc5rbTNM2JW2BMOxAywAoLXv6TC9bUTH8TTN+ceuXab5x3t8/71qFhTTXYvQ9Lz
         QtqgaSdeBj3WvhRNQNXRbk62lohOHEfMB5XEnRkbpT92+VkdsYKwe39ONruuuTmfgj61
         YA6Row0fE1YXWNu2ZoKSGe+23LcwXGH2dgYNNVs7Za1650kQ7B4UEbXjyQjsUQfG61IB
         DjbmiX5/sBqnDuoaBhKs3ff8dWSexBhFDd+KCYBMiN2fov4LFcBQuCVRHXYWG/9HNlH5
         FYMAbh+Oo6rJwNLzaQb4RHK4DPPdhPPe6UX6IrvJJ6DGQqh9/4EqgImbRpmC/BL9nBIU
         3JmA==
X-Gm-Message-State: ALyK8tJAA3axM5f/ngbH3RJE3LAcXFYTYvd6KQ/DQN9C5xiPdzEXpRYJpKEG9KaHBZoMMg==
X-Received: by 10.55.115.69 with SMTP id o66mr5174877qkc.67.1464117064576;
        Tue, 24 May 2016 12:11:04 -0700 (PDT)
Received: from rem20twn32.ads.autodesk.com ([132.188.72.187])
        by smtp.gmail.com with ESMTPSA id f66sm5457461qge.7.2016.05.24.12.11.03
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 12:11:03 -0700 (PDT)
In-Reply-To: <CAPc5daURo8SkbeGf0MEsp0sLzdzFfUOxptgusFr58UG9SKmDAA@mail.gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295522>


> On 24 May 2016, at 12:07, Junio C Hamano <gitster@pobox.com> wrote:
> 
> On Tue, May 24, 2016 at 5:55 AM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> So, when trying a forbidden push, Git would deny it and the only way to
>> force the push would be to remove the blacklist from the config, right?
>> 
>> Probably the sanest way to go. I thought about adding a "git push
>> --force-even-if-in-blacklist" or so, but I don't think the feature
>> deserves one specific option (hence add some noise in `git push -h`).
> 
> Yeah, I agree --even-if-in-blacklist is a road to madness, but I wonder
> how this is different from setting pushURL to /dev/null or something
> illegal and replace that phony configuration value when you really need
> to push?
It is no different from changing the push URL. As a matter of fact, that
is how I've implemented this "blacklist" feature with the current version
of Git:
https://speakerdeck.com/larsxschneider/git-at-scale?slide=35

- Lars
