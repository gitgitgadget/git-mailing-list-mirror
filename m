From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH 3/3] reset: Print a warning when user uses "git reset"
 during a merge
Date: Sat, 15 Mar 2014 15:23:43 -0400
Message-ID: <5324A8BF.80308@xiplink.com>
References: <1394771872-25940-1-git-send-email-andrew.kw.w@gmail.com>	<1394771872-25940-4-git-send-email-andrew.kw.w@gmail.com>	<5323131C.7070506@xiplink.com>	<CADgNjan9kCTMPczFzO4jQvM63EU4x7KnJKszhno5PjHivE9ENg@mail.gmail.com> <xmqqa9csh54f.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 15 20:32:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOuJU-0004TX-53
	for gcvg-git-2@plane.gmane.org; Sat, 15 Mar 2014 20:32:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753778AbaCOTbj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2014 15:31:39 -0400
Received: from smtp130.ord.emailsrvr.com ([173.203.6.130]:53935 "EHLO
	smtp130.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900AbaCOTbi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2014 15:31:38 -0400
X-Greylist: delayed 473 seconds by postgrey-1.27 at vger.kernel.org; Sat, 15 Mar 2014 15:31:38 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp13.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id A8A1A198645;
	Sat, 15 Mar 2014 15:23:44 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp13.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 4081B198D94;
	Sat, 15 Mar 2014 15:23:44 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <xmqqa9csh54f.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244164>

On 14-03-14 04:55 PM, Junio C Hamano wrote:
>
> So I am OK with "eventually error out by default", but not OK with
> "we know better than the user and will not allow it at all".

Can I interpret that as you being OK with my proposed "Cowardly 
refusing" approach?

		M.
