From: "Jan Hudec" <bulb@ucw.cz>
Subject: Ad: fast-import problem importing dos format files under cygwin
Date: Wed, 3 Dec 2008 10:10:17 +0100 (CET)
Message-ID: <43270.194.138.12.144.1228295417.squirrel@artax.karlin.mff.cuni.cz>
References: <43827.194.138.12.144.1228290700.squirrel@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 03 10:11:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7nln-00010g-Jz
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 10:11:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbYLCJKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 04:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbYLCJKT
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 04:10:19 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.26.195]:39579 "EHLO
	artax.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957AbYLCJKS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 04:10:18 -0500
Received: from artax.karlin.mff.cuni.cz (localhost [127.0.0.1])
	by artax.karlin.mff.cuni.cz (Postfix) with ESMTP id 538929803C
	for <git@vger.kernel.org>; Wed,  3 Dec 2008 10:10:17 +0100 (CET)
Received: from 194.138.12.144
        (SquirrelMail authenticated user jhud7196)
        by artax.karlin.mff.cuni.cz with HTTP;
        Wed, 3 Dec 2008 10:10:17 +0100 (CET)
In-Reply-To: <43827.194.138.12.144.1228290700.squirrel@artax.karlin.mff.cuni.cz>
User-Agent: SquirrelMail/1.4.9a
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102231>

On 3 December 2008, 08:51, Jan Hudec wrote:
> Hello folks,
>
> I have been playing with fast-import in cygwin and I have problems
> importing files with CR/LF line-endings. The size in data command is
> calculated including the CRs and than the file is copied binary to the
> fast-import input stream. However fast-import skips the CRs when reading,
> overreads by that number of bytes and fails when it tries to read the
> next command from the middle.

One addition:

I have tried with MSYS version 1.5.6.1.1071.g76fb and it imported the
test, as it was, except it didn't like 'refs/heads/master' as branchname
(and accepted bare 'master', but that created '.git/master').

-- 
                                        - Jan Hudec <bulb@ucw.cz>
