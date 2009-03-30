From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH 6/8] sh-tools: add a run_merge_tool function
Date: Mon, 30 Mar 2009 09:32:29 +0200
Message-ID: <200903300932.29870.markus.heidelberg@web.de>
References: <1238389428-69328-1-git-send-email-davvid@gmail.com> <1238389428-69328-6-git-send-email-davvid@gmail.com> <1238389428-69328-7-git-send-email-davvid@gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 09:34:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoC0P-0000Iq-Lf
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 09:34:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216AbZC3Hcb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 03:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbZC3Hcb
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 03:32:31 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:50985 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813AbZC3Hca (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 03:32:30 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id 89AB5FF260B5;
	Mon, 30 Mar 2009 09:32:28 +0200 (CEST)
Received: from [89.59.73.72] (helo=.)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LoByu-0001Xq-00; Mon, 30 Mar 2009 09:32:28 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <1238389428-69328-7-git-send-email-davvid@gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+DPLH2EnfVL2TCxQM3rq6SfNI5NLoh37niCUis
	SKztI7z1uUrqsmp+uKlh4Dmz0dPmtbhqLbadmFkOYBtrLPpY6r
	ha1lOPDHQWSpJ3qUxq4Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115096>

David Aguilar, 30.03.2009:
> +# Runs a side-by-side merge tool
> +run_merge_tool()
> +{
> +	merge_tool="$1"
> +
> +	# base_present is always false when !mergetool_mode
> +	case "$merge_tool" in
> +	kdiff3)
> [...]

Kompare is missing here. Note, that this is only diff tool, not for
merges.

Markus
