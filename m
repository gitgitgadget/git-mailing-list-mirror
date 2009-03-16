From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] config: --replace-all with one argument exits properly 
	with a better message.
Date: Mon, 16 Mar 2009 17:25:46 +0200
Message-ID: <94a0d4530903160825h2e4fae8fy9fd53271a2944d40@mail.gmail.com>
References: <1236998552.9952.2.camel@luis-desktop>
	 <7vtz5vakrp.fsf@gitster.siamese.dyndns.org>
	 <94a0d4530903141434w2fb8aa28we087465482a12e41@mail.gmail.com>
	 <7vab7na6wb.fsf@gitster.siamese.dyndns.org>
	 <94a0d4530903150326u34a0715v38269417e2785db8@mail.gmail.com>
	 <1b46aba20903160741y64598f92gda5cfe9c8dd31586@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	johannes.schindelin@gmx.de
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 16:27:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjEim-0002KS-Gq
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 16:27:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753082AbZCPPZu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 11:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752949AbZCPPZu
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 11:25:50 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:7327 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752919AbZCPPZt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 11:25:49 -0400
Received: by fg-out-1718.google.com with SMTP id 16so1181137fgg.17
        for <git@vger.kernel.org>; Mon, 16 Mar 2009 08:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=SrWqyTgqQXioTSRkVws2ZHRLyLFckNnlkgOloVGsDa8=;
        b=SquRM5NiUJR435lO3w8bB4e9SQBYfmuNvEuYm89lL7DLqtwe7KWsQivCDJyWQRZM0z
         PEGr9hMetoPjkCUgLa/q5PEMGEt68vurDVvAdI/fxrmsqxhCIjimtZ8stVavjgLqFKmR
         wWTtWM+d5NBX8hCdDl/oRC3J80qXIB+hOcMQE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pdn6SN8kuQzoFlfW9B+T4JFq7sTdVRMu7hKGkyyklmMME/0SR5FAEQfuOSoo6p8W60
         rhd4KHu/P4Rq4igBPwpDLSXMlSYkkWJDmfmN+zxIVtTtG47DZKk6Rz+xahEP8le3sdcB
         tRUBi5Uq+ogCY/1DXhYsET68lzgCvDwO617tI=
Received: by 10.86.79.19 with SMTP id c19mr2577502fgb.5.1237217146956; Mon, 16 
	Mar 2009 08:25:46 -0700 (PDT)
In-Reply-To: <1b46aba20903160741y64598f92gda5cfe9c8dd31586@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113335>

On Mon, Mar 16, 2009 at 4:41 PM, Carlos Rica <jasampler@gmail.com> wrote:
> Hi Felipe, I didn't know that you were writing the parse options for
> config. I tried it a year ago and I leave it unfinished because (if I
> remember correctly) options like -4, -5, -6... and those:
> http://thread.gmane.org/gmane.comp.version-control.git/78480

I found the same issue, but Johannes suggested to use
PARSE_OPT_STOP_AT_NON_OPTION :)

-- 
Felipe Contreras
