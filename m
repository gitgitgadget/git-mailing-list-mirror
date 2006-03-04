From: Francis Daly <francis@daoine.org>
Subject: Re: [PATCH] AsciiDoc fix for tutorial
Date: Sat, 4 Mar 2006 23:07:26 +0000
Message-ID: <20060304230726.GA13159@craic.sysops.org>
References: <20060304163527.GA12015@craic.sysops.org> <7v4q2dri8c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 05 00:15:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFfxw-0002ST-MT
	for gcvg-git@gmane.org; Sun, 05 Mar 2006 00:15:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751760AbWCDXOZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Mar 2006 18:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751770AbWCDXOY
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Mar 2006 18:14:24 -0500
Received: from craic.sysops.org ([217.75.2.2]:29578 "EHLO craic.sysops.org")
	by vger.kernel.org with ESMTP id S1751760AbWCDXOY (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Mar 2006 18:14:24 -0500
Received: from craic.sysops.org (craic.sysops.org [127.0.0.1])
	by craic.sysops.org (8.12.11/8.12.11) with SMTP id k24N7QAJ013185;
	Sat, 4 Mar 2006 23:07:27 GMT
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v4q2dri8c.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
X-Virus-Scanned: ClamAV 0.87.1/1313/Fri Mar  3 16:19:06 2006 on craic.sysops.org
X-Virus-Status: Clean
X-Spam-Status: No, hits=-5.0 required=2.0
	tests=EMAIL_ATTRIBUTION,IN_REP_TO,QUOTED_EMAIL_TEXT,REFERENCES,
	      REPLY_WITH_QUOTES,USER_AGENT_MUTT
	version=2.55
X-Spam-Checker-Version: SpamAssassin 2.55 (1.174.2.19-2003-05-19-exp)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17197>

On Sat, Mar 04, 2006 at 01:51:47PM -0800, Junio C Hamano wrote:
> Francis Daly <francis@daoine.org> writes:
> 
> >  shows the difference between that previous state and the state two
> > -commits ago.  Also, HEAD~5 can be used as a shorthand for HEAD^^^^^,
> > +commits ago.  Also, HEAD~5 can be used as a shorthand for HEAD{caret}{caret}{caret}^^,
> 
> Thanks.  Why not 5 {caret}, not just three {caret} plus ^^?

No real reason; the asciidoc parser accepts two together so I left them
there.  Anyone reading a transformed version should see the real ^s,
so the question is whether it's clearer for someone reading the .txt
file to see a mixture with a passing resemblance to a few lines earlier,
or just to see {caret} consistently.

5 {caret} is fine by me.

For more consistency, there are three other ^s in the file could which
could also be changed, but none of them cause breakage now.

	f
-- 
Francis Daly        francis@daoine.org
