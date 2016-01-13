From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] docs: clarify that --depth for git-fetch works with newly
 initialized repos
Date: Wed, 13 Jan 2016 19:24:07 +0100
Message-ID: <56969647.7020005@gmail.com>
References: <n6j1cs$p4$1@ger.gmane.org> <568F8244.2030309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 19:24:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJQ5y-0008Gw-6W
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 19:24:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755949AbcAMSYa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 13:24:30 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:32806 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755941AbcAMSY3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 13:24:29 -0500
Received: by mail-wm0-f42.google.com with SMTP id f206so307332719wmf.0
        for <git@vger.kernel.org>; Wed, 13 Jan 2016 10:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=4zYzOn5uM8VHIO7BiMFjaO/M/0CFZXr6SK21BaSZEv8=;
        b=J1AQJAhn+sbUS/0Xt52Ih2odsRpLYJ7JwPFhPe469M2kK2jFArlCAC68hw12x5vfhx
         qS9zQJ8wV7hg/V6FL1F9HHX8tV7iaB7ToIyo+8s7QkIlhjFz35Bbd76hJOBXXNK+B1zF
         OsVzrxPL/q6dUAwGGDmI65UCCBCmJkldUUdMWCqAJqnwZGYez8C0DygZcwAeE/NVUxQN
         8lA22YRzAeR9hIBgF4DTT0tQn6+/lBFqcsclnH57E+/5fAojruw6Zj4Y/J6zZ4x1TBSh
         n/HFwPl7RGtT09hxNuh6zqWlP2mKzqgyj+ZrnCJesnbA0TZMsVJP02ejA2BtoNg0qWsM
         BF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:newsgroups:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=4zYzOn5uM8VHIO7BiMFjaO/M/0CFZXr6SK21BaSZEv8=;
        b=OHTlM0xnvVHfNlAMQRzh/yZOso/yBFnZXK8vVkwprwPjkv1ajBUhS76UKW5IDxZcQ0
         niJmYHjaJs9ARvXQtPrCVMmkilitLKm6hSSz8qFrYCqMIh16Ip1efOL5T+bVnJPXujVY
         q7mecbA8cknX0z3FjCwm/Cc3h2joH70DREa6HVbsU+C3gbJhd8/EQpHtBWpaP2TqNSuk
         DyA2SKqEXm5f66/PBBYKdrpOqHxNISQrBIj/Ms8TgXhocj5caU0vqnOL8R+EDL9E9gD1
         Y2My9NjzUb86eddN5C4rqJwp556PRhks6aGIWQepLjyALHs1MC9lsQZlLFbCasXVSGsB
         rfjg==
X-Gm-Message-State: ALoCoQn14x9IbP5zOIhnruI5uFSg/i1ffwrKATXIRTc3GhVwLZs2Ca1V73e5kTji8ib6JZCYfpPIDrSul1Mou6O2zuysoZXp1g==
X-Received: by 10.28.218.81 with SMTP id r78mr286498wmg.91.1452709467659;
        Wed, 13 Jan 2016 10:24:27 -0800 (PST)
Received: from [192.168.188.20] (p548D69D8.dip0.t-ipconnect.de. [84.141.105.216])
        by smtp.googlemail.com with ESMTPSA id b127sm23333090wmh.9.2016.01.13.10.24.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Jan 2016 10:24:27 -0800 (PST)
Newsgroups: gmane.comp.version-control.git
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12)
 Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
In-Reply-To: <568F8244.2030309@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283962>

On 08.01.2016 10:32, Sebastian Schuberth wrote:

> The original wording sounded as if --depth could only be used to deepen or
> shorten the history of existing repos. However, that is not the case. In a
> workflow like
>
>      $ git init
>      $ git remote add origin https://github.com/git/git.git
>      $ git fetch --depth=1
>
> The newly initialized repo is properly created as a shallow repo.

Sorry for the missing sign-off, feel free to amend that in pu:

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>

-- 
Sebastian Schuberth
