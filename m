From: "Rob Shearman" <robertshearman@gmail.com>
Subject: Re: [PATCH 1/4] git-imap-send: Allow the program to be run from subdirectories of a git tree.
Date: Wed, 9 Jul 2008 13:08:02 +0100
Message-ID: <1096648c0807090508w5b161dd0xf4fc61a6653b3289@mail.gmail.com>
References: <1215555496-21335-1-git-send-email-robertshearman@gmail.com>
	 <7v3amjq2mj.fsf@gitster.siamese.dyndns.org>
	 <76718490807081828k7640d07bp547a69d05a6e07c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Jay Soffian" <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 14:09:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGYTv-0000GN-2F
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 14:09:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753649AbYGIMIH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 08:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753493AbYGIMIG
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 08:08:06 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:48206 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354AbYGIMID (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 08:08:03 -0400
Received: by wr-out-0506.google.com with SMTP id 69so2112656wri.5
        for <git@vger.kernel.org>; Wed, 09 Jul 2008 05:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=m3+NETLGAnl5lSsbygVjIdSKUoKlJ6TdlO6wWkilD8I=;
        b=wbUQHQ9yn1ItVvX5LhmxmxpkWKuEv6RUJnpuPxCAV2V6ig/tzdZ9jelAXROcSzqJMx
         4tOBwsgzhqOO8VyMSyxR+UmCNEgTULs6wk2QakEqmCouCm44/VUnz90phFovCjS0q/+T
         saNKNQcklaWjOdUXwqFTU1PIgCkBMrmNNtAGc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=dU2ODg/i3RPPhoIx93de+JiwKclCmeI9E+FvUaFUgTJBI6kJ8MSTQ2+JCjPzqt/Lp6
         5MtVf4v/8Opk9aloR4FmHf4Oa1f5cD3fj65okk4bLQoYMsLwt4rzF8JLhWInI8SHKEpH
         1LyYV4GwIBySZXAMxkgi4sNU84wDFxPqu1/kE=
Received: by 10.90.87.7 with SMTP id k7mr8437351agb.47.1215605282883;
        Wed, 09 Jul 2008 05:08:02 -0700 (PDT)
Received: by 10.90.93.17 with HTTP; Wed, 9 Jul 2008 05:08:02 -0700 (PDT)
In-Reply-To: <76718490807081828k7640d07bp547a69d05a6e07c4@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87876>

2008/7/9 Jay Soffian <jaysoffian@gmail.com>:
> On Tue, Jul 8, 2008 at 9:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> I thought Jeff already explained why this NULL was a bad idea, but perhaps
>> I was dreaming...
>
> http://article.gmane.org/gmane.comp.version-control.git/87701

Sorry, I missed that message. I'll resend the patch with his suggestion.

-- 
Rob Shearman
