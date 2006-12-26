From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: cgit vs. gitweb
Date: Tue, 26 Dec 2006 01:44:44 +0100
Message-ID: <8c5c35580612251644u26fde33aoe23d331c9192f8e7@mail.gmail.com>
References: <8c5c35580612250921o765e141cq27f81b06364d0a4@mail.gmail.com>
	 <empikd$s32$1@sea.gmane.org>
	 <8c5c35580612251604s5e211518yd958fdc2e73232ef@mail.gmail.com>
	 <200612260132.41062.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 26 01:44:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gz0R1-0007GI-1T
	for gcvg-git@gmane.org; Tue, 26 Dec 2006 01:44:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754617AbWLZAoq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Dec 2006 19:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754614AbWLZAoq
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Dec 2006 19:44:46 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:22609 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754617AbWLZAoq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Dec 2006 19:44:46 -0500
Received: by nf-out-0910.google.com with SMTP id o25so4635903nfa
        for <git@vger.kernel.org>; Mon, 25 Dec 2006 16:44:44 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tFK2yGNM7Suwuszph58z/NuJsuRsRWvzm8ETP6rECNACxc/nuo5c6tV1b7fNnXX+Irf6ytTCBsq/wmOe5bSt/kGnFBWLjTWuOPki8Po5uvL0ciKNCix95pjgbLH9woJS0eNNl64mTpTPDvygK+Bb/jEkMr1o7UtyiUzXivMGnJA=
Received: by 10.82.114.3 with SMTP id m3mr505152buc.1167093884620;
        Mon, 25 Dec 2006 16:44:44 -0800 (PST)
Received: by 10.82.171.10 with HTTP; Mon, 25 Dec 2006 16:44:44 -0800 (PST)
To: "Jakub Narebski" <jnareb@gmail.com>
In-Reply-To: <200612260132.41062.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35403>

On 12/26/06, Jakub Narebski <jnareb@gmail.com> wrote:
> By the way, which version of gitweb did you use (shortened sha1 of
> commit, or result of git-describe)?

Results from ab used gitweb/1.4.4.3.gd4ada (pulled tonight), but my
homemade scripts used c902c9a6 (from dec 21)

> I'm interested if it is before
> or after Robert Fitzsimons patches which replaced 101 forks in
> log-like views with 1 fork, which I think affects gitweb performance
> a lot.

ab is after the patches, my homemade scripts was before

> The page which is optimized is summary view, if you use projects_list
> and not projectroot directory...

I tested 'a=shortlog', since it seems to be functionally equivalent to
cgits log view.

-- 
larsh
