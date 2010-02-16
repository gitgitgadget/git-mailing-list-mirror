From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: git fetch origin hanging in 1.7.0
Date: Tue, 16 Feb 2010 15:32:43 +0800
Message-ID: <be6fef0d1002152332k2983d750l7b76496118dc3952@mail.gmail.com>
References: <7e3605161002151608t44bd320cgcd589796a9ec902b@mail.gmail.com>
	 <20100216063959.GC2169@coredump.intra.peff.net>
	 <20100216151821.994ace31.rctay89@gmail.com>
	 <20100216072456.GG2169@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Kevin Menard <nirvdrum@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 16 08:32:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhHvP-0005OV-Oq
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 08:32:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932661Ab0BPHcr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 02:32:47 -0500
Received: from mail-iw0-f185.google.com ([209.85.223.185]:51415 "EHLO
	mail-iw0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753805Ab0BPHcq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 02:32:46 -0500
Received: by iwn15 with SMTP id 15so5564830iwn.19
        for <git@vger.kernel.org>; Mon, 15 Feb 2010 23:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=7sre3rQ/VWMMEoOnAEIoY3ptkKJdf7oVdwOZNYNhex0=;
        b=H/n7CDme3giPe5h3vO6LCRhr/jEG35BmV+JLE2VCtcqpCeEZi8S4ltlVnQarOtT/0P
         ioHc7JJV2vTDXuWqBjaXA9oH6lPYda7SYB4z9AidFpCQv0O6Szhw7Lp+Z01iPuTgdLBm
         eLMauUpj4ZPPaG4DdZWFz+MeVKdd2wu76PgAU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=SvCEoi0MzaXAunuIxU3qq7cmhcDFB/u8LgwhJqdvV3G0elBTeuUdgo60/I2+pVQnNX
         lP+GuV3NDAn771bVHGrJ/YwxNdEH97+qty1o72K0X9DA/foc9xLkUj5KD90Kc6D7LfKv
         FUn55keOYPCvuEmasJA464WSlYSOl9HOMGZnA=
Received: by 10.231.149.6 with SMTP id r6mr4778737ibv.68.1266305563983; Mon, 
	15 Feb 2010 23:32:43 -0800 (PST)
In-Reply-To: <20100216072456.GG2169@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140082>

Hi,

On Tue, Feb 16, 2010 at 3:24 PM, Jeff King <peff@peff.net> wrote:
> OK, I figured it was something like that. In that case, your fix looks
> like the right thing to do (and it fixes my test case).
>
> Thanks.

No problem.

Kevin, I didn't add a Reported-by line, as I don't regard my patch as
actually fixing the issue at hand (hanging read) - it just side-steps
the issue. Hope you don't mind this.

-- 
Cheers,
Ray Chuan
