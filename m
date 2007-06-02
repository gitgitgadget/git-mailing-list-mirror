From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH] Let .git/config specify the url for submodules
Date: Sat, 02 Jun 2007 09:49:10 +0200
Message-ID: <20070602074910.GB955MdfPADPa@greensroom.kotnet.org>
References: <1180385483418-git-send-email-hjemli@gmail.com>
 <8c5c35580705301717h4e9b127fr21ee19764f8ec288@mail.gmail.com>
 <20070601085705.GT955MdfPADPa@greensroom.kotnet.org>
 <8c5c35580706010225p7c34c3ceu8bbfb9996388d673@mail.gmail.com>
 <20070601093554.GV955MdfPADPa@greensroom.kotnet.org>
 <8c5c35580706010745l76fc5410l21f2e3f385693ad9@mail.gmail.com>
 <20070601145104.GY955MdfPADPa@greensroom.kotnet.org>
 <8c5c35580706010856s390b1157p3ea0d28cb2074cae@mail.gmail.com>
 <alpine.LFD.0.98.0706010919360.3957@woody.linux-foundation.org>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Lars Hjemli <hjemli@gmail.com>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jun 02 09:49:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuOMR-0000ut-3j
	for gcvg-git@gmane.org; Sat, 02 Jun 2007 09:49:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755279AbXFBHtN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jun 2007 03:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755479AbXFBHtN
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 03:49:13 -0400
Received: from smtp18.wxs.nl ([195.121.247.9]:52584 "EHLO smtp18.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755279AbXFBHtN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2007 03:49:13 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp18.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JJ000MKF0DZFN@smtp18.wxs.nl> for git@vger.kernel.org; Sat,
 02 Jun 2007 09:49:11 +0200 (CEST)
Received: (qmail 29657 invoked by uid 500); Sat, 02 Jun 2007 07:49:10 +0000
In-reply-to: <alpine.LFD.0.98.0706010919360.3957@woody.linux-foundation.org>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48914>

On Fri, Jun 01, 2007 at 09:29:58AM -0700, Linus Torvalds wrote:
> 	[module "infrastructure"]
> 		submodule = lib
> 		submodule = build
> 
> 	[submodule "lib"]
> 		url = git://xyzzy/lib-1.2.3
> 
> 	[submodule "build"]
> 		url = git://xyzzy/build-0.61
> 
> 
> IOW, in the above case, we have *three* modules:
> 
>  - module "infrastructure", that is the union of submodules/paths "lib" 
>    and "build"
>  - module "lib" (== submodule/path "lib")
>  - module "build" (== submodule/path "build")

If there are three modules, then why is one in the "module" section
and the other two in the "submodule" section?
Why not allow a module to both contain smaller modules and be contained
in a bigger module?

skimo
