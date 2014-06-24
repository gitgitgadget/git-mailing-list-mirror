From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [RFC/PATCH V2] alias.c: replace git_config with git_config_get_string
Date: Tue, 24 Jun 2014 07:20:13 +0530
Message-ID: <53A8D955.9050200@gmail.com>
References: <1403520105-23250-1-git-send-email-tanayabh@gmail.com> <20140623223825.GC4445@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 03:50:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzFsR-0005ZV-Eh
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jun 2014 03:50:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbaFXBuX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 21:50:23 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:37668 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179AbaFXBuX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2014 21:50:23 -0400
Received: by mail-pb0-f43.google.com with SMTP id um1so6325298pbc.16
        for <git@vger.kernel.org>; Mon, 23 Jun 2014 18:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=umtJ8WoYcM94F1ICpU1cf6U8QYF8v9NOvfg4FIqUbFE=;
        b=ZiEPp2q7uZXlGquAuPnt3Sy45DuSbgoQqMR9Ps52WCOGIZX7jPI6BRy8rH/vl/2Api
         jykqD+t3o5EAYdV9ZyX0xuxiPvYmxexmpbtAFnVMpVKvr1Lan/Ngb/g2szjjwjsIksWE
         OKgmVb9cW1Bw8S46LZisNWs5S3cyYLrJMwQQOa7fSYg+aq4/8TLVKoq/FuZiIAFOpXlO
         lqmwW0sCoB9ACYp3p0LOgSsQ/ST/+y9mCgMt6YImnwH/CpPredz2g8O2oyhCJDCaRXC7
         uzuAlrjQf6dx+ud5HsrV2uMY8BAk0tX8UJ4Nkd2eD4IDM1UXR8oQOOgAQn/OjU8tVLjJ
         tadw==
X-Received: by 10.68.102.34 with SMTP id fl2mr33462707pbb.2.1403574622745;
        Mon, 23 Jun 2014 18:50:22 -0700 (PDT)
Received: from [127.0.0.1] ([117.254.220.71])
        by mx.google.com with ESMTPSA id mt1sm29030620pbb.31.2014.06.23.18.50.19
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 23 Jun 2014 18:50:22 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <20140623223825.GC4445@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252383>

On 6/24/2014 4:08 AM, Jonathan Nieder wrote:
> Tanay Abhra wrote:
>
>>   alias.c | 28 ++++++++++------------------
>>   1 file changed, 10 insertions(+), 18 deletions(-)
>
> What commit are these patches against?  Are they a continuation
> of the "git config cache & special querying api" series?
>

My fault, I should have marked them. You have inferred correctly,
they have been built on top of "git config cache & special" querying
api" series[1].

[1] http://thread.gmane.org/gmane.comp.version-control.git/252329

Thanks,
Tanay.
