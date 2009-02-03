From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 1/2] Introduce config variable "diff.primer"
Date: Tue, 03 Feb 2009 10:56:47 -0800 (PST)
Message-ID: <m3d4dzwdr3.fsf@localhost.localdomain>
References: <1233598855-1088-1-git-send-email-keith@cs.ucla.edu>
	<1233598855-1088-2-git-send-email-keith@cs.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Keith Cascio <keith@cs.ucla.edu>
X-From: git-owner@vger.kernel.org Tue Feb 03 19:58:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUQTn-0006Nb-5q
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 19:58:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752916AbZBCS4w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 13:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751525AbZBCS4v
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 13:56:51 -0500
Received: from ti-out-0910.google.com ([209.85.142.189]:32386 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbZBCS4u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 13:56:50 -0500
Received: by ti-out-0910.google.com with SMTP id b6so1114700tic.23
        for <git@vger.kernel.org>; Tue, 03 Feb 2009 10:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=qVDxMeRTz30pHZN9IZhyl6AvaRo0Y7tLyTid2jfdsPw=;
        b=iB0cTkhjXvIl1/8jh0yKtu4yg6y81LdOxXrNQHbmc+dedjCwyqLfJYIT9tqs1VXTjC
         C2dN1xS7nct1x9RLHkE8nSBFJ65T1JhPKlgkXxckeaiAd7rbhEMSO4t1IzKsLu0eMMts
         b/12+h7r9CtQkrhBgl2VWQC2v+f0gexCNOI60=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=YKcHd+KlER2iJr5xocYZC8xpHX+AAz89LoQrmCJPyKnUrXw2OF5pKtuOuijQ/FrOVI
         /B9QvMFQ198/DWUMP45qmkl/j2A8rz12vFktmp6PMvgYGht/ZsA01WJfaUP1jsVfYTey
         8Y33OyPMn1CReCVgmCOk6m+mBxSGRP4dWrWaA=
Received: by 10.110.43.16 with SMTP id q16mr8711503tiq.7.1233687408695;
        Tue, 03 Feb 2009 10:56:48 -0800 (PST)
Received: from localhost.localdomain (abvf78.neoplus.adsl.tpnet.pl [83.8.203.78])
        by mx.google.com with ESMTPS id 22sm540997tim.35.2009.02.03.10.56.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Feb 2009 10:56:47 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n13IubJT024612;
	Tue, 3 Feb 2009 19:56:37 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n13IuXvm024609;
	Tue, 3 Feb 2009 19:56:33 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1233598855-1088-2-git-send-email-keith@cs.ucla.edu>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108239>

Keith Cascio <keith@cs.ucla.edu> writes:

> Introduce config variable "diff.primer".

I still think that naming this configuration variable (or
configuration section in the reverse primer.diff) 'primer' is not a
good idea, because it is quite obscure and not well known word.  In
computer related context I have seen it only when talking about
introductory / novice / basic level documentation ('primer (textbook)'
meaning).  Git user, who might be not a native English speaker,
shouldn't have to look up in dictionary what it is about...

I think that 'defaults' or 'options' would be a much better name.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
