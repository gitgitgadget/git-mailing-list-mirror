From: Adam Majer <adamm@zombino.com>
Subject: Re: git and appending merge commits
Date: Mon, 26 May 2008 01:39:30 -0500
Message-ID: <483A5B22.3070809@zombino.com>
References: <483A300E.6090104@zombino.com> <7vej7pek3z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 26 08:40:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0WNT-0006uz-Nc
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 08:40:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752490AbYEZGjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 02:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752403AbYEZGjZ
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 02:39:25 -0400
Received: from polaris.galacticasoftware.com ([216.55.199.131]:38355 "EHLO
	polaris.galacticasoftware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751506AbYEZGjY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 May 2008 02:39:24 -0400
Received: from mira.lan.galacticasoftware.com ([192.168.53.2])
	by polaris.galacticasoftware.com with esmtp (Exim 4.63)
	(envelope-from <adamm@zombino.com>)
	id 1K0WMc-00019b-TC
	for git@vger.kernel.org; Mon, 26 May 2008 01:39:22 -0500
User-Agent: Mozilla-Thunderbird 2.0.0.14 (X11/20080509)
In-Reply-To: <7vej7pek3z.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82905>

Junio C Hamano wrote:
> In a combined diff, unlike the single column to show "+/-/ " at the
> beginning for one-parent diff, each parent gets one column.  And in a
> condensed combined diff, a hunk whose result is inherited solely from one
> parent (iow, a trivial conflict resolution) is removed from the output, so
> that only a non-trivial conflict resolution that leaves result that is
> different from all parents are shown.

Thank you Junio and Shawn for the very clear explanation! Now it makes
very good sense why the patch looks so "weird" :) For cases where both
branches touch the same file and there is a conflict, this would be very
useful indeed.

Cheers,
Adam
