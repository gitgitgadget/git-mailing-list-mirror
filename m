From: Junio C Hamano <junkio@cox.net>
Subject: Re: [FYI] pack idx format
Date: Wed, 15 Feb 2006 17:58:49 -0800
Message-ID: <7vy80ckqsm.fsf@assigned-by-dhcp.cox.net>
References: <7vd5hpm2x0.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602151144010.5606@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Feb 16 02:59:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9YQ4-0000pH-5J
	for gcvg-git@gmane.org; Thu, 16 Feb 2006 02:58:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbWBPB6w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Feb 2006 20:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWBPB6w
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Feb 2006 20:58:52 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:52645 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750880AbWBPB6v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2006 20:58:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060216015526.WOQE20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 15 Feb 2006 20:55:26 -0500
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0602151144010.5606@localhost.localdomain> (Nicolas
	Pitre's message of "Wed, 15 Feb 2006 11:46:46 -0500 (EST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16260>

Nicolas Pitre <nico@cam.org> writes:

> On Wed, 15 Feb 2006, Junio C Hamano wrote:
>
>> This is still WIP but if anybody is interested...  Once done, it
>> should become Documentation/technical/pack-format.txt.
>> 
> [...]
>> 
>> Pack file entry: <+
>> 
>>      packed object header:
>> 	1-byte type (upper 4-bit)
>
> Actually the type occupies only 3 bits (bits 4 to 6) as bit 7 is the 
> size continuation bit.

You are right.
