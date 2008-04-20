From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Git performance on OS X
Date: Sun, 20 Apr 2008 05:23:14 +0400
Message-ID: <20080420012314.GS3133@dpotapov.dyndns.org>
References: <1208633300-74603-1-git-send-email-pdebie@ai.rug.nl> <alpine.LFD.1.10.0804191443550.2779@woody.linux-foundation.org> <FEFAB19F-742A-452E-87C1-CD55AD0996DB@ai.rug.nl> <m3od85qxcl.fsf@localhost.localdomain> <alpine.LFD.1.10.0804191547320.2779@woody.linux-foundation.org> <alpine.LFD.1.10.0804191551540.2779@woody.linux-foundation.org> <0BE9BBE3-EA9D-4A66-A086-A2A1B289B0DD@ai.rug.nl> <alpine.LFD.1.10.0804191619240.2779@woody.linux-foundation.org> <2F8F3BF2-66F9-473C-BE82-8F784E1FF9A4@ai.rug.nl> <alpine.LFD.1.10.0804191727270.2779@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pieter de Bie <pdebie@ai.rug.nl>,
	Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Apr 20 03:24:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnOHz-0006OM-MU
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 03:24:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751919AbYDTBXU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2008 21:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751774AbYDTBXU
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Apr 2008 21:23:20 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:28865 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314AbYDTBXU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2008 21:23:20 -0400
Received: by fg-out-1718.google.com with SMTP id l27so1183779fgb.17
        for <git@vger.kernel.org>; Sat, 19 Apr 2008 18:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=5Jq11vZY0aKbriHAikNlhmnfRnb0lWaxwsdNFkdPBYE=;
        b=LlWEwRJ4LrqhmYZTKt8I4LLP72u7PapuFHFA6PI2WFPB7fvo6wvJ00tv+A7c4yvjjr0YDZjADNWAiX/KVkpjMHYSsxpaEYj5+L8rWUU0n63wZciQBrkxGuACEPAlI7+xl9/vCAMrqMnE0yPddxmh/xub+n9VEWDnphw51OoRZAw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=HzEqIgRGyqmOjEcf3QI8jEIdYOtlAy7F41eXgFX0GbhzdTWGGEDrHPMKsl8H8rgC5wLf0TnKXIAhau85fG8GRMcqgjAoz3d4XBLlI+6f82Xr5L4Z+Uyz/Yy8BoR2cp4gfZ1XnxwyFDAW+oWbx5PsQIW/qNEjr8sGfp6/0tas1Yg=
Received: by 10.86.96.18 with SMTP id t18mr9303185fgb.4.1208654598760;
        Sat, 19 Apr 2008 18:23:18 -0700 (PDT)
Received: from localhost ( [85.140.168.45])
        by mx.google.com with ESMTPS id c25sm3197427ika.9.2008.04.19.18.23.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 19 Apr 2008 18:23:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0804191727270.2779@woody.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79944>

On Sat, Apr 19, 2008 at 05:31:41PM -0700, Linus Torvalds wrote:
> 
> Maybe my CPU is faster too (2.66GHz Core 2), but the thing is, Linux 
> really does tend to outperform others at a lot of these kinds of loads. 
> System calls are fast to begin with, and the Linux directory cache kicks 
> ass, if I do say so myself.

Yes, Linux is really fast. Even with relatively old AMD Sempron 1.8 GHz,
I got the following numbers:
real    0m0.177s
real    0m0.154s

Dmitry
