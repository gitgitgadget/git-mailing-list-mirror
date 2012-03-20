From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Please discuss: what "git push" should do when you do not say what to push?
Date: Tue, 20 Mar 2012 05:04:22 -0700 (PDT)
Message-ID: <m3y5qv32d9.fsf@localhost.localdomain>
References: <7v7gyjersg.fsf@alter.siamese.dyndns.org>
	<4F67EB1F.30205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Antony Male <antony.male@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 20 13:04:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9xnh-00031b-KH
	for gcvg-git-2@plane.gmane.org; Tue, 20 Mar 2012 13:04:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757608Ab2CTMEY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Mar 2012 08:04:24 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:64271 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752702Ab2CTMEX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2012 08:04:23 -0400
Received: by wibhq7 with SMTP id hq7so5117396wib.1
        for <git@vger.kernel.org>; Tue, 20 Mar 2012 05:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=iYFkmu46S5IfszStNnvTz2BarvfELFaUn1mRmZoMz/s=;
        b=ZRXwYp5ADmrgoBogOwIZLMVy1Jxokep6waQBF7+Mvzovdt5bls70I6E6S9lCM9Jbgy
         3z1NSrjwC4q5TmVB3TmMbxA/OX9L254zHdwi7Gx3n+rDprUoDl2i14pCZK/L+SVDtYvK
         sTSUheClH+RDeF0HW0/L6jFpNn00YPyiam+cgJVCAq4W3x3Rn2CBIRcw7S7ftY7N0gn+
         TjUGcTpQ61Tx/nY9h66h5PWbkezFhiK264huKwxlQRNo0bwHKqReTfSY5s1Jc2ISXS7m
         tQAtdCCADOfzkYLnJQknhGR4ZZZFzZN6en7Ojx9rqe2EqVIR/2j7AvY5gHGDiPoizxA+
         /+HA==
Received: by 10.180.24.7 with SMTP id q7mr28327521wif.11.1332245062417;
        Tue, 20 Mar 2012 05:04:22 -0700 (PDT)
Received: from localhost.localdomain (abvw11.neoplus.adsl.tpnet.pl. [83.8.220.11])
        by mx.google.com with ESMTPS id fz9sm33558144wib.3.2012.03.20.05.04.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 20 Mar 2012 05:04:22 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q2KC4JHH019392;
	Tue, 20 Mar 2012 13:04:19 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q2KC4I1q019389;
	Tue, 20 Mar 2012 13:04:18 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4F67EB1F.30205@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193498>

Antony Male <antony.male@gmail.com> writes:

> This is my 2 cents from helping out on #git.  I don't consider
> workflows at all, only how to minimise confusion for new users when
> they're trying to understand how git works.
> 
> We occasionally get users who are having trouble understanding why the
> argument-less form of 'git pull' is failing, due to lack of tracking
> configuration.  We explain that the tracking config is git's way of
> "connecting" local and remote branches, and how to use 'git push -u'
> and 'git branch --set-upstream' appropriately.
> 
> This is all well and good -- they've discovered that local and remote
> branches are separate, that they aren't "magically" joined, that
> there's a bit of configuration data which "connects" the two, and how
> to manipulate it.
> 
> Users then assume that argument-less form of 'git push' uses the same
> mechanism.  To then discover that it (by default) uses a different way
> of "connecting" local and remote branches is often confusing [1].
[...]

The "matching" behavior is intende for non-symmetrical situation of a
workflow where each user has its own separate public publishing
repository, but can pull from many repositories from other developers
(but never from one's own).

The situation is assymetrical (even more that "pull" and "push" for
single upstream repository, in a shared central repository case), so
configuration is assymetrical.

-- 
Jakub Narebski
