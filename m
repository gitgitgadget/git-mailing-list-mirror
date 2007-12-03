From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Fix UTF Encoding issue
Date: Tue, 4 Dec 2007 00:37:35 +0100
Message-ID: <200712040037.37204.jnareb@gmail.com>
References: <4753D419.80503@clearchain.com> <200712040020.26773.ismail@pardus.org.tr> <20071203230432.GA1337@wolf.clearchain.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Ismail =?iso-8859-1?q?D=F6nmez?= <ismail@pardus.org.tr>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Junio C Hamano <gitster@pobox.com>,
	Alexandre Julliard <julliard@winehq.org>, git@vger.kernel.org
To: Benjamin Close <Benjamin.Close@clearchain.com>
X-From: git-owner@vger.kernel.org Tue Dec 04 00:38:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzKrP-0002UU-7e
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 00:37:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbXLCXhm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 18:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbXLCXhl
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 18:37:41 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:32517 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245AbXLCXhk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 18:37:40 -0500
Received: by nf-out-0910.google.com with SMTP id g13so2810866nfb
        for <git@vger.kernel.org>; Mon, 03 Dec 2007 15:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=NIv10UGMord2rL950tcNdIW4zlPHlvGH/hNtLUL1raU=;
        b=DK2pQNm/Uo/dOWiTKqF1SyJRG9HEekX147g1cNJ2UOFhg14fR78g2w2D7Pt+e7MF4j5CNwuInaIREepcb6fmlfZLEYR05qlrhBsUE1pkKbLMU8SM4UkSYO7oPkZMLtXK1j6hU9ojSM3Z6KujabQTlQvcRFJgt/avkRejCWL9C/k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=bhvVE2AXWmfPg81PY9WMyBbO4vNpFMC1/8PDc6ZdLtVyYpG6lWwbc/UvF2Qyz6m9PNQJwM/WK5WEa9vZL4j1F7vuKDYxKWiCgvQyH2PRDUO/AO3kMXSbGlxUHEWLQRu9pn9TamcXCY3n5hTPkFN1qgt8snYh1vFDAimzF/U7JvA=
Received: by 10.86.81.8 with SMTP id e8mr11129984fgb.1196725058913;
        Mon, 03 Dec 2007 15:37:38 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.233.204])
        by mx.google.com with ESMTPS id e11sm6581303fga.2007.12.03.15.37.36
        (version=SSLv3 cipher=OTHER);
        Mon, 03 Dec 2007 15:37:37 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20071203230432.GA1337@wolf.clearchain.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66979>

On Tue, 4 Dec 2007, Benjamin Close wrote:
> On Tue, Dec 04, 2007 at 12:20:26AM +0200, Ismail Donmez wrote:
> > 
> > Can you try the attached patch?
> 
> I confirm that the patch corrects the problem.
> 
> Without it I get the Cannot decode string error. With it gitweb
> displays correctly.

But the patch _avoids_ issue (des not convert owner to utf8), rather
than solving it, if I understand it correctly. What if gecos is in 
utf-8?

-- 
Jakub Narebski
Poland
