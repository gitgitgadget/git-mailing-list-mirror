From: "Dmitry Kakurin" <dmitry.kakurin@gmail.com>
Subject: Re: [MinGW PATCH] git clone was failing with 'invalid object name HEAD' if ran from cmd.exe directly
Date: Mon, 6 Aug 2007 14:55:09 -0700
Message-ID: <a1bbc6950708061455v459182cei3fb6b3b518d4b176@mail.gmail.com>
References: <BD28FA320B7749FFBE3135FE92380BCE@ntdev.corp.microsoft.com>
	 <Pine.LNX.4.64.0708061134380.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 06 23:55:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIAXj-0007rk-Vi
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 23:55:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754978AbXHFVzL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 17:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753827AbXHFVzL
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 17:55:11 -0400
Received: from rv-out-0910.google.com ([209.85.198.184]:31008 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752632AbXHFVzK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 17:55:10 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1233339rvb
        for <git@vger.kernel.org>; Mon, 06 Aug 2007 14:55:09 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EqqoHBt9GaYwblmvz73AKZITJ12rrGtPsOrdNk194MlepIIUHHyAyD/ZS79cYRTZpMMeHTevwao1KqRHbB11jy3eDaYE/Czv7hj5Ji83IG/u8HdreMJ/NuvhYiCyvHJIBhsasT8EdSzKLiV9TiQy95GEhkv7GFStK89TxyURL1s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fiNxKGabIhSWbvI6x9CddYsdFAOCeqxNVSdWZChiCj1DcO5ktgY4/ksgo4Nbkp0T8xqblayI+2BBijy60upDz1osxOb5aeUIkjdsGhyz3GPYefAkhiI6yGjU6pFBJDD118Pe4sVesw6OOtV0TESG6tqRy+nOSClKxsK4oQoPSXE=
Received: by 10.141.42.10 with SMTP id u10mr2275958rvj.1186437309349;
        Mon, 06 Aug 2007 14:55:09 -0700 (PDT)
Received: by 10.141.2.18 with HTTP; Mon, 6 Aug 2007 14:55:09 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0708061134380.14781@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55174>

On 8/6/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> I had more problems than I thought with setting up a fork of mingw.git.
> It seems that the relative alternates path to mingw.git is followed, but
> not that one from mingw.git to git.git.  So I could upload, but not fetch.

Does it mean that fork of a fork does not work on repo.or.cz?

- Dmitry
