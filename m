From: Timur Sufiev <tsufiev@gmail.com>
Subject: Re: [PATCH 2/4] Add I18N-wrappers for low-level IO-routines
Date: Wed, 28 Oct 2009 21:01:21 +0300
Message-ID: <4ae886f4.0b38560a.6cfb.5ac4@mx.google.com>
References: <1256651643-18382-1-git-send-email-timur@iris-comp.ru> <1256651643-18382-2-git-send-email-timur@iris-comp.ru> <20091027210817.GA1577@sigill.intra.peff.net>
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 28 19:01:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3Cpw-0005Y4-3O
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 19:01:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915AbZJ1SBV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 14:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751857AbZJ1SBV
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 14:01:21 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:62298 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841AbZJ1SBU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 14:01:20 -0400
Received: by fg-out-1718.google.com with SMTP id 16so591925fgg.1
        for <git@vger.kernel.org>; Wed, 28 Oct 2009 11:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:cc:subject
         :in-reply-to:references:comments:x-mailer:date;
        bh=BNARZCwJKItgxDpSSNzmOUI1mI5yvBR2S2jsH36CpZc=;
        b=hGxhyF8bAaeuHppWTseAVYc1Bcwc/hnkYK2W2VX3MUpQzY7qaHsbkb/5Ot6kB5a3pH
         VeiikUKyjSCsmWM46tZEQ+3QozgsZFVZ7Cp+8BXR1nhw2UyV/WcCmW8IF6chT+oQ6cAr
         Ja1U7HUSeNHc70O1TZY25hfrmUZJgJO67SrFI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:cc:subject:in-reply-to:references:comments
         :x-mailer:date;
        b=cIf29odJ5A0jc1qIPGglG1pyu+SLnLmgm9fRzczz1EMeK5MaKC24gqKrt95IcvKjo9
         TO6xb6xmf3kIgvq9fYvM44vCm/LQeOMFolONRBNP/cfR1So0/rcnQV1OtTrUwfFTSaHi
         KDhZM14bauLTpjwjFBGYAuihE2IG6pi5UkNhE=
Received: by 10.86.21.8 with SMTP id 8mr1319490fgu.38.1256752885040;
        Wed, 28 Oct 2009 11:01:25 -0700 (PDT)
Received: from localhost ([80.90.116.82])
        by mx.google.com with ESMTPS id e11sm3339351fga.27.2009.10.28.11.01.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Oct 2009 11:01:24 -0700 (PDT)
In-reply-to: <20091027210817.GA1577@sigill.intra.peff.net>
Comments: In-reply-to Jeff King <peff@peff.net>
   message dated "Tue, 27 Oct 2009 17:08:17 -0400."
X-Mailer: MH-E 8.1; nmh 1.3; GNU Emacs 22.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131485>

> Hmm. Two questions about this series:
> 
>   1. Patch 3/4 didn't seem to make it to the list. Presumably that is
>      where you actually use these routines in git? Or are they just for
>      mingw?

Yes, it actually haven't made it to the list. Perhaps this was due to
patch size: it was approx. 3300 lines long (BTW, what's the message size
limit?) So I've rewritten the patch to make it more compact, using mingw
approach with macros. Subj prefix for a patch series is 'PATCH I18N
filenames v2'. 

>   2. I seem to recall that Linus added a filename translation layer for
>      doing much more, like handling unicode normalizations (but I
>      confess I haven't looked closely at that code). Should this be part
>      of that system?

I've heard nothing about that :(. Could you point me directly at Linus'
changes?

> -Peff

-- 
Timur Sufiev
