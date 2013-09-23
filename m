From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: What's cooking in git.git (Sep 2013, #07; Mon, 23)
Date: Mon, 23 Sep 2013 23:24:20 +0200
Message-ID: <5240B184.8060101@googlemail.com>
References: <20130923211047.GD9464@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 23 23:23:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VODbc-0006lv-JP
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 23:23:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753256Ab3IWVXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 17:23:40 -0400
Received: from mail-ee0-f43.google.com ([74.125.83.43]:63629 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752630Ab3IWVXj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 17:23:39 -0400
Received: by mail-ee0-f43.google.com with SMTP id e52so2018110eek.2
        for <git@vger.kernel.org>; Mon, 23 Sep 2013 14:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=iGaeGQmpL2iPcLhRM/tRibiIOUi241U+b1k2A5IGQaY=;
        b=qSja5yvrvszxRV6SegxXlAjwXUSFvjeWB+VDMYqexbc27Ii/cFCu0LgD1dKZfb2UmM
         FhyQrC277eIOGk1NT2Wf/vb8j97i6EHk5R3p7D9Gp/bUrpKgI2It8u07/ewwBRmBVyF1
         k2R3gkytEiFOlVnyuMC1b9/+Bei4+pToKeKb+XcOe63uIm5Es/u9GcBcYhSPfg6GTCRk
         4pD4FSR/ReVE1fsRyGfZ7tEFDUT7SO1TRCQoggYv6ANX7EWZAn6PJ+ajxiGS/w/G7kQ/
         92mbw1eJ6Hyblphck8AD5+pt5evDybM/DW9GGyyJkbgHpJ9a8Xa2XZZTsjaggogXuKpq
         KTEw==
X-Received: by 10.14.208.194 with SMTP id q42mr40218260eeo.31.1379971418512;
        Mon, 23 Sep 2013 14:23:38 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id h52sm45833050eez.3.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 23 Sep 2013 14:23:37 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <20130923211047.GD9464@google.com>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235247>

On 09/23/2013 11:10 PM, Jonathan Nieder wrote:
> You can find the changes described here in the integration branches at
> 
>     https://repo.or.cz/r/git/jrn.git
> 
> I am still catching up on patches sent since last week.  If I have
> missed yours, do not despair, but feel free to send me a reminder to
> look at it.

How would I get these changes?
A plain 
	git fetch https://repo.or.cz/r/git/jrn.git
doesn't work, as it yields:
fatal: unable to access 'https://repo.or.cz/r/git/jrn.git/': server certificate verification failed. CAfile: /etc/ssl/certs/ca-certificates.crt CRLfile: none

So I'll try without security:
	$ env GIT_SSL_NO_VERIFY=true git fetch https://repo.or.cz/r/git/jrn.git
	fatal: Couldn't find remote ref HEAD
	Unexpected end of command stream

I guess I'm doing it not quite right, so please enlighten me.
Thanks,
Stefan
