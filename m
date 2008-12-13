From: "Edward Z. Yang" <edwardzyang@thewritingpot.com>
Subject: Re: gitweb and unicode special characters
Date: Fri, 12 Dec 2008 22:06:23 -0500
Message-ID: <ghv8rf$47v$1@ger.gmane.org>
References: <3f2beab60812121033r5d41894t77acc271b7c6955c@mail.gmail.com> <m3y6ylf3mq.fsf@localhost.localdomain> <3f2beab60812121655m6cd868bfhaaf386e6f5457533@mail.gmail.com> <200812130231.06929.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 13 04:08:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBKrQ-00075B-Jm
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 04:08:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752402AbYLMDGh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 22:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752337AbYLMDGh
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 22:06:37 -0500
Received: from main.gmane.org ([80.91.229.2]:33353 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751880AbYLMDGg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 22:06:36 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LBKpr-00017W-Gq
	for git@vger.kernel.org; Sat, 13 Dec 2008 03:06:31 +0000
Received: from lily.mit.edu ([18.243.2.157])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 13 Dec 2008 03:06:31 +0000
Received: from edwardzyang by lily.mit.edu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 13 Dec 2008 03:06:31 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: lily.mit.edu
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <200812130231.06929.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102982>

Jakub Narebski wrote:
> Sidenote: There is probably one exception we want to add, namely not
> escape '\r' at the end of line, to be able to deal better with DOS
> line endings (\r\n).

I'm sorry, but I have to disagree. I find being able to see \r
line-endings in the pretty-printed format is exceedingly useful for
figuring out if a file has been checked in with the wrong line-endings.
The number of files that must have \r line endings are vanishingly small
(Bat files are perhaps the one example I can think of right now).

Cheers,
Edward
