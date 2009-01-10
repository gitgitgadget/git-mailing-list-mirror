From: Henk <henk_westhuis@hotmail.com>
Subject: SSH_ASKPASS
Date: Sat, 10 Jan 2009 02:55:34 -0800 (PST)
Message-ID: <1231584934701-2137400.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 10 11:57:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLbWV-0000Uq-PT
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 11:57:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbZAJKzg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 05:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbZAJKzg
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 05:55:36 -0500
Received: from kuber.nabble.com ([216.139.236.158]:48731 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027AbZAJKzf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 05:55:35 -0500
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1LLbV8-0001nl-Mu
	for git@vger.kernel.org; Sat, 10 Jan 2009 02:55:34 -0800
X-Nabble-From: henk_westhuis@hotmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105090>


Hi,

I'm trying to get "git push" to use git-gui--askpass to ask me for the
password instead of promting me on the command promt. I need this because I
start the "git push" command from code and there is no terminal where ssh
can ask the user for a password. I tried writing the following tcl script
that allmost is what I need:

set env(SSH_ASKPASS) "C:/Program
Files/Git/libexec/git-core/git-gui--askpass"
exec ssh git@github.com

Ssh will now ask me for the password using git-gui--askpass. But now the
standardout is also shown in a dialog, and not on the standardout of the
process. Looking at the git-gui scripts didn't help me, because I have
absolutely zero experience in tcl.

I also tried not using a tcl script, but setting SSH_ASKPASS as an
environment variable in windows. This doesn't seem to work, ssh will still
prompt me for a password. 

Anyone can help me write a script that asks for the password using
SSH_ASKPASS but still prints the output on standardout? 

I use Windows btw.

Henk
-- 
View this message in context: http://n2.nabble.com/SSH_ASKPASS-tp2137400p2137400.html
Sent from the git mailing list archive at Nabble.com.
