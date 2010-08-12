From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] git-am: Ignore whitespace before patches
Date: Thu, 12 Aug 2010 15:24:57 -0500
Message-ID: <20100812202457.GC2029@burratino>
References: <1273944188-9472-1-git-send-email-avarab@gmail.com>
 <1281556645-23361-1-git-send-email-avarab@gmail.com>
 <AANLkTinDHvwHLZfj6DDPtV39Z2xhDZREiqwdt5cjiaLP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 22:26:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjeMa-0002P5-PN
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 22:26:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933942Ab0HLU0b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 16:26:31 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:60550 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754988Ab0HLU0a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 16:26:30 -0400
Received: by qwh6 with SMTP id 6so1922041qwh.19
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 13:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=0QUSYcOHSnyoIFLWbEOAMqAfB8Z9PGnpIVduLm1tkVI=;
        b=S+qJC1aziwiofA6f3IkYxF8LMf+qhY4EDWuMMxvWuIVBvO2bN07GEc3bAxoS+WmOyD
         f8uczKN5AwZ2z+dBgW+Y0RSSucuNgxhynGWRorHDYwH9B1QO9QGJQ6rpcYq8klhKI50F
         HbeiIkRDcHReyhDMCFTNjdD3xoW4qMXqhncZU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=GGVAKlu9erDrS3IxSSM22MqVQ1qfHi9ctDgO4Pf8F115EU6oHwJEot4sLQKJ0oiHcZ
         Dnfv9zPYJ12U3WDBkl3lmgE7RDv2+lJlAKqLzBpuiJvYp6+IA7Dbt5i2Hm2qMrrqH1G0
         vCTpLki9eTCyIRHo0FtJn3sDIKMzlnCTX1SEI=
Received: by 10.229.221.131 with SMTP id ic3mr528201qcb.152.1281644789470;
        Thu, 12 Aug 2010 13:26:29 -0700 (PDT)
Received: from burratino ([66.99.3.154])
        by mx.google.com with ESMTPS id t1sm2326417qcs.21.2010.08.12.13.26.27
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 12 Aug 2010 13:26:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinDHvwHLZfj6DDPtV39Z2xhDZREiqwdt5cjiaLP@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153410>

Jay Soffian wrote:

> Perhaps, before making git-am less strict, we should modify
> format-patch to include a sha1 of the diff output so that corruption
> can be reliably detected by git-am.

I seem to remember a discussion about hand-munging and rebasing of
patches suggesting such verification might be a bad idea[1].  I dunno.

[1] but all a search turned up is this:
http://thread.gmane.org/gmane.comp.version-control.git/136008/focus=136234
