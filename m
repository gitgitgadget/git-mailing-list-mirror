From: Erick Mattos <erick.mattos@gmail.com>
Subject: Re: [PATCH v3] git checkout -b: unparent the new branch with -o
Date: Wed, 17 Mar 2010 15:55:45 -0300
Message-ID: <55bacdd31003171155l6cae5386m9f12ed72979f489f@mail.gmail.com>
References: <1268763584-14164-1-git-send-email-erick.mattos@gmail.com> 
	<7v634v27vf.fsf@alter.siamese.dyndns.org> <55bacdd31003161810w1c824570lee1b7d5759568bc1@mail.gmail.com> 
	<20100317041307.GA26641@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 17 19:56:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NryPf-00069J-Tw
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 19:56:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450Ab0CQS4K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Mar 2010 14:56:10 -0400
Received: from mail-yw0-f201.google.com ([209.85.211.201]:42330 "EHLO
	mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915Ab0CQS4J convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Mar 2010 14:56:09 -0400
Received: by ywh39 with SMTP id 39so554474ywh.21
        for <git@vger.kernel.org>; Wed, 17 Mar 2010 11:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=T107MCZ88KDyNw7/jL8thOBZTj+XbbRL4E61xKqby1M=;
        b=NM1erC9om6mmOfUo2Lo5CfQvWPTocYP6jbr764lQdYyfjgVMpi13Neb9OVc0Vqyueb
         vAFS0gDtvOKugydlu8rVA9RwxNVdfa0hE7617huAu/zCS+2uUHvc+3G1HnU+kgqZi+za
         MJHAR9zwqHb/GybSBCuACJLm/g4b1Se04RSYw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=eyGgwnIkFP+WR9RI1cXiYnVk2kMRHPKw17EeikxA+MnfhxEV6EkXB7FknnrJlihhLB
         cWJoU3KKcSQ/lpGYDWS92i7qR1VsDawI1HverpW+6Jnvq6qJ1WhX8yX8V8y0r87thnYA
         SSVm1GXQ93KOOFV4INuywUynXaUmBDnc26rAo=
Received: by 10.150.169.14 with SMTP id r14mr5689598ybe.83.1268852165077; Wed, 
	17 Mar 2010 11:56:05 -0700 (PDT)
In-Reply-To: <20100317041307.GA26641@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142429>

2010/3/17 Jonathan Nieder <jrnieder@gmail.com>:
> ...
>
> Thank you for your efforts. =C2=A0As hinted above, I would not mind s=
eeing
> improvement in this area at all. =C2=A0Anyway, I hope this has provid=
ed some
> food for thought (if not, don=E2=80=99t mind me; please carry on).
>
> Kind regards,
> Jonathan

Thanks for your kindness.

We are almost at the end of this new option creation cycle.  We are
now building the appropriated explaining messages.

This improvement is indeed targeted to let end users create orphan
branches.  I don't see a reason for changing focus because I see this
need as eventual really.

Kind regards
