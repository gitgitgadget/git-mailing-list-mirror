From: Greg Price <price@MIT.EDU>
Subject: Re: Fwd: [PATCH 0/6] rebase: command "ref" and options
	--rewrite-{refs,heads,tags}
Date: Wed, 3 Aug 2011 18:31:11 -0400
Message-ID: <20110803223110.GJ16707@dr-wily.mit.edu>
References: <cover.1309133817.git.greg@quora.com> <BANLkTinDFYsw7-N=_Ex8i42So_0LzVAWvA@mail.gmail.com> <7vhb7bxgt9.fsf@alter.siamese.dyndns.org> <20110628104758.GS5771@dr-wily.mit.edu> <CAGdFq_jLv810a1H=+M14hEho9B_BS4OhdVUz1S-jjMBi6PP28g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 04 00:31:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QojyA-0005bC-Uh
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 00:31:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755615Ab1HCWbP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 18:31:15 -0400
Received: from DMZ-MAILSEC-SCANNER-4.MIT.EDU ([18.9.25.15]:58648 "EHLO
	dmz-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754817Ab1HCWbN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2011 18:31:13 -0400
X-AuditID: 1209190f-b7b44ae000000a24-1d-4e39cb99eb6c
Received: from mailhub-auth-1.mit.edu ( [18.9.21.35])
	by dmz-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 6C.AD.02596.99BC93E4; Wed,  3 Aug 2011 18:28:41 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-1.mit.edu (8.13.8/8.9.2) with ESMTP id p73MVCrE013104;
	Wed, 3 Aug 2011 18:31:12 -0400
Received: from localhost (DR-WILY.MIT.EDU [18.181.0.233])
	(authenticated bits=0)
        (User authenticated as price@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id p73MVBIW026638;
	Wed, 3 Aug 2011 18:31:11 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CAGdFq_jLv810a1H=+M14hEho9B_BS4OhdVUz1S-jjMBi6PP28g@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRmVeSWpSXmKPExsUixCmqrDvztKWfQddvHYuuK91MFg29V5gt
	5t84y+jA7LFz1l12j4uXlD0+b5ILYI7isklJzcksSy3St0vgyri0ZjNbwR7Wirdf7jM3MG5n
	6WJk55AQMJHYbNLFyAlkiUlcuLeerYuRi0NIYB+jxIxbvYwQznpGiUNn9rBAOJ8ZJU7dWcsK
	0sIioCJxdtdbFhCbTUBB4sf8dcwgtoiAtsS5H9MYQWxmAWuJZaefgdUIC8RK3HuykAnE5gVa
	/GH/WmaIoX8ZJTYceMkGkRCUODnzCQtEs5bEjX8vgRo4gGxpieX/OEDCnAKBEqsf/QULiwLd
	sGpp5gRGwVlImmchaZ6F0LyAkXkVo2xKbpVubmJmTnFqsm5xcmJeXmqRrolebmaJXmpK6SZG
	cChL8u9g/HZQ6RCjAAejEg+vZIKlnxBrYllxZe4hRkkOJiVR3qaTQCG+pPyUyozE4oz4otKc
	1OJDjBIczEoivPMqgXK8KYmVValF+TApaQ4WJXHecu//vkIC6YklqdmpqQWpRTBZGQ4OJQne
	xcCYFRIsSk1PrUjLzClBSDNxcIIM5wEavgCkhre4IDG3ODMdIn+KUVFKnNcOJCEAksgozYPr
	haWaV4ziQK8I8yaBVPEA0xRc9yugwUxAg/+/twAZXJKIkJJqYPQTStvV9G3L+kMJVow3hGql
	3vRN/5u7+bCJvcH7SRUaMxM3pRTevPc/dos280VjS2l9CRYO5eS5z/Y3eWjaWDemJgVvvLBr
	05XUrw2vp6bYLeh48qC2idfotu19N/04zbbKs9K7xKw+W6YqCD4wbN3FsVJ1vY9+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178640>

On Wed, Aug 03, 2011 at 03:32:41PM +0200, Sverre Rabbelier wrote:
> FWIW, I'm having the exact same need while working on the remote-hg
> series (which depends on my remote-helper follow-up series, which
> depends on fast-export-fixes, which depends on my original
> remote-helper series, which depends on peffs initial patches; luckily
> the latter two have been merged to next :P). I'd really like having
> this available, especially the rebase -i support.

Thanks for the encouragement and the poke.  Work is busy, but I've put
together a new version of the series addressing everyone's comments
from last time.  I'll give it the finishing touches and try to send it
out soon.

Greg
