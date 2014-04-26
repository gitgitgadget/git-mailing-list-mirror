From: nod.helm@gmail.com
Subject: Re: [PATCH] subtree/Makefile: Standardize (esp. for packagers)
Date: Sat, 26 Apr 2014 14:56:15 +1000
Message-ID: <3cb4338e-de68-404d-86dc-70cac7e13606@email.android.com>
References: <1398304336-1879-1-git-send-email-nod.helm@gmail.com> <CAHYYfeGNDLVxzP6zMyJnSi8GxpQaUKGAkqaLfXbZ=8B1k7vvyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 26 06:56:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdufM-0008W1-4L
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 06:56:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbaDZE4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2014 00:56:38 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:62880 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168AbaDZE42 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2014 00:56:28 -0400
Received: by mail-pb0-f44.google.com with SMTP id jt11so2185558pbb.17
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 21:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type:subject:from:date:to
         :message-id;
        bh=OoQn8NwacbEOmowifllUojElfW6Utv1OrDzQA6bxAao=;
        b=CEOnQVPzfsMGHuyB4BTcP+WSBc3ETY/ZBe+QfnAtKTc1YNYHclVVVQt7hYEsRVNKO1
         bnbRA7wq8kd2CobxE2l2rJKRmdYmwuFRoKHQ3iW2UsZ2AQDt68k5SV3FiB4Z05PcvgSs
         ZLBtmDqIqe3CoEzbSxMblEyRFLnyPYKYIKBzVbRD6SlZSZVMqZbyFqa9q0g+2T/B+2d3
         1rOCQSbVRntXP5TiftHK9GsIgk0CxtOawLakrZkzPc9620RgbMsrJdnLZtEH22vWbvXG
         BUP2UQBCNBLcxRbiGT9RZ6eJ/ln3BO3elN4oOHXAtNk/TI264deD0Ev/Nqvut1w64TE+
         OpZA==
X-Received: by 10.66.161.231 with SMTP id xv7mr12155982pab.7.1398488187987;
        Fri, 25 Apr 2014 21:56:27 -0700 (PDT)
Received: from [10.90.152.87] ([101.119.29.107])
        by mx.google.com with ESMTPSA id kt8sm49566007pab.7.2014.04.25.21.56.24
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 25 Apr 2014 21:56:26 -0700 (PDT)
User-Agent: Kaiten Mail
In-Reply-To: <CAHYYfeGNDLVxzP6zMyJnSi8GxpQaUKGAkqaLfXbZ=8B1k7vvyQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247144>



On 24 Apr 2014 11:52, <nod.helm@gmail.com> wrote:
>
> From: James Denholm <nod.helm@gmail.com>
>
> contrib/subtree/Makefile is a shambles in regards to it's consistency
> with other makefiles, which makes subtree overly painful to include in
> build scripts.
>
> Two major issues are present:
>
> Firstly, calls to git itself (for $(gitdir) and $(gitver)), making
> building difficult on systems that don't have git.
>
> Secondly, the Makefile uses the variable $(libexecdir) for defining the
> exec path.
>
> (...)

I hate to be that guy, but could I get an opinion on the proposed patch? Is
git
interested in purely makefile patches,
or should I find further improvements
to make in subtree and purpose this again with those?

Regards,
James Denholm.
