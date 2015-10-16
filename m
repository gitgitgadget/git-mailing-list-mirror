From: Aleksey Komarov <leeeeha@gmail.com>
Subject: Re: submodule: allow submodule directory in gitignore
Date: Fri, 16 Oct 2015 16:33:35 +0700
Message-ID: <5620C46F.8040007@gmail.com>
References: <561B5372.7040508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 16 11:34:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zn1Ok-0003O5-Lj
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 11:34:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754066AbbJPJd5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2015 05:33:57 -0400
Received: from mail-lf0-f52.google.com ([209.85.215.52]:34721 "EHLO
	mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753926AbbJPJdz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2015 05:33:55 -0400
Received: by lfaz124 with SMTP id z124so76881461lfa.1
        for <git@vger.kernel.org>; Fri, 16 Oct 2015 02:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-type:content-transfer-encoding;
        bh=YjSUzwpklovyDQDpXrU1r7n9TumkZj9nie6rrx7YgQM=;
        b=HP2M1QppRadN/YIT6VwvNmpqNp7XEqJneGubegg65pke1VRXmPuPvAjK9Dkz1okJcK
         SoxxoTPXbf+K6Cp38gynz/KaymQ0sUVAo3T+ZmR075QXQp9OxiIRSsy98Ul/HSnXofDy
         N86i0KHdkMNJIBOoCvDulnjl45rrA+UzS8nZeP9pDVy2Osv+mxSOYzcYpbB6s8l0kVi/
         sFnH6Mdy2cr7Ws+hgnR76VPKq8EyMnvgL44nw16VbitJEnos3/Tn4pop/MbWc6iBL4O5
         LQjeLgTUgR5Cq/J7iRq6s7iBPfIVdcKPhQE2dkQIfu+0XO2oSDIEEHuE+LAJp1k4RpWU
         otHg==
X-Received: by 10.25.212.2 with SMTP id l2mr4989993lfg.118.1444988034073;
        Fri, 16 Oct 2015 02:33:54 -0700 (PDT)
Received: from [127.0.0.1] ([62.213.32.124])
        by smtp.gmail.com with ESMTPSA id p3sm2739388lfd.42.2015.10.16.02.33.50
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Oct 2015 02:33:53 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <561B5372.7040508@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279741>

On 12.10.2015 13:30, Aleksey Komarov wrote:

> Now, I'm trying to add a submodule to my repository, but fail to understand why
> my .gitignore prevents it from being added. I use the following command to check
> if my submodule will be ignored or not:
> 
> $ git add --dry-run --ignore-missing c/

By the way I've just consulted documentation[1].
Can --ignore-missing option be used for checking not already present
directories, in addition to ordinary files?

[1] https://git-scm.com/docs/git-add
