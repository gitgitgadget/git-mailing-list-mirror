From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: git branch --set-upstream regression in master
Date: Fri, 16 Sep 2011 20:19:08 -0400
Message-ID: <CAG+J_DwtkVws_kDbpb2HDW56BCdixa=DtnZ-uXei=URCkFq1=w@mail.gmail.com>
References: <CAG+J_DyxNpPevwfrJVkv3GBmv0tEXgW2LZtdHgarFoXb9Qqghw@mail.gmail.com>
	<7vy5xocafg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, conrad.irwin@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 17 02:19:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4icl-0001l8-PL
	for gcvg-git-2@lo.gmane.org; Sat, 17 Sep 2011 02:19:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755669Ab1IQATJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Sep 2011 20:19:09 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:47065 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189Ab1IQATI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Sep 2011 20:19:08 -0400
Received: by ywb5 with SMTP id 5so3272478ywb.19
        for <git@vger.kernel.org>; Fri, 16 Sep 2011 17:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=vxd4Syi87P63wKjFrk7r+sOr2AhR54J+sclJbuHF4c4=;
        b=eaPBT5AaP1tggAJuysB6UZnjx6ZAgNZSlmg4qrMsc793cL8yydT+xjMEQcq3NeDtma
         d24BKx0HIaMtzxKoWbLSpVWPZJDtUtYCBRcuB0EsB9CzrJ614KdsjATug9Y1GAHgZKrU
         9JOwg/BQKZ8ALkHlPWgO9Iq3bv0XaLlvkX9c8=
Received: by 10.147.17.13 with SMTP id u13mr4629yai.31.1316218748128; Fri, 16
 Sep 2011 17:19:08 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Fri, 16 Sep 2011 17:19:08 -0700 (PDT)
In-Reply-To: <7vy5xocafg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181568>

On Fri, Sep 16, 2011 at 7:52 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Jay Soffian <jaysoffian@gmail.com> writes:
>
>> This used to be possible on the checked out branch:
>>
>> =C2=A0 $ git branch --set-upstream origin/master master
>>
>> Now it gives "fatal: Cannot force update the current branch."
>> broken.
>
> Let's do this. I would be happy if I can include it in -rc2 with Test=
ed-by:
> or something ;-)

Tested-by: Jay Soffian

Thanks for the quick turnaround. I'll try to find some time to make
--set-upstream a proper option for post 1.7.7.

j.
