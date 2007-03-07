From: Paolo Bonzini <paolo.bonzini@lu.unisi.ch>
Subject: Re: [PATCH, final version] git-archimport: allow remapping branch
   names
Date: Wed, 07 Mar 2007 10:48:52 +0100
Message-ID: <45EE8A84.8070908@lu.unisi.ch>
References: <eslrcr$9rc$1@sea.gmane.org>	<7vodn5iiew.fsf@assigned-by-dhcp.cox.net>	<45EE7442.6030308@lu.unisi.ch>	<7vlki9h1mg.fsf@assigned-by-dhcp.cox.net>	<45EE80B0.8010403@lu.unisi.ch> <7vwt1tfle8.fsf@assigned-by-dhcp.cox.net> <45EE894D.4000206@lu.unisi.ch>
Reply-To: bonzini@gnu.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: bonzini@gnu.org
X-From: git-owner@vger.kernel.org Wed Mar 07 10:49:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOslj-0005RF-LZ
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 10:49:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422695AbXCGJtA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Mar 2007 04:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422696AbXCGJtA
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 04:49:00 -0500
Received: from server.usilu.net ([195.176.178.200]:34596 "EHLO mail.usilu.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1422695AbXCGJs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 04:48:59 -0500
Received: from [1.240.182.245] ([213.140.22.65] RDNS failed) by mail.usilu.net over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 7 Mar 2007 10:48:57 +0100
User-Agent: Thunderbird 1.5.0.10 (Macintosh/20070221)
In-Reply-To: <45EE894D.4000206@lu.unisi.ch>
X-OriginalArrivalTime: 07 Mar 2007 09:48:57.0909 (UTC) FILETIME=[D392BE50:01C7609D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41663>


> This patch add support to archimport for remapping the branch names
> to match those used in git more closely.  This is useful for
> projects that *migrate* to git (as opposed to users that want
> to use git on Arch-based projects).  For example, one can
> choose a branch name and call it "master".
> 
> The new command-line syntax works even if there is a colon in
> a branch name, since only the part after the last colon is taken
> to be the git name (git does not allow colons in branch names).
> 
> The new feature is implemented so that archives rotated every
> year can also be remapped into a single git archive.

ARGH!

Signed-Off-By: Paolo Bonzini  <bonzini@gnu.org>

paolo
