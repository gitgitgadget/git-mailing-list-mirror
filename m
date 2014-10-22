From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH 1/2] Documentation/technical: signature formats
Date: Wed, 22 Oct 2014 18:57:02 +0200
Message-ID: <5447E1DE.2040601@gmail.com>
References: <cover.1413990838.git.git@drmicha.warpmail.net> <13b090185cb5a36cddf8c1ba4fcd6fe52e109084.1413990838.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 22 18:57:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgzDm-0002mA-BS
	for gcvg-git-2@plane.gmane.org; Wed, 22 Oct 2014 18:57:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753846AbaJVQ5J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Oct 2014 12:57:09 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:49149 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753587AbaJVQ5I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2014 12:57:08 -0400
Received: by mail-la0-f52.google.com with SMTP id hz20so3280601lab.39
        for <git@vger.kernel.org>; Wed, 22 Oct 2014 09:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=NXP6vpG5MDVvxbxfVKEi1vLS0KVId21+BBvXpOuiWEU=;
        b=YJ6Ch2KLnto0lrd94jZr/nk7aUGokJvvsyurUKzlxwNt/pjAJsZEifvNga31jEh6uG
         iMefdwHGFtJqBAZ/dBD59OTiuztoYd+vN/TZaTTiTc8KHm89wmz/WIqdZspL0ZzNT8R/
         KUyb74BxGhoUAScw8bFPlHvSCbEbfjlvK6obV0JgcTvZ6/dvp+Drn159AVLHtuwQ5hIP
         ot8+i6InZMBJn2WbZlHQMHNs7IykSXG6cMRxtk3VaQb8A9I7Oyg6J6dQjHh1y/ZmqCpO
         YDaEvNISECd/u9oVKezPj2VSSGMwPCPK3VqxSmNtET0sFrBMgEfExDCAeCaFrLnNjKsw
         KuFQ==
X-Received: by 10.112.52.33 with SMTP id q1mr44081355lbo.42.1413997025299;
        Wed, 22 Oct 2014 09:57:05 -0700 (PDT)
Received: from [192.168.130.235] ([158.75.2.130])
        by mx.google.com with ESMTPSA id f8sm6014548lbv.39.2014.10.22.09.57.03
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 22 Oct 2014 09:57:04 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <13b090185cb5a36cddf8c1ba4fcd6fe52e109084.1413990838.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 2014-10-22 17:16, Michael J Gruber napisa=C5=82:

> +=3D=3D Commit signature
> +
> +- created by: `git commit -s`
> +- payload: commit object
> +- embedding: header entry `gpgsig`
> +  (content is preceded by a space)
> +- example: commit with commit message `sigtest`

Actually it is not "content is preceded by space", but it is
multi-line header which uses RFC-2822 like wrapping (see "Long
Header Fields" there) - leading space means wrapped in email,
separate line here.

Nice work.
--=20
Jakub Nar=C4=99bski
