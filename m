From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH v3] Give the hunk comment its own color
Date: Fri, 27 Nov 2009 09:44:01 +0100
Message-ID: <36ca99e90911270044o68375902l3a0d2a4afa726a91@mail.gmail.com>
References: <7v4oogzo74.fsf@alter.siamese.dyndns.org>
	 <1259304918-12600-1-git-send-email-bert.wesarg@googlemail.com>
	 <7v3a40tl9t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 27 09:44:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDwQy-0001z9-J1
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 09:44:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752691AbZK0In5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 03:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752618AbZK0In4
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 03:43:56 -0500
Received: from mail-fx0-f213.google.com ([209.85.220.213]:35695 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752608AbZK0In4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 03:43:56 -0500
Received: by fxm5 with SMTP id 5so1366404fxm.28
        for <git@vger.kernel.org>; Fri, 27 Nov 2009 00:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=8T3B+dKGGLKkYCkLbA74k/yIRbtK4j0znG4nzezUkhU=;
        b=t9DMqiU25YZTM7/g0GHRYGQqJ+R+hL8EOiECUBG3Vi6Xr8RNWK2mQ68ICzN6rENrA4
         bQ5Vi6w8Mnz5ZKJGifgUNt6Sw0OYZeYwvD6gj/TSFiwUInpyy4ywVta+La2Up8mHEsU1
         p8/Yyscy8+eu++TJjPHFtPjDNvYaCQK/vZ8E4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Z7u8HVPIA4vCCHyKohT8DjURDAAKzE8f6VsjEgQ9VJMhqbseN0QO4tZotX9iFAxnxc
         gKA6Iu6EJSeg73fp5g8C8XTVBazVorPB5cTC7Jt13Nse3hVTUQUJvubs9CSEYfZTlsAu
         F5kwuzIEY4r/yBHWzubkVgPbZIsdm3ASAXPUc=
Received: by 10.223.22.4 with SMTP id l4mr112326fab.37.1259311441640; Fri, 27 
	Nov 2009 00:44:01 -0800 (PST)
In-Reply-To: <7v3a40tl9t.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133877>

On Fri, Nov 27, 2009 at 09:38, Junio C Hamano <gitster@pobox.com> wrote:
> I was slightly surprised that this seems to have differences other than
> the flipping of the default color since the last one, especially after you
> sounded like you would be sending with only that change.
v3 does only that and adopt the change to the t/t4034-diff-words.sh
test. There I set an explicit value of func to magenta for testing.

Maybe you missed v2 (Message-Id:
<1258557087-31540-1-git-send-email-bert.wesarg@googlemail.com>)? Which
fixed the test and also a small bug.

Bert
>
