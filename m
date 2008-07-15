From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: git config oddity
Date: Tue, 15 Jul 2008 17:35:19 +0200
Message-ID: <bd6139dc0807150835p1da70becj7fe28f6fa7d79ed5@mail.gmail.com>
References: <bd6139dc0807150744l78eb8d54ld167d3a9a5a600f@mail.gmail.com>
	 <alpine.DEB.1.00.0807151600170.8950@racer>
	 <bd6139dc0807150829n2b3c88d7p18c203e93cd4e0c1@mail.gmail.com>
	 <alpine.DEB.1.00.0807151631520.8950@racer>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailinglist" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 15 17:36:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KImZv-0006Ih-6K
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 17:36:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755112AbYGOPfY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 11:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752607AbYGOPfY
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 11:35:24 -0400
Received: from rn-out-0910.google.com ([64.233.170.185]:52801 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752951AbYGOPfW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 11:35:22 -0400
Received: by rn-out-0910.google.com with SMTP id k40so1551256rnd.17
        for <git@vger.kernel.org>; Tue, 15 Jul 2008 08:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=KjfYE4Be+hiQEtmeFhCVW/JkOkSoHo7kh2lzVRwi0aI=;
        b=TKdPWH8Yq94V/SrT4M4Jn2PiZVwKib8DlOKL1XeVBVKrBYSrt7QlUJJjC8huhb2aep
         mGzDDij0qMwgOjYY75FoGD+8n94Jn6IcOvGFuk7PAU7807yc3SJ/147nIs1GtaFV4dSB
         yaQl5ZDypCAFOG/IwVKglSVAv+dsXptGHyplE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=aNt/vId8+q7ITuyYhKHY9yccS2Q+6OFJkdqtlGBT+0juq4PjgUoJ9nhuvEUHxbLj/C
         Re0pCuOKm6C64M2+wKDGHxc5xsDRcKdDEHtuR8rrYKw0EV4YhzzFVAPnup3bPEbeIBn9
         tzleA+F7V4udN8c00mvxSB1Ws2ZQHwG7Gytmg=
Received: by 10.142.174.18 with SMTP id w18mr4704235wfe.325.1216136119563;
        Tue, 15 Jul 2008 08:35:19 -0700 (PDT)
Received: by 10.143.38.17 with HTTP; Tue, 15 Jul 2008 08:35:19 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807151631520.8950@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88571>

On Tue, Jul 15, 2008 at 5:33 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> The config writing uses the config parser to determine where the locations
> of the config variables (and therefore, sections) are by using the parser,
> and remembering the position in the file.

Ok, thanks for the explanation, I'll add a workaround in my code.

-- 
Cheers,

Sverre Rabbelier
