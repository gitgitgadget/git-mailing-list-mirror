From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Add testcase for 'git cvsexportcommit -w $cvsdir ...' with relative $GIT_DIR
Date: Wed, 13 Feb 2008 01:26:57 -0800 (PST)
Message-ID: <m3odalcill.fsf@localhost.localdomain>
References: <200802110228.05233.johan@herland.net>
	<200802120043.41610.johan@herland.net>
	<200802122141.35594.robin.rosenberg.lists@dewire.com>
	<200802130411.22093.johan@herland.net>
	<7vabm5s2xs.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 10:29:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPDvF-0000xY-Ca
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 10:28:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754999AbYBMJ1J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 04:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932416AbYBMJ1H
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 04:27:07 -0500
Received: from fk-out-0910.google.com ([209.85.128.187]:14483 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932620AbYBMJ1A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 04:27:00 -0500
Received: by fk-out-0910.google.com with SMTP id z23so5256522fkz.5
        for <git@vger.kernel.org>; Wed, 13 Feb 2008 01:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=X/zwdaTplNO0xIEbrlCG9ki+GCBoEmz0+w70/jKeVzI=;
        b=lYvsknn4IvCtHRVN3hekjL6Nj9YrKRZg/9rZDqN55Ebj7MLmIyamXIQAu+ILFcpg3de6PAstCVOKLOPHAqer48l8Uv1l+QtFjUtFeGyH7O7kdWHeP7KPF4+1RRz/YIL1wkAcu8ImOU2nut2u0iCBmw8qaqapSp50gcZCIeFK5as=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=JAe7YxWQcMa4mJAJvYL3ovESLwZBr7BpRg7kOZ5XXVZfhuSxjJAQIT1hGfG/bpFmtOzZSoGjr5QGo//BK9bYq4UfCanfEHx3Ir7/0sxpNkVxXTNtdVVUYNOLILn3440/YmEDcxygpw20/ZC71tPvhodCP3ZroNA0+nIXFhPMBdY=
Received: by 10.82.187.2 with SMTP id k2mr4466465buf.19.1202894818372;
        Wed, 13 Feb 2008 01:26:58 -0800 (PST)
Received: from localhost.localdomain ( [83.8.208.20])
        by mx.google.com with ESMTPS id q9sm1406758gve.10.2008.02.13.01.26.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Feb 2008 01:26:57 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m1D9QpId002773;
	Wed, 13 Feb 2008 10:26:51 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m1D9Qk9T002769;
	Wed, 13 Feb 2008 10:26:46 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vabm5s2xs.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73762>

Junio C Hamano <gitster@pobox.com> writes:

> Except that I'll reorder the patches so that
> 
>  (1) this test comes first, but with test_expect_failure instead;
> 
>  (2) then your earlier fix patch, but with a change that changes
>      the test_expect_failure to test_expect_success.
> 
> Thanks.
> 
> Perhaps it would be a good idea to require fix-up patches to
> always come with a test case to prevent future regression.

Perhaps we should add this hint to SubmittingPatches, on top
of your additions? And to t/README?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
