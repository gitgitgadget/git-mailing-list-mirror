From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: What's cooking in git.git (Mar 2009, #06; Sat, 21)
Date: Mon, 23 Mar 2009 15:46:50 +0100
Message-ID: <20090323144650.GA20058@pvv.org>
References: <7vk56jfgt2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 15:48:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LllRy-0004AY-Pc
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 15:48:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755736AbZCWOq4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 10:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755498AbZCWOqz
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 10:46:55 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:34822 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754615AbZCWOqz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 10:46:55 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1LllQQ-0002be-NQ; Mon, 23 Mar 2009 15:46:50 +0100
Content-Disposition: inline
In-Reply-To: <7vk56jfgt2.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114318>

On Sat, Mar 21, 2009 at 12:58:33AM -0700, Junio C Hamano wrote:
[...]
> * fg/push-default (Mon Mar 16 16:42:52 2009 +0100) 2 commits
>  - Display warning for default git push with no push.default config
>  + New config push.default to decide default behavior for push
> 
> Replaced the old series with the first step to allow a smooth transition.
> Some might argue that this should not give any warning but just give users
> this new configuration to play with first, and after we know we are going
> to switch default some day, start the warning.

If you feel that talking about a possible future change is premature,
you could omit that part of the second commit I guess, but I think
printing some kind of warning is valuable.  Are you waiting for more
input?  It seems that this topic is pretty dead now.

Most people who get bitten by this directly are probably not active on
this list so I don't think you will hear from many of them.

- Finn Arne
