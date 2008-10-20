From: "Harvey Harrison" <harvey.harrison@gmail.com>
Subject: Re: [PATCH] fix for "index-pack: rationalize delta resolution code"
Date: Mon, 20 Oct 2008 11:37:39 -0700
Message-ID: <590657100810201137m477b834cr9c940851b1a599d8@mail.gmail.com>
References: <alpine.LFD.2.00.0810201357340.26244@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Jeff King" <peff@peff.net>
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Oct 21 00:28:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Krzf4-0008NT-E8
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 20:39:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754412AbYJTShl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 14:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754734AbYJTShl
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 14:37:41 -0400
Received: from wf-out-1314.google.com ([209.85.200.168]:7172 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565AbYJTShk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 14:37:40 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2110818wfd.4
        for <git@vger.kernel.org>; Mon, 20 Oct 2008 11:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=giMITnRdG5+bWRJWVbzLF2ZAbLTaRiaa+v/khPwzXoo=;
        b=Rr3rRsRbIG551e3yM0wjtfUa5GXydLO1ndMywWT211VsIPvyDpcnBlWkXti3WV7VOm
         M9wTBfEodb/rFXh2w9HxfVeg2u5u54lKzF5LXZanklR3UpVk+yyyJrjXtQCw9H/gtEJy
         +ueVcoWo8/lBrhz2eFz9h0zMFq6ap/9VXS6Xs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=XDRSaUBsj1OnvAT2BN1j2NNtZuuMO40hlDAoZ6VLIR3GZby0sl8ybuZkPEqAfGp60G
         gw2MMRHc1TZRFgMqNVmIQhuupS2BQluSUAw40dWn3IfnCjDHoia30W2oLnCGF7ei8vYp
         JLS4M7KT1z1Yynmt3Q1oYjsEXma5PQSey47FI=
Received: by 10.114.123.19 with SMTP id v19mr5657479wac.168.1224527859357;
        Mon, 20 Oct 2008 11:37:39 -0700 (PDT)
Received: by 10.115.55.11 with HTTP; Mon, 20 Oct 2008 11:37:39 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0810201357340.26244@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98727>

On Mon, Oct 20, 2008 at 11:12 AM, Nicolas Pitre <nico@cam.org> wrote:
> My bad.  A small detail went through the crack: the real_type of
> a delta object is the real_type of its base object.
>
> Without this, the created index will be wrong as the actual object SHA1
> won't match the object.
>
> Signed-off-by: Nicolas Pitre <nico@cam.org>

This fixes it for me, thanks for the quick fix.

Tested-by: Harvey Harrison <harvey.harrison@gmail.com>
