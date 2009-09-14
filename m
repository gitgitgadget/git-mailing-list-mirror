From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 01/17] Avoid declaration after statement
Date: Mon, 14 Sep 2009 15:59:40 +0200
Message-ID: <81b0412b0909140659p2472c026gaece8b9388fb21d6@mail.gmail.com>
References: <cover.1252925290.git.mstormo@gmail.com>
	 <1b36d8e041c9c1a6dc68f9cc3919fcf91b7a9ac6.1252925290.git.mstormo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes.Schindelin@gmx.de, msysgit@googlegroups.com,
	git@vger.kernel.org, lznuaa@gmail.com
To: Marius Storm-Olsen <mstormo@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 14 16:00:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnC5s-0003GH-0m
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 15:59:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755087AbZINN7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2009 09:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755061AbZINN7j
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Sep 2009 09:59:39 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:47969 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755024AbZINN7i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2009 09:59:38 -0400
Received: by bwz19 with SMTP id 19so2093454bwz.37
        for <git@vger.kernel.org>; Mon, 14 Sep 2009 06:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=l5UVPVyKzVNPVtfYz8t5UCTNSSpioCVGIXKYCwtCmiQ=;
        b=sfuICqUT4ObEIptunAHjJEbzmLOthfzc6Qu5v2ijWux31ud5xNKXxhyJIO5u0LnUDE
         PbzjMtHI7e/gSVPuE3feyeub/thtq/Q8koANIjGzDIw/KoBw9fbMBU2/SIMvU6LB97zx
         X0IVB1/5noP0L/VDA3XmpEESWtEBVxJVITFaw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=NQKM5P8t9ED332puOmEjCd9YLYcUvgqC164332jsxHeZqFChROvZJzmUIfJTSu0vlV
         yzGGELvYdTjn4TdzW21cxjV2LBNFxbMheoqgDebPBTGaaZTTB7YoMoIIS2KXOXsZWdnk
         HMckC0RWArAlMntPZeXHxraDuspkqP00BsfJE=
Received: by 10.204.26.150 with SMTP id e22mr5178313bkc.166.1252936780847; 
	Mon, 14 Sep 2009 06:59:40 -0700 (PDT)
In-Reply-To: <1b36d8e041c9c1a6dc68f9cc3919fcf91b7a9ac6.1252925290.git.mstormo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128481>

On Mon, Sep 14, 2009 at 15:11, Marius Storm-Olsen <mstormo@gmail.com> wrote:
> From: Frank Li <lznuaa@gmail.com>
>
> Microsoft Visual C++ does not understand this C99 style
>

But you don't use the C++ compiler (which does understand that syntax).
