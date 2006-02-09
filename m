From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitweb using "--cc"?
Date: Thu, 9 Feb 2006 12:50:56 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602091246010.2458@g5.osdl.org>
References: <Pine.LNX.4.64.0602081532360.2458@g5.osdl.org> <43EAA560.8030504@didntduck.org>
 <Pine.LNX.4.64.0602081817040.2458@g5.osdl.org> <7vu0b9jkad.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0602090822100.2458@g5.osdl.org> <Pine.LNX.4.64.0602091029310.2458@g5.osdl.org>
 <7v3bisb9qn.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0602091216460.2458@g5.osdl.org>
 <7vd5hw9sk1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 21:51:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7Ikv-00029R-Vp
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 21:51:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWBIUvG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 15:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbWBIUvF
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 15:51:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:29676 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750780AbWBIUvE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Feb 2006 15:51:04 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k19Kp1DZ019912
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 9 Feb 2006 12:51:01 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k19KouHS012020;
	Thu, 9 Feb 2006 12:50:58 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5hw9sk1.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15827>



On Thu, 9 Feb 2006, Junio C Hamano wrote:
> 
> Actually, I've known about the removals and have excuse in one
> of the commits why it does not show them.
> 
> It is an excuse (the internal data structure is not really
> suited to show removal diff), but I think what the excuse gives
> as the official reasoning behind it sort of make sense from
> usability point of view as well.

Fair enough. It looks a bit strange in gitk, but maybe that could be 
rectified by just making the new/deleted file case say so explcitly 
instead of having the "mode" line.

So instead of just "mode", how about saying "deleted file mode" or 
"new file mode" the way that the regular diffs do (but then not showing 
the contents for the deleted case).

		Linus
