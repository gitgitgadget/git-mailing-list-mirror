From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v1] config: add '--sources' option to print the source of
 a config value
Date: Fri, 5 Feb 2016 12:13:04 +0100
Message-ID: <56B483C0.6070906@gmail.com>
References: <1454661750-85703-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net
To: larsxschneider@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 05 12:13:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aReK9-0004Gd-Ux
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 12:13:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751920AbcBELNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 06:13:09 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35397 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827AbcBELNH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 06:13:07 -0500
Received: by mail-wm0-f66.google.com with SMTP id g62so2489508wme.2
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 03:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=ZTIiAIXe8twIzKvkkbrJIF5yA3onTei38l6DI82k+cM=;
        b=xX2Q0L4EeK/SX6gS5wVsbR5e8+4fetcP6eqLAhqw4oEW+uHJu+ZN9agtrrqIh2Oa/+
         VVwIRnEJUilTEwnsaA4LEBCHqn21UcPMCcxPKk0KIlMDF27s8OL8sh53L410UUJGhQW1
         bC8IPxGM5nunnpeQftcdbDTCaJJM7JetMGRQreLTfZTs1l59wp3nO+cYD08xyEeDEMOT
         O1UawXNENeWvwj8G2NZUMLOkkYYZAcsWGpc7G3/uKIJ6KPYLa61JvePwTaGIqYv7Npop
         N4zfvJcthPeV7O2cnlgxlE6FqqhoFQcELzgDJ0yGF3qmgdBAR10yBVNVS/b5F7lQLWH0
         37Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=ZTIiAIXe8twIzKvkkbrJIF5yA3onTei38l6DI82k+cM=;
        b=nNWWaTSEIZ2v77GCiz0NBbqbZegGBZ2lrW4HQuK1B1wrdU4HlS3Mj03LKnHjZgdCAt
         fB1HcqpTlWSIRwAlYDkzRGjmQxJ50DJkfdn7vuEDnzOhkokAqGE8pRrRYXL8TQrOEK/d
         IRnp46AOrhhh2CU+GwV62RGioU5anG2cO9VM9kSBc/MUhfh2vDdIiJSWX/dnwmZ2srWJ
         T9DqEJL4n9AQCjme0UAMEJ3cXleaIse1qriODZyjCY9zlnMFZvVu4bGSKRrafzof6vOB
         zH6vkLAjEujS3+oiBm7CE1XOyTkCb+apUeYbyuUhSdqJZ+4aF9W4Tsw0Hv+Ek4CStfDa
         C/jg==
X-Gm-Message-State: AG10YORVK1SOpYTvNu2jeKFMkBG7ol3GEd6B4RD/vVDIeFWlgjtGPTUMhU3WezUSBKCHfw==
X-Received: by 10.28.180.84 with SMTP id d81mr3762501wmf.42.1454670786181;
        Fri, 05 Feb 2016 03:13:06 -0800 (PST)
Received: from [10.223.62.214] ([131.228.216.134])
        by smtp.googlemail.com with ESMTPSA id t195sm30600180wme.13.2016.02.05.03.13.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 05 Feb 2016 03:13:05 -0800 (PST)
Newsgroups: gmane.comp.version-control.git
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <1454661750-85703-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285567>

On 2/5/2016 9:42, larsxschneider@gmail.com wrote:

> Teach 'git config' the '--sources' option to print the source
> configuration file for every printed value.

Yay, not being able to see where a config setting originates from has 
bothered me in the past, too. So thanks for working on this.

However, the naming of the '--sources' option sounds a bit misleading to 
me. It has nothing to do with source code. So maybe better name it 
'--origin', or even more verbose '--show-origin' or '--show-filename'?

Regards,
Sebastian
