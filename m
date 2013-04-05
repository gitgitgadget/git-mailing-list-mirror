From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] glossary: extend "detached HEAD" description
Date: Fri, 5 Apr 2013 19:46:45 -0400
Message-ID: <CAPig+cQ+4r17UK=uWcjGAa1PeFiJ-fFOfgEQJTMd+FGbVbw3yg@mail.gmail.com>
References: <7vwqshc8ec.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	=?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 06 19:14:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWRL-0001b9-Nx
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:58:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163069Ab3DEXqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 19:46:47 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:64959 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162968Ab3DEXqr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 19:46:47 -0400
Received: by mail-lb0-f173.google.com with SMTP id w20so4262364lbh.18
        for <git@vger.kernel.org>; Fri, 05 Apr 2013 16:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=e0LSp5fTlc3kNRycvjTQYMtADLdOCue8hNQua9wF2iM=;
        b=uSENqzkwLIdW++2UGq+2ywdRICdiNfwukWgqUX6L4AHH1zPoZzVYgiDGEZBpsV1Dl0
         yb+IVhvqpXvAVacY3sWiqc2Rtk/uuINcebGyAMXoYB6keV9q9nd4CVsB4WTkugiLuJpV
         R+8Xmj0PMBgpAX23+VbT0G4I2HGWxnBtJHovpm5vRkW0+HRtbz3a6AGnzLyjB6Zy0A0F
         LOVNIP3GhMult/NsCSYVrwsKa2CQponsSsWJ63GQ29AzPnsMv59P19+TIRDdQMg7moAc
         VZXvQ6Pcn3ljCUhapaJrMjCRhOm6T4zlb7kNto55ie6FNivkzyspOHUaPMcT5zEf7lwP
         L5Lg==
X-Received: by 10.112.82.164 with SMTP id j4mr7243530lby.112.1365205605645;
 Fri, 05 Apr 2013 16:46:45 -0700 (PDT)
Received: by 10.114.1.43 with HTTP; Fri, 5 Apr 2013 16:46:45 -0700 (PDT)
In-Reply-To: <7vwqshc8ec.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: MLieHNK5MQWAdVbLggmo9IuhAWY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220198>

On Fri, Apr 5, 2013 at 11:19 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Add a blanket description to the glossary to cover them instead.
> The general principle is that operations to update the branch work
> and affect on the HEAD, while operations to update the information

s/work and affect on the/work on and affect the/

> about a branch do not.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
