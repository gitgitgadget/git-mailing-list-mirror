From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 0/5] diff --ignore-case
Date: Mon, 20 Feb 2012 09:41:45 +0100
Message-ID: <4F420749.9010206@kdbg.org>
References: <1329704188-9955-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 20 09:42:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzOos-0006pk-Fy
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 09:42:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752285Ab2BTIlt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 03:41:49 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:3877 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751481Ab2BTIlt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 03:41:49 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id BC720A7F0C;
	Mon, 20 Feb 2012 09:42:28 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 8775619F329;
	Mon, 20 Feb 2012 09:41:45 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.26) Gecko/20120124 SUSE/3.1.18 Thunderbird/3.1.18
In-Reply-To: <1329704188-9955-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191055>

Am 20.02.2012 03:16, schrieb Junio C Hamano:
> This teaches our "diff" machinery to optionally consider lines that are
> different only in upper/lower-cases to be equivalent.

When would I want to use --ignore-case? And how useful is it that it
does not obey the current locale, as in your implementation?

-- Hannes
