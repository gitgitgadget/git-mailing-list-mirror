From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Re: How to ignore changes on remote
Date: Tue, 23 Mar 2010 16:13:03 +0000
Message-ID: <26ae428a1003230913s447de452rfc7b8df753885365@mail.gmail.com>
References: <26ae428a1003230654m50c35caci4a02e2df321f289c@mail.gmail.com>
	 <1269353235.14299.0.camel@kheops>
	 <26ae428a1003230713y12f0c74dh3b22c0d97565159b@mail.gmail.com>
	 <1269354326.14299.7.camel@kheops>
	 <d411cc4a1003230905y12839743x400333a0aa2e7018@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: sylvain@abstraction.fr, git@vger.kernel.org
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 23 17:13:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nu6jB-00015X-Lf
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 17:13:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754204Ab0CWQNI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Mar 2010 12:13:08 -0400
Received: from gv-out-0910.google.com ([216.239.58.186]:18411 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754107Ab0CWQNG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Mar 2010 12:13:06 -0400
Received: by gv-out-0910.google.com with SMTP id l14so95152gvf.37
        for <git@vger.kernel.org>; Tue, 23 Mar 2010 09:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=BppxBoNsi/z68SnU31126YORRfuJ3GFS1onSBxaTkGQ=;
        b=E8pPjvnm9BGOVdfJfTiRA9lOjn79ySRRrBWSQXF/4f4uDx/2hUVG9Al9EcwpgHSOcU
         GwF7INpR4w1Liu2sncESs8wWO27U9idVPebQIFXjS32Z/YTHZ/NLPbe18GHhr3xnoQOt
         ivc4b69Pqo9fI8WUIswk0+QzZ+PDqrtg4MeYA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=B3GCOa4uoLcZbXK9eyiETDeJn9jlu8JKZjB4a8vEoURWftQ+NDQWpTAXkfc/HLwiXL
         UOzQJPKaY40MHLvgxZ0JqC1ujx8flMkRIw/lCw2i8WW2k6v/+qxDcqwd1Zc6CUGKqm9f
         7FTKmm2GfuX8NdP2d21KHt2x6j72qHyKIzkwk=
Received: by 10.103.7.31 with SMTP id k31mr11764475mui.132.1269360783233; Tue, 
	23 Mar 2010 09:13:03 -0700 (PDT)
In-Reply-To: <d411cc4a1003230905y12839743x400333a0aa2e7018@mail.gmail.com>
X-Google-Sender-Auth: f3516e60c4cb0aa6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143027>

On 23 March 2010 16:05, Scott Chacon <schacon@gmail.com> wrote:
> Why would we teach someone to do that instead of just recommending th=
e
> far less obscure 'git push -f'? =A0A leading '+' on the refspec is
> ridiculously confusing compared to "just tell it to force the push
> with -f". =A0Am I forgetting something?
>
> Also, Howard, what do you mean by "I forgot to merge"? =A0Do other
> people have push access to this branch? =A0You can't just tell people
> "use the local version" after you force a push. =A0If anyone has base=
d
> work off of that point, you're going to get into way more trouble
> forcing a non-ff push than if you just did a merge and then resolved
> all the conflicts as --ours.

I'm not really fussed. I hope not to make a habit of this. I'll
probably forget and ask again next time :)

It's not a repo that particularly matters - just a convenience thing
for some test scripts. If it had been on a proper production repo then
I would just have dealt with the conflicts.
