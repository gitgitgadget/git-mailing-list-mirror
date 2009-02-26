From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] t5540-http-push.sh: avoid non-portable grep -P
Date: Thu, 26 Feb 2009 17:40:25 -0500
Message-ID: <76718490902261440p4c9981fbncbdd58ad12e38349@mail.gmail.com>
References: <1235677745-939-1-git-send-email-jaysoffian@gmail.com>
	 <7vwsbdq6u4.fsf@gitster.siamese.dyndns.org>
	 <76718490902261243gaebdd8an2bd75bf625556f7b@mail.gmail.com>
	 <7vmyc8rhry.fsf@gitster.siamese.dyndns.org>
	 <76718490902261419r314f6ea4r5eb02e9b5b0c40d0@mail.gmail.com>
	 <7veixkrfif.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Tay Ray Chuan <rctay89@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 23:42:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcovT-0006qr-VR
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 23:41:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758370AbZBZWka (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 17:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755053AbZBZWk3
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 17:40:29 -0500
Received: from rv-out-0506.google.com ([209.85.198.225]:7324 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758045AbZBZWk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 17:40:27 -0500
Received: by rv-out-0506.google.com with SMTP id g37so743396rvb.1
        for <git@vger.kernel.org>; Thu, 26 Feb 2009 14:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RobdrwvA++sOiW0uvDkAYLutTc1tMRzYMCXzy/GlMC0=;
        b=dSgZFAmXGx1dBMEjL8MGo8EXG6L0Ymq4Foqgtm+asbR3DqEzCxNmKfpMKXKGYYkOff
         rM4B+yplMN/II4REA9cjdJTbFEleTqb10cb8p/oXFPbfVQZBOIJGx3B4zAvFW3bT9/o9
         /C6KbO1kNY/RxkfXxnE81nThIF5+AVbEu7NQI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MD35GMCIWLk4rCHIkydlWhe9EUiTOxT6g3X5/+IP/bPA6azE8S+bY5gHVyyZ98PM47
         O5mZoFuieErL8D3ro+Zz3ZDfBBT2qkMJCAp/G2vuP9M6y8eeIyEj5VUUkCswXJO3ofHT
         DOCcUjnQiM7STSKkDuC7vuU/mAW/NNZlPKkyg=
Received: by 10.141.53.18 with SMTP id f18mr846192rvk.188.1235688025125; Thu, 
	26 Feb 2009 14:40:25 -0800 (PST)
In-Reply-To: <7veixkrfif.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111606>

On Thu, Feb 26, 2009 at 5:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I don't mind Perl as we already depend on it; the looseness of the regexp
> stil bothers me somewhat, though...

I think you're letting the perfect be the enemy of the good. The point
of the test is merely to check for the SHA-1 has suffix in PUT/MOVE
operations. Any of my suggestions so far are better than what is there
now. Why so much fuss?

I'll send one more iteration, and if that's not good enough, I give up.

j.
