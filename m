From: Mark Lodato <lodatom@gmail.com>
Subject: Re: A Visual Git Reference
Date: Mon, 8 Feb 2010 15:57:25 -0500
Message-ID: <ca433831002081257u4fec4010sa382f1e1bfeb4c0b@mail.gmail.com>
References: <ca433831002081134m698f531bwa22f0474db0cdcb@mail.gmail.com> 
	<20100208195141.GF30877@m62s10.vlinux.de> <ca433831002081221o660ff882o703381c5f066512e@mail.gmail.com> 
	<2cfc40321002081234t2e8585bxfbcae41b18804e70@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git list <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 21:57:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Neag6-0003Xy-Qr
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 21:57:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752622Ab0BHU5q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2010 15:57:46 -0500
Received: from mail-px0-f202.google.com ([209.85.216.202]:39253 "EHLO
	mail-px0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543Ab0BHU5p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 15:57:45 -0500
X-Greylist: delayed 2146 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Feb 2010 15:57:45 EST
Received: by pxi40 with SMTP id 40so6801541pxi.21
        for <git@vger.kernel.org>; Mon, 08 Feb 2010 12:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=Wg+J0HFQ18PlmecrybvfTCXI85uCpZwRvUTUZFytcFY=;
        b=AeeCO9zKFCd2u2qHaEgq4khktj32QxWEWGrIN7ewgjN34MOKIbAcBR5KBYGsjsNJ9g
         i5BYcP2YUqmZtxS0RlzBOmh1WtXWP6Eo3wl5baeXbNfgTwtNlR+zPb+iRa1NnDnIMsn2
         LWKB5BfFAXvsHUJzBU7q7nCWBRZU/pGwEWC48=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=f717S7MOkI8Ea2XD7ZSv1Tydmjy78fbLA7WR19iH96osTT/0NOl4HnmaqDUbbS2FOF
         XBuDFyzI1dPS77NJfrJJB2nwqieT+kZ7AKAQzFHApF4MFYeyPg7jRVQiWRJW3S6rnr2m
         9hsM5zHJ00TVw+Yc0vNfcvY0w23PCM7+rN1ZA=
Received: by 10.114.236.35 with SMTP id j35mr2191536wah.117.1265662665129; 
	Mon, 08 Feb 2010 12:57:45 -0800 (PST)
In-Reply-To: <2cfc40321002081234t2e8585bxfbcae41b18804e70@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139318>

On Mon, Feb 8, 2010 at 3:34 PM, Jon Seymour <jon.seymour@gmail.com> wrote:
> Nice diagrams. You might want to change the arrows on the diffs to be
> consistently in direction of the forward diff.

Thanks.  You're right, the da985->b325c was the only one that made
sense - the rest were reversed.  Is this what you meant?  I just
pushed this change, so it should be fixed.

Mark
