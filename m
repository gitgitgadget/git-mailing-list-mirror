From: "Jonas Fonseca" <fonseca@diku.dk>
Subject: Re: What's cooking in git.git (topics)
Date: Fri, 2 Nov 2007 01:00:56 +0100
Message-ID: <2c6b72b30711011700t7a9d4027k39e61ac472253cc3@mail.gmail.com>
References: <20071022063222.GS14735@spearce.org>
	 <7vzly84qwf.fsf@gitster.siamese.dyndns.org>
	 <7vmytycykt.fsf@gitster.siamese.dyndns.org>
	 <alpine.LFD.0.999.0711011129460.3342@woody.linux-foundation.org>
	 <916BE4AD-5BD9-48E6-8026-B1AC7387E28D@adacore.com>
	 <7v4pg5btis.fsf@gitster.siamese.dyndns.org>
	 <DB2DC59C-8580-4AFE-860F-6E7C4A47499E@adacore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "Geert Bosch" <bosch@adacore.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 01:01:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InjyL-0005af-M3
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 01:01:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756669AbXKBAA6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 20:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756530AbXKBAA6
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 20:00:58 -0400
Received: from rv-out-0910.google.com ([209.85.198.189]:32530 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756228AbXKBAA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 20:00:57 -0400
Received: by rv-out-0910.google.com with SMTP id k20so641084rvb
        for <git@vger.kernel.org>; Thu, 01 Nov 2007 17:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=rXAvsezsOBqCdUdnSY4FU9Rsri4Ux+72KRALVLyDf48=;
        b=qhAAiqzFPn9AGQhdT1GdQOUIx2XOo2npUIxuxe0m9vwO1kLUKb+uAz9pqxgM3hVtwv6okJbKxLJrn/KXV6HfJvEMoNf9nbs70KH4r5uP9EUJNinnSAbT00S6TNEqlZwpfxXfd8kHJ5dBCz4xXPUDkhbOUjM0xp6mQVOag00yhHo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=hYGGnbrJHEDjoAsdw4ZFY4Mg4ZNMWFUPzXg3WG0fNmF+OBusHBvOsMFjPlUW0j8/wClcbsqBk5Pea1w+WXaCwidPhdVc5qEZ4OwOcE3WMLziALMIRWIHLXlN+WkCTXRUv859AIuPfouUhaQJqOd755fXQzy2kkX0zAPXKMm1dhs=
Received: by 10.141.169.9 with SMTP id w9mr590745rvo.1193961656538;
        Thu, 01 Nov 2007 17:00:56 -0700 (PDT)
Received: by 10.141.5.5 with HTTP; Thu, 1 Nov 2007 17:00:56 -0700 (PDT)
In-Reply-To: <DB2DC59C-8580-4AFE-860F-6E7C4A47499E@adacore.com>
Content-Disposition: inline
X-Google-Sender-Auth: 6ec9de30d7f82558
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63038>

On Nov 1, 2007 10:17 PM, Geert Bosch <bosch@adacore.com> wrote:
> On Nov 1, 2007, at 16:27, Junio C Hamano wrote:
> > I think what you are trying to do is to deprecate or remove "git
> > clean".
>
> Yes, and in the meantime I'd like to discourage people
> from spending time and effort to upgrade it to first
> class built-in status.

If you search the archive you will find that a builtin-clean.c has already
been offered.

-- 
Jonas Fonseca
