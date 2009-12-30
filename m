From: Tarmigan <tarmigan+git@gmail.com>
Subject: Re: [PATCH RFC 1/2] Smart-http tests: Break test t5560-http-backend 
	into pieces
Date: Wed, 30 Dec 2009 13:09:38 -0500
Message-ID: <905315640912301009x491f957al839f66de7aba56ed@mail.gmail.com>
References: <1262037899-16786-1-git-send-email-tarmigan+git@gmail.com> 
	<7veimc2vq0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Shawn O . Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 19:10:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQ2zj-000620-Ib
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 19:10:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753137AbZL3SJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2009 13:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752394AbZL3SJ7
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 13:09:59 -0500
Received: from mail-px0-f189.google.com ([209.85.216.189]:55442 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876AbZL3SJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2009 13:09:58 -0500
Received: by pxi27 with SMTP id 27so6991773pxi.4
        for <git@vger.kernel.org>; Wed, 30 Dec 2009 10:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type;
        bh=aev5gJY+UDxvu7vrvtf5OLVj5m/FwDS5qCECbl9kzW8=;
        b=Hj/Rb1snIWgXRDdyH90YOdAJUj6BuwgHD+X6S1Dq88/ngxTehJdi2lIPyNwkumZcio
         eJpgIF4djWhbNrMSlFHyImeVp30EzQyXsZha8f9Us4myWE2QiybGZgWsCxTlzV0mszVo
         CXldgTxnUKuaQcvTOZVVi9LcbzRnzgVwO4FwY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        b=Ceg81Zz48fUb4cy3V7TRmhC8hPo3djwic88JshWOFEwCyPQv6MmRIAOHCNo0sSqGjy
         kpPFrWDKaVbH+Y/RCsf6SUnG0KCrHwH2skd+75fGeejDgZ8p7epu1+c55fz1GpkdINIX
         mfxdDbBxEKRYp1WDhaNhypzfyIOoseBsERUXQ=
Received: by 10.142.63.25 with SMTP id l25mr11883541wfa.333.1262196598126; 
	Wed, 30 Dec 2009 10:09:58 -0800 (PST)
In-Reply-To: <7veimc2vq0.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: a532e1f79221b0df
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135912>

On Wed, Dec 30, 2009 at 12:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Tarmigan Casebolt <tarmigan+git@gmail.com> writes:
>
>> This should introduce no functional change in the tests or the amount
>> of test coverage.
>>
>> Signed-off-by: Tarmigan Casebolt <tarmigan+git@gmail.com>
>
> This seems to crash rather badly with your own "Smart-http: check if
> repository is OK to export before serving it".

Yes, they were both separately based on 'master' a few days ago.

If you think the goal (more about that is in the commit log of 2/2) is
worthwhile, I am happy to rebase on top of pu and resend.

One reason it's labeled RFC is that I'm not very confident in my
ability to write portable shell script.  It works for me with bash,
but I'm not completely confident that is would work on ksh or dash.
So it would be nice if you could specifically take a look at the new
POST() and GET() and see if you notice anything obviously wrong there.

Thanks,
Tarmigan
