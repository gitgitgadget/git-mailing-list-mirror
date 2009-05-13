From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: switching upstream tips
Date: Wed, 13 May 2009 10:16:31 +0200
Message-ID: <81b0412b0905130116l1ec0eb56p67003bacfa19c3d6@mail.gmail.com>
References: <4A0A6BD1.7050907@gmail.com>
	 <81b0412b0905130019x114d53d1v86833217bff613bc@mail.gmail.com>
	 <4A0A777E.7080506@gmail.com>
	 <81b0412b0905130041t327ef5f2m3b6d1dfac51fc1b1@mail.gmail.com>
	 <4A0A7BA1.4030500@gmail.com> <4A0A7D5E.1010909@viscovery.net>
	 <4A0A7FBA.1010606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Ittay Dror <ittay.dror@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 13 10:16:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M49dr-0002zx-Hu
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 10:16:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757599AbZEMIQh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 May 2009 04:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757263AbZEMIQf
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 04:16:35 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:51657 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757592AbZEMIQc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 May 2009 04:16:32 -0400
Received: by bwz22 with SMTP id 22so476847bwz.37
        for <git@vger.kernel.org>; Wed, 13 May 2009 01:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=OsomixF1X++1JPpgYddvTEaSzA0Wo0DxcglK/ULC4GM=;
        b=ujUB/OU6gY69nxYLPnAeYhBAOYX/7+CUtTjQBSpKrbT7aNNZlpBahUbN2Zr/eh4XQk
         bdOz28XHkEpJv3MjzyLDO2k3XZYBdDZU8/3is+vwOkrPiZa2jvNzKpt4OzvvA3zEJtVG
         G/1s7ZZ6GPE0csa24EEODcIvd/vJQ/F0HMppk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PUOfxMudfqDSvIsi12dLBwAd92Q8NHgsoF8pQCF5Xy/qMDjJr+yQNMd/7bNLqDTzKA
         hlxx9wR7dClK5R6uNEX6m+juyIufIuLicAwPrO8yyK26x47LuvNebaZ8L/cAoFVwgU9F
         piinpWNkY71c4vBYitaSZmFuiM0yVHva4yghc=
Received: by 10.204.68.10 with SMTP id t10mr638911bki.182.1242202591906; Wed, 
	13 May 2009 01:16:31 -0700 (PDT)
In-Reply-To: <4A0A7FBA.1010606@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119002>

2009/5/13 Ittay Dror <ittay.dror@gmail.com>:
> Johannes Sixt wrote:
>> I guess it should have been
>>
>> =C2=A0 git rebase -i --onto new-upstream old-upstream master
>>
>> That is, you take commits old-upstream..master and transplant them o=
nto
>> new-upstream.
>>
>
> same thing:
>> git rebase -i --onto upstream old-upstream master
> fatal: Needed a single revision
> Does not point to a valid commit: upstream

Well, don't put random characters where your branch names should be.
