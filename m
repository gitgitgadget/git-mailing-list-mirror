From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] whitespace: fix initial-indent checking
Date: Sun, 16 Dec 2007 21:31:03 +0100
Message-ID: <200712162131.04280.jnareb@gmail.com>
References: <7vodd4fb2f.fsf@gitster.siamese.dyndns.org> <200712161916.44715.jnareb@gmail.com> <20071216195956.GA14676@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio Hamano <junkio@cox.net>
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Sun Dec 16 21:31:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J409A-0004x8-Hf
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 21:31:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754768AbXLPUbN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Dec 2007 15:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753090AbXLPUbN
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 15:31:13 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:14671 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753275AbXLPUbM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 15:31:12 -0500
Received: by fg-out-1718.google.com with SMTP id e21so207084fga.17
        for <git@vger.kernel.org>; Sun, 16 Dec 2007 12:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=aROwRvkaBrMnJR7EIpYZWvM5zpDCYP2pmeSFZe8sljo=;
        b=w/Z6iIPcLQdPeOmqdSWXPPKwYeVElxg64uYA2XLZPT8nWZeSXMbQV8nYCwFQDi4Qs+Zb2dRfj7bMDduEP3loOdRsmk7Ln68w82H8tEFKqP95SKQKlhRf3fP19BFgUmm3RiBLKDhxgLC5FQGRZqdxJlLYohl5E2mwmAQyAYKekSk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=e9pxcr6KY3Gde2wtkLdRpcKfpnAn7HzVx//BPyqbrsKu1ZT+Mmk1uhbqtlsPxvCoptvVWomzzRxj+p1cdx80yVUuHgPrr3kigkjma1iVdc0JwREhAj0sPg0hHEPxqidhUtPNAm3nDAoualXmGecruz1rgcvhx/R51D15YfPXFCg=
Received: by 10.86.70.8 with SMTP id s8mr5636178fga.29.1197837071202;
        Sun, 16 Dec 2007 12:31:11 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.189.199])
        by mx.google.com with ESMTPS id 12sm4512033fgg.2007.12.16.12.31.08
        (version=SSLv3 cipher=OTHER);
        Sun, 16 Dec 2007 12:31:09 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20071216195956.GA14676@fieldses.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68485>

On Sun, 16 Dec 2007, J. Bruce Fields wrote:

> If we've got to define a fourth whitespace policy for this, well, OK,
> I'll live--tell me what I need to do. =A0I haven't seen a convincing
> argument for that yet, though.

Perhaps the new version of policy should be called indent-with-non-tab,
and we keep old version under name indent-with-spaces, hmmm...?

By the way, what about check for diff3/rcsmerge conflict markers?
This is not "whitespace" error per se, but...
--=20
Jakub Narebski
Poland
