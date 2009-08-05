From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Message from git reset: confusing?
Date: Wed, 5 Aug 2009 17:42:53 +0000
Message-ID: <32541b130908051042x5308e8fte7b3ead6bf1f24ee@mail.gmail.com>
References: <vpqab2e7064.fsf@bauges.imag.fr> <7v1vnqb2hc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 19:43:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYkWJ-0002fY-UY
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 19:43:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbZHERnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 13:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbZHERnO
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 13:43:14 -0400
Received: from mail-yx0-f175.google.com ([209.85.210.175]:36211 "EHLO
	mail-yx0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbZHERnN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 13:43:13 -0400
Received: by yxe5 with SMTP id 5so323132yxe.33
        for <git@vger.kernel.org>; Wed, 05 Aug 2009 10:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=wmZrzy7zDM3/h9hLMiqCUhvLbmk6W1vd/Z7lhB0BIuo=;
        b=aVuYgooZNQOogvACyGat34bPIAqiMGy8yJ2XpaavE//usiyWZd73FRgLgmdyIdJ9jo
         gbgRy/lV5eectWR9hPWZaQKkRN5RZPo+mq4211yRsYupi1JWQUjEOnrmDtfbjOVetrLo
         /sb0ehAwgMqHWCZRzfnPn6uJTJRVmnTyNLzl8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=piVVq/OZ1MRmx2uvVsizhUX32fGTZTV4/300feXyqdMUgtpe9IlR8TGsloidF9+goc
         amSw/6zjJRVGg15JO5VBEIBRuO28pxA41uUPXiEmwXBjs2eSynVc8+XuDnM6zvVrRmpi
         xUqwAvaiHNBVKzg2coeiLfco9cIcJLlgWDR8w=
Received: by 10.150.229.5 with SMTP id b5mr14803567ybh.268.1249494193065; Wed, 
	05 Aug 2009 10:43:13 -0700 (PDT)
In-Reply-To: <7v1vnqb2hc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124932>

On Wed, Aug 5, 2009 at 5:21 PM, Junio C Hamano<gitster@pobox.com> wrote:
> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> I was wondering what was the motivation for the output of "git merge":
>
> You meant "git reset".
>
>> $ git reset file
>> file: locally modified
>> $
>
> First a tangent.
>
> Removing this output _when no <path> is given_ would greatly reduce the
> usability of the command.

Yes.  I think the problem is that the current output looks more like
an error message than a status report.

I would find it very pleasant if the output looked more like the
output of "git checkout" (no parameters) in the no-files-specified
case.

Even if people don't know what "M" means on day 1 (although hopefully
they don't need "git reset" on day 1), at least it doesn't look like
an error message.

Have fun,

Avery
