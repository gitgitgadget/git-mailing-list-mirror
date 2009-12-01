From: Thomas Singer <thomas.singer@syntevo.com>
Subject: Re: non-US-ASCII file names (e.g. Hiragana) on Windows
Date: Tue, 01 Dec 2009 19:55:06 +0100
Message-ID: <4B15668A.5050209@syntevo.com>
References: <4B1168D4.5010902@syntevo.com> <4B11AD43.3070307@gmail.com>	<4B123C80.30607@syntevo.com> <4B14CA79.6040408@syntevo.com>	<4B14D381.3010706@viscovery.net> <4B14DA1A.4060505@syntevo.com>	<4B14E934.9090304@viscovery.net> <4B150747.2030900@syntevo.com> <m3k4x6na81.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 01 19:54:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFXrv-0002Ev-PF
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 19:54:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752932AbZLASyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 13:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751870AbZLASyX
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 13:54:23 -0500
Received: from syntevo.com ([85.214.39.145]:51486 "EHLO syntevo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751792AbZLASyX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 13:54:23 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1]) with ESMTP id 80DA737C7B0
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <m3k4x6na81.fsf@localhost.localdomain>
X-Enigmail-Version: 0.96.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134247>

Jakub Narebski wrote:
> If you use Git from Java, why don't you just use JGit (www.jgit.org),
> which is Git implementation in Java?

We are using JGit for the read-only stuff and the Git command line
executable for all writing commands. We very much appreciate Shawn O.
Pearce' (and the other JGit developers') effort, but Git is a fast moving
target and (much) more complex than CVS or SVN, for which we use Java
libraries communicating with the corresponding server which adds another
sanity layer to the repository making repository corruption less likely than
direct access.

-- 
Best regards,
Thomas Singer
=============
syntevo GmbH
http://www.syntevo.com
http://blog.syntevo.com
