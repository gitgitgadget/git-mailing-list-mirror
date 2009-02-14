From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] use a hash of the lock token as the suffix for PUT/MOVE
Date: Sat, 14 Feb 2009 17:53:40 +0800
Message-ID: <be6fef0d0902140153i568fd1ecuff79635341aa9576@mail.gmail.com>
References: <49967321.10800@gmail.com>
	 <7vskmhwh6m.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 10:55:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYHEr-0007pm-KK
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 10:55:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbZBNJxm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 04:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbZBNJxl
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 04:53:41 -0500
Received: from wa-out-1112.google.com ([209.85.146.180]:19239 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978AbZBNJxl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 04:53:41 -0500
Received: by wa-out-1112.google.com with SMTP id v33so792448wah.21
        for <git@vger.kernel.org>; Sat, 14 Feb 2009 01:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2hg7GjUBNmyxSOS045wIYWfFTGvLpZevNsfn2nQhVsY=;
        b=eykZbVewbrLLHOrJDTeA3qCqYySJi4piVegK2e0tDrt1DCSs/STRUXgOBOMzdlfZW4
         Ugo0xpdzTCHud9Aj0pGlwkct0nXNUNLRpcyNYMEuemXBfrZQ2zCspxa5h9nDPtgu7Z1X
         YCdGdYGJhzI9E7cutB/Ma8KIHaB8UH4ZbRfaE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jKHdSpGSj6/qv+p+dXwGuMzFpqO9eSEMaCnmGw4AtlrGfamF8Y9WQEIB8zh7IS15RK
         GFcAXUi8UE/LVYhYJKisk8vDJWfnvA9jagHW19K4cVkoxw+aXCrw6cWBVlcpBU/SdHyd
         avtODAMurH0mbFyHvnaQnLnCwnX8imLC/ySl0=
Received: by 10.115.50.5 with SMTP id c5mr1234642wak.7.1234605220338; Sat, 14 
	Feb 2009 01:53:40 -0800 (PST)
In-Reply-To: <7vskmhwh6m.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109854>

Hi,

On Sat, Feb 14, 2009 at 4:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Other than that, I think this is a good patch.
>

thanks for the encouraging words, I've sent in the modified patch already.

-- 
Cheers,
Ray Chuan
