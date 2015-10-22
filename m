From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v1 0/2] git-p4: Fix tests on OS X
Date: Thu, 22 Oct 2015 23:47:03 +0100
Message-ID: <56296767.2080108@diamand.org>
References: <1444669384-85419-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: larsxschneider@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 23 00:47:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZpOdt-0004J8-I1
	for gcvg-git-2@plane.gmane.org; Fri, 23 Oct 2015 00:47:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758146AbbJVWrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2015 18:47:24 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34629 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756487AbbJVWrW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2015 18:47:22 -0400
Received: by padhk11 with SMTP id hk11so98642548pad.1
        for <git@vger.kernel.org>; Thu, 22 Oct 2015 15:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=Dojc3sQkubcIVi9vdSe6CCXtfPkiNLXw3JxcF0PUmHM=;
        b=Izctvd5SpLY8UUBqod6oHn3GxckasC3c95yNOQTJK3zSDJJHeLu/UMMylYDZd4Crcc
         ITPEecStyV7F4S0HeRgDDaN+GaNhUVJDpP5Y3L463Gk4/qg+x5PaujBzkChJcBDljuuQ
         ff71xY4+DluBaI9cjIQsClP1i46zQk6vljZcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Dojc3sQkubcIVi9vdSe6CCXtfPkiNLXw3JxcF0PUmHM=;
        b=GTQgGlxY7foJrXrDDlCLEZO7d/KjheimvVKgKYoRNGoMajVzPBsMgX5FZSopyOFk6t
         23qa6PWD04vOjSpCE5nh11NwvMfJ0mdUJ1STB3cjlUWu/navpzDGgas2WSDVKWSlaAbu
         nRpwA6ppalCNNSafVQ+T+m54P9AIHVyuK0tQ2Ij2Ih307oJV0p/SWJA7mys48OTSxQLd
         yjEX9+lf+0xVfxS8MrTCRQHzIYFzmwOtwHpzlOntt+EYJQJ5BrfadLrchavXFhUxPIad
         dOBN+DhRpYgvsSp0DAk/qmW67+AePyoTQacIBL+FG1riQFFY8/kYkrj/VWkMnXnwXlbg
         FrSA==
X-Gm-Message-State: ALoCoQm2Il8dkmmpnoOzws9MX+kwWDQOWgg5kMqMEs2IqO6EpEE8ArFdJWuj+gqpSnfmDu0kuk/s
X-Received: by 10.68.69.79 with SMTP id c15mr20103508pbu.90.1445554042230;
        Thu, 22 Oct 2015 15:47:22 -0700 (PDT)
Received: from [192.168.245.128] (cpc12-cmbg17-2-0-cust914.5-4.cable.virginm.net. [86.30.131.147])
        by smtp.gmail.com with ESMTPSA id pw7sm15585586pbc.4.2015.10.22.15.47.20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Oct 2015 15:47:21 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <1444669384-85419-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280078>

On 12/10/15 18:03, larsxschneider@gmail.com wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
>
> I extracted this patch series from "[PATCH v3 0/3] Add Travis CI support" as
> suggested by Junio.

All seems sensible to me.

Luke


>
> Thanks,
> Lars
>
> Lars Schneider (2):
>    git-p4: Improve test case portability for t9815 git-p4-submit-fail
>    git-p4: Skip t9819 test case on case insensitive file systems
>
>   t/t9815-git-p4-submit-fail.sh  | 7 ++-----
>   t/t9819-git-p4-case-folding.sh | 6 ++++++
>   2 files changed, 8 insertions(+), 5 deletions(-)
>
> --
> 2.5.1
>
