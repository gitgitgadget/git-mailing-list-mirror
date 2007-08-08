From: Gerrit Pape <pape@smarden.org>
Subject: Re: [PATCH 1/2] merge-recursive: sometimes, d/f conflict is not an issue
Date: Wed, 8 Aug 2007 14:39:43 +0000
Message-ID: <20070808143943.12061.qmail@de98ec6b1268cc.315fe32.mid.smarden.org>
References: <Pine.LNX.4.64.0706131543140.4059@racer.site> <20070625071819.8091.qmail@5e4088a43a10fd.315fe32.mid.smarden.org> <Pine.LNX.4.64.0707080148370.4093@racer.site> <7vabu765r0.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707080248320.4093@racer.site> <7v644v5tr3.fsf@assigned-by-dhcp.cox.net> <7vwsxb4e2q.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707081353560.4248@racer.site> <7v8x9q1x5t.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707171812490.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 08 16:42:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IImjy-0000No-8X
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 16:42:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756948AbXHHOll (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 10:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754271AbXHHOll
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 10:41:41 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:50838 "HELO a.mx.smarden.org"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with SMTP
	id S1756948AbXHHOlk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 10:41:40 -0400
Received: (qmail 12062 invoked by uid 1000); 8 Aug 2007 14:39:43 -0000
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707171812490.14781@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55321>

On Tue, Jul 17, 2007 at 06:13:12PM +0100, Johannes Schindelin wrote:
> When a merge has a d/f conflict on a path which was not touched
> between the merge base(s) and the remote HEAD, and the index and
> HEAD contain the same version for that path (even if empty), it
> is not really a conflict.

Hi, this patch solves the reported problem fine, and it didn't break
anything for me yet.  Can this still be considered for 1.5.3?

Thanks, Gerrit.
