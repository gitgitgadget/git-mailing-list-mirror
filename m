From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: New special handing of '@' character broke my use case
Date: Thu, 15 Aug 2013 10:16:11 +0100
Message-ID: <520C9C5B.2090402@gmail.com>
References: <520BC017.7050907@gmail.com> <7vd2pgtagc.fsf@alter.siamese.dyndns.org> <520BE468.1030808@kdbg.org> <7vr4dwrnwx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 15 11:16:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9tfH-0006ZX-Jq
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 11:16:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753361Ab3HOJQP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 05:16:15 -0400
Received: from mail-we0-f171.google.com ([74.125.82.171]:63395 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028Ab3HOJQO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 05:16:14 -0400
Received: by mail-we0-f171.google.com with SMTP id q55so365191wes.16
        for <git@vger.kernel.org>; Thu, 15 Aug 2013 02:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=l0AtkkNNQj7vTYzX7gX9RNPmOTogkx+2S3gNzBOCIvw=;
        b=MO6SJPJlgWBUCt8vBH/VFNeRK5QuZ9tT6YmOL/glXWV7leJ4qD3gDW+x7TGu27MKuc
         V/zhkChtIS+M2tDhEqK8FD9DKMsIKPN3nvgM0cStWPtELG77WD+94JDQZblV7908eDYz
         xxbXWDiai+2FI4AvB0g5KA1r9b58xBABRGbuQLgc4CsCoT2ImKIMZckuXQcr6jbp3gB8
         bv67VnLjLjAErE4jF4kjiQxAq1mwfTcyR/GQP50GMDHahthYLey2TVVEv02xt3qXRYU4
         MvUhLry5m+81wwHyfa8V9R3SCgPeMQsV++uoErJ2f8Wp+o039CdDVF2+gZE3QhmQcvBk
         fp0w==
X-Received: by 10.180.183.43 with SMTP id ej11mr1282197wic.9.1376558173644;
        Thu, 15 Aug 2013 02:16:13 -0700 (PDT)
Received: from marcovaldo.dub.corp.google.com ([2620:0:1040:205:8a51:fbff:fe5c:1cad])
        by mx.google.com with ESMTPSA id fu13sm1731491wic.7.2013.08.15.02.16.11
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 15 Aug 2013 02:16:12 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130804 Thunderbird/17.0.8
In-Reply-To: <7vr4dwrnwx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232338>

On 08/14/2013 09:57 PM, Junio C Hamano wrote:
 > Johannes Sixt <j6t@kdbg.org> writes:
 >
 > [SNIP]
 >
 >> Stefano's use-case, where @/foo is turned into HEAD/foo,
 >> indicates a bug.
 >>
 >> In my opinion, the topic, which touches a central part of ref
 >> handling, was a bit hurried (and this report is a symptom of it), and
 >> I wouldn't mind seeing it reverted.
 >
 > Thanks; you said it much better than I did.  I think the short-hand
 > is not a bad idea by itself, but the execution may need to be redone
 > a bit more carefully, and it is prudent to revert it from the
 > upcoming release.
 >
Thanks both for taking care of this issue with the usual speed and
clarity.

Best regards,
   Stefano
