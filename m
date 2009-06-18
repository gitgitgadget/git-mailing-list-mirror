From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH resend] Test cccmd in t9001-send-email.sh and fix two bugs
Date: Thu, 18 Jun 2009 08:49:50 -0400
Message-ID: <76718490906180549mb65dc17va513c294038470d2@mail.gmail.com>
References: <1245223062-27132-1-git-send-email-bonzini@gnu.org>
	 <200906181211.39440.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: markus.heidelberg@web.de, Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Thu Jun 18 14:49:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHH40-0003Ji-V9
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 14:49:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762308AbZFRMtt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 08:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761917AbZFRMtt
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 08:49:49 -0400
Received: from mail-gx0-f214.google.com ([209.85.217.214]:42972 "EHLO
	mail-gx0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752894AbZFRMts (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 08:49:48 -0400
Received: by gxk10 with SMTP id 10so1620771gxk.13
        for <git@vger.kernel.org>; Thu, 18 Jun 2009 05:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NcbdPNVzIZ+PqQyuQxVsuoxat1miXpV1fgh1gwlEI5E=;
        b=xbNVaWV5a2ja8uZTBLKRCVgXnyGy4bwwh61xwrbY4HPK++jqHZuUPn16B/ESr9mkcP
         ZzYzzVIwdKWqgYn87TerVFsbA3GEBOKEuHnwUH92cPxoHum1Ghty1RWh0I8kYiKyZmi3
         c2I8UEXYzAgLVXe9OMozgkLQbcSFVVvfkm8Pg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NVLYfYAcuT8S6rfHVyeKSRFFXZbPHiL8oblPG1nn2Sx1YEMW+YwNQZfkqsCcTz8Gc3
         +Ob0rHw3s8P9DERfNjR+mZX1+e8I/Nu/TXcCqCoIqdJ6ikP8J9vXMWV+kxzbOnfo43UQ
         hOppQicaH+xjHLVU9NIlUcFzcsELCzTUS98b8=
Received: by 10.151.111.11 with SMTP id o11mr3479407ybm.312.1245329390930; 
	Thu, 18 Jun 2009 05:49:50 -0700 (PDT)
In-Reply-To: <200906181211.39440.markus.heidelberg@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121836>

On Thu, Jun 18, 2009 at 6:11 AM, Markus
Heidelberg<markus.heidelberg@web.de> wrote:
> Paolo Bonzini, 17.06.2009:
>> The first bug is that the --suppress-cc option for `cccmd' was
>> misspelled as `ccmd' in the code.

Good catch. That error has actually existed since --suppress-cc was
introduced in 65648283. But nor did I (sheesh, aren't many eyes
supposed to make all bugs shallow?) catch it in 3531e2703d.

> Then I noticed that the documentation mentions ccbody, but the code uses
> bodycc.
> The author seemed to intend using bodycc, since it is also used in the
> tests and the commit message (3531e2703d, send-email: --suppress-cc
> improvements, 2009-02-15), but besides the documentation, ccbody is used
> in the bash completion.

Wow, I'm pretty sure I intended bodycc. And I'm not even dyslexic.

Thanks,

j.
