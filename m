From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 29 Jun 2008 22:15:00 +0200
Message-ID: <A87D312D-8B65-4D57-84AC-8FC07A27B937@ai.rug.nl>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org> <7vwsnjl21c.fsf@gitster.siamese.dyndns.org> <7vhcehzdeg.fsf@gitster.siamese.dyndns.org> <7vbq4j748l.fsf@gitster.siamese.dyndns.org> <7vr6d8apjx.fsf@gitster.siamese.dyndns.org> <7vhcdyfe9u.fsf@gitster.siamese.dyndns.org> <7vabjm1a0q.fsf@gitster.siamese.dyndns.org> <7vr6crj0jk.fsf@gitster.siamese.dyndns.org> <7vmyn4hr8f.fsf@gitster.siamese.dyndns.org> <7vmymsjz6x.fsf@gitster.siamese.dyndns.org> <7vabijxhk4.fsf@gitster.siamese.dyndns.org> <7vwslhg8qe.fsf@gitster.siamese.dyndns.org> <7vhccfiksy.fsf@gitster.siamese.dyndns.org> <7vod6k6zg4.fsf@gitster.siamese.dyndns.org> <7v4p7xwsfp.fsf@gitster.siamese.dyndns.org> <7v3anb19n7.fsf@gitster.siamese.dyndns.org> <7vwskjazql.fsf@gitster.siamese.dyndns.org> <7vk5ggipuw.fsf@gitster.siamese.dyndns.o
 rg> <7vej6l3lp7.fsf@gitster.siamese.dyndns.org> <7vod5kd3im.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.10.0806291127140.21402@hp.linux-foundation.org> <7vk5g89f34.fsf@gitster.siamese.dynd
 ns.org>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailinglist <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 22:16:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KD3Ja-0007wu-08
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 22:16:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758159AbYF2UPE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 16:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756023AbYF2UPE
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 16:15:04 -0400
Received: from smtp-3.orange.nl ([193.252.22.243]:43330 "EHLO smtp-3.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754706AbYF2UPC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 16:15:02 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6203.online.nl (SMTP Server) with ESMTP id 8FF161C0008E;
	Sun, 29 Jun 2008 22:15:01 +0200 (CEST)
Received: from [192.168.1.11] (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6203.online.nl (SMTP Server) with ESMTP id 290C11C00088;
	Sun, 29 Jun 2008 22:15:01 +0200 (CEST)
X-ME-UUID: 20080629201501168.290C11C00088@mwinf6203.online.nl
In-Reply-To: <7vk5g89f34.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86825>


On 29 jun 2008, at 22:11, Junio C Hamano wrote:

> use of them from your scripts after adding
>   output from "git --exec-path" to the $PATH will still be supported  
> in
>   1.6.0, but users are again strongly encouraged to adjust their
>   scripts to use "git xyzzy" form, as we will stop installing
>   "git-xyzzy" hardlinks for built-in commands in later releases.

I think msysgit doesn't (didn't?) install the hardlinks to conserve  
space,
as Windows doesn't support hard links. Perhaps we should mention that
as well?

- Pieter
