From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 24 Jun 2008 22:06:11 +0200
Message-ID: <200806242206.12291.jnareb@gmail.com>
References: <7vhccfiksy.fsf@gitster.siamese.dyndns.org> <m3wskek4wt.fsf@localhost.localdomain> <alpine.DEB.1.00.0806242033570.9925@racer>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Pieter de Bie <pdebie@ai.rug.nl>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 24 22:07:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBEnV-0006yj-U1
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 22:07:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755714AbYFXUG2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 16:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755573AbYFXUG1
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 16:06:27 -0400
Received: from ik-out-1112.google.com ([66.249.90.182]:56683 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755237AbYFXUG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 16:06:26 -0400
Received: by ik-out-1112.google.com with SMTP id c28so1584194ika.5
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 13:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=hYKQZNyOpSEBCf59ALVNiWdv37qfGIkGp++GyCOJulE=;
        b=IeRsfNdfX8hDcMecRI1ftiy4HiuQ+lEhMrgNIGLn87zoRlU27YgFhnB23h/WZ32/gl
         lM8g5QYDeYvFfxXg13CrRQFBgApET5kZ30wzGEAFYuMS3TkpzLLFlAhq5QxB5Ip2JDaV
         7qq84OimxdmNhpCU4htIgnB2lrQJnMwLdloUo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=o0CRA7YBQOWHhk5I8nxil3jBjA0EokeWyfkRmtBczRSnfVkU4FsTYaN35aVD09iRtl
         9eH7uIgDOTeiHw7S21RpqJDp0NHrYA4LFP1B+RYHZ+ueugfgMM1+7M9Ru1V5m+t44Ego
         Vh0YgGoc5fJbx66RlKksCeuz1QGxaKmGYOMRU=
Received: by 10.210.25.19 with SMTP id 19mr707417eby.141.1214337982034;
        Tue, 24 Jun 2008 13:06:22 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.223.44])
        by mx.google.com with ESMTPS id c22sm10869543ika.1.2008.06.24.13.06.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Jun 2008 13:06:20 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.DEB.1.00.0806242033570.9925@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86132>

Hello!

Johannes Schindelin wrote:
> On Tue, 24 Jun 2008, Jakub Narebski wrote:
> 
> > git-shell hackery won't solve problem, because not everybody is using 
> > git-shell.
> 
> The problem is not git-shell vs git potty.
> 
> The problem is that not everybody magically updates their clients to ask 
> for dash-less form.

What I meant here by "git-shell hackery" was for git-shell to
automagically redirect request for "git-receive-pack" to "git receive-pack"
(or "$GIT_EXEC_PATH/git-receive-pack").

But, as I said, it isn't complete solution.  Leaving git-*-pack in $PATH
for the time being (what I said) is.
-- 
Jakub Narebski
Poland
