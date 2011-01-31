From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [1.8.0] 't/' is standard name for directory with tests
Date: Mon, 31 Jan 2011 13:59:35 -0800 (PST)
Message-ID: <m3d3ncag7r.fsf_-_@localhost.localdomain>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
	<7vwrll57ha.fsf@alter.siamese.dyndns.org>
	<alpine.LFD.2.00.1101311459000.8580@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Jan 31 22:59:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pk1mi-0001ib-Ev
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 22:59:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756566Ab1AaV7j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Jan 2011 16:59:39 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39983 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754260Ab1AaV7j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jan 2011 16:59:39 -0500
Received: by wyb28 with SMTP id 28so6007680wyb.19
        for <git@vger.kernel.org>; Mon, 31 Jan 2011 13:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=SlSZhpTxZAy3BEt1XTRzOww6eDqjZLLl6h8137P7dZg=;
        b=HmOuxqmQmuW4NVlL1c8endIMc+dJnYhYvQCSj8LfnyLS4Lat7sYDA9AH8TEIJmPVw9
         DZBqcrQLBSI1x6d8fT/sO40+1YowNb25swjjJ2YFhOLflzJzjbc9Sdw26cQnrYB7Zl1m
         FVeXrL/Y4Wv+ygn9MGoD2C2s5SALteIwBfUag=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=eb5YFGtWN2iK1neUYi/5OvIFskG71dkahFiTXxOKTzDBs2yCn911LIA50XoExovHzT
         0DG/8gTrIKzUZTh7OyMRESFtg4YLGW8K5QPp7FndmtwjHqkhhXQea0/ZSzEUni1SdiVU
         f3V2pagUiHjKpTgLMX8EjJ0T8C2o1/qR8HwIQ=
Received: by 10.216.208.230 with SMTP id q80mr10816944weo.103.1296511177743;
        Mon, 31 Jan 2011 13:59:37 -0800 (PST)
Received: from localhost.localdomain (abvg238.neoplus.adsl.tpnet.pl [83.8.204.238])
        by mx.google.com with ESMTPS id f52sm11047410wes.11.2011.01.31.13.59.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 31 Jan 2011 13:59:35 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p0VLwcA8006493;
	Mon, 31 Jan 2011 22:58:48 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p0VLw02D006488;
	Mon, 31 Jan 2011 22:58:00 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.LFD.2.00.1101311459000.8580@xanadu.home>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165761>

Nicolas Pitre <nico@fluxnic.net> writes:

> So I'd suggest doing the following:

> 5) Rename t/ to testsuite/ so this doesn't look like some garbage 
>    leftover.

Nope.  't/' is the standard name for directory with "normal" tests, at
least in Perl / CPAN land, where TAP comes from ('xt/' is for extra
tests)

-- 
Jakub Narebski
Poland
ShadeHawk on #git
