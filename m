From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH 0/4] replace unsinged long with time_t
Date: Thu, 6 Nov 2008 22:04:27 +0100 (CET)
Message-ID: <alpine.LRH.1.10.0811062203120.19166@yvahk3.pbagnpgbe.fr>
References: <1225993728-4779-1-git-send-email-david@statichacks.org> <alpine.LFD.2.00.0811061000430.3419@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 06 22:08:57 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyC60-0005Uf-Mg
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 22:08:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbYKFVHi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2008 16:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbYKFVHi
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 16:07:38 -0500
Received: from kluster1.contactor.se ([91.191.140.11]:33461 "EHLO
	kluster1.contactor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750932AbYKFVHh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 16:07:37 -0500
Received: from linux3.contactor.se (linux3.contactor.se [91.191.140.23])
	by kluster1.contactor.se (8.13.8/8.13.8/Debian-3) with ESMTP id mA6L7Z9V002953
	for <git@vger.kernel.org>; Thu, 6 Nov 2008 22:07:35 +0100
X-X-Sender: dast@linux3.contactor.se
In-Reply-To: <alpine.LFD.2.00.0811061000430.3419@nehalem.linux-foundation.org>
User-Agent: Alpine 1.10 (LRH 962 2008-03-14)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100266>

On Thu, 6 Nov 2008, Linus Torvalds wrote:

> In theory, some platform might have a 64-but "unsigned long long" time_t 
> even if the architecture is 32-bit (apparently windows used to do that if 
> you included <time64.h>, for example), but since we wouldn't take advantage 
> of that anyway, even then there is no real advantage.

It could also be worth to notice that there are even 64-bit architectures that 
feature 32-bit 'time_t'...

-- 

  / daniel.haxx.se
