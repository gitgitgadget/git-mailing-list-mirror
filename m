From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [RFC PATCH 2/3] filter-branch: optionally load existing mappings prior to filtering
Date: Fri, 31 Dec 2010 18:10:53 +0100
Message-ID: <201012311810.53586.j6t@kdbg.org>
References: <cover.1293809100.git.trast@student.ethz.ch> <f89203efcf1b2f49fb33097b3e7fc27e070626fb.1293809100.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: jeffrey.freeman@syncleus.com, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Dec 31 18:11:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PYiVJ-0006Cp-TM
	for gcvg-git-2@lo.gmane.org; Fri, 31 Dec 2010 18:11:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753818Ab0LaRK5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Dec 2010 12:10:57 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:13032 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753811Ab0LaRK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Dec 2010 12:10:56 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 2061F10016;
	Fri, 31 Dec 2010 18:10:58 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id A07FA19F69E;
	Fri, 31 Dec 2010 18:10:53 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <f89203efcf1b2f49fb33097b3e7fc27e070626fb.1293809100.git.trast@student.ethz.ch>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164391>

On Freitag, 31. Dezember 2010, Thomas Rast wrote:
> +	--load-map)
> +		case "$OPTARG" in
> +		/*)

Please use is_absolute_path here as well.

-- Hannes
