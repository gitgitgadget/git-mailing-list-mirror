From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: format-patch on permission change gives empty patch
Date: Thu, 07 Oct 2010 15:06:05 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010071503210.3107@xanadu.home>
References: <20101006.173714.245380201.davem@davemloft.net>
 <20101006.174008.70175671.davem@davemloft.net>
 <7vtykyy70w.fsf@alter.siamese.dyndns.org>
 <7vocb6y5sq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, David Miller <davem@davemloft.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 21:06:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3vnD-00043D-Rj
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 21:06:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751809Ab0JGTGJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 15:06:09 -0400
Received: from relais.videotron.ca ([24.201.245.36]:35973 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352Ab0JGTGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 15:06:09 -0400
Received: from xanadu.home ([66.130.28.92]) by vl-mh-mrz21.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L9X00KWIP1YMYE0@vl-mh-mrz21.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 07 Oct 2010 15:05:58 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vocb6y5sq.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158433>

On Wed, 6 Oct 2010, Junio C Hamano wrote:

> I have a mixed feeling about where to go next.
> 
>  (1) Treat "rebase" as a way to reproduce a reasonable history; the
>      current behaviour to drop empty commits is consistent with this view,
>      as a history with an empty commit is _not_ entirely reasonable.

But a file mode change isn't exactly an empty commit, no?


Nicolas
