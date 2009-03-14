From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-push.txt: describe how to default to pushing only
	current branch
Date: Sat, 14 Mar 2009 16:56:28 -0400
Message-ID: <20090314205628.GA17445@coredump.intra.peff.net>
References: <20090313164941.GA16504@sigill.intra.peff.net> <1236994051-27346-1-git-send-email-chris_johnsen@pobox.com> <7vd4cjc3da.fsf@gitster.siamese.dyndns.org> <20090313164941.GA16504@sigill.intra.peff.net> <1236994051-27346-1-git-send-email-chris_johnsen@pobox.com> <20090314203434.GA15444@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Chris Johnsen <chris_johnsen@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 14 21:58:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Liavj-0002Nv-05
	for gcvg-git-2@gmane.org; Sat, 14 Mar 2009 21:58:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755533AbZCNU4c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2009 16:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754878AbZCNU4c
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Mar 2009 16:56:32 -0400
Received: from peff.net ([208.65.91.99]:46708 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754642AbZCNU4b (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2009 16:56:31 -0400
Received: (qmail 14936 invoked by uid 107); 14 Mar 2009 20:56:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 14 Mar 2009 16:56:37 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 14 Mar 2009 16:56:28 -0400
Content-Disposition: inline
In-Reply-To: <20090314203434.GA15444@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113264>

On Sat, Mar 14, 2009 at 04:34:34PM -0400, Jeff King wrote:

> The question is how it _should_ be rendered. Monospace isn't really
> useful for terminals. Maybe simply putting quotation marks around it
> would cover all situations (I'm worried it will look funny for
> single-word instances).

And here's a patch that does that; skimming through the output it
doesn't look too bad. What do you guys think?

---
diff --git a/Documentation/callouts.xsl b/Documentation/callouts.xsl
index 6a361a2..01df100 100644
--- a/Documentation/callouts.xsl
+++ b/Documentation/callouts.xsl
@@ -27,4 +27,6 @@
   </xsl:if>
 </xsl:template>
 
+<xsl:template match="literal">"<xsl:apply-templates/>"</xsl:template>
+
 </xsl:stylesheet>
