From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 0/4] git --paginate: do not commit pager choice too early
Date: Sun, 18 Jul 2010 22:27:00 +1000
Message-ID: <AANLkTim9f_A5OjiXYRK584CrKTG_Lol9oXwguBwwIW19@mail.gmail.com>
References: <20100626192203.GA19973@burratino> <7vpqzacs3h.fsf@alter.siamese.dyndns.org> 
	<7v630hyf5r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 18 14:27:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OaSxp-0006uF-TK
	for gcvg-git-2@lo.gmane.org; Sun, 18 Jul 2010 14:27:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754682Ab0GRM1V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Jul 2010 08:27:21 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:50438 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754639Ab0GRM1U convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jul 2010 08:27:20 -0400
Received: by pvc7 with SMTP id 7so1349751pvc.19
        for <git@vger.kernel.org>; Sun, 18 Jul 2010 05:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=h0Cvk8n5rVIZTQpsETeq54SBmBL6GF+906nLaJVDY+o=;
        b=uXH+kHqGiiHuKUhzH5PPpKiRQ+RYPlGvc/3EfPKoEUad4KOLvawEIO4lecX0IMqgQv
         LiYa4xgHTHLC/GUaJ0YsioYBCuyNQYeBcuQ0P3dmjuQVMASklfsooRbDRnvoYV4SBGwq
         51ychNbIlAfFnWIdFH6fyBZxqkhn1ISKIvX0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=O7raIedFi+e/mgF2rM1AQVXi91z6kUAoS0qfQSfdmlONDQvNpBSqSBHxIIJ5lLtg7j
         HLMc/fHFUwy2oyhAhxPptS4IhrwrsUYNo8Ek+0M9v/IB64MPUXpRVPD/PgjxCtzdpDcW
         5HZg59mkPZD19+cTu/vMTHIuxKoCFWui4Frjs=
Received: by 10.142.192.2 with SMTP id p2mr4928694wff.222.1279456040223; Sun, 
	18 Jul 2010 05:27:20 -0700 (PDT)
Received: by 10.142.98.1 with HTTP; Sun, 18 Jul 2010 05:27:00 -0700 (PDT)
In-Reply-To: <7v630hyf5r.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151208>

2010/7/15 Junio C Hamano <gitster@pobox.com>:
> Missing from the above enumeration are are external commands. =C2=A0T=
hey depend
> on commit_pager_choice() to be called before execv_dashed_external() =
gets
> called. =C2=A0For example, "git -p request-pull $args" no longer work=
s with
> this patch.
>
> Sigh..

I'm sorry. I missed those paths..
--=20
Duy
