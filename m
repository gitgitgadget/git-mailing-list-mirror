From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC] Use cases for 'git statistics'
Date: Thu, 15 May 2008 14:21:43 +0200
Message-ID: <482C2AD7.3070808@op5.se>
References: <bd6139dc0805080851y2065bedfsf0f388cfd6d85929@mail.gmail.com> <200805131507.04912.jnareb@gmail.com> <bd6139dc0805130637saf704e1v2ab67c99da3078c3@mail.gmail.com> <200805142234.54600.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 15 14:22:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwcTl-0000Cj-EA
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 14:22:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753375AbYEOMVr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 08:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753313AbYEOMVr
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 08:21:47 -0400
Received: from mail.op5.se ([193.201.96.20]:33975 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753117AbYEOMVq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 08:21:46 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 7BA491B80087;
	Thu, 15 May 2008 14:18:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xULDvjPpdUGW; Thu, 15 May 2008 14:18:31 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.27])
	by mail.op5.se (Postfix) with ESMTP id 8D46F1B80084;
	Thu, 15 May 2008 14:18:31 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <200805142234.54600.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82202>

Jakub Narebski wrote:
> On Tue, 13 May 2008, Sverre Rabbelier wrote:
>> On Tue, May 13, 2008 at 3:07 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> 
> [on helping maintainer decide how closely patch should be examined]
> 
>>>  Weighting different statistics, bayesian hypotesis/filtering, expert
>>>  system, machine learning... I guess that would be quite a work to do
>>>  it well.  Probably would require to calculate and adjust scoring of code
>>>  (difficulity) and authors (skill), and matching them...
>>>
>>>  This is certainly in the "wishlist" scope.
>> Yeah, I think it would go in the 'c' of 'MoSCoW', but it could be very
>> useful when done right.
> 
> Errr... what do you mean by 'MoSCoW'?
> 

Must have
Should have
Could have
Won't have

It's a priority scheme used in agile development techniques, where
developers, customers and users work close together. The customer
decides "must have this, or we scrap this project", "should have this,
or users will be unhappy", "could have this, many would appreciate it"
and "won't have this, it's too expensive to develop" after the devs
have estimated the time required to develop the individual components.

Agile development is usually used to go under-feature instead of
over-budget. Since opensource projects are more driven by whatever
passing-by developers happen to find interesting (or annoying) at the
moment (nearly as predictable as Brownian motion), agile development
techniques are very rarely used successfully to develop oss in
anything but extremely tight communities.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
