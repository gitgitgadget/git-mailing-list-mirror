From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH 09/21] Remove unneeded code from mktag.c
Date: Sat, 9 Jun 2007 23:39:00 +0200
Message-ID: <81b0412b0706091439q7be180celb939f694b80df159@mail.gmail.com>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
	 <7vzm3aig7j.fsf@assigned-by-dhcp.cox.net>
	 <200706090210.36270.johan@herland.net>
	 <200706090216.18823.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Johan Herland" <johan@herland.net>
X-From: git-owner@vger.kernel.org Sat Jun 09 23:39:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx8eJ-0000Vt-0a
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 23:39:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757865AbXFIVjF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 17:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756996AbXFIVjD
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 17:39:03 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:6425 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756794AbXFIVjB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 17:39:01 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1203318ugf
        for <git@vger.kernel.org>; Sat, 09 Jun 2007 14:39:00 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X1oEedYj/O/RmSe7PkGyzt/h+mgDUV1Vz1beopjp0kd0yKfLM56tAa1bds/maVuUin/x+cQsiKfjX8BciQ0IwkJnfDBlBwtWFUlxClABSMm5Xtg4d0sqeXsBOGet5C8jGNheW0uF9qlvuqI5/d2p9kVmCTZ8eI4TShuNtI943h8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KcN0Fzy3PjlFy18NH8EE8gwN5K5On5IZDbciLwm/ou+6kg4Ua2WkEL4oNivOfX4HnZxP4ndro75v7LUCCyhYrvJf57cx5uo6B6ieTtx/YMFC5XrpaClffq8zuvh9P/buIzTP/cbKxwSPlzPx1aUhKGkEENUQ2PwgdHpQv7HCMx8=
Received: by 10.78.170.6 with SMTP id s6mr1667043hue.1181425140412;
        Sat, 09 Jun 2007 14:39:00 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Sat, 9 Jun 2007 14:39:00 -0700 (PDT)
In-Reply-To: <200706090216.18823.johan@herland.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49624>

On 6/9/07, Johan Herland <johan@herland.net> wrote:
> Signed-off-by: Johan Herland <johan@herland.net>
> ---
>  mktag.c |   94 ---------------------------------------------------------------
>  1 files changed, 0 insertions(+), 94 deletions(-)

So, you do some useless changes just to remove the
function completely afterwards?
