From: "Dmitry Potapov" <dpotapov@gmail.com>
Subject: Re: [PATCH] "git shell" won't work, need "git-shell"
Date: Mon, 25 Aug 2008 21:20:38 +0400
Message-ID: <37fcd2780808251020j1ef51b38h7c6d6e8f050a92ce@mail.gmail.com>
References: <20080824202325.GA14930@eagain.net>
	 <7vfxoukv56.fsf@gitster.siamese.dyndns.org>
	 <20080824203825.GB14930@eagain.net>
	 <7vbpzikt4b.fsf@gitster.siamese.dyndns.org>
	 <20080825170816.GQ10544@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Tommi Virtanen" <tv@eagain.net>, git@vger.kernel.org
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Aug 25 19:21:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXflA-0005nI-QZ
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 19:21:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753773AbYHYRUk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 13:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753911AbYHYRUk
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 13:20:40 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:52377 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753704AbYHYRUj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 13:20:39 -0400
Received: by gxk9 with SMTP id 9so2415318gxk.13
        for <git@vger.kernel.org>; Mon, 25 Aug 2008 10:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=yk3iRViusMnPFjZCvkVfTKJpQIrizE40SpUKzCySM2M=;
        b=oxcBvS75rUtc8x03JRM/jBrxbuNhFQ0LwqdCz8o7+LvxIxcTQRdiYYmUOIukARlG2S
         uXXMxq8yh1RphNurEvgHj3LfnqL59PLZtWujOhXlPXDQFRU5C46NSBuqO7edxH4S8t9r
         jiwsokuzmoDSlJ588UtFkwVVocaIrT/y7Yw7M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=jI7IjgUhuf7WouImYrHl8WPpiPrJ4N/XgANROFpGB+MAZU7cHHtHe61otw62Ol+BZI
         mT0R6LdJK7WMpwOEXJX8Fkxk+L2vPjKy2ImqXwp52VqvTScRO726Pa1pCWVcnun4hiDE
         WNxjJLAgp0Dvs9yZtD9tdWznQvydBUqEQSG4A=
Received: by 10.142.222.21 with SMTP id u21mr1613542wfg.244.1219684838367;
        Mon, 25 Aug 2008 10:20:38 -0700 (PDT)
Received: by 10.142.106.16 with HTTP; Mon, 25 Aug 2008 10:20:38 -0700 (PDT)
In-Reply-To: <20080825170816.GQ10544@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93645>

On Mon, Aug 25, 2008 at 9:08 PM, Petr Baudis <pasky@suse.cz> wrote:
>
> Can we agree that direct calls of libexec stuff should never be part of
> the "official" interface (i.e. not workarounds for deprecated usage)?

Agreed. It looks somewhat strange to type the libexec path in /etc/passwd.

> Considering that calling the git-shell executable directly is the _only_
> sensible way of using this interface, it should follow that it has to be
> in /usr/bin, no matter if users type this command or not.

Perhaps, /usr/sbin would be a better place, as it is intended only for
system administration binaries.

Dmitry
