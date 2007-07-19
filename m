From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH (REVISED)] Add core.editor configuration variable
Date: Thu, 19 Jul 2007 15:23:40 +0100
Message-ID: <200707191523.42086.andyparkins@gmail.com>
References: <11848281302504-git-send-email-aroben@apple.com> <200707191148.46228.andyparkins@gmail.com> <Pine.LNX.4.64.0707191213300.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Adam Roben <aroben@apple.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 19 16:23:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBWv3-0007k4-QP
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 16:23:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756807AbXGSOXt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 10:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755886AbXGSOXt
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 10:23:49 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:64119 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753913AbXGSOXr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 10:23:47 -0400
Received: by ug-out-1314.google.com with SMTP id j3so417228ugf
        for <git@vger.kernel.org>; Thu, 19 Jul 2007 07:23:46 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=R6AJJly44BERjJa6vXd4a372P+DtRjGvcgsaj85+rA7OY6a8Av8wsgVDmM9f3a77ojx11jAn7ZdCxJWVMHCWbBys72sLcZlyPazPD9QpoPLAr0xBvHN5PmtkwzzTVVPxMqAlE+Ti1IExJB9tSVhfT5VGXgnh/u96tV02qettSsc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Wq6pYLvLiySIDeZpm/F2yVCe/gWivWGk0bsefGSZJdXwxlG5H2R+AxnR1ZXnv4SEL7AJZUg+g21CzM4uf3+LbCeJkkPl9EvZlPqwGgxami4RfQCa/6W3dI8Ui6ZKq4iPmTlsK9pIJPS2uaUwcPbwZ1qwsFT+kbgxDw6bKr9UsDU=
Received: by 10.67.15.15 with SMTP id s15mr1213584ugi.1184855026245;
        Thu, 19 Jul 2007 07:23:46 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTPS id z33sm3756537ikz.2007.07.19.07.23.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 19 Jul 2007 07:23:45 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <Pine.LNX.4.64.0707191213300.14781@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52991>

On Thursday 2007 July 19, Johannes Schindelin wrote:
> Hi,
>
> On Thu, 19 Jul 2007, Andy Parkins wrote:
> > On Thursday 2007 July 19, Johannes Schindelin wrote:
> > > On Thu, 19 Jul 2007, Andy Parkins wrote:
> > > > Would porcelain.editor be a better name for this variable?
> > >
> > > From my point of view you can put into "myWonderfulGit.editor".  It
> > > does not matter.
> >
> > By that argument, why do we bother with subsections at all.  In fact why
> > not call the variable "xhxhxjjjll.yqlaoospsp"?
>
> No.  I said, and I quote here, "From my point of view".

That doesn't change my point - these things are named to give meaning, they 
aren't just arbitrary strings of characters.

> And how would having "core.pager" but "porcelain.editor" be easier to
> remember?  Nah, not really.

If there is no difference, then do you object so strongly?

Besides, memory isn't just about having words, it's about meaning too.  
Categorisation and hierarchy are important.  If I'm searching my brain for a 
function that does something to strings then the fact that it starts 
with "str" gets me a long way there.  The fact that they _all_ start 
with "str" is what's important.

I don't care _that_ strongly; just like you it won't make any difference to me 
personally as I'll cope either way.  I'm trying to think like a noob, and it 
seems that coherency is broken when we make distinctions between porcelain 
and plumbing and then don't stick to them in the config file.

Perhaps I am wrong in my assumption: I have always thought of core.* options 
being those options which apply to plumbing - i.e. if I were a git-guru and 
did everything with plumbing I would still need those options.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
