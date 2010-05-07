From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Fri, 7 May 2010 21:25:13 +0200
Message-ID: <B929B102-3175-4CB2-AEEB-131E3F96DC94@gmail.com>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com> <cover.1273183206.git.eyvind.bernhardsen@gmail.com> <7v4oijhdsi.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1005071007320.901@i5.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	hasan.aljudy@gmail.com, kusmabite@googlemail.com, prohaska@zib.de
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 07 21:25:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OATAq-0004UN-6R
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 21:25:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758015Ab0EGTZT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 15:25:19 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:27501 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754794Ab0EGTZS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 15:25:18 -0400
Received: by ey-out-2122.google.com with SMTP id d26so136863eyd.19
        for <git@vger.kernel.org>; Fri, 07 May 2010 12:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=IwUSMpibIuYjKts4ACYIl1qwZ2AE6H8PEgucMZhNGp0=;
        b=oJj6pEBzmNezAg8qXaPYVW1RxHy5KFU/+cpVyn4+5qXTPMgva5k9rSBJZaCLjOGzJv
         iAgJx1lL4FTYmPv9pUxlRSXPVznuKP4Eyqq0NW2vHTCnkEEOVOd8Wtk7UXowJ0RvqHwM
         cfTNxeMmu9DQF6PaM+VObhQO7pws8lkfsIDyU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=D+U+lvyQRQgSAzxQx5EOJHqoBAbtSU7xqipO+uIFAGGpg0GFre7IbQAC60J8v1XbIG
         yc3xTDObvLE2iohEGQr/4LPFoDgHAAXKRB6viYq3GEDVs02NLS9TlGFRxrYanIOeVsX1
         phMHcACchNnkc1SHQv7r8CVw1Vo0wD1FhZBqg=
Received: by 10.213.53.75 with SMTP id l11mr256795ebg.31.1273260316749;
        Fri, 07 May 2010 12:25:16 -0700 (PDT)
Received: from vredefort.d.eyvind.bernhardsens.net (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 13sm1284918ewy.13.2010.05.07.12.25.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 07 May 2010 12:25:16 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1005071007320.901@i5.linux-foundation.org>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146560>

On 7. mai 2010, at 19.10, Linus Torvalds wrote:

> I also do think that maybe we could just change the existing crlf 
> attribute to work even without 'core.autocrlf'. 

Ah, of course.  Thanks for the clarification!  I didn't understand what Junio meant (and was composing a long email which may or may not have had a bitter tone); now I'm preparing a new patch series instead.
-- 
Eyvind
