From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] pre-commit hook should ignore carriage returns at EOL
Date: Tue, 24 Jun 2008 16:34:35 -0700 (PDT)
Message-ID: <m3k5gejtkp.fsf@localhost.localdomain>
References: <53A5AFCF-94C7-465E-A181-1DA69F251F5B@gmail.com>
	<alpine.LFD.1.10.0806241418360.32759@sys-0.hiltweb.site>
	<39C2861E-F800-40AE-8C15-4FC3BB51EF16@gmail.com>
	<7v3an2bh3b.fsf@gitster.siamese.dyndns.org>
	<930163B6-4A7E-49C7-B9D5-F7B37699C2A9@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Christian Holtje <docwhat@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 01:35:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBI2w-0002gh-Il
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 01:35:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693AbYFXXej (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 19:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752091AbYFXXej
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 19:34:39 -0400
Received: from ik-out-1112.google.com ([66.249.90.176]:40298 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660AbYFXXei (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 19:34:38 -0400
Received: by ik-out-1112.google.com with SMTP id c28so1611281ika.5
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 16:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=jkm0vdJYUp2HYyj7/5RVtoDgDubHOjvybC02rHzZpZw=;
        b=ODyXip2t+NgOeLK+HWIKd0wt8RDw+A6bR3TkFF6yJJJeiECR31S910yHpTRV6PYu4L
         vUEpIgeDdHeqr7N13r3/R2AhHGpMXTwHBszhNoMh7PtL9A4U3o0ihhUOOwAbtFE54E9P
         7lCWrILoU1ZUAaF71wDU4GBP76qonj/eATZDg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=xQBN85jXJO59nPy9it2ULmSshapOoQnJUtCYy1WTBB04N6Dcu35Z2g4atoZKwd5314
         uKEAYg9zmKui6/Dy4GYu3GtQLW48oPB6qId95f+dhduV/SwKYDGPwu+N9PSZtqovLqqf
         R8wB/cE8DtLutSBgPr3RrPSekRuYh3HvCmqf0=
Received: by 10.210.46.14 with SMTP id t14mr1072748ebt.124.1214350477031;
        Tue, 24 Jun 2008 16:34:37 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.223.44])
        by mx.google.com with ESMTPS id z34sm11025133ikz.9.2008.06.24.16.34.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Jun 2008 16:34:35 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5ONYXlC012019;
	Wed, 25 Jun 2008 01:34:33 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5ONYUY8012016;
	Wed, 25 Jun 2008 01:34:31 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <930163B6-4A7E-49C7-B9D5-F7B37699C2A9@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86183>

Christian Holtje <docwhat@gmail.com> writes:

> Based on the information about core.whitespace doesn't git do this
> already?  Maybe we should just delete the pre-commit hook or make it
> empty with a note saying what you can do with it?

pre-commit hook also detects unresolved merge conflicts, which
core.whitespace doesn't (and probably shouldn't).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
