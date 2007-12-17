From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 2/2] builtin-commit: make summary output consistent with
 status
Date: Sun, 16 Dec 2007 22:42:30 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0712162241330.5349@iabervon.org>
References: <Pine.LNX.4.64.0712151507420.5349@iabervon.org>
 <7vwsregrom.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 04:43:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J46sl-0007Ro-OE
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 04:43:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760563AbXLQDmn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2007 22:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760062AbXLQDmn
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 22:42:43 -0500
Received: from iabervon.org ([66.92.72.58]:38466 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754819AbXLQDmm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 22:42:42 -0500
Received: (qmail 2063 invoked by uid 1000); 17 Dec 2007 03:42:30 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Dec 2007 03:42:30 -0000
In-Reply-To: <7vwsregrom.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68506>

On Sun, 16 Dec 2007, Junio C Hamano wrote:

>  * And this fixes the "7 files" because print_summary() does not pass -B
>    -M which makes it inconsistent with the status output.  After this
>    you should see "6 files".

Yup, it now looks like what I thought that commit consisted of.

	-Daniel
*This .sig left intentionally blank*
