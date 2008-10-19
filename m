From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH/RFR&A] Do not rename read-only files during a push
Date: Sun, 19 Oct 2008 19:41:46 +0200
Message-ID: <200810191941.46986.johannes.sixt@telecom.at>
References: <7v63np83mw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 20 13:23:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrcJ0-00044V-2T
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 19:43:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535AbYJSRlw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 13:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751548AbYJSRlw
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 13:41:52 -0400
Received: from smtp4.srv.eunet.at ([193.154.160.226]:40082 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751533AbYJSRlv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2008 13:41:51 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 7DD2797259;
	Sun, 19 Oct 2008 19:41:48 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 5BF7C11807;
	Sun, 19 Oct 2008 19:41:47 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7v63np83mw.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98655>

On Sonntag, 19. Oktober 2008, Junio C Hamano wrote:
> From: Petr Baudis <pasky@suse.cz>
>
> Win32 does not allow renaming read-only files (at least on a Samba
> share), making push into a local directory to fail. Thus, defer
> the chmod() call in index-pack.c:final() only after
> move_temp_to_file() was called.

Concerning the Win32 aspect of this patch:

Acked-by: Johannes Sixt <johannes.sixt@telecom.at>

-- Hannes
