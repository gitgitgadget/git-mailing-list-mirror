From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH 0/2] Allow detached forms (--option arg) for git log options.
Date: Tue, 27 Jul 2010 08:10:35 -0700 (PDT)
Message-ID: <m37hkhklll.fsf@localhost.localdomain>
References: <1280168078-31147-1-git-send-email-Matthieu.Moy@imag.fr>
	<20100726193109.GA1043@burratino> <20100727144639.GU2504@madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Jul 27 17:10:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Odlno-0007HV-Gu
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 17:10:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756357Ab0G0PKi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 11:10:38 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:65121 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754672Ab0G0PKh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 11:10:37 -0400
Received: by fxm14 with SMTP id 14so680324fxm.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 08:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=c5yM+tD8+TvEWMHc+o+er8I4oUFYBLucJsXxyb7ce7s=;
        b=UGBqx02w7qS0RTq7QpfEHrS6v83uUw2vFEyyoAqEqSycfD+hg0U0OTsyt/tn3EAuZz
         iNRUvsk1RFBuWrcv2F/FSS1ke8rCVUP3LVE4s9pe+yBu34OI9oiAxeECPwZAIJQUqimf
         tydAgAAVHzYf65NI49rzUq/vLcjDJjDOEOE6k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=GXG5rP8ehcjut/e81tmuyHVp5jpJvnW7ODOW8aW4R0KzRBpvhAtrwqHj11frwajFl7
         Ea2kAvJlpZRVYEbcnli02yUWtyd4G3LLpxgNRWIyJr61+kflp65Dxc+HDyNsVmb7B8mG
         uh5Vu49ULSNqfys1NNLda/td2TM4axUyIxpV8=
Received: by 10.223.114.9 with SMTP id c9mr1259466faq.59.1280243436358;
        Tue, 27 Jul 2010 08:10:36 -0700 (PDT)
Received: from localhost.localdomain (abvi50.neoplus.adsl.tpnet.pl [83.8.206.50])
        by mx.google.com with ESMTPS id q17sm1963457faa.21.2010.07.27.08.10.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Jul 2010 08:10:35 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o6RF9tio031161;
	Tue, 27 Jul 2010 17:09:56 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o6RF9RVt031153;
	Tue, 27 Jul 2010 17:09:27 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20100727144639.GU2504@madism.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151947>

Pierre Habouzit <madcoder@debian.org> writes:

> On Mon, Jul 26, 2010 at 02:31:09PM -0500, Jonathan Nieder wrote:
> > Hi Matthieu,
> > 
> > Matthieu Moy wrote:
> > 
> > >                    is there any reason why "git log" hasn't been
> > > migrated to parse-option? Or is it only that nobody did it yet?
> > 
> > Please go ahead. :)
> 
> I started it in the past, but never went around to actually do it.
> 
> I started to get rid of most of the bitfields to use explicit or-ed
> fields, but stopped at that, I don't even remember if those patches got
> merged or not.

Why did you feel this change was needed / necessary?  Was it
limitation of parseopt?  Or perhaps it was for portability reasons?
Or was it just the matter of code elegance?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
