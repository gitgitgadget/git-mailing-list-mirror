From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 01/15] mingw: implement syslog
Date: Fri, 22 Oct 2010 02:13:26 +0200
Message-ID: <AANLkTinGABTRegSCCboRafGknU_B_faFrMC-vxtCHE++@mail.gmail.com>
References: <1287705944-5668-1-git-send-email-kusmabite@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com, j6t@kdbg.org, avarab@gmail.com,
	sunshine@sunshineco.com, jrnieder@gmail.com, schwab@linux-m68k.org,
	patthoyts@gmail.com, Mike Pape <dotzenlabs@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 22 02:13:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P95Gb-0005zO-82
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 02:13:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531Ab0JVANs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 20:13:48 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50426 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750975Ab0JVANr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 20:13:47 -0400
Received: by fxm16 with SMTP id 16so196599fxm.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 17:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type;
        bh=I70fHpGm4v52K82wLy8TcTq/Vsns2aK2xJjfrfPFj8o=;
        b=ZLswJGIYa20kpGzZlILaeVFP8/2eX0cjIcwnfmcROiToWk4RYGI6OMCgVDp269IFaR
         L6kMxMKNuXJajbGkw4QTTdw5R++XFhfu5J95ePI1B0jbPz6Grx8r9mOZ0BhMkFilsx2r
         xAvEi8M7QOOYCStVPzZKr8vMT+BcoSxEe+73c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=os2h0gPDGfN/DaBwe+4xhpTJ2vwkZo1pt8yP/B83c5uOUqnAI7VH6EbIW7ZFUDS/i0
         0XbWsYCGfED9DOonbirEi9w6GxPKa5rNC/s/2SOQ8ZS/yORtS1vF2EjS1RV1Zm6Hwwka
         OjSBOe58HYYaCuD2wbBd5TbJqilMV2G8fFVuA=
Received: by 10.103.181.5 with SMTP id i5mr2416705mup.48.1287706426399; Thu,
 21 Oct 2010 17:13:46 -0700 (PDT)
Received: by 10.223.112.146 with HTTP; Thu, 21 Oct 2010 17:13:26 -0700 (PDT)
In-Reply-To: <1287705944-5668-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159607>

I'm sorry for the noise, but this was incorrectly sent out. It's
missing the first patch, so I'll resend in a little while with a
proper cover letter etc...
