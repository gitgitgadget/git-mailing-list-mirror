From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH 0/2] Use %as and %cs as pretty format flags
Date: Thu, 28 Aug 2008 23:43:05 -0400
Message-ID: <32541b130808282043v5516e95ai49f928aeefb75fdd@mail.gmail.com>
References: <d77df1110808280409o9445f9fybcab2c8d1066a8d8@mail.gmail.com>
	 <20080828231547.GD29609@coredump.intra.peff.net>
	 <7viqtkd84s.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>,
	"Nathan Panike" <nathan.panike@gmail.com>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 05:44:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYuuG-0003M5-9q
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 05:44:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbYH2DnK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 23:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbYH2DnJ
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 23:43:09 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:56806 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214AbYH2DnG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 23:43:06 -0400
Received: by yx-out-2324.google.com with SMTP id 8so380581yxm.1
        for <git@vger.kernel.org>; Thu, 28 Aug 2008 20:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=2hgxk8Wwrv7D/FUZXshqrltXBg0sKs+F7/aQnQpSKoY=;
        b=HM+MXrB0k6DAi2sriBh0qzTy7gI7V1gxLaUdDNwyq6OF/sl/elEDHgxlPtqqEpKnzP
         WinTRHtPfZp8+Lq5xgRz+/Ktld7YAsrxx0JYmIfYVv0bV3EuA5tKN6sVlQm3EygTWwYI
         27U2GfhoXKiiLLe35Dll6j7k4EZUKNtnd9FRY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=vnpmqsnIq+QiHqF8A9VII9wGowl1LHv+JMG8PatmQWhn6j0aoGArnn3+AaRtha+KLG
         PsTr0sZqtY2MUmSGOxImcMpl0afGmCCPfwRzK7tJJ3GREC572vR8eACYndysGw8DBejA
         HhGdpzjMSgSZUezPPebP3PGjieiB9O1atgkhw=
Received: by 10.150.227.9 with SMTP id z9mr3404771ybg.36.1219981385539;
        Thu, 28 Aug 2008 20:43:05 -0700 (PDT)
Received: by 10.150.96.5 with HTTP; Thu, 28 Aug 2008 20:43:05 -0700 (PDT)
In-Reply-To: <7viqtkd84s.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94246>

On Thu, Aug 28, 2008 at 7:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I was actually thinking about rejecting this, asking for something that
> allows to express all the other %[ai][dDri] format can express, and
> perhaps more.  So I think "%ad(short)" is a good direction to go, except
> that 'd' is already taken.  Perhaps %a(date), %a(shortdate,local),...?

These format strings are getting increasingly complicated without
really gaining much in generality.  Why not
"%ad(strftime-compatible-format-string)" ?  You could differentiate
localtime vs. gmtime with %ad vs. %aD, or something like that.

Have fun,

Avery
