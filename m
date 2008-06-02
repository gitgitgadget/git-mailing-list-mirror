From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 02 Jun 2008 01:10:22 -0700 (PDT)
Message-ID: <m3hccc1cm0.fsf@localhost.localdomain>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
	<7vwso85qkf.fsf@gitster.siamese.dyndns.org>
	<7vwso5r87q.fsf@gitster.siamese.dyndns.org>
	<7v8x0992hy.fsf@gitster.siamese.dyndns.org>
	<7vd4pf7h9y.fsf@gitster.siamese.dyndns.org>
	<7vwsnjl21c.fsf@gitster.siamese.dyndns.org>
	<7vhcehzdeg.fsf@gitster.siamese.dyndns.org>
	<7vbq4j748l.fsf@gitster.siamese.dyndns.org>
	<7vr6d8apjx.fsf@gitster.siamese.dyndns.org>
	<7vhcdyfe9u.fsf@gitster.siamese.dyndns.org>
	<7vabjm1a0q.fsf@gitster.siamese.dyndns.org>
	<7vr6crj0jk.fsf@gitster.siamese.dyndns.org>
	<7vmyn4hr8f.fsf@gitster.siamese.dyndns.org>
	<7vmymsjz6x.fsf@gitster.siamese.dyndns.org>
	<7vabijxhk4.fsf@gitster.siamese.dyndns.org>
	<7vwslhg8qe.fsf@gitster.siamese.dyndns.org>
	<7vhccfiksy.fsf@gitster.siamese.dyndns.org>
	<7vod6k6zg4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 02 10:11:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K358V-0007Z9-QU
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 10:11:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752807AbYFBIKa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 04:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752048AbYFBIK3
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 04:10:29 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:59911 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751786AbYFBIK2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 04:10:28 -0400
Received: by nf-out-0910.google.com with SMTP id d3so382621nfc.21
        for <git@vger.kernel.org>; Mon, 02 Jun 2008 01:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=oXNxFRYkoIYk7yKKYRwEe/powliYBiqTdBV3+PGEsj8=;
        b=DNZmM9RTFIQEVfCcT399i2DN4KPZUWGIi61chITnqVhNo0QPcQrPsY1kJRiSPZrHomEkqNJ5xeQ77J+flsen1vOV5uY83/OTTcAyqVq/7hIKt6cNoLXDLVrUMvQk9Q8hMAtcUbmHX8Lc2iZTeGd/s+k874h58I6SDkldVUE9KTM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=Gc9x05232BAuCM91DM+rdXpQgtryzBy79j9TDF+LKVSkySuPXHYvCIDJEZ/Tw6DP4Q+KrrZoSeXUghvt7vLnIQfXipfrb7wwa7D3itHIU+8FWvHqBc9oyAN37yDFfvCPEqK6Ru8q7O8EUOpcg3QeR25V1MBkerkelbMNE7II2fk=
Received: by 10.210.19.11 with SMTP id 11mr3428438ebs.111.1212394224463;
        Mon, 02 Jun 2008 01:10:24 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.195.117])
        by mx.google.com with ESMTPS id j8sm5508888gvb.1.2008.06.02.01.10.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Jun 2008 01:10:22 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m528AITZ015186;
	Mon, 2 Jun 2008 10:10:18 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m528AG74015183;
	Mon, 2 Jun 2008 10:10:16 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vod6k6zg4.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83501>

Junio C Hamano <gitster@pobox.com> writes:

> I've looked at the Git.pm testsuite that uses Test::More briefly but
> hadn't really reviewed it.  Is Test::More commonly used, considered solid
> and widely available?

It is part of perl-5.8.6-24 RPM package in Fedora Core 4.
It is mentioned in http://www.perlfoundation.org/perl5/index.cgi?testing
 
> ----------------------------------------------------------------
> [Graduated to "master"]
> 
> * lr/init-bare (Wed May 28 19:53:57 2008 +0100) 1 commit
>  + git-init: accept --bare option
> 
> This makes both "git --bare init" and "git init --bare" work, which would
> reduce confusion.

Nice.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
