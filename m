From: "Carlos Rica" <jasampler@gmail.com>
Subject: Re: People unaware of the importance of "git gc"?
Date: Thu, 6 Sep 2007 02:27:05 +0200
Message-ID: <1b46aba20709051727od0644d7t16eaa348af86952a@mail.gmail.com>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
	 <87odgh0zn6.fsf@hades.wkstn.nix> <46DEF1FA.4050500@midwinter.com>
	 <877in50y7p.fsf@hades.wkstn.nix>
	 <alpine.LFD.0.9999.0709051438460.21186@xanadu.home>
	 <7vr6lcj2zi.fsf@gitster.siamese.dyndns.org>
	 <alpine.LFD.0.9999.0709051634190.21186@xanadu.home>
	 <7v1wdciy3w.fsf@gitster.siamese.dyndns.org>
	 <alpine.LFD.0.9999.0709051858060.21186@xanadu.home>
	 <7v3axshe6q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Nicolas Pitre" <nico@cam.org>, Nix <nix@esperi.org.uk>,
	"Steven Grimm" <koreth@midwinter.com>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 02:27:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT5DJ-0000ID-W6
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 02:27:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755686AbXIFA1M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 20:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755231AbXIFA1L
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 20:27:11 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:8946 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754339AbXIFA1J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 20:27:09 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2767547wah
        for <git@vger.kernel.org>; Wed, 05 Sep 2007 17:27:08 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lrXY4hW8twvnpjplKeJlppb6N/m8d6+kTQ6CcBbyzBxVeiXRlABu+j6WNrAWoo62cpTHidC2Y6DkP1dKvWeHStRE3PwLTiUgAtmLNr9ggoncneSFcHnBeoOAe1Ra6UsMhuInzODxjZOlM5rtXiFnOnd+uWl+uMNOcZJ3KkCOLcY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CcqcjofZUXxHNO85fPqLGFcDwMrdAxyp0G7I4Q/e7FYPQWfyYZ9hWlLIglLRnFWUYmrPh/9g7XMV4Fi5zSlJ7ZYCZ5QX0WED+NbFvbpJfW2ZDcQeLWF3Ypqfcc6r//xwOjXjWLveP2jYNC9wzNOddFz8VS73Z5lJjax25cPinyM=
Received: by 10.115.109.1 with SMTP id l1mr1719199wam.1189038425549;
        Wed, 05 Sep 2007 17:27:05 -0700 (PDT)
Received: by 10.114.57.10 with HTTP; Wed, 5 Sep 2007 17:27:05 -0700 (PDT)
In-Reply-To: <7v3axshe6q.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57781>

2007/9/6, Junio C Hamano <gitster@pobox.com>:
> Nicolas Pitre <nico@cam.org> writes:
> > The more I think of it, the less I like automatic repack.  There is
> > always a bad case for it somewhere.
>
> I tend to agree, but at the same time, I think the long term
> goal should be not to have bad cases.

The best solution is make "git gc" unnecessary.
At the long term, and without loss of efficiency.
