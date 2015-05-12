From: Thomas Ferris Nicolaisen <tfnico@gmail.com>
Subject: Re: automatic git installation
Date: Tue, 12 May 2015 21:30:48 +0200
Message-ID: <CAEcj5uXSTu+eqX3O0ecb1JnQQfjEYb38TfYhF9tUOmNV8hZCTw@mail.gmail.com>
References: <AM3PR01MB3742DD43DFAE5196C50A572E6DA0@AM3PR01MB374.eurprd01.prod.exchangelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: "Knobbe, Fabian" <Fabian.Knobbe@landisgyr.com>
X-From: git-owner@vger.kernel.org Tue May 12 21:30:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsFtJ-0006Im-BZ
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 21:30:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933671AbbELTaw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 15:30:52 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:36818 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933214AbbELTau convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 May 2015 15:30:50 -0400
Received: by lagv1 with SMTP id v1so13660803lag.3
        for <git@vger.kernel.org>; Tue, 12 May 2015 12:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=bdOx5dAMDtQqut/BdlZUUivL3QL9Lb4vdcUXQI6dDK4=;
        b=n6dg8adu1Pvc/mszHV+T1G9knug+NPnBAe4G3ZH4Ulfk87XzXnpLuz0pYg+F2cvkxy
         qKCG91uBLrNddGDQxDZolmakxBSuedrfLsBcUMuzQF2xZaeL8m53frfkXzhRK+3J0tlf
         vqccmTHpfkFLyMseUit4pe8SKDcNKcMd43FlomMKfNqn27qc95iEsVJN9YRCOma/IFQ4
         kK5nG+TMt5alXIIJESsiOtYCyd3mOGxHYmlEqaZsB4GG+AuHaswtzYHi23rwuLcoThws
         ZSIeIlCmzaRCscLL87zevrMLJzRZxkyjdU4pMmeT8hK+GgdgtI+T429WkNpANqqgHd5a
         HYDA==
X-Received: by 10.112.180.201 with SMTP id dq9mr13507267lbc.78.1431459048954;
 Tue, 12 May 2015 12:30:48 -0700 (PDT)
Received: by 10.25.159.10 with HTTP; Tue, 12 May 2015 12:30:48 -0700 (PDT)
In-Reply-To: <AM3PR01MB3742DD43DFAE5196C50A572E6DA0@AM3PR01MB374.eurprd01.prod.exchangelabs.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268873>

On Tue, May 12, 2015 at 10:50 AM, Knobbe, Fabian
<Fabian.Knobbe@landisgyr.com> wrote:
>
> Hallo,
>
> I would like to automatically install git with a script. I already found some command line arguments to pass my settings to the setup routine, but I still don't know how to set "Adjust your PATH environment" to "Use Git from the Windows Command Prompt" without userinteraction.
>
> Thanks for any hints!

Have you looked at Chocolatey? It's a Windows-based package manager
that lets you install software like Git in one command [1].

[1] https://chocolatey.org/packages?q=git
