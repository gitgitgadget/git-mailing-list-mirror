From: Christian Hammerl <info@christian-hammerl.de>
Subject: Re: Re: Annoying absolute path for "core.worktree" to submodule
Date: Wed, 21 Mar 2012 10:42:03 +0100
Message-ID: <20120321104203.44dd0f95@christian-hammerl.de>
References: <20120320105243.2e8a489b@christian-hammerl.de>
	<4F6886A6.3010805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Antony Male <antony.male@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 21 10:42:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAI3Z-0000SI-1u
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 10:42:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753263Ab2CUJmH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 05:42:07 -0400
Received: from w3variance.de ([85.197.82.140]:43794 "EHLO w3variance.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751565Ab2CUJmG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2012 05:42:06 -0400
Received: from ip-95-222-97-168.unitymediagroup.de ([95.222.97.168] helo=localhost.localdomain)
	by w3variance.de with esmtpa (Exim 4.75)
	(envelope-from <info@christian-hammerl.de>)
	id 1SAI32-0001oV-7E; Wed, 21 Mar 2012 10:41:40 +0100
In-Reply-To: <4F6886A6.3010805@gmail.com>
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.10; x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193562>

> What are you referring to as the "last update"? v1.7.8 introduced the 
> separate git dir for submodules, and used an absolute path.

Ah ok, my current Version is 1.7.9.4. I did not recognize this
behaviour before, so I assumed it came with the last update. Sorry for
that.

> This absolute path was changed to a relative path in the patchset at 
> [1], which is present in v1.7.10-rc1.
> 
> 
> [1]: http://thread.gmane.org/gmane.comp.version-control.git/192173

I see, thanks for the information.
I think I will wait until my linux distribution will update the
package to 1.7.10. For now it works for me to replace the .git file
with the corresponding repository which is located at ".git/modules/*"
within the superproject.
