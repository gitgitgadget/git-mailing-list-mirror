From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH RFC] cherry: support --abbrev option
Date: Mon, 15 Mar 2010 23:39:10 +0100
Message-ID: <40aa078e1003151539u2d1873bcy394063466c8e404b@mail.gmail.com>
References: <1268668999-4188-1-git-send-email-kusmabite@gmail.com>
	 <7vwrxdse24.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 15 23:39:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrIwa-0001ZU-4g
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 23:39:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456Ab0COWjS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 18:39:18 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:51930 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932386Ab0COWjR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 18:39:17 -0400
Received: by wwe15 with SMTP id 15so235293wwe.19
        for <git@vger.kernel.org>; Mon, 15 Mar 2010 15:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=H4n6DWazrAW5FRA2ajXCvd37LT/48nXsc3pViMoZ4NM=;
        b=icCkVsvYS5c/IP9dSbntJiCwI7wYRbw7zMgzemersXVyijYsjt9+7iVUPOgT+m4929
         uuEe25OO0HtjvDYaKkZ4O8AU84+6S/SZNXSOfs7ypSOwCNbOVQKr1cRkHWwpFaDnvrXx
         X2jU5mPGS/gF3o9A19FO5ePh1K2sUidUKTkUw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=QCd5URBUt5Te8Kxn1DRAl0xCuRPykGJNFd4iPuO0zc3UaMi6uWkyb4PV16j2pwhljt
         9XfadUhrErq3qJyawubFKjjdFTX2YDSMClDHj0TqZo+HtR8SSLUcqkK343cQhuhoBYR0
         Ujd8EMy6wBJSe6uuTW7epHHy6ujl0xbiDbEJ0=
Received: by 10.216.85.8 with SMTP id t8mr1005686wee.39.1268692750933; Mon, 15 
	Mar 2010 15:39:10 -0700 (PDT)
In-Reply-To: <7vwrxdse24.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142268>

On Mon, Mar 15, 2010 at 6:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Erik Faye-Lund <kusmabite@googlemail.com> writes:
>
>> Switch to parse-options API while we're at it.
>>
>> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
>> ---
>>
>> I sometimes find it useful to look at the commit-subject together with
>> the SHA-1s. Using --abbrev increases the chance that the lines fits on
>> an 80 character wide terminal, making the output easier to read.
>
> Even though "cherry" historically was meant to be a low-level helper for
> Porcelain scripts, I've seen people use it as the top-level UI, and I
> think what the patch tries to do makes sense.
>

I find it very useful. In fact, even the documentation seems to
suggest to use it to find out if a patch is merged upstream, which
doesn't sound very scriptish to me. So I think it has somehow exceeded
it's original goal :)

-- 
Erik "kusma" Faye-Lund
