From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git
Date: Wed, 01 Mar 2006 14:51:55 -0800
Message-ID: <7vfym1eq2c.fsf@assigned-by-dhcp.cox.net>
References: <7vmzgagxox.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603011625250.29834@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 01 23:52:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEaB0-0001oV-0u
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 23:52:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934AbWCAWv7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 17:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751937AbWCAWv7
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 17:51:59 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:16333 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751934AbWCAWv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Mar 2006 17:51:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060301225042.FFBF3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 1 Mar 2006 17:50:42 -0500
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0603011625250.29834@localhost.localdomain>
	(Nicolas Pitre's message of "Wed, 01 Mar 2006 16:28:07 -0500 (EST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17024>

Nicolas Pitre <nico@cam.org> writes:

> On Wed, 1 Mar 2006, Junio C Hamano wrote:
>
>>   These are waiting for further progress by authors:
>> 
>>   - delta packer updates for tighter packs (Nicolas Pitre)
>
> Please don't wait to merge the first two patches to diff-delta.c.  They 
> are purely cleanups with no functional differences.

I presume you mean these three?

    commit 8e1454b5ad285ec5dd25758e799c589045aff9d4
    Author: Nicolas Pitre <nico@cam.org>

        diff-delta: big code simplification

    commit fe474b588b3cb1c23c987a3d0f9e869a160d82d2
    Author: Nicolas Pitre <nico@cam.org>

        diff-delta: fold two special tests into one plus cleanups

    commit cac251d0bc4c68b7ab36026990aff3c783913ae6
    Author: Nicolas Pitre <nico@cam.org>

        relax delta selection filtering in pack-objects
