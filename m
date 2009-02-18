From: Brent Goodrick <bgoodr@gmail.com>
Subject: Re: Is there a way to exclude user-specified files or directories 
	from participating in merges?
Date: Tue, 17 Feb 2009 21:39:12 -0800
Message-ID: <e38bce640902172139h6ddda8e8va089e514e625de52@mail.gmail.com>
References: <e38bce640902171649g765275a4n4e86d1d4f4aaf394@mail.gmail.com>
	 <7v1vtw367w.fsf@gitster.siamese.dyndns.org>
	 <e38bce640902171732j9b8801gca4223cdb96d2d34@mail.gmail.com>
	 <7vfxic1p6m.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 06:40:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZfAn-0004hu-FV
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 06:40:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752382AbZBRFjO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 00:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751676AbZBRFjO
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 00:39:14 -0500
Received: from mail-gx0-f222.google.com ([209.85.217.222]:48703 "EHLO
	mail-gx0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185AbZBRFjN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 00:39:13 -0500
Received: by gxk22 with SMTP id 22so5027137gxk.13
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 21:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CdGxKbpe9TXG2Oiqc7kvgFic0LawiCj17tdfiTW5oBc=;
        b=DhBTu9xASOazq/5dzfd7NAnlGs8W2N8j2PrV0fCa494axhC+IKMxO2ia8oiygW0/zN
         0f1NfwZlRzWqa0Jk7trfZxxHMxKYZbMmSVkz7fYTRqAYDfe5bgq2i6lG3zaTQygT3/n/
         pzZ24ojnjXrcFj5e7/BON+4xxp4sor/rpTC9o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kz3S3NK5hwQeCg/EYoY75D6nyQS01RKX/m5xtOrcn1R6P3sPV9sRWEtdYUvBbJIG5l
         ZCBlW93Rw6noH7bqBBhrdwyucUukuQupz1BATOKsihYcBZunhWDpQ5+TGumewTGQBa/G
         J1Cfj+mBNIfeHtnF+wGEmNBQ55Hct7GjzxieQ=
Received: by 10.100.144.11 with SMTP id r11mr876112and.24.1234935552108; Tue, 
	17 Feb 2009 21:39:12 -0800 (PST)
In-Reply-To: <7vfxic1p6m.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110505>

On Tue, Feb 17, 2009 at 5:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Compared to that, the two simple rules "commit changes to generic things
> only to the generic branch" and "merge only from generic to specific" will
> not grow as your project grows in complexity.

I now I see the wisdom of the above statement.  You've given me a lot
of approaches to think about and try. Thanks for your help!

bg
