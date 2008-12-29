From: Ted Pavlic <ted@tedpavlic.com>
Subject: -pthread should be removed on MacOS builds?
Date: Mon, 29 Dec 2008 12:46:50 -0500
Message-ID: <49590D0A.4050508@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 29 18:57:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHMMp-0002NU-DV
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 18:57:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbYL2R4K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 12:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbYL2R4I
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 12:56:08 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:46933 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751135AbYL2R4I (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Dec 2008 12:56:08 -0500
X-Greylist: delayed 552 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Dec 2008 12:56:08 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id CB6F680D8022
	for <git@vger.kernel.org>; Mon, 29 Dec 2008 12:41:33 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1fWEaHMpVNsB for <git@vger.kernel.org>;
	Mon, 29 Dec 2008 12:41:33 -0500 (EST)
Received: from tedbook.mshome.net (tedpc.ece.ohio-state.edu [164.107.166.97])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id B787680D8002
	for <git@vger.kernel.org>; Mon, 29 Dec 2008 12:41:33 -0500 (EST)
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104119>

I notice that every time I build git on my OS X 10.4.11 (PowerBook G4) 
system, I get a bunch of:

powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'

Doing a little search, I see:

http://lists.apple.com/archives/Unix-porting/2005/Mar/msg00019.html

====
The C library on Mac OS X is always thread safe (well the ones which
can be thread safe and are defined to be thread safe by the POSIX 
standard) and always include the pthread library.
====

So I get the feeling that -pthread can be removed from the MacOS build 
line without any impact (except for removing those warnings).

Just something cosmetic.

-- 
Ted Pavlic <ted@tedpavlic.com>
