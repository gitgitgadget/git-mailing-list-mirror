From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git Survey 2011; now let's not forget the index/cache/stage
Date: Wed, 22 Sep 2010 09:38:31 -0700 (PDT)
Message-ID: <m3tylhhgyz.fsf@localhost.localdomain>
References: <201009201538.41287.jnareb@gmail.com>
	<20100921111344.647453d8@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Yann Dirson <dirson@bertin.fr>
X-From: git-owner@vger.kernel.org Wed Sep 22 18:38:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OySLB-00037G-LQ
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 18:38:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752550Ab0IVQig (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Sep 2010 12:38:36 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33271 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751931Ab0IVQif (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Sep 2010 12:38:35 -0400
Received: by fxm12 with SMTP id 12so140465fxm.19
        for <git@vger.kernel.org>; Wed, 22 Sep 2010 09:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=gs8+h+E9PiMmK8B3PupVyg1pcolCOp5TBKEPeX3oiNc=;
        b=kpUhj7eVLwroWjFW4mC+u+3nRv9rbYe4IztXmQj5B0S1vsGuQWimJe8+wAtXJjhN3O
         lm2Lv/DXr3jiRloDdorJgHvYd8t9cTimRlkOXBKKcJTyFfwEkXR8jTmqjgdzNVYBSYpk
         e49FjFC22c9dOf1yk/0sAj3xwXVL7Y5FWDzXA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=TNxUPmWj0Pg6fDBt14iHhUPAsJDgdHlzo9fhmQZmeyWT3RTSkLydgbMe8miUOW5JEY
         Rl0OPX/m7c6wJnuaFCL2zZP7j36qDkSV7Urcfyu7AepVMgLUrufFalOyNjda3vfFzSKY
         g6wXAoKGgKpIonoh5VGAdqQN6IWKXJEmyeniY=
Received: by 10.223.123.145 with SMTP id p17mr541059far.90.1285173513922;
        Wed, 22 Sep 2010 09:38:33 -0700 (PDT)
Received: from localhost.localdomain (abva250.neoplus.adsl.tpnet.pl [83.8.198.250])
        by mx.google.com with ESMTPS id e17sm4338521faa.39.2010.09.22.09.38.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Sep 2010 09:38:31 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o8MGbw0G031492;
	Wed, 22 Sep 2010 18:38:09 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o8MGbeQN031482;
	Wed, 22 Sep 2010 18:37:40 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20100921111344.647453d8@chalon.bertin.fr>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156808>

Yann Dirson <dirson@bertin.fr> writes:

> > > You agreed it would be there, and it's not, so I wonder what's the
> > > point of asking for feedback if it's going to be forgotten. Next time
> > > I think you should send the final version for review before
> > > publishing.
> >
> > There were two issues conflated that contributed to this error
> > of mine.
> >
> > First, I have re-checked *direct email* responses to request for 
> > feedback on Git User's Survey 2010 questions proposal, but I have 
> > forgot to re-check responses which were send only to git mailing list 
> > without Cc (i.e. in my case *newsgroup* responses).  I am very sorry 
> > for that.
> 
> Well, all that seems to call for a git-backed survey engine, so that
> suggestions could be straightforward patches !

While it could be quite straighforward to design survey engine which
uses git as backend for storing survey schema (the structure of
survey, including questions and choices), I don't think that git as
backend would work for storing answers, if it were to be possible to
(re)edit own answers.

And of course there is problem with *hosting* a survey app...
-- 
Jakub Narebski
Poland
ShadeHawk on #git
