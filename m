From: Stefan Monnier <monnier@iro.umontreal.ca>
Subject: Re: List of files aded/removed/modified by "git-checkout"
Date: Thu, 07 Feb 2008 08:41:29 -0500
Message-ID: <jwvfxw4ga0s.fsf-monnier+inbox@gnu.org>
References: <jwvodatkbdm.fsf-monnier+gmane.comp.version-control.git@gnu.org>
	<7vve51qva3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 07 14:52:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN7Ab-0001p0-Li
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 14:52:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758895AbYBGNvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 08:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758330AbYBGNva
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 08:51:30 -0500
Received: from ironport2-out.pppoe.ca ([206.248.154.182]:33457 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757859AbYBGNv3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 08:51:29 -0500
X-Greylist: delayed 598 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Feb 2008 08:51:29 EST
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CALOZqkfO+K8J/2dsb2JhbACsU3s
X-IronPort-AV: E=Sophos;i="4.25,316,1199682000"; 
   d="scan'208";a="13816904"
Received: from smtp.pppoe.ca ([65.39.196.238])
  by ironport2-out.pppoe.ca with ESMTP; 07 Feb 2008 08:41:30 -0500
Received: from pastel.home ([206.248.175.9])
        by smtp.pppoe.ca (Internet Mail Server v1.0) with ESMTP id NPW75029;
        Thu, 07 Feb 2008 08:41:29 -0500
Received: by pastel.home (Postfix, from userid 20848)
	id 2E1758568; Thu,  7 Feb 2008 08:41:29 -0500 (EST)
In-Reply-To: <7vve51qva3.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 06 Feb 2008 19:51:00 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72945>

>> Whenever I do a git-checkout to switch between branches, I'm
>> disappointed by the absence of a "-v" option which would list the
>> operations performed.
>> 
>> How can I get this information?

> I'd be mightily annoyed with it myself, though, as I switch
> between 'master', 'next', 'pu' and 'maint' pretty often.

Why would such a "-v" option bother you?  Nobody forces you to use it.

> Have something like this in .git/hooks/post-checkout and make it
> executable, perhaps?  Modify the options to suit your taste.

That doesn't really cut it: I'd like to use it in a git frontend.


        Stefan
