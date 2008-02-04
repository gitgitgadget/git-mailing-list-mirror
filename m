From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH 4/4] git-submodule: prepare for the .git-file
Date: Mon, 4 Feb 2008 23:23:04 +0100
Organization: glandium.org
Message-ID: <20080204222304.GA15178@glandium.org>
References: <1202158761-31211-1-git-send-email-hjemli@gmail.com> <1202158761-31211-2-git-send-email-hjemli@gmail.com> <1202158761-31211-3-git-send-email-hjemli@gmail.com> <1202158761-31211-4-git-send-email-hjemli@gmail.com> <1202158761-31211-5-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 23:24:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM9jL-0003Io-MH
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 23:24:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754767AbYBDWX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 17:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754583AbYBDWX0
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 17:23:26 -0500
Received: from vuizook.err.no ([85.19.215.103]:56443 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752780AbYBDWX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 17:23:26 -0500
Received: from aputeaux-153-1-42-109.w82-124.abo.wanadoo.fr ([82.124.6.109] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JM9jN-0002C7-Kn; Mon, 04 Feb 2008 23:24:07 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JM9iS-000412-3x; Mon, 04 Feb 2008 23:23:04 +0100
Content-Disposition: inline
In-Reply-To: <1202158761-31211-5-git-send-email-hjemli@gmail.com>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 2.2): No, score=2.2 required=5.0 tests=RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72581>

On Mon, Feb 04, 2008 at 09:59:21PM +0100, Lars Hjemli wrote:
> -		if ! test -d "$path"/.git
> +		if ! test -e "$path"/.git

Is test -e supported by all shells we support ? I have some doubts...

Mike
