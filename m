From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] git-merge: add option --no-ff
Date: Wed, 19 Sep 2007 09:09:46 +0200
Message-ID: <8c5c35580709190009u48e52acbq3c4113114de8cf1@mail.gmail.com>
References: <8c5c35580709170817s467fa7dv375952f872bba0e3@mail.gmail.com>
	 <11900461843997-git-send-email-hjemli@gmail.com>
	 <20070918225134.GA5906@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Peter Baumann" <waste.manager@gmx.de>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 09:09:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXth2-0004Kx-95
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 09:09:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752874AbXISHJs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 03:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752872AbXISHJs
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 03:09:48 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:6681 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752276AbXISHJr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 03:09:47 -0400
Received: by wa-out-1112.google.com with SMTP id v27so133888wah
        for <git@vger.kernel.org>; Wed, 19 Sep 2007 00:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=oAcqagevhv2X+6OW2ZK86qaNwWR62kh3v+6jYgnoqGY=;
        b=Ux5q1qC5wUKvbmcA2ZGcpHIAiyYGJwbUEC1XQDOR/pEzi3XBPBCoXbXwF+FaBWIX4sI0rXLUmVF5KJw9ekuGfPzt89pg3yViNJBPpRN7aMxgN2tZ6h2+yAU0piJj6XP+9zEAM2Ac0sNNCKIt9ZF93BRYAHOhRI2u8qicOTCGko8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BL8hlpqb9gmxFD3vCr/QzdGwLWvAegj84Oojl5nqRNuVtPRXekhImnOqtkI1VLWewRJKXKXLZNmaOuCvljg6CWKRGa/G26WY9sijwQ+8thKqLaf00apAf1ub/n2KTrqX5xFjETPRNnb3yHuDXcvyYnB19hYtsdjQh+rBiul2bmc=
Received: by 10.114.198.1 with SMTP id v1mr373417waf.1190185786152;
        Wed, 19 Sep 2007 00:09:46 -0700 (PDT)
Received: by 10.115.73.2 with HTTP; Wed, 19 Sep 2007 00:09:46 -0700 (PDT)
In-Reply-To: <20070918225134.GA5906@xp.machine.xx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58683>

On 9/19/07, Peter Baumann <waste.manager@gmx.de> wrote:
> This should be quoted, e.g.
>   +    if test "$no_ff" = 't'
>

Ouch, sorry about that. I can send an updated patch late tonight (it's
now early morning here), but I'm not sure Junio wants/needs it. Junio?

--
larsh
