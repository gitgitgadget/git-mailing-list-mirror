From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Please default to 'commit -a' when no changes were added
Date: Fri, 23 Apr 2010 15:26:38 -0500
Message-ID: <p2wb4087cc51004231326t1e92a59eg555024eaa4fd51e6@mail.gmail.com>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain> 
	<20100422155806.GC4801@progeny.tock> <87wrvzs590.fsf@frosties.localdomain> 
	<alpine.LFD.2.00.1004221445310.7232@xanadu.home> <87sk6n4426.fsf@frosties.localdomain> 
	<alpine.LFD.2.00.1004221651590.7232@xanadu.home> <87vdbitu9v.fsf@frosties.localdomain> 
	<25441792-181D-456D-8182-F33B49209EFF@wincent.com> <87aastx6sa.fsf@frosties.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Goswin von Brederlow <goswin-v-b@web.de>
X-From: git-owner@vger.kernel.org Fri Apr 23 22:27:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5PT2-0005qD-34
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 22:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756970Ab0DWU1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Apr 2010 16:27:06 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:51872 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754517Ab0DWU07 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 16:26:59 -0400
Received: by bwz25 with SMTP id 25so11691042bwz.28
        for <git@vger.kernel.org>; Fri, 23 Apr 2010 13:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=bHg9+NrULU7sYsHeEwfVh9hs4sTjZAGMp5GQAWpY3wo=;
        b=WEkqeIs4JmBJ4jQy8Dw0xy0U1ahLFpA/Vdy+mLBNLDxYJRxvf5Y4D0i8Ic6covapm9
         yKCnyFZr6++6IYxVPL8eX41SwIPkXAEEf5XFk33DZbsWruNL+tvMotTEABLRihgND/Vk
         +wgVrjtY0j/IyyWRkQhuft6zfB7GMIaXcfDNc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ukeyxPa9k2M6QrS+VANAGOkAaabxXYGP2q4sthbbkgoJAE5+B/Y3vZd3OEuuVkUp9c
         p5rvNqH1ek22EI3vzF548YXx31LaPusLSg/3+1uI6Sf7tn2ZAKOumeehJIUlDxYVbKk1
         vO2Q0YMTtjQwkglT8AwZ/zC8jHjaHNUmVA5aU=
Received: by 10.239.150.79 with SMTP id m15mr55637hbb.61.1272054418138; Fri, 
	23 Apr 2010 13:26:58 -0700 (PDT)
Received: by 10.239.189.143 with HTTP; Fri, 23 Apr 2010 13:26:38 -0700 (PDT)
In-Reply-To: <87aastx6sa.fsf@frosties.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145639>

On Fri, Apr 23, 2010 at 15:17, Goswin von Brederlow <goswin-v-b@web.de> wrote:
> But you are already rejecting it in the design phase before there even
> is a patch.
> ...
> You like that Git is different so don't use the --a-if-empty option. You
> will have lost nothing by allowing that option in. So far I have read
> arguments from people saying they don't want to USE the option. But no
> arguments why there could not be such an option. And I'm not the only
> one that would welcome such an option. Is there no room for a compromise?

My sincere advice is just to write the patch and submit it with an
example usage to illustrate your feature.

Prose aren't well received on this list (especially without concrete
code to reference).
