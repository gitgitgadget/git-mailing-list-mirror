From: Frank Li <lznuaa@gmail.com>
Subject: Re: [PATCH 01/17] Avoid declaration after statement
Date: Mon, 14 Sep 2009 22:04:37 +0800
Message-ID: <1976ea660909140704r4b730002o5d3f42463b57828d@mail.gmail.com>
References: <cover.1252925290.git.mstormo@gmail.com>
	 <1b36d8e041c9c1a6dc68f9cc3919fcf91b7a9ac6.1252925290.git.mstormo@gmail.com>
	 <81b0412b0909140659p2472c026gaece8b9388fb21d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Marius Storm-Olsen <mstormo@gmail.com>, Johannes.Schindelin@gmx.de,
	msysgit@googlegroups.com, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 14 16:04:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnCAf-00050k-Uy
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 16:04:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752695AbZINOEh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2009 10:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbZINOEh
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Sep 2009 10:04:37 -0400
Received: from mail-qy0-f181.google.com ([209.85.221.181]:55755 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061AbZINOEh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2009 10:04:37 -0400
Received: by qyk11 with SMTP id 11so2418556qyk.1
        for <git@vger.kernel.org>; Mon, 14 Sep 2009 07:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=nWYB3IqXc76kH1ekGLb+VTrKE9dgN2ZkblDPMGyoghc=;
        b=UtDHsZZ+irolPP/t6xHDpEtePEr69IBRzUAUqVm3U5CZ2vtfPR9PEgDHqXFM7EDLsS
         7HOOjobOzIvsNJKVHKYQxW5EP+06NQtVP+e9eM56zPK/st+jLQgyURDwB+NrJWDoq3P1
         rbcYmld93ObYHLzwRkTRYjdklxsDZcOoDSKg4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=AzeUlS0YjqXtlTbzGarUBXfMqgYCTjrli1WBDtn2ZeWBMh4DFjr8WwsJ5Elv+91c5W
         F9i8oht7cW3xZGIpGfBktpZ7X7H/z+yG0gC3hiroOExNoM29xadzhxl558vyp58qomO3
         TXXDorCzkC1XxfxfHRkLESgWXmKiZta3DBkgI=
Received: by 10.224.32.194 with SMTP id e2mr5161394qad.33.1252937077964; Mon, 
	14 Sep 2009 07:04:37 -0700 (PDT)
In-Reply-To: <81b0412b0909140659p2472c026gaece8b9388fb21d6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128483>

>>
>> Microsoft Visual C++ does not understand this C99 style
>>
>
> But you don't use the C++ compiler (which does understand that syntax).
>

Microsoft Visual C++ is product name. If you think it is confuse, it
can change to "MSVC"
