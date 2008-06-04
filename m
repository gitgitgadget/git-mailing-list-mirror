From: "Nigel Magnay" <nigel.magnay@gmail.com>
Subject: Re: [JGIT RFC] Mavenized JGit
Date: Wed, 4 Jun 2008 07:40:32 +0100
Message-ID: <320075ff0806032340k9814a81g196e0417d42a3f6@mail.gmail.com>
References: <7bfdc29a0806030742r77b79786n92a5ce6a0aba7726@mail.gmail.com>
	 <200806031856.11060.robin.rosenberg.lists@dewire.com>
	 <20080603225418.GP12896@spearce.org>
	 <200806040130.41654.robin.rosenberg.lists@dewire.com>
	 <7bfdc29a0806032052w39010711q27e5257ef559908a@mail.gmail.com>
	 <20080604042703.GQ12896@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Imran M Yousuf" <imyousuf@gmail.com>,
	"Robin Rosenberg" <robin.rosenberg.lists@dewire.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jun 04 08:41:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3mgp-0006lQ-8K
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 08:41:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752168AbYFDGkg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 02:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751681AbYFDGkf
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 02:40:35 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:13030 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990AbYFDGke (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 02:40:34 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1244906fgg.17
        for <git@vger.kernel.org>; Tue, 03 Jun 2008 23:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ntcDbFygkgmgUBS+NVz4dO5Y3HebCfGDnK4WCl2YV9E=;
        b=lSnl28fCe9Hx17Nxm2yA9Bb2EAnznlIH3s4I+oGCTY7nerThm7+kjFmjpSevdR2/jDthL4tut2wVcDV2RTkyyAumskTNIrUWF5cb/h6LOfdP6HDkLCHyNQfLIfbLn0AHkVoGH15aOgT+0nx6oW3SqcHbUENpDis3AWF0a5BUuUY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BPI7ggBWHxmHA5hoI69uo4Qp+LzMeQ8YSq/1l60m8CbApo2NaRVUv7yf4LPeMiYRW/QzP/YPbpLVOxOxxVOTKw+oaglbzRs609rRjUo0XWuCfBtX2cy0XYyI4Cc3HSNKy63YtibJPSFnZLY0c7iA+abGyJH9KibLY7IO5AOFo/4=
Received: by 10.82.153.12 with SMTP id a12mr212183bue.2.1212561632574;
        Tue, 03 Jun 2008 23:40:32 -0700 (PDT)
Received: by 10.82.168.20 with HTTP; Tue, 3 Jun 2008 23:40:32 -0700 (PDT)
In-Reply-To: <20080604042703.GQ12896@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83746>

>
> But this shows one reason why I don't use Maven I think.  The
> fact that we need a "java" directory to hold our java code.
> What if another build system wants a different name?  Grumble.
>

You don't. Just set the appropriate config item in pom.xml
(sourceDirectory possibly, but my memory isn't good this morning) and
you can use 'src' as it is currently. src/main/java is just the
default.
