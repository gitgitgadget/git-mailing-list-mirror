From: "Imre Deak" <imre.deak@gmail.com>
Subject: Re: [PATCH] fix bogus "diff --git" header from "diff --no-index"
Date: Sun, 5 Oct 2008 23:47:47 +0300
Message-ID: <500f3d130810051347g4033c86euf683d0e29cfb9f43@mail.gmail.com>
References: <20081005193515.GA29022@coredump.intra.peff.net>
	 <alpine.LFD.2.00.0810051333110.3208@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Oct 05 22:49:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmaXC-000184-M4
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 22:48:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754599AbYJEUrs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Oct 2008 16:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754523AbYJEUrs
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 16:47:48 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:51058 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754159AbYJEUrs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2008 16:47:48 -0400
Received: by yx-out-2324.google.com with SMTP id 8so376373yxm.1
        for <git@vger.kernel.org>; Sun, 05 Oct 2008 13:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=5dtVnz76OVUY6Ky+RH3XGog0Ev302jX0Acvm4SuiHX4=;
        b=ZompQS4i+5/6uf3mR4me1qFD9ZCt62CdM7lZLrU5720RyCCsgg+GR2V8mTSqBof6Fb
         Gjgf3XozUTACwAmUzAJkA605XZXq3MbddT0EN76i4P8L/T6Mk+uSFOUZifvHhD13o52x
         NWpoF/vFZEdnVWbySt67NfHeH3sk7++GyBhRI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=raUDCFtWlgNf9PBw4Pi4dUdSHWdxfPhIeP5Muedaw+tV5JCCxEj56huknY7Y7JrleN
         AkRvKqN46ur77ZMEaPsKiUWRNjgGjUm/gb43Qv8KccefXhUaKipgpPxfkvB/sXCjtWhH
         iu9KGoi2mIkI3PMcv32s628XuQ4xeUPCfvvvE=
Received: by 10.150.181.7 with SMTP id d7mr6221757ybf.206.1223239667024;
        Sun, 05 Oct 2008 13:47:47 -0700 (PDT)
Received: by 10.150.123.11 with HTTP; Sun, 5 Oct 2008 13:47:47 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0810051333110.3208@nehalem.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97535>

This solved my problem, thanks for the fast fix!

--Imre

On Sun, Oct 5, 2008 at 11:40 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>
> On Sun, 5 Oct 2008, Jeff King wrote:
>> From: Linus Torvalds <torvalds@linux-foundation.org>
>>
>> Signed-off-by: Jeff King <peff@peff.net>
>
> Tests and explanation looks fine, so you can add my Signed-off-by: too..
>
>        Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
>
> Thanks,
>
>                Linus
>
