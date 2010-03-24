From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: GIT_ONE_FILESYSTEM inclusion?
Date: Wed, 24 Mar 2010 10:29:59 +0100
Message-ID: <81b0412b1003240229l6f7eaa18l563c3d7ba0cf6cc5@mail.gmail.com>
References: <20100323232055.GV7038@pixar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Lars Damerow <lars@pixar.com>
X-From: git-owner@vger.kernel.org Wed Mar 24 10:30:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuMum-0001fS-GW
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 10:30:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755258Ab0CXJaF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Mar 2010 05:30:05 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:53956 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755234Ab0CXJaB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Mar 2010 05:30:01 -0400
Received: by bwz1 with SMTP id 1so2662705bwz.21
        for <git@vger.kernel.org>; Wed, 24 Mar 2010 02:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=gKCBNJiWHkQ9UMhEskDFL/901jxVB3TVL00CMZg2bag=;
        b=AqHKOdqgGEJYikBixI+U7hyNzIagi9KlbcKyECwQT+DuIVOxzPZVbdD4qjOeW1rfpd
         4HO9DJ0C8WOGATXinOtfiUJ7Pg/pDMxzDUyfg1hKE1+fj1zP847GS/KicQPp8L1c29CU
         WWyOUd3CvfHcHxfeiCv5Ubm8huoeYO/w6KgTo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tLjQTktiZqTdKNNE0u3h/Fr64l7qiQ8l+jUxnUxRRo7TZirAQa4vDM2rMB5s0uq6sX
         1fKvKCyxAkosiDDmGr305gJfmjrICcBrR4gOLG298feKh6eiaqkghhuMsHERGBzvNcKj
         hPwQnKNByMUStGEi7KHUVQidlMaCpVfeEJK74=
Received: by 10.204.6.66 with SMTP id 2mr1568301bky.138.1269422999396; Wed, 24 
	Mar 2010 02:29:59 -0700 (PDT)
In-Reply-To: <20100323232055.GV7038@pixar.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143078>

On Wed, Mar 24, 2010 at 00:20, Lars Damerow <lars@pixar.com> wrote:
> Just wondering if anyone has any further comments or suggestions for =
the
> GIT_ONE_FILESYSTEM patches I posted. See here for context:
>
> =C2=A0 =C2=A0http://thread.gmane.org/gmane.comp.version-control.git/1=
42436
>
> If it looks good I'd love to have it considered for inclusion.

Have considered making it an option to git wrapper as suggested
(-x/--one-filesystem)?
And while at it, how about making it a config option? (i.e. core.oneFil=
esystem?)
