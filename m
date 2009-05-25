From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [RFC PATCH] am: do not do any reset on --abort
Date: Mon, 25 May 2009 11:54:36 -0400
Message-ID: <32541b130905250854v981277oe093ee4990726a2a@mail.gmail.com>
References: <20090525104308.GA26775@coredump.intra.peff.net> 
	<alpine.DEB.1.00.0905251348050.4288@intel-tinevez-2-302> <20090525120019.GA1740@coredump.intra.peff.net> 
	<4A1A8C6C.5020009@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon May 25 17:56:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8cW2-0000te-MB
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 17:55:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752340AbZEYPy7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 May 2009 11:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752005AbZEYPy6
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 11:54:58 -0400
Received: from mail-gx0-f166.google.com ([209.85.217.166]:63365 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751828AbZEYPy5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2009 11:54:57 -0400
Received: by gxk10 with SMTP id 10so5690254gxk.13
        for <git@vger.kernel.org>; Mon, 25 May 2009 08:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=9sOfiwJeZJrcIB/FU4ZZhaEOSYsvo/+AeUDgZd+JxJI=;
        b=O7yqRX/1t1b2tg1mQ5ULM7yhOcl2abGIdTItIRzJZsA0/4YMnLkC7Aef8WmtjP6b/a
         hIj8ef8HOr33ruZYWpLKcYtPHHTCPc/oAev8BZeeAItQFzJp1VT9KdCLITN6OPxFhxzC
         HrqMS5EyuMyMn2jmjCmA184IGnDEDUHOqqoNk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ltLrCXndMZ2m/mvtlCxRF8V07ZuYW+ADOb0DmN4gNy5GNhzyZZ9Yt5rc95jMug/fLB
         xT4lV6/VSzaebVTh6Enx2LhsT7/VWKjacpQjfFEJwP18+gxGpWDSTdoUHVs62SvnPo1h
         dN2bOTKUdIQnNq0vWnJ+jsclkuqWMcmxj7oXY=
Received: by 10.151.137.6 with SMTP id p6mr14513143ybn.154.1243266896258; Mon, 
	25 May 2009 08:54:56 -0700 (PDT)
In-Reply-To: <4A1A8C6C.5020009@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119938>

On Mon, May 25, 2009 at 8:17 AM, Johannes Sixt <j.sixt@viscovery.net> w=
rote:
> =A0 $ git am --abort
> =A0 OUTCH! other-branch was reset!

If *that's* your problem, then presumably you could avoid it just by
checking whether the right branch corresponds to HEAD before doing a
reset.

Have fun,

Avery
