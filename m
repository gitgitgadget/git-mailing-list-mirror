From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Apply patch on server w/o git
Date: Tue, 25 Mar 2008 20:46:31 +0100
Message-ID: <20080325194631.GD4857@efreet.light.src>
References: <CA08AA77-A9EA-4490-B1BE-25E8B7402290@faithfulgeek.org> <3e8340490803251141x6d199d8ch8828b396da202d81@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joe Fiorini <joe@faithfulgeek.org>, git@vger.kernel.org
To: Bryan Donlan <bdonlan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 20:47:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeF7C-0002Ju-D0
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 20:47:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752214AbYCYTql (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 15:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752188AbYCYTqk
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 15:46:40 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:54074 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752175AbYCYTqk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 15:46:40 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 300E276DBD;
	Tue, 25 Mar 2008 20:46:39 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id z9IPeeRfXb2K; Tue, 25 Mar 2008 20:46:36 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 34DDA76DB2;
	Tue, 25 Mar 2008 20:46:34 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.69)
	(envelope-from <bulb@ucw.cz>)
	id 1JeF6N-0001WG-M7; Tue, 25 Mar 2008 20:46:31 +0100
Content-Disposition: inline
In-Reply-To: <3e8340490803251141x6d199d8ch8828b396da202d81@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78212>

On Tue, Mar 25, 2008 at 14:41:04 -0400, Bryan Donlan wrote:
> Just a guess, but the gnuwin32 tools might not like unix line endings.
> Try opening and re-saving in wordpad (or vim :set ff=dos, or $insert
> your favorite method here).

That won't actually work! The problem is, that:
 - The headers (+++/---/@@ lines) should have dos line endings (but does not
   matter too much).
 - The bodies must have the same line endings the actual code does.

Question is, what the code has (it could have been transfered by some method
that converted the line-endings or something).

Also trying to patch with ignoring whitespace could work (I believe I did
that the other way 'round -- applying windowsy newline-damaged patch on
unix). And if it does not, it's not the newlines problem.

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
