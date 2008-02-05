From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: man pages are littered with .ft C and others
Date: Tue, 5 Feb 2008 02:21:20 +0100
Message-ID: <200802050221.21647.jnareb@gmail.com>
References: <alpine.DEB.1.00.0802021055180.21831@an.sumeria> <20080204220120.GA23798@diku.dk> <200802050026.22262.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Adam Flott <adam@npjh.com>,
	git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Tue Feb 05 02:22:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMCVj-00020E-2J
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 02:22:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757501AbYBEBVd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 20:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757268AbYBEBVd
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 20:21:33 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:49578 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754726AbYBEBVc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 20:21:32 -0500
Received: by fg-out-1718.google.com with SMTP id e21so2087944fga.17
        for <git@vger.kernel.org>; Mon, 04 Feb 2008 17:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=XhPFEEyiADDQEI9r1vOMw+Juh1YjPlTcjTS8QQZiB7E=;
        b=thju2MjxMxpq6zw+aXg71MoQqUlQo6gP+ER1+Nazt78//bfAM/2JLoQB2e0sw0qoKo9JUjyHFnZUscEgiA2Dm18ksxvGXsj77+YS08PdJ51Mq5sBbFsGsr6j2fgJ2/sdCNaT/jQMJCCnkSlHsalxidxnI6yDIuEghQcdRaFHrAI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=XNGxLb1JrdhMwLlWtW/SXrwCm41lmfk26d6tCJ504dxWGOo7Z6r7t9yvgvbCQFEkjqAsdUjFgpc3iOOvvLIbjWr0R/uhXSZEypszsPNHykbf5Gh2Io2Hs+TD2fPJHImbQxoQxU01PedbtLAo1PRNcE0H9BHnTa7PJCwPIKCDtWg=
Received: by 10.82.175.17 with SMTP id x17mr1080273bue.12.1202174490576;
        Mon, 04 Feb 2008 17:21:30 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.221.201])
        by mx.google.com with ESMTPS id b33sm3114465ika.5.2008.02.04.17.21.27
        (version=SSLv3 cipher=OTHER);
        Mon, 04 Feb 2008 17:21:28 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200802050026.22262.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72607>

Jakub Narebski wrote:

> I have applied this patch, and it makes manpages worse, not better.
> I use DocBook XSL version 1.68.1

Sorry, I must have had run "make doc" without "make clean" first.
Of course patch doesn't change anything for pre 1.72, and marked
as such.

One again, I'm sory for the confusion.

The old .ft C... .ft error remains.
-- 
Jakub Narebski
Poland
