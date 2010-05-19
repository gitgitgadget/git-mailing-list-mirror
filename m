From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: What's cooking extra
Date: Wed, 19 May 2010 22:09:49 +0200
Message-ID: <09806842-2F50-4D79-8B2B-F7804449F50D@gmail.com>
References: <7vsk5o9d1f.fsf@alter.siamese.dyndns.org> <20100519170656.GA30161@pvv.org>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>,
	Finn Arne Gangstad <finnag@pvv.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 19 22:10:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEpab-0005Z6-0P
	for gcvg-git-2@lo.gmane.org; Wed, 19 May 2010 22:10:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756022Ab0ESUJy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 May 2010 16:09:54 -0400
Received: from mail-ew0-f216.google.com ([209.85.219.216]:48929 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752661Ab0ESUJx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 May 2010 16:09:53 -0400
Received: by ewy8 with SMTP id 8so2822062ewy.28
        for <git@vger.kernel.org>; Wed, 19 May 2010 13:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=WLbxXb7EemcVozQI1trBYKJzKpwEgRYXhVrvyCLjZlA=;
        b=TsObFxmuQEE87U38vY1Ao8Sc2ApsFmC0DQSB7b8o7b4aR+0Mh6cIuiokiGkMTcfBtN
         YkmNTG6mHEGSrnQHLHl1JNJdwQBtPoEQIW1MqwJxM5B/x1/CRgyxN9RAy1aL3xctuE3k
         zyuxZTcAmAUeEOsXoNbxLWxXacnt9NipMomRA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=onnNh9JjJY0D0R6RF2ystDT82oHgqj5d81tNloE9j4oAFj6uIIqz2beL+fqHQwlCDc
         gQ43EJj0Ql967wGegoG0pdZAVZhM6WdyPnoaZTfMYaiDwzIT3yBjJeeQ3m/KKcpXZWfD
         Uds0zLsbgVq1YhG+XOMmoKjXTlLqlBbPQTxgc=
Received: by 10.213.62.142 with SMTP id x14mr3620716ebh.71.1274299791679;
        Wed, 19 May 2010 13:09:51 -0700 (PDT)
Received: from vredefort.d.eyvind.bernhardsens.net (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 13sm3797616ewy.9.2010.05.19.13.09.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 19 May 2010 13:09:50 -0700 (PDT)
In-Reply-To: <20100519170656.GA30161@pvv.org>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147340>

On 19. mai 2010, at 19.06, Finn Arne Gangstad wrote:

> On Wed, May 19, 2010 at 07:33:32AM -0700, Junio C Hamano wrote:
> 
>> * (Eyvind Bernhardsen and Linus) Fixing the behaviour of crlf attribute;
>>   ignoring them when core.autocrlf is not in effect was a wrong design
>>   decision.
>> 
>>   I agree with what Linus said in the thread; I haven't yet looked at the
>>   discussion in the past few days.  Also I don't know where '[PATCH v2]
>>   Add "core.eol" config variable' fits in the picture.
> 
> I think this one is pretty much discussed by now, with the latest
> changes this should do pretty much what Linus wanted.  Together with
> the autocrlf patch, this should make CRLF handling on Windows and
> mixed Linux/Windows setups a lot better!

Yes, it's done.  I'll resend the series with the core.eol patch included.
-- 
Eyvind
