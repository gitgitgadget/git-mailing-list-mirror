From: Francis Daly <francis@daoine.org>
Subject: Re: [PATCH] Tweak asciidoc output to work with broken docbook-xsl
Date: Mon, 6 Mar 2006 01:09:07 +0000
Message-ID: <20060306010907.GA22105@craic.sysops.org>
References: <20060305231336.GA21797@craic.sysops.org> <7vr75gcs20.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 06 02:16:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FG4Ka-0000da-TV
	for gcvg-git@gmane.org; Mon, 06 Mar 2006 02:16:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbWCFBQJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 20:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWCFBQJ
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 20:16:09 -0500
Received: from craic.sysops.org ([217.75.2.2]:38286 "EHLO craic.sysops.org")
	by vger.kernel.org with ESMTP id S1751337AbWCFBQI (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Mar 2006 20:16:08 -0500
Received: from craic.sysops.org (craic.sysops.org [127.0.0.1])
	by craic.sysops.org (8.12.11/8.12.11) with SMTP id k261973V022147;
	Mon, 6 Mar 2006 01:09:07 GMT
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vr75gcs20.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
X-Virus-Scanned: ClamAV 0.87.1/1314/Sat Mar  4 13:39:05 2006 on craic.sysops.org
X-Virus-Status: Clean
X-Spam-Status: No, hits=-5.0 required=2.0
	tests=EMAIL_ATTRIBUTION,IN_REP_TO,QUOTED_EMAIL_TEXT,REFERENCES,
	      REPLY_WITH_QUOTES,USER_AGENT_MUTT
	version=2.55
X-Spam-Checker-Version: SpamAssassin 2.55 (1.174.2.19-2003-05-19-exp)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17257>

On Sun, Mar 05, 2006 at 04:53:11PM -0800, Junio C Hamano wrote:
> Francis Daly <francis@daoine.org> writes:

> > asciidoc by default converts "listingblock" to "<screen>". This change
> > causes asciidoc in git to convert "listingblock" to "<literallayout>", which
> > both old and new docbook-xsl handle correctly.
> 
> Have you tested html generation side?  With 1.68 I seem to be
> getting an disaster.

Oh how stupid of me.

Yes, of course you're right.  The backend matters.

Clearly, I don't read the html pages; and no-one (with old stylesheets)
reads the man pages ;-)

Thanks,

	f
-- 
Francis Daly        francis@daoine.org
