From: Junio C Hamano <gitster@pobox.com>
Subject: A good time to pull from your gitk tree?
Date: Mon, 23 Mar 2015 12:03:37 -0700
Message-ID: <xmqqegofa646.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Mar 23 20:03:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ya7da-00050G-FE
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 20:03:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752630AbbCWTDk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2015 15:03:40 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65464 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752120AbbCWTDk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2015 15:03:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5FDF43BDEA;
	Mon, 23 Mar 2015 15:03:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=6
	WMxcu40Xk8WIPothB2O3yhNFMk=; b=yZWsj+CdL+91oGUeXLCaQ71DRcYfx8jPs
	hLUF4/n/ZDA8zo+1uckt744mqvdd/09WNaUbr63DyBqOFF4Eqw1bcpIfCMKY5j/5
	UdsCpSpp7r88MjWcku850j9KrsnZKbKG6OkUJj8DXrOIvtttHs0oAVf6TZPygq7c
	JOK2MjWYZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=vlHbqeVtLD+xWm2/5YFetjFw8J9dlYuq9lCdYpMeW68LPTEZ4fJoupFP
	ZBuuFxMDaE77djtkytFevEuJi1RZyqeEOlhHBtHRgDTDbjaMSa971cv+/CXm70or
	wG94s8nkYCVv/H7gDDt1ckdUJ2GSmxSvDkidxo0FXtWL3QMBork=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 57E4A3BDE8;
	Mon, 23 Mar 2015 15:03:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A9A983BDE6;
	Mon, 23 Mar 2015 15:03:38 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5061EADA-D18F-11E4-8767-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266157>

I see you queued several patches and pushed out the following on the
'master' branch in your git://ozlabs.org/~paulus/gitk.git repository:

    c846920 gitk: Update .po files
    f7fa39b gitk: l10n: Add Catalan translation
    66e3f01 gitk: Fix typo in Russian translation
    8a1692f gitk: Remove tcl-format flag from a message that shouldn't have it
    ce232c3 gitk: Pass --invert-grep option down to "git log"
    eaf7e83 gitk: Synchronize config file writes
    1dd2960 gitk: Report errors in saving config file
    995f792 gitk: Only write changed configuration variables
    122b807 gitk: Enable mouse horizontal scrolling in diff pane
    e203d1d gitk: Default wrcomcmd to use --pretty=email

Is it a good time for me to pull from you, or do you recommend me to
wait for a bit, expecting more?  We'll go in the pre-release freeze
soon-ish, so I thought I should ping.

Thanks.
