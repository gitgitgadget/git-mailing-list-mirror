From: Geert Bosch <bosch@adacore.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Thu, 17 Jan 2008 01:13:26 -0500
Message-ID: <A915BECA-A486-477B-A07D-D1033E44DCBD@adacore.com>
References: <478E1FED.5010801@web.de> <1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org> <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org> <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org> <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org> <B45968C6-3029-48B6-BED2-E7D5A88747F7@sb.org> <alpine.LFD.1.00.0801161707150.2806@woody.linux-foundation.org> <8AC4CC86-A711-483D-9F9C-5F8497006A1D@sb.org> <alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org> <4C21C1AF-40B0-48C7-8F0E-2DAF3C5FAB29@sb.org> <46a038f90801162051s5ce40abcm623599269943a24@mail.gmail.com> <ACDB98F4-178C-43C3-99C4-A1D03DD6A8F5@sb.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Jakub Narebski" <jnareb@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Mark Junker" <mjscod@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 07:14:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFO0t-0006o6-8S
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 07:14:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbYAQGN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 01:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbYAQGN2
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 01:13:28 -0500
Received: from rock.gnat.com ([205.232.38.15]:40116 "EHLO rock.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750865AbYAQGN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 01:13:28 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by filtered-rock.gnat.com (Postfix) with ESMTP id 6275C2A9644;
	Thu, 17 Jan 2008 01:13:27 -0500 (EST)
Received: from rock.gnat.com ([127.0.0.1])
	by localhost (rock.gnat.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id n3xdNa386E4R; Thu, 17 Jan 2008 01:13:27 -0500 (EST)
Received: from [172.16.1.99] (sdsl-216-220-103-157.dsl.bway.net [216.220.103.157])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rock.gnat.com (Postfix) with ESMTP id EE4E02A9637;
	Thu, 17 Jan 2008 01:13:26 -0500 (EST)
In-Reply-To: <ACDB98F4-178C-43C3-99C4-A1D03DD6A8F5@sb.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70832>

For those on Mac OS X: it is possible to create a case-sensitive HFS+  
partition and
use it with git. You even can just create a disk image and mount it.  
However,
I wouldn't quite try to use it as startup filesystem...

   -Geert

PS. I'm working on a proposal/patch for addressing the UFS/case  
sensitivity issues.
     Will try to mail something later this week.
