From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Sun, 25 Nov 2012 13:01:11 +0100
Message-ID: <50B20887.5060601@gmail.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com> <CAMP44s18MzmWRNRiRjL6hvpK1cm=S-97fB2ep-_0RAhnfs5cvA@mail.gmail.com> <50B1F684.5020805@alum.mit.edu> <20121125105707.GA25212@thyrsus.com> <alpine.DEB.2.02.1211250344360.32333@nftneq.ynat.uz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Eric S. Raymond" <esr@thyrsus.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: David Lang <david@lang.hm>
X-From: git-owner@vger.kernel.org Sun Nov 25 13:01:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tcatw-00051s-SJ
	for gcvg-git-2@plane.gmane.org; Sun, 25 Nov 2012 13:01:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961Ab2KYMBS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 07:01:18 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:35897 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673Ab2KYMBQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 07:01:16 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so4237519bkw.19
        for <git@vger.kernel.org>; Sun, 25 Nov 2012 04:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=CYW21IAuPIlhIyOV4Rzqh/bfQCVFNIyB0JQ5jx9+IQw=;
        b=Pda83gPGvAAE0XiFtjUjy8EEm0g/HpLX3PfsDryh/GExlOSgcvurwrfYUkhp95PRXS
         xOK60tZTIMVJIPqmRtzHnD94PtrKb8C+dwALi01b4sOZgwsf6dx1lgm7Qi/2VP8PBM80
         xDZV6Jjg6ezEySHxydRNzhZsfNol/uiMNvwLVeHaV0zx0V409gqflEwhUoYbRHt5GKlm
         +5ayEdZg1gOYk6vPZ8qFLx1W0U/+CsH9dqWE4su0QnDRmCYMyNDbicliNZGyRI0q1xR+
         yNoT0hoARsRo7AIROjV7+WMthLr50rYtMsLZ2IdEMLnjz2IWYACXopnXWZbbw9xPYzsJ
         B4ow==
Received: by 10.204.147.78 with SMTP id k14mr2516027bkv.7.1353844875388;
        Sun, 25 Nov 2012 04:01:15 -0800 (PST)
Received: from [192.168.178.21] (host54-50-dynamic.58-82-r.retail.telecomitalia.it. [82.58.50.54])
        by mx.google.com with ESMTPS id l17sm6401347bkw.12.2012.11.25.04.01.13
        (version=SSLv3 cipher=OTHER);
        Sun, 25 Nov 2012 04:01:14 -0800 (PST)
In-Reply-To: <alpine.DEB.2.02.1211250344360.32333@nftneq.ynat.uz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210368>

Hi David.  One minor but important correction ...

On 11/25/2012 12:51 PM, David Lang wrote:
>
> You may think that C and Bash are poor choices, but that is what the
> community is familar with.
>
Actually, it is C and POSIX shell -- not merely bash.  Indeed, the shell
code in Git is expected to work with the Solaris Korn shell, the BSD
/bin/sh, the dash shell (which is now the default /bin/sh on Debian and
Ubuntu), etc.

(Oh, and on the python vs. C vs. shell diatribe I'm mostly neutral,
mostly because I'm no Git developer, and I have no "cents to throw").

Regards,
  Stefano
