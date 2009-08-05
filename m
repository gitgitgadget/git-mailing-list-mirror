From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 3/3] transport: don't show push status if --quiet is given
Date: Wed, 5 Aug 2009 13:30:20 -0700
Message-ID: <fabb9a1e0908051330v24863b4fo6fc2021bafb2fdb8@mail.gmail.com>
References: <20090805201937.GB9004@coredump.intra.peff.net> 
	<20090805202326.GC23226@coredump.intra.peff.net> <fabb9a1e0908051327l74e06afdvf3b35b5abde2e140@mail.gmail.com> 
	<32541b130908051329w43882ca6ne0824b01da3948aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Albert Astals Cid <aacid@kde.org>,
	Junio C Hamano <gitster@pobox.com>,
	Pau Garcia i Quiles <pgquiles@elpauer.org>,
	git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 22:30:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYn8K-0005Cj-Ee
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 22:30:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752608AbZHEUal (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 16:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752499AbZHEUal
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 16:30:41 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:11717 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752489AbZHEUak (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 16:30:40 -0400
Received: by ey-out-2122.google.com with SMTP id 9so230676eyd.37
        for <git@vger.kernel.org>; Wed, 05 Aug 2009 13:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=qLz2XepPxWkaCodi3kheRbZLILHmL6NVoH8MHoAS05I=;
        b=xGX2qIx/21CQr19h4U3LwMaTxyQqLS7gBs/GCiBPBbAmFSUFmWWCmyqTb1pS/eRuS4
         2v6PhBx8UFw4jwQQV+37QFHMLG6xFmpZqyUxYfM+4Hy+gKflJXBkdPiwzVz7auJSuhCG
         nRtDTC7re83lOAKpBjB5h/XgJe7Ipv1GsnpY8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ZwzMGbpIOxxAj2iwfgHeJIb2AChcSGfzwdFwqcuzJMn2MLohoK642OwVhzRQE5S5K1
         oCv4x7gOC5l1n8dmMhF6ykS/wVC2UcbRWnuzgxKLU3cMVQpImx5oSAk28cRMgqlk95Go
         SUyeC/3df7s2+dJJCDQfBF4gOVBQvj6gH3s+s=
Received: by 10.216.88.71 with SMTP id z49mr1781wee.90.1249504240191; Wed, 05 
	Aug 2009 13:30:40 -0700 (PDT)
In-Reply-To: <32541b130908051329w43882ca6ne0824b01da3948aa@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124969>

Heya,

On Wed, Aug 5, 2009 at 13:29, Avery Pennarun<apenwarr@gmail.com> wrote:
>> Is my C getting sloppy or is this a non-looping loop? AFAICS it either
>> return 1's on the first run, or breaks?
>
> The "break" in this case breaks out of the switch, not the for.

Ouch, painfull, my C _IS_ getting sloppy :(.

-- 
Cheers,

Sverre Rabbelier
