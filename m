From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: [PATCH] Clean weird documentation for 'git var' and 'git
Date: Thu, 10 May 2012 20:26:21 +0200
Message-ID: <CAGK7Mr7rzuPVmGsnx+uhmVgBepAav734uh6hHeqn25BC0_+0Lw@mail.gmail.com>
References: <CAGK7Mr7QWrddaRLkr=1h=GYUNtNVOatQF1sj+p11mejzs65u8A@mail.gmail.com>
 <7vzk9gm0wa.fsf@alter.siamese.dyndns.org> <F89882854A7D45E2843F6F1F7CB21DB4@PhilipOakley>
 <CAGK7Mr6AjSY-D9p1vzs=xCg-TMCPiBJDOSxMVYtykeCZCPW2FA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu May 10 20:26:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSY4o-0005rT-C7
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 20:26:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761184Ab2EJS0y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 May 2012 14:26:54 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:34146 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761152Ab2EJS0w convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 May 2012 14:26:52 -0400
Received: by yenm10 with SMTP id m10so1781166yen.19
        for <git@vger.kernel.org>; Thu, 10 May 2012 11:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=aa7j+ybg+qu7LvO98wiRRKq5656/WfNbJb0mczew8WI=;
        b=FwE8vxqkP0kfsF3ghg7gxbfJ97efixTSnsgAEPV6U9EwDjyF5Yf2X8ErkIj1Cp2Qjq
         PsAs5WmMqsvtsR5LF1EDDNiXkJObblyNMeYKz3XT7hUDCcy75K6wmMBFU4ynTL3bgOYZ
         34GT4mSQE+EdX1NrhAjquaig+tTqCePdsAhPNFWsb6b/5E5V/yCjvexr1aau9LdnoQ0g
         0dmJkXXNdaaNfeybHXwND2Ee/ROrEX3AfP0vFqjAcjBQDPCLSgxbaXIRf4aotJyxd5Ta
         zXxHcz1LNyT3hqrMP4xZCTuavXJM4nIYJ2UAkfXno77zLCu/RG1w1vUXkKNYaSWe69uB
         giUA==
Received: by 10.50.207.38 with SMTP id lt6mr3248541igc.55.1336674411847; Thu,
 10 May 2012 11:26:51 -0700 (PDT)
Received: by 10.50.65.101 with HTTP; Thu, 10 May 2012 11:26:21 -0700 (PDT)
In-Reply-To: <CAGK7Mr6AjSY-D9p1vzs=xCg-TMCPiBJDOSxMVYtykeCZCPW2FA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197612>

>> What's weird about them? =A0They are real messages issued exactly wh=
en they are described to be issued.
>
> The problem is surely that an explanatory line is needed to say that =
these are the diagnostic messages that occur in various cases. Its in '=
ident.c'.

I guess I'm just unfamiliar with the "Diagnostics" section of a man
page.=A0When I fall on this there's nothing I learn... all the other
sections are helpful and providing self explanatory informations.

In this case (diagnostic section), the first thing I see is "You don't
exist, Go away!", and I'm like "okay..." then I see something about
the passwd file (what on earth has git-commit-tree in common with
passwd?) then I see "Your parents must have hated you!" and there I'm
like "okay, there's definitly something wrong with this man page".

I'm probably not the only one confused by this. I think a simple line
"This tool might report the following error messages" would already be
a great step forward. The next step would be to improve those error
messages :)

Philippe
