From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Make words boundary for --color-words configurable
Date: Fri, 02 May 2008 17:18:31 -0700 (PDT)
Message-ID: <m34p9g6y09.fsf@localhost.localdomain>
References: <1209699564-2800-1-git-send-email-pkufranky@gmail.com>
	<alpine.DEB.1.00.0805020839200.2691@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ping Yin <pkufranky@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 03 02:19:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Js5TG-0005NI-5u
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 02:19:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765353AbYECASf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 20:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764968AbYECASf
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 20:18:35 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:32128 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760190AbYECASe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 20:18:34 -0400
Received: by ug-out-1314.google.com with SMTP id h3so178896ugf.16
        for <git@vger.kernel.org>; Fri, 02 May 2008 17:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=/He14PdTs3PEQVdEigLxwD2IO3DDkfKRIxo3MKf6m5w=;
        b=niVI+3hTvwt69Fn7TmgG+304hXP6Is9uBVx0X2hFAyHXhS85Z0E7UuTT3CEgIOPYgv4PiKrxfuZ+vSwCsBISIzRQtHbhCTidxjUYpFg7d+HhPA/R+/Mc60wkwgZy7AKB4xtdOG3jUBr3UYjdfTLLijqHG1sDl5QbNHT3MoNKWyQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=eUKOoYusth4HrXZSU7DN7z583+3YD87J3ofCGW5EV7f98LORODuLawYBzqaRTFRZGDxPJYRSNQ03dX8ljrBL37Y+hkvY/mup5EYwiWERpZAR8MpKJ7c4DSnWkxqsHyFgZCI8UgOR+p8rhqFnrdyaPfdtmPAq7S9h1Wr51BV13e4=
Received: by 10.67.15.8 with SMTP id s8mr660716ugi.42.1209773912869;
        Fri, 02 May 2008 17:18:32 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.251.103])
        by mx.google.com with ESMTPS id b30sm6067330ika.3.2008.05.02.17.18.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 02 May 2008 17:18:31 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m430IWln023006;
	Sat, 3 May 2008 02:18:32 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m430IU2F023003;
	Sat, 3 May 2008 02:18:30 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.DEB.1.00.0805020839200.2691@eeepc-johanness>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81052>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Oh, and maybe having "::default" and "::alnum" suffixes interpreted, so 
> that I can say "_::alnum" to have C identifiers interpreted as words?

I'd rather use POSIX classes like "[:alnum:]" for that

-- 
Jakub Narebski
Poland
ShadeHawk on #git
