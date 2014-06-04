From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH v2 7/9] fetch doc: remove "short-cut" section
Date: Wed, 04 Jun 2014 10:46:21 -0400
Message-ID: <538F313D.90403@xiplink.com>
References: <1401833792-2486-1-git-send-email-gitster@pobox.com> <1401833792-2486-8-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 16:46:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsCSL-0007lD-SN
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 16:46:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592AbaFDOqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2014 10:46:17 -0400
Received: from smtp138.ord.emailsrvr.com ([173.203.6.138]:38820 "EHLO
	smtp138.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329AbaFDOqQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2014 10:46:16 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp22.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 2325820092C;
	Wed,  4 Jun 2014 10:46:16 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp22.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id E641F2004D0;
	Wed,  4 Jun 2014 10:46:15 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <1401833792-2486-8-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250732>

On 14-06-03 06:16 PM, Junio C Hamano wrote:
> It is misleading to mention that <ref> that does not store is to
> fetch the ref into FETCH_HEAD, because a refspec that does store is
> also to fetch the LHS into FETCH_HEAD.  It is doubly misleading to
> list it as part of "short-cut".  <ref> stands for a refspec that has
> it on the LHS with a colon and an empty RHS, and that definition
> should be given at the beginning of the entry where the format is
> defined.
> 
> Tentatively remove this misleading description, which leaves the
> `tag <tag>` as the only true short-hand, so move it at the beginning
> of the entry.

Well that neatly solves the missing empty line problem...  :)

		M.
