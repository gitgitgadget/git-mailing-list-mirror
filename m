From: roylee17 <roylee17@gmail.com>
Subject: How to to override repository-specific attributes in.git/config?
Date: Fri, 2 Apr 2010 09:30:02 -0800 (PST)
Message-ID: <1270229402991-4843642.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 02 19:30:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nxkh7-00044D-I3
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 19:30:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755919Ab0DBRaF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 13:30:05 -0400
Received: from kuber.nabble.com ([216.139.236.158]:60599 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755861Ab0DBRaE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Apr 2010 13:30:04 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <roylee17@gmail.com>)
	id 1Nxkh1-0002hD-06
	for git@vger.kernel.org; Fri, 02 Apr 2010 10:30:03 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143831>


Hi,

Do we currently have a native way to override attributes specified in the
repository-specific .git/config ?

While working with a large project which is composed by multiple
repositories, from time to time, I'd like to override *some* attributes
without modifying each of the repository-specific config files.

For example, when such a project was copied or moved from a window file
system, all files got filemode changed. Even worse, their are many
uncommitted changes! In this case, I'd like to filter out the filemode
changes(with core.filemode=false) when review the uncommitted changes. Since
the core.filemode attribute was specified in the repository-specific config,
modifying the ~/.gitconfig does not help.

The aforementioned situation is not the only case that I'd like to have such
function. Do we currently have a native way to solve this? For example, to
provide an extra config file via environment variable or directly feed the
attributes via environment variable to override only *some* but not *all* of
attributes specified in the repository-specific config.

I found this thread "Introduce the GIT_CONFIG_EXTRA environment variable"
initiated by Miklos Vajna, did provide a solution to my problem, which is
complete different use case though. :-) So I initiate another thread to
discuss the use case here.

Thanks.

Roy
-- 
View this message in context: http://n2.nabble.com/How-to-to-override-repository-specific-attributes-in-git-config-tp4843642p4843642.html
Sent from the git mailing list archive at Nabble.com.
