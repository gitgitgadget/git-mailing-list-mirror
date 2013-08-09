From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Repo with only one file
Date: Fri, 9 Aug 2013 11:00:25 -0400
Message-ID: <CABURp0p9NGoL=F8-xpicz5J+TmOopYhv-qmxoWagHOcBiKn6=w@mail.gmail.com>
References: <CAH_OBid8SO3ydpjhRHa68s+54CScLh=jactxTQhwQPo-jcnAvA@mail.gmail.com>
 <520224E0.5060206@viscovery.net> <CAH_OBicysTTu9YdHsHz0H6x3umU5va68J3nT1qHA9-CJY9+E=A@mail.gmail.com>
 <CABURp0o_07HdB2o0knPABtAiiuHQ6-fYgemvdCYOsdSghO7v1w@mail.gmail.com>
 <52048B5B.5060009@viscovery.net> <CAH_OBicF3xn8+MsKH0nTg-HnPg58T-TWHW20r7GqXOm3Nbutfg@mail.gmail.com>
 <52049121.2080604@viscovery.net> <CAH_OBifYFyVVo_OEfniWJE=0peX+UPLkRznqyQzvO4gGGLu_tQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git List <git@vger.kernel.org>
To: shawn wilson <ag4ve.us@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 09 17:00:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7oBO-0003Rn-TH
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 17:00:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934113Ab3HIPAq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 11:00:46 -0400
Received: from mail-vb0-f45.google.com ([209.85.212.45]:57445 "EHLO
	mail-vb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933949Ab3HIPAq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 11:00:46 -0400
Received: by mail-vb0-f45.google.com with SMTP id e15so4166856vbg.32
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 08:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=TzbUKNAyla6hsMaGeu6YEMJTrFBiRDov+4szVz9QK1M=;
        b=CnuThCjMl41gEAN87kfLb6gAksUUa867zMFzOfMdB+HIbbyE82000z6qG90iSaOOx8
         VAUEeNbf/SBOk+KytHG+YhzbiEg9/WnKaIBONaUuFjRQNYL6znHQAVMoXQPxCVJHbW7q
         CdY6r3GwfzFGarLKDbqe4ZbgnybuA+IzzkUQGjtg2+6q6CT2+2LXLymD5aI9CAmHysSu
         BnoEuurZBw9cB3FqVQzhHn4jUuYImysd/bKfbxeVATosTcaT3NqpQxtsFSobwPxpe24k
         Os4Wmq+WFMHmSnej2ZqHDpXQqP8MMpT0bf6uIuA/2nlGucVgGGtBpYldR4VogPppEXOo
         E95w==
X-Received: by 10.58.46.196 with SMTP id x4mr598040vem.73.1376060445373; Fri,
 09 Aug 2013 08:00:45 -0700 (PDT)
Received: by 10.58.220.72 with HTTP; Fri, 9 Aug 2013 08:00:25 -0700 (PDT)
In-Reply-To: <CAH_OBifYFyVVo_OEfniWJE=0peX+UPLkRznqyQzvO4gGGLu_tQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231986>

On Fri, Aug 9, 2013 at 6:03 AM, shawn wilson <ag4ve.us@gmail.com> wrote:
> On Fri, Aug 9, 2013 at 2:50 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> Let's check: After running your command above to remove other files, does
>> the command
>>
>>    git filter-branch -f HEAD webban.pl
>>
>
> Ahha, no but:
> git filter-branch -f HEAD -- webban.pl
> did
>
> Thanks.
>
> The question still stands though - why is that unassociated commit left there?

Maybe you need  --prune-empty.

Phil
