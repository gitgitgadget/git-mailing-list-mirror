From: Tim Visher <tim.visher@gmail.com>
Subject: Re: Make a non-bare repo bare.
Date: Wed, 15 Jul 2009 20:54:01 -0400
Message-ID: <c115fd3c0907151754o55acec54ocdcdebe177b3c9c4@mail.gmail.com>
References: <c115fd3c0907151443h49aaac60r3462c69f55ed2d9f@mail.gmail.com>
	 <4A5E4EBA.4050708@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Thu Jul 16 02:54:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRFEt-0003dg-Dh
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 02:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756771AbZGPAyE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Jul 2009 20:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756746AbZGPAyE
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 20:54:04 -0400
Received: from mail-yx0-f184.google.com ([209.85.210.184]:58676 "EHLO
	mail-yx0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756761AbZGPAyC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jul 2009 20:54:02 -0400
Received: by yxe14 with SMTP id 14so6102617yxe.33
        for <git@vger.kernel.org>; Wed, 15 Jul 2009 17:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Fz02tIinG2YJnPNDRTnUirHb5VwP8AMTSq1Rt9VW/AI=;
        b=ezLke0K5oepcZwxkguUKXIXEM/RflugRYHQKFn2evO3mQiszXJ33wWv2dmmpwbszf/
         uCN8YjCOMemLArvoKJS7Gwjzgsj7tICq4iWzVqpVgExttKOcpAP/QYKlqy+2LcmsFx7N
         xpfqCiLqtx48j7igEHH0LPLAKEfh+fz3yeDd8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DQ12z9Fn8dg3UobqJ4LL+amCkxBF6/PRzq8+nK7bxVbM142ZDuR+fP6e1jXfefDxmr
         LEw42J/rCDNQzSFFL88YZbMToZ/r3OqO1gXaV07yvjilIjU91z3zMj9AHHYuxXQ3pn/u
         GZT8PBvec+uMazRXtvOVLmJbxGAxcmyHQY0zw=
Received: by 10.100.6.16 with SMTP id 16mr11075639anf.52.1247705641953; Wed, 
	15 Jul 2009 17:54:01 -0700 (PDT)
In-Reply-To: <4A5E4EBA.4050708@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123349>

On Wed, Jul 15, 2009 at 5:48 PM, Paolo Bonzini<bonzini@gnu.org> wrote:
> On 07/15/2009 11:43 PM, Tim Visher wrote:
>> I recently had occasion to make a previously non-bare repo bare. =C2=
=A0Is
>> there any way to do this? =C2=A0It will not allow me to delete a bra=
nch
>> that I'm on so I wasn't sure how to proceed.
>
> Just do "mv repo/.git repo.git; rm -rf repo" (with care!).

Thanks, Paolo.

--=20

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
