From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH v3 2/2] Move git-dir for submodules
Date: Mon, 15 Aug 2011 10:30:19 -0400
Message-ID: <4E492D7B.50508@xiplink.com>
References: <1313178913-25617-1-git-send-email-iveqy@iveqy.com> <1313178913-25617-3-git-send-email-iveqy@iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jens.lehmann@web.de, hvoigt@hvoigt.net,
	gitster@pobox.com
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Mon Aug 15 16:30:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsyBi-0003GV-2n
	for gcvg-git-2@lo.gmane.org; Mon, 15 Aug 2011 16:30:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753963Ab1HOOaj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Aug 2011 10:30:39 -0400
Received: from smtp152.iad.emailsrvr.com ([207.97.245.152]:38500 "EHLO
	smtp152.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753562Ab1HOOaj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2011 10:30:39 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp55.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 29A9B2E0351;
	Mon, 15 Aug 2011 10:30:37 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp55.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id D6E8B2E036C;
	Mon, 15 Aug 2011 10:30:36 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.18) Gecko/20110617 Thunderbird/3.1.11
In-Reply-To: <1313178913-25617-3-git-send-email-iveqy@iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179366>

On 11-08-12 03:55 PM, Fredrik Gustafsson wrote:
> 
> This patch will not affect already cloned submodules at all.

My question is perhaps a bit beyond the scope of this series...

Is there going to be a way to migrate submodules to the new layout?  If the
eventual goal is to be able to delete & restore submodule working
directories, it would be nice if that could work with submodules cloned by an
older git.

		M.
