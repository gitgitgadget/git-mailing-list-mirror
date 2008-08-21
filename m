From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit] kha/{safe,experimental} updated
Date: Thu, 21 Aug 2008 23:16:01 +0100
Message-ID: <b0943d9e0808211516j4c1f35c0gcbc3374a6b710797@mail.gmail.com>
References: <20080808082728.GA24017@diana.vm.bytemark.co.uk>
	 <b0943d9e0808131454p16cb104bs1bcf67a6c660a88a@mail.gmail.com>
	 <20080817201848.GA10889@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Samuel Tardieu" <sam@rfc1149.net>,
	"Daniel White" <daniel@whitehouse.id.au>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 00:17:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWISv-0004fS-7B
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 00:17:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756266AbYHUWQG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Aug 2008 18:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757624AbYHUWQG
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 18:16:06 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:42886 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756465AbYHUWQD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Aug 2008 18:16:03 -0400
Received: by yx-out-2324.google.com with SMTP id 8so104907yxm.1
        for <git@vger.kernel.org>; Thu, 21 Aug 2008 15:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=CpPTUYCmqnuuHfXZusjvr44iFn7mR4lgWqpqKKRnmME=;
        b=OlZCJTQ6V8yH1ZKPPOcsqCYVaas19gsAcIrqiFinSCMg5DzZlWXbxKSiPBoZfRmu92
         dqslQXkODZvl+i8SzSDOE2CSXghjge3LkVQrpTaRcO4xDQ7FrtMKsQNC/LHU3HS6y5kw
         KFFPvoxIS0HYtn6rd0ZzVTJF0ZJzNtFCfnpQ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=je0DTpPetJnySkTT87JSGma7NZ/L6d0RIWs1qvLWp2cVVFc6HWFL2+15Jyuu33J/zQ
         4ae56RboVnF18kEzm3hxYYuhCmKwMgcP/4KeOGRHfTSfcdKUNrS2X1f8I13ZbV1JnMtA
         Wg0J4ra7y1avHu7AVze4cHytbFw6ere+2EgBs=
Received: by 10.114.37.1 with SMTP id k1mr435717wak.44.1219356961890;
        Thu, 21 Aug 2008 15:16:01 -0700 (PDT)
Received: by 10.114.193.12 with HTTP; Thu, 21 Aug 2008 15:16:01 -0700 (PDT)
In-Reply-To: <20080817201848.GA10889@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93219>

2008/8/17 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2008-08-13 22:54:57 +0100, Catalin Marinas wrote:
>> I'll repost my patches with the new git id format as well
>
> Excellent. I was about to merge them a while back, but I noticed you
> hadn't addressed the latest round of comments then.

I actually decided to commit them since the comments were minor like
fixing the commit log or using strip_prefix(). I implemented them and
hopefully haven't forgotten any.

--=20
Catalin
