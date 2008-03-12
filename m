From: Geert Bosch <bosch@adacore.com>
Subject: Re: [PATCH] gc: call "prune --expire 2.weeks.ago"
Date: Wed, 12 Mar 2008 12:20:55 -0400
Message-ID: <F3B86403-2AB7-4F65-85FD-FF3243B69C77@adacore.com>
References: <alpine.LSU.1.00.0803112157560.3873@racer.site> <7vskywadum.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0803112234470.2947@xanadu.home> <7vbq5k77z0.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803121153160.1656@racer.site>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 12 17:22:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZThw-00067w-0r
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 17:21:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbYCLQU5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 12:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbYCLQU5
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 12:20:57 -0400
Received: from rock.gnat.com ([205.232.38.15]:50789 "EHLO rock.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751159AbYCLQU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 12:20:56 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by filtered-rock.gnat.com (Postfix) with ESMTP id 4AB722AA503;
	Wed, 12 Mar 2008 12:20:56 -0400 (EDT)
Received: from rock.gnat.com ([127.0.0.1])
	by localhost (rock.gnat.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id lVMsRHRgEB5A; Wed, 12 Mar 2008 12:20:56 -0400 (EDT)
Received: from potomac.gnat.com (potomac.gnat.com [205.232.38.124])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rock.gnat.com (Postfix) with ESMTP id 332A42A993E;
	Wed, 12 Mar 2008 12:20:56 -0400 (EDT)
In-Reply-To: <alpine.LSU.1.00.0803121153160.1656@racer.site>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76965>


On Mar 12, 2008, at 06:57, Johannes Schindelin wrote:
> The real question I asked was: is 2 weeks a sensible default?  As I  
> said,
> I was almost tempted to reduce it to 3 days.
>
> Hmm?

Two weeks is a sensible default. Many people don't use their SCM every
day (really!). Say you'd work on something friday, mess up and go home,
it would be quite bad on monday morning to find that gc kicks in and
removes some objects you're trying to recover.

The only point is to reduce build-up over long periods,
so two weeks seems a perfectly fine cut-off.
