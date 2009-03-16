From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: [PATCH v2] New config push.default to decide default behavior
	for push
Date: Mon, 16 Mar 2009 16:56:29 +0100
Message-ID: <20090316155629.GA17526@pvv.org>
References: <20090311220144.GA6782@pvv.org> <7vwsavlg6q.fsf@gitster.siamese.dyndns.org> <20090312115433.GA2848@pvv.org> <7viqmbakmt.fsf@gitster.siamese.dyndns.org> <7viqmayslg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 16:58:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjFCT-0006Hr-UV
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 16:58:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753982AbZCPP4d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 11:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753342AbZCPP4d
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 11:56:33 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:44240 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239AbZCPP4c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 11:56:32 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1LjFAz-00084S-Bh; Mon, 16 Mar 2009 16:56:29 +0100
Content-Disposition: inline
In-Reply-To: <7viqmayslg.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113339>

On Sun, Mar 15, 2009 at 09:55:23PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> As some people still seem to object to the change of default (and that
> includes 20-30% of myself), we may end up deciding not to switch the
> default after all, but even in that case, applying the first half would
> benefit people who would want different behaviour.

I think the suggested new default is a lot safer then the current
one. A default of "nothing" will print a nice message if you end up
pushing nothing, which you will fix in a heartbeat with a single git
config command.

If you erroneously push one or more branches however, cleanup might
end up being very complicated. Many pushable repos are set up with
disallowing non-fast-forward pushes, so it may require intervention by
someone else to clean up, and by then someone else have already
fetched the bad push.

- Finn Arne
