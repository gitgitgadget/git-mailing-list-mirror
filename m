From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Subject: Re: Libification project (SoC)
Date: Fri, 16 Mar 2007 10:47:15 -0300
Organization: Mandriva
Message-ID: <20070316104715.483df0d5@localhost>
References: <20070316042406.7e750ed0@home.brethil>
	<20070316045928.GB31606@spearce.org>
	<7vejnpycu1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Mar 16 14:47:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSCmL-00041Y-Rx
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 14:47:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933636AbXCPNrb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 09:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933643AbXCPNrb
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 09:47:31 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:56044 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933636AbXCPNra (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 09:47:30 -0400
Received: from localhost (localhost [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 4CFAE2AE81;
	Fri, 16 Mar 2007 10:47:28 -0300 (BRT)
X-Virus-Scanned: amavisd-new at conectiva.com.br
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id mCnjlcNCxw4h; Fri, 16 Mar 2007 10:47:18 -0300 (BRT)
Received: from localhost (doriath.conectiva [10.0.2.48])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 54BF32AE78;
	Fri, 16 Mar 2007 10:47:18 -0300 (BRT)
In-Reply-To: <7vejnpycu1.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.3; i586-mandriva-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42360>

Em Thu, 15 Mar 2007 22:30:46 -0700
Junio C Hamano <junkio@cox.net> escreveu:

| "Shawn O. Pearce" <spearce@spearce.org> writes:
| 
| >>     o Documentation (eg, doxygen)
| >>     o Unit-tests
| >>     o Add prefix (eg, git_*) to public API functions
| >
| > Yes.  But which functions shall we expose?  ;-)
| 
| Before going into that topic, a bigger question is if we are
| happy with the current internal API and what the goal of
| libification is.  If the libification is going to say that "this
| is a published API so we are not going to change it", I would
| imagine that it would be very hard to accept in the mainline.

 I think you can put this way: do you want/whish to make
git more useful than it's today?

 If so, such a library is important because it will allow
users to write application that use git in a reasonable
way.

 It doesn't need to be the next five-zilion-function-library
that will provide the wonders of git in several different
ways.

 We could start by fixing the got-an-error-die behaivor and
define a _experimental_ API (just a few functions) just to get
data out of git.

 This would be enough to write the Perl binding I think?

-- 
Luiz Fernando N. Capitulino
