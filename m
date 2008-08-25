From: "Mikael Magnusson" <mikachu@gmail.com>
Subject: Re: [PATCH] "git shell" won't work, need "git-shell"
Date: Mon, 25 Aug 2008 20:25:38 +0200
Message-ID: <237967ef0808251125q3e50fa04wf0e97ff29298bef2@mail.gmail.com>
References: <20080824202325.GA14930@eagain.net>
	 <7vfxoukv56.fsf@gitster.siamese.dyndns.org>
	 <20080824203825.GB14930@eagain.net>
	 <7vbpzikt4b.fsf@gitster.siamese.dyndns.org>
	 <20080824222534.GC14930@eagain.net>
	 <alpine.DEB.1.00.0808251235430.24820@pacific.mpi-cbg.de.mpi-cbg.de>
	 <48B29B2A.6000802@gnu.org>
	 <alpine.DEB.1.00.0808251955490.24820@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Paolo Bonzini" <bonzini@gnu.org>,
	"Tommi Virtanen" <tv@eagain.net>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 25 20:27:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXgm6-0007Ry-QT
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 20:26:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752586AbYHYSZl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 14:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751576AbYHYSZl
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 14:25:41 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:6230 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144AbYHYSZk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 14:25:40 -0400
Received: by nf-out-0910.google.com with SMTP id d3so790908nfc.21
        for <git@vger.kernel.org>; Mon, 25 Aug 2008 11:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=OnmdvAKq/2jOhSGI/vT5uix7noN13SbVEehhBcnSbb0=;
        b=JWXbyuB1RIenXWERs/opnhxBycM5/Xd8FFJ5lOMLIWOevQSF1TUSgy5lDQnvOxwf+e
         vymd6goYNFC28Y+aC/Ia5BEuz6hfdnIgYyK1DLD+NN83qqFRJR0V1FeoiLQ5KiDQXKGx
         +ywcemIwsdkIb+Tm6ETiU81vRRhzw8jaNE1JU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=pwcjS+LwqH0FaoHANaG0C5a+IWNxkWSJz+ih1lUQFQ5nDDg/rrcCkWADP8nLBf1pov
         ooCJ1lW15v7MIpYxJLZO966NWeq+vK5NhxIE+aVvTr3a7NUoAkr8g9LjkmfzH0/TKrZf
         YBibnPWH+6A0zjXkaLmRspNpGA1R+GLYVLNWg=
Received: by 10.210.90.8 with SMTP id n8mr7019793ebb.121.1219688738897;
        Mon, 25 Aug 2008 11:25:38 -0700 (PDT)
Received: by 10.210.19.20 with HTTP; Mon, 25 Aug 2008 11:25:38 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0808251955490.24820@pacific.mpi-cbg.de.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93652>

2008/8/25 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi,
>
> On Mon, 25 Aug 2008, Paolo Bonzini wrote:
>
>> > That would involve you actually finding out what's happening, though.
>>
>> He said so:
>>
>> > test:x:1001:1001:,,,:/home/test:/usr/bin/git shell
>> >
>> > just makes ssh loop asking for a password, logging
>> >
>> > "User test not allowed because shell /usr/bin/git shell does not exist"
>
> Okay, so this means that you cannot pass arguments to the login shell.
> Makes me wonder... I had the impression that bash was called with --login.

When you login, a '-' is prepended in argv[0], ie, bash checks if it's called
"-bash". This is documented in man bash, but I couldn't find it in man login
or man agetty, not sure where else it might be written down.

-- 
Mikael Magnusson
