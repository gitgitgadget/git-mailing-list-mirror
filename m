From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-latexdiff: new command in contrib, to use latexdiff and Git
Date: Fri, 17 Feb 2012 10:40:26 -0800 (PST)
Message-ID: <m34nups3q2.fsf@localhost.localdomain>
References: <1329320987-15203-1-git-send-email-Matthieu.Moy@imag.fr>
	<20120216003300.17228570@sirion> <vpq39abrxav.fsf@bauges.imag.fr>
	<7v8vk2zghl.fsf@alter.siamese.dyndns.org>
	<vpqty2px4l5.fsf@bauges.imag.fr>
	<7vmx8hvb69.fsf@alter.siamese.dyndns.org>
	<vpqobsx7d9s.fsf@bauges.imag.fr>
	<7vwr7ltlrj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Tim Haga <timhaga@ebene6.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 17 19:40:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RySjS-0002Gj-Q2
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 19:40:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752510Ab2BQSka (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Feb 2012 13:40:30 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:53335 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937Ab2BQSk3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2012 13:40:29 -0500
Received: by eaah12 with SMTP id h12so1428673eaa.19
        for <git@vger.kernel.org>; Fri, 17 Feb 2012 10:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=F3ysJdAPBk/uk0hnDdpTsBpZytBW1iMiYiUU1AXcmYM=;
        b=ZAc+6BKmUOv4Nc+3T9isBU/grBwt249gipqg9dGi0AQ+EHrApR/LM0Fq9LyxG3XQUS
         mLUJGvMTwx6PCqVGatBduAfckXDu18psAOfkZzKW1d7/ZnQrkbXvn8ngQDKL8OxFkzEB
         O1V1QBaoVpNffqdyc53gyNkWkJJkhv4OTC9gw=
Received: by 10.14.29.66 with SMTP id h42mr4180697eea.75.1329504028074;
        Fri, 17 Feb 2012 10:40:28 -0800 (PST)
Received: from localhost.localdomain (abwr227.neoplus.adsl.tpnet.pl. [83.8.241.227])
        by mx.google.com with ESMTPS id c16sm41399236eei.1.2012.02.17.10.40.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 17 Feb 2012 10:40:26 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q1HIede5029813;
	Fri, 17 Feb 2012 19:40:39 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q1HIecap029809;
	Fri, 17 Feb 2012 19:40:38 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vwr7ltlrj.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190968>

Junio C Hamano <gitster@pobox.com> writes:

> Aren't there LaTeX tools archives that would be a much better home for
> this tool?

There is CTAN: Comprehensive TeX Archive Network (http://ctan.org),
which hosts tools such like latexmk (cousin of the general make
utility), autolatex (generates Makefile), chktex, ite (interactive TeX
editor),... latexdiff itself is also there.

-- 
Jakub Narebski
