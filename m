From: "Ken Pratt" <ken@kenpratt.net>
Subject: Re: pack operation is thrashing my server
Date: Mon, 11 Aug 2008 12:15:59 -0700
Message-ID: <a6b6acf60808111215y45b261d2ra667ea8d9f5f76d2@mail.gmail.com>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com>
	 <20080811030444.GC27195@spearce.org>
	 <a6b6acf60808110043t76dc0ae6l428c5da473d79c71@mail.gmail.com>
	 <87vdy71i6w.fsf@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Andi Kleen" <andi@firstfloor.org>
X-From: git-owner@vger.kernel.org Mon Aug 11 21:17:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSct6-0007uF-PW
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 21:17:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752978AbYHKTQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 15:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752931AbYHKTQA
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 15:16:00 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:29449 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752108AbYHKTP7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 15:15:59 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2395562rvb.1
        for <git@vger.kernel.org>; Mon, 11 Aug 2008 12:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=/4x/mBpnYefPbvJtNkaeQzDEDkHZ9JtfxoUxbrDqtCo=;
        b=KQiW6iaf8UyF0LtPZxkW/yzYHeBeH+CD9HFOOVgJnEL4FIT2CZEtIDdG2erUgHgX6+
         SEaNS61nPx//udqHPcsvvpdloP4D3dZm8FWIg80f57utcEAmO4wSFq0W0iLuT3euKiM/
         CWlnEQMqvNe3bRMBwANrHVM7T/C4O1kdgUquY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=E+N5Oyy6sg+zmBFbJ0xQUuKo4IWTKqpbw9N25J7nz3/954hcnoil5sfnwM13tS8Syl
         okNzz4if/IxeNdP/u+A9Z75YQAWsUuN47PapfyZXmon2zQdBY66aks5Z5T0XwXjgjbfv
         W7pe2+B9Im6sZ80ATIC4K+u0LG+MlCcY4qrus=
Received: by 10.141.177.10 with SMTP id e10mr3751900rvp.112.1218482159132;
        Mon, 11 Aug 2008 12:15:59 -0700 (PDT)
Received: by 10.141.42.15 with HTTP; Mon, 11 Aug 2008 12:15:59 -0700 (PDT)
In-Reply-To: <87vdy71i6w.fsf@basil.nowhere.org>
Content-Disposition: inline
X-Google-Sender-Auth: 73dd7bf673a1b69b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91981>

> As a quick workaround you could try it with a 32bit git executable?
> (assuming you have a distribution with proper multilib support)

In this case, I do have control over the server (running Arch Linux,
which should do 32-bit multilib just fine), but for my workflow I
cannot assume that the server will have 32-bit git support.

I will use the previously mentioned solution of doing the packing
elsewhere for now as a band-aid, with hopes that this will get fixed
sometime soon.

Thanks!

-Ken
