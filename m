From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH 6/8] sh-tools: add a run_merge_tool function
Date: Mon, 30 Mar 2009 08:55:09 +0200
Message-ID: <200903300855.09353.markus.heidelberg@web.de>
References: <1238389428-69328-1-git-send-email-davvid@gmail.com> <1238389428-69328-6-git-send-email-davvid@gmail.com> <1238389428-69328-7-git-send-email-davvid@gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 08:56:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoBQI-0000E8-O8
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 08:56:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754758AbZC3GzL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 02:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752083AbZC3GzL
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 02:55:11 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:51319 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204AbZC3GzK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 02:55:10 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id E0C05FC3DA52;
	Mon, 30 Mar 2009 08:55:07 +0200 (CEST)
Received: from [89.59.73.72] (helo=.)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LoBOl-0001hh-00; Mon, 30 Mar 2009 08:55:07 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <1238389428-69328-7-git-send-email-davvid@gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19bWhAmGWqwt0ki9e/ROkAn4PbUga0ERsNnZXDO
	GPe/ODNQt9xQ0FmLtQfifFzvJ27ASLbAAtlKBBQ6c86qO2mgnw
	YYkrE7R8DO6llq0gMpSQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115091>

David Aguilar, 30.03.2009:
> +		if mergetool_mode; then
> +			base=Baes

Base

> +			local=Local
> +			remote=Remote
> +		else
