From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Update "gc" behavior in commit, merge, am, rebase and index-pack
Date: Mon, 14 May 2012 10:18:38 -0500
Message-ID: <CAGdFq_hneGBtjKHk=jqmgrVgYFKEFYLTnyS+-OemwL4z7JKmKw@mail.gmail.com>
References: <1336810134-3103-1-git-send-email-pclouds@gmail.com>
 <alpine.LFD.2.02.1205121326380.21030@xanadu.home> <CACsJy8DxoRHYnBvJn7P9dS1A0Y88Bm0ur1meWCUBp09UEfuOgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nicolas Pitre <nico@fluxnic.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Fernando Vezzosi <buccia@repnz.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 14 17:19:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STx3X-00058Q-U4
	for gcvg-git-2@plane.gmane.org; Mon, 14 May 2012 17:19:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756896Ab2ENPTT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 May 2012 11:19:19 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:56387 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755655Ab2ENPTS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2012 11:19:18 -0400
Received: by obbtb18 with SMTP id tb18so7547073obb.19
        for <git@vger.kernel.org>; Mon, 14 May 2012 08:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=O9txgolhGR2xf4kXmCCbWwk4FVd5JmFJ3yaFaVUdg0c=;
        b=TaTgnS6ezBzZqNBX3i9G61pN4XT3Tb9gD3VZ4Hm+Fu1JuaroZDiV6McEoZiRv8eBPX
         BSV4cJM9aoNFJZ/N7TszWoz6Tn4SByna64Zbc581jC0zeG1MsUMyqKS/trr1tmq050sm
         3Cv/FWW+tnEl6X/zwIqfs0tV1IR589fFIpJsYw4bNMYdHO6pOf2xKwldnV73+I38uoGW
         4926lsIS52wcH5e4mPTd/C4/rBiF4QyYJedJKuIKEwx9GQJfUjZn1tk6qsnrtoFqm/Qh
         fDG/YUtRWSwqVcFAqVk1lWy2BexBaHWETlbx86KZD75MZB23UmUJpLM6tj5Tsaf1pBQ8
         OPBg==
Received: by 10.182.52.38 with SMTP id q6mr12452697obo.8.1337008758404; Mon,
 14 May 2012 08:19:18 -0700 (PDT)
Received: by 10.76.169.98 with HTTP; Mon, 14 May 2012 08:18:38 -0700 (PDT)
In-Reply-To: <CACsJy8DxoRHYnBvJn7P9dS1A0Y88Bm0ur1meWCUBp09UEfuOgg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197776>

On Mon, May 14, 2012 at 4:09 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> I'm good with always warning too. The moment it shows up, I can just
> open another terminal for "gc". Though (I guess) a new user in the
> middle of the work may not want to do that as they fear "gc" may
> interfere their work.

If we know that it won't interfere with their work, can we just spawn
git gc as a background process?

-- 
Cheers,

Sverre Rabbelier
