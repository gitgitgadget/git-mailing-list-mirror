From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [WIP/PATCH v4 5/8] for-each-ref: introduce 'ref_filter_clear_data()'
Date: Sun, 31 May 2015 13:50:27 +0530
Message-ID: <556AC44B.8070709@gmail.com>
References: <5569EF77.4010300@gmail.com>	<1433008411-8550-5-git-send-email-karthik.188@gmail.com> <CAP8UFD341nSMLvsXynbDfQ4kLoddBL5rhXrhyePTT0LHACzfuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 31 10:20:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyyU1-0001BU-6s
	for gcvg-git-2@plane.gmane.org; Sun, 31 May 2015 10:20:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbbEaIUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 04:20:33 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:33566 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757446AbbEaIUb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2015 04:20:31 -0400
Received: by pdbqa5 with SMTP id qa5so85385816pdb.0
        for <git@vger.kernel.org>; Sun, 31 May 2015 01:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=+Z+ARk+SNE8kY2jcG7fG4K9Gj4FVbJXzO62S6UtlbTc=;
        b=Z8znut3qzcoqtItFzl/E4ob6F5ZY2jgu0cR9OkXC60SWaU5ggZSEvnAHA9lalgqa/b
         9cJsAnN5aReON/JlpkBVlUQ2AyCi5boowYmo30m1S9XTGZLoUyrz+72s0hz9BqEhfT8X
         RHSNy/+bgPU9gRP3gZLYf6H4zthERy7IfA6S2Z65vWSm3yys6G/HWxNT7X9CEWuYWseY
         GdRR7p9SojcFT6U5ZRAPT9P1w7jFY4Kj7ZQ4Vyj+GNSe47oyD1oHMxe1xueEWGEZN5gZ
         1UCl9kvHjJWhKwOcnGyXBFk3F2HL0kWKXFBKYw+GwGkIQl6MIecgrnIldCjD4jwBn4v0
         5b/Q==
X-Received: by 10.67.4.161 with SMTP id cf1mr30032870pad.35.1433060431268;
        Sun, 31 May 2015 01:20:31 -0700 (PDT)
Received: from [192.168.0.101] ([106.51.130.23])
        by mx.google.com with ESMTPSA id om4sm10674764pdb.68.2015.05.31.01.20.29
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 May 2015 01:20:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <CAP8UFD341nSMLvsXynbDfQ4kLoddBL5rhXrhyePTT0LHACzfuQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270323>

>
> As this is clearing the array only, it would be better to have it in a
> ref_array_clear() function.
> There are already argv_array_clear() and sha1_array_clear() by the way.
> And maybe if many such ref_array functions are created and start being
> used elsewhere we can easily move everything into new ref-array.{c,h}
> files.
>

Makes sense. Will change.
-- 
Regards,
Karthik
