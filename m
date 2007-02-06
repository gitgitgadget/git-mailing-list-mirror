From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: git-fast-import
Date: Tue, 6 Feb 2007 14:50:48 +0100
Message-ID: <81b0412b0702060550u3d4064dal43e37593b013f82e@mail.gmail.com>
References: <20070206023111.GB9222@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 06 14:51:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEQin-0004Wk-PD
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 14:50:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037AbXBFNuv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 08:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752056AbXBFNuv
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 08:50:51 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:21719 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037AbXBFNuu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 08:50:50 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1608340uga
        for <git@vger.kernel.org>; Tue, 06 Feb 2007 05:50:49 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kAm2FHY8mlZTcP5wFQ/H/AZgHlmVWCySeVpH7d80VXPUfwn6acGu53bcjopXWfrIbldYTdTKHbZvUge5a+aAn72wSB0YwU/qAf0ysdu7pdOPUg0dzBe09KBkNL5LvrN3ag5Xd5+35wHljkXrIFIHymiOCJa2/APYDLOag/dG10A=
Received: by 10.78.178.5 with SMTP id a5mr1672571huf.1170769848469;
        Tue, 06 Feb 2007 05:50:48 -0800 (PST)
Received: by 10.78.139.9 with HTTP; Tue, 6 Feb 2007 05:50:48 -0800 (PST)
In-Reply-To: <20070206023111.GB9222@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38840>

On 2/6/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> I'm mainly worried about breaking compliation on odd architectures.
> gfi builds, runs and has been used for production level imports
> on Mac OS X, Linux and Dragonfly BSD, using both 32 bit and 64 bit
> architectures, but some of Git's other targets (e.g. AIX) haven't
> seen any testing.

Compilation errors are the simplest to fix, just send it in.
I have to import lots of data from perforce spaghetti, so I'm very
likely to try it out.
