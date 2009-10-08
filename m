From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Fix MSVC build on cygwin
Date: Thu, 8 Oct 2009 20:50:16 +0200
Message-ID: <fabb9a1e0910081150s72d3b167k841175856c1f2b6f@mail.gmail.com>
References: <4ACE0388.6070706@ramsay1.demon.co.uk> <alpine.DEB.1.00.0910082040110.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>, mstormo@gmail.com,
	GIT Mailing-list <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 08 20:54:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mvy7t-0008It-Hy
	for gcvg-git-2@lo.gmane.org; Thu, 08 Oct 2009 20:54:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759561AbZJHSvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2009 14:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759554AbZJHSvP
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Oct 2009 14:51:15 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:35147 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759551AbZJHSvO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2009 14:51:14 -0400
Received: by ewy4 with SMTP id 4so3186515ewy.37
        for <git@vger.kernel.org>; Thu, 08 Oct 2009 11:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=vSQ6VQr2UOdIZYsuJetEXfdSg/DeOstpTqq3l68/tF4=;
        b=k9F3rKS9kTRXgAXszOAgoTH0vCNzac+uuznUckoTi4mVw4+5DbMQfRmsGTVw8LkKZf
         sfhiCLcWlBhb10lbepQwibpkMTlkbtSCAvPuIuVfzycj9ZswYm75rYlC1PK6ts9F5oQ7
         Bp3lHW8MFgVpN6h3kwVkq+qlJIFhZ8wiPWD+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Ux1YOtUlgpBz5IBVPvurs6PTpHr1m1a4Jc5kMWjvG/J7ItLxrcr5WgvQm87b3OEVOo
         NwCXwib1NcuiTEDdoCGpxvLj7B2fi5yp9RdKEUbCaxya7wfw3Byj7kvPk0FpXnLbhId2
         gKC7f+8wpu6/1KKNC+AfOWZYOdJreX2+okS4s=
Received: by 10.216.88.10 with SMTP id z10mr578056wee.108.1255027836123; Thu, 
	08 Oct 2009 11:50:36 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0910082040110.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129713>

Heya,

On Thu, Oct 8, 2009 at 20:40, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> I thought we only used shell patterns for filenames, and regexes for
> everything else?

Maybe he's enacting a long silence after his Hi? "Hi                       "?

-- 
Cheers,

Sverre Rabbelier
