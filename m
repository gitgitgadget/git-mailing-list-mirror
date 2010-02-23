From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH] Allow '+', '-' and '.' in remote helper names
Date: Tue, 23 Feb 2010 14:32:10 +0100
Message-ID: <40aa078e1002230532n6e692fd0p8fa5d599c21a1873@mail.gmail.com>
References: <1266928428-19075-1-git-send-email-ilari.liusvaara@elisanet.fi>
	 <alpine.DEB.1.00.1002231402350.3980@intel-tinevez-2-302>
	 <4B83D5CC.9030206@viscovery.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Feb 23 14:32:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Njus7-0003En-W8
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 14:32:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752164Ab0BWNcN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 08:32:13 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:52197 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751893Ab0BWNcM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 08:32:12 -0500
Received: by wya21 with SMTP id 21so607458wya.19
        for <git@vger.kernel.org>; Tue, 23 Feb 2010 05:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=2cYo3BaTaDmX2/xavqKDX98xXKsrFBK9+fV9aBAozYU=;
        b=BstVe4qKtgSEkCvqCTnR+jTdWkGbm6MLCCz+QGp4RD48abR5WY5xaV3qoI/RLs40gP
         lgulvyDCGoTxeLol5E5ItkwGyob9mY2eY7jy4PqqlhKAAzBrT1qNjhqhl/AkUaAEVGUE
         gl5yOg04T6qiGQy/QIC3Cs8QWQcNxpgOFX/CY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=mRDj3/NQE9UrZYgggk+9rBOF+7gufN3aa8uibcZDp2ZBIN6+yrIOw5arYos6Uk0LNc
         BS+/jXeFNgr63WSzqznA1sxBQ/lAdl+NBAnWikpMCBganAlI9JajPAX8neFaussvjiRH
         bEMV/RCTMviL6qMyiqFV+vFmAZx19gtoNxznE=
Received: by 10.216.88.71 with SMTP id z49mr538498wee.90.1266931930564; Tue, 
	23 Feb 2010 05:32:10 -0800 (PST)
In-Reply-To: <4B83D5CC.9030206@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140799>

On Tue, Feb 23, 2010 at 2:19 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Johannes Schindelin schrieb:
>> May I caution against allowing "+" as part of filenames? On Windows,
>> thanks to the DOS garb^Wheritage, "+" is not really allowed...
>
> I don't think that's true (and I also think it never was).
>

Wikipedia doesn't seem to think so either:
http://en.wikipedia.org/wiki/Filename#Reserved_characters_and_words

-- 
Erik "kusma" Faye-Lund
