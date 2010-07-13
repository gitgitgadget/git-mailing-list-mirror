From: Nazri Ramliy <ayiehere@gmail.com>
Subject: Re: [PATCH 2/2] rebase -i: Preserve whitespace at beginning of commit 
	header in $GIT_EDITOR
Date: Tue, 13 Jul 2010 13:19:16 +0800
Message-ID: <AANLkTinY9LGB1v8WdwJvFr8f-InaqFx5BozsAH2xlVBQ@mail.gmail.com>
References: <1278764821-32647-1-git-send-email-ayiehere@gmail.com>
	<1278764821-32647-2-git-send-email-ayiehere@gmail.com>
	<7vbpadfd4r.fsf@alter.siamese.dyndns.org>
	<AANLkTin9vUliwD5Ufa1vMTC2RZ7TSiyNaPmnDNtz1FQd@mail.gmail.com>
	<7vzkxw3r8f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 13 07:19:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYXtr-0002bp-D3
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 07:19:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575Ab0GMFTS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 01:19:18 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41440 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207Ab0GMFTR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 01:19:17 -0400
Received: by wwi17 with SMTP id 17so663862wwi.1
        for <git@vger.kernel.org>; Mon, 12 Jul 2010 22:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=ROlqQcQvwwzSXUnpXMg9hJPzTEf4PBU4PCiYE5wp8ns=;
        b=cR8eRXHah41eJoUo8zzxmHY3tBE2sS2rez6B8FbgdtC2ZfYX/tV79D5Uwjn+BHhjPx
         J6On7KvNkoTeeJSfIVISGKy5dXq7LQBUAVn4M4l2Kze/iTBG260oxtldR63+qZnSia9L
         4sLH8B0jP/Egau0yGHdvNleOsXwu4yV2jIECo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=TluLpDdNg7WYoQlJGxgL8xDmXx2RTOoepzRiMxDuszQOWOc5yTwQYSQTCQL47aeh58
         IfTBVPon0WdESoLJ/z76NYm9XUUp0qQFsWuT3TgRNCb1w3ClAImaf9/hBXk42BARXGy/
         FZVtQakX945nvdtKupGjOMSzc8Xw8MiY81AbY=
Received: by 10.227.128.144 with SMTP id k16mr1526895wbs.196.1278998356223; 
	Mon, 12 Jul 2010 22:19:16 -0700 (PDT)
Received: by 10.216.163.142 with HTTP; Mon, 12 Jul 2010 22:19:16 -0700 (PDT)
In-Reply-To: <7vzkxw3r8f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150875>

On Tue, Jul 13, 2010 at 1:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
> To put it differently, if we really do perceive this "impossible to spot
> if you _only_ look at the insn sheet, but it is easy to remember which
> ones to edit" as an issue, shouldn't the patch at least mention that it
> attempts to solve only one and punts on the other two that are still to be
> fixed later (so that other people can come back to help)?

Thanks for spending your time to clarify the issues.  I'll see if I
can improve the commit
message and/or the patch to handle those issues.

nazri.
