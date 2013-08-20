From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: CPPCheck found 24 high risk bugs in Git v.1.8.3.4
Date: Wed, 21 Aug 2013 01:01:32 +0200
Message-ID: <87y57wnf03.fsf@igel.home>
References: <85C8141E5DAD94428A121F706995A31F010F116FDAD3@MX1.net.tbe.com>
	<33FCCE7A2CD5494B88F3C5CDBC341DFD@PhilipOakley>
	<166132E40AA54EE387BA9B4558823C55@PhilipOakley>
	<CABPQNSZidMv4MEW+SqVm94pX4szw9QW8LFWsvBTOXYH7ezzycw@mail.gmail.com>
	<87eh9op5gq.fsf@igel.home>
	<CABPQNSZSXgvLw_i25em38B70EgtZrv9iQh8OaCJzYRCk2vjZXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Philip Oakley <philipoakley@iee.org>,
	"Koch\, Rick \(Subcontractor\)" <Rick.Koch@tbe.com>,
	Git List <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Wed Aug 21 01:01:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBuvk-0007Hi-DQ
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 01:01:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555Ab3HTXBg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 19:01:36 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:58331 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379Ab3HTXBg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 19:01:36 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3cKSDZ0Np1z4KK46;
	Wed, 21 Aug 2013 01:01:34 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3cKSDZ0DPJzbbn4;
	Wed, 21 Aug 2013 01:01:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id s1ZgrU__75_o; Wed, 21 Aug 2013 01:01:33 +0200 (CEST)
X-Auth-Info: fh3k/v+b+xtUYd0YnglLYV/931QWjEMBt1Gh6MjUmow=
Received: from igel.home (ppp-88-217-111-200.dynamic.mnet-online.de [88.217.111.200])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Wed, 21 Aug 2013 01:01:33 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id E06FF2C06D8; Wed, 21 Aug 2013 01:01:32 +0200 (CEST)
X-Yow: LOOK!!!  I'm WALKING in my SLEEP again!!
In-Reply-To: <CABPQNSZSXgvLw_i25em38B70EgtZrv9iQh8OaCJzYRCk2vjZXQ@mail.gmail.com>
	(Erik Faye-Lund's message of "Wed, 21 Aug 2013 00:26:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232666>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> I don't see how it's undefined. It's using the memory that 'pos'
> *points to* that is undefined, no? The difference between 'pos' and
> 'str' should still be the same, it's not like realloc somehow
> magically updates 'pos'...

It does.  Think of segmented architectures, where freeing a pointer
invalidates its segment, so that even loading the value of the pointer
traps.  Probably no such architecture is in use any more, though.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
