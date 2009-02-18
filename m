From: skillzero@gmail.com
Subject: Re: Retry conflicting merge with matching line endings?
Date: Tue, 17 Feb 2009 19:44:40 -0800
Message-ID: <2729632a0902171944l7a5ca5b4nf6d77bc7f9c1b201@mail.gmail.com>
References: <2729632a0902171755n3e89e717p6b3a38b556252bfb@mail.gmail.com>
	 <7v8wo41o8d.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 18 04:46:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZdNx-0006cf-Ua
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 04:46:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752713AbZBRDom (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 22:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752627AbZBRDom
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 22:44:42 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:15951 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752414AbZBRDol (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 22:44:41 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1228420yxm.1
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 19:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=skMqG5P4CdU4zkYcBaVfDGtaI3qnW4FLG4pMfcyJ2FA=;
        b=VJo/FuFtyifJToHE94oVxQeFAzm3Yii8d+rmPtmXpViKoAjs2xEZtJMT2EJFgcnH+b
         cBgJUs9DP35Tw16L3rI3/H3mk883IqWQTL5pZXY1r9YZVrH9rKKieReTwyitOkoRapA4
         hOuzoseoc0AqJrdnPtuGCCTJSB6Kjkf6QDlCI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=wrKkWIw4aYdy5lSjmVbFHTuUbO+FLeZ7jy0VMzejzHvt+aYYWOYk9RzCm4s3MDVYHt
         HPeXFzIDAA9dHZ/1H5fJaNI9CsWX4hqj3cIDYW94JvR5ZMFFeNuJUdPvj7pemZr0EN68
         pOb6C5QdrrNy37FxhXAFp9omIInZtl+K84g78=
Received: by 10.150.150.19 with SMTP id x19mr2811701ybd.115.1234928680591; 
	Tue, 17 Feb 2009 19:44:40 -0800 (PST)
In-Reply-To: <7v8wo41o8d.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110503>

On Tue, Feb 17, 2009 at 6:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> This is not specific to fixing line ending but applies any "global token
> replacement" (e.g. you renamed a variable) operation in general.

Thanks for the details. I was previously resolving things in a more
tedious manner and your steps will make things easier for me.

What I was curious about though is whether it would be reasonable for
me to submit a patch to have git automatically try this for the
special case of line endings (possibly implemented as a general token
replacement scheme with built-in filters for line endings)?
