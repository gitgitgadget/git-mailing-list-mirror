From: John Tapsell <johnflux@gmail.com>
Subject: Re: Problem with large files on different OSes
Date: Wed, 27 May 2009 14:28:58 +0100
Message-ID: <43d8ce650905270628o2eb4ed3cqf6b78e00933198af@mail.gmail.com>
References: <submission.1M9Gk0-0000N8-MQ@mail.cs.st-andrews.ac.uk>
	 <4A1D2614.5060303@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Christopher Jefferson <caj@cs.st-andrews.ac.uk>,
	git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed May 27 15:29:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9JBr-00018j-F0
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 15:29:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761338AbZE0N26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 09:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760642AbZE0N25
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 09:28:57 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:43444 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760287AbZE0N25 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 09:28:57 -0400
Received: by yw-out-2324.google.com with SMTP id 5so2614111ywb.1
        for <git@vger.kernel.org>; Wed, 27 May 2009 06:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8OS4jXGdhsW274IRdjFY0NvOYf9nTdJgarQHyk5NEkU=;
        b=h4NZ2J9Sbc4qHB7g1W5HoMVwQh4AJyWf3GLgkzqXWqnXKm/oT3RCvhND20MWWQG1y0
         isDRuKqBH4XihHiuq+As9z22FKrUNHKf9/vYqqXVlFGdad9NupZeMe2ywRpJzHp8hH3F
         UP17pNiIioiYyv6FuYErkQnsP/hA1Mrzf2Yr8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=D3xbQvAB+QQAeyitqZDHDlhUfiuWs9aQS/Xci4m9x6z+tZukn7p4+WQLv96bYe+6MH
         wG9awqkw/4nvSJONiS5Hf2CLF5TQ4EpquOCHm6dBN5UwQmSlv/JsUcwDcGymhLMzsNI8
         CsvOWD8MXg+ICcjdg0qRdRcsSZztamF6TfNAY=
Received: by 10.150.201.4 with SMTP id y4mr176468ybf.306.1243430938475; Wed, 
	27 May 2009 06:28:58 -0700 (PDT)
In-Reply-To: <4A1D2614.5060303@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120061>

2009/5/27 Andreas Ericsson <ae@op5.se>:
> Christopher Jefferson wrote:
>> If the requirement that all files can be mmapped cannot be easily removed,
>> would be it perhaps be acceptable to impose a (soft?) 1GB(ish) file size
>> limit?
>
> Most definitely not. Why should we limit a cross-platform system for
> the benefit of one particular developer's lacking hardware?

Perhaps a simple warning would suffice  "Warning: Files larger than
2GB may cause problems when trying to checkout on Windows."

John
