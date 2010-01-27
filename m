From: Jeff Epler <jepler@unpythonic.net>
Subject: Re: [PATCH] work around an obnoxious bash "safety feature" on
	OpenBSD
Date: Tue, 26 Jan 2010 20:41:48 -0600
Message-ID: <20100127024148.GA18826@unpythonic.net>
References: <7veilcxudx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 03:41:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZxqs-0003Th-5T
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 03:41:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754733Ab0A0Clu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 21:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753831Ab0A0Clu
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 21:41:50 -0500
Received: from dsl.unpythonic.net ([206.222.212.217]:54450 "EHLO
	unpythonic.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751968Ab0A0Clu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 21:41:50 -0500
Received: by unpythonic.net (Postfix, from userid 1000)
	id C0DEF11494E; Tue, 26 Jan 2010 20:41:48 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <7veilcxudx.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138103>

On Tue, Jan 26, 2010 at 04:29:30PM -0800, Junio C Hamano wrote:
>  update_squash_messages () {
> -	if test -f "$SQUASH_MSG"; then
> +	if test -f "$SQUASH_MSG"
> +	then

I don't think this belongs here.

Jeff
