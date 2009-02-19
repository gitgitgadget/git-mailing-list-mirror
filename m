From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 4/4] remote: new show output style
Date: Thu, 19 Feb 2009 14:51:51 -0500
Message-ID: <76718490902191151u7a893139p9f1c3a2c5d2b3267@mail.gmail.com>
References: <1235020471-59982-1-git-send-email-jaysoffian@gmail.com>
	 <1235020471-59982-2-git-send-email-jaysoffian@gmail.com>
	 <1235020471-59982-3-git-send-email-jaysoffian@gmail.com>
	 <1235020471-59982-4-git-send-email-jaysoffian@gmail.com>
	 <1235020471-59982-5-git-send-email-jaysoffian@gmail.com>
	 <499DB309.7000706@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Marc Branchaud <marcnarc@xiplink.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Feb 19 20:53:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaExW-0004S7-PI
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 20:53:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753497AbZBSTvx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 14:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753338AbZBSTvw
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 14:51:52 -0500
Received: from rv-out-0506.google.com ([209.85.198.239]:12073 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753400AbZBSTvw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 14:51:52 -0500
Received: by rv-out-0506.google.com with SMTP id g37so558958rvb.1
        for <git@vger.kernel.org>; Thu, 19 Feb 2009 11:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=izyw1UUuMkn9EXwPZFa+7U1tr7qAbwhLUk9FGi9ll6M=;
        b=O4S5FFrxLpuFlzl5h0viBb6OY9fp8ZLoSbwfHyhAoTUdKIgxdjUrn04AiZGny3I+ql
         uj3m+2O8AWNVTqAu15D5in8rVwuLenn95Cr/GGJtzOXBtJi2XO04EwI0J/2fe7D2CV8h
         eVSEXG7UUtvlfkNIQdi7GbQtrfqhUlcgYlJPc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Fp1LO2PXq/oJvD4OmGBt04wfkPVBcAwES0Gt48mqtV195ua8wv9bA0Rq+TqUAiHoBW
         5csarRxvQRX8LI30HkRTkhDU9bB1L5QgcdHujDK3tOvKnHn4Z9jNs0MN34m1aiSH0y+T
         fsBvoLzZQaX7hCvMfODJCk5zQRoSNUrlHjqFY=
Received: by 10.141.69.12 with SMTP id w12mr1477834rvk.108.1235073111091; Thu, 
	19 Feb 2009 11:51:51 -0800 (PST)
In-Reply-To: <499DB309.7000706@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110736>

On Thu, Feb 19, 2009 at 2:29 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Jay Soffian schrieb:
>>
>>  * remote two
>>   URL: ../two
>> -  HEAD branches:
>> -    another
>> -    master
>> +  HEAD branches: another, master
>
> Any reason why this list of branches is now horizontal instead of vertical?

Not a good one, but I thought it fit better w/how an octopus branch
listing was displayed.

> I must admit that I don't know what is meant by "HEAD branches".
> Can this list grow large?

The git:// protocol does not currently have a way to determine what a
remote sym ref is pointed to, so it guesses by matching SHA1s. In
theory this list is unbounded, in practice I don't think it is likely
to be large.

I like the suggestion above about how to display the octopus merge
tho, so I will put this back how it was.

j.
