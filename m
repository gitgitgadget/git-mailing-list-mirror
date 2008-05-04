From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH v2 4/5] Make boundary characters for --color-words configurable
Date: Mon, 5 May 2008 00:35:57 +0800
Message-ID: <46dff0320805040935n22354e1bta85b3f3fe7c16cad@mail.gmail.com>
References: <46dff0320805020726y2592732cj9aef0111e5b2288a@mail.gmail.com>
	 <1209815828-6548-1-git-send-email-pkufranky@gmail.com>
	 <1209815828-6548-2-git-send-email-pkufranky@gmail.com>
	 <1209815828-6548-3-git-send-email-pkufranky@gmail.com>
	 <1209815828-6548-4-git-send-email-pkufranky@gmail.com>
	 <1209815828-6548-5-git-send-email-pkufranky@gmail.com>
	 <7vy76rtfns.fsf@gitster.siamese.dyndns.org>
	 <46dff0320805031732x25286707r991358162046c07c@mail.gmail.com>
	 <alpine.DEB.1.00.0805041040560.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun May 04 18:36:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JshCg-0008BJ-EU
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 18:36:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753438AbYEDQf7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 12:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753333AbYEDQf7
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 12:35:59 -0400
Received: from an-out-0708.google.com ([209.85.132.245]:65031 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035AbYEDQf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 12:35:58 -0400
Received: by an-out-0708.google.com with SMTP id d40so471055and.103
        for <git@vger.kernel.org>; Sun, 04 May 2008 09:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=CO2pOmGUNuICjxrW2nuZtMzG+JQ3YrZSpiYcyN0TyfY=;
        b=VlU/zgUrnrHr3Myf7cSH8Veoaf3hjer9q4mTuj8uoJI/5CMxBf5BD5g0yJQc1vUO9lOEbUJ4ETPsnhkAEI7OkvlIhBf9s3O91svRBc00CljlGFVZUbAKjGLI3O2RxWjX4/UsbyQzha/CtBHbrSmTDSVls22VtjjUpjTrbvnX5H8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AjLUAnKBP25PSLS4ezpFyLBH5/E1kEsFWn5pT+WZvk9oQS/vRcalw8tsBkn+RtrI1BSEbuNjycd1eugnuTJ96qjHtur8BuMKYC+DmYSk0GT69cnu0LuZWX1Cw8lRNGHHZLtS3p2Ps/m4xmCmjn3x7esGUgXl7CgxYpxjrDWPUkY=
Received: by 10.100.154.19 with SMTP id b19mr6723151ane.115.1209918957330;
        Sun, 04 May 2008 09:35:57 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Sun, 4 May 2008 09:35:57 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0805041040560.30431@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81185>

On Sun, May 4, 2008 at 5:44 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
>  The problem: given two chunks of text, where a word was changed, and a
>  non-word-character was moved to the next line.  Example:
>
>         The quick,
>         brown fox
>
>  vs
>
>         The fast
>         , brown fox
>
>  IMHO the layout of the new version should be retained, i.e.
>
>         The /quick/fast/
>         , brown fox
>
>  should be shown.

Why not

  The <r>quick</r><g>fast</g><r>,</r>
  <g>,</g>brown fox



-- 
Ping Yin
