From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: Meaning of "fatal: protocol error: bad line length character"?
Date: Tue, 23 Jan 2007 01:14:22 +0100
Message-ID: <45B5535E.2000808@xs4all.nl>
References: <17842.1385.366750.915767@lisa.zopyra.com> <7vk5zh7b7d.fsf@assigned-by-dhcp.cox.net>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 01:14:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H99J7-0004f2-71
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 01:14:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbXAWAOd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 19:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbXAWAOc
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 19:14:32 -0500
Received: from main.gmane.org ([80.91.229.2]:50974 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932410AbXAWAOc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 19:14:32 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H99J0-0008WL-3e
	for git@vger.kernel.org; Tue, 23 Jan 2007 01:14:30 +0100
Received: from muurbloem.xs4all.nl ([213.84.26.127])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Jan 2007 01:14:30 +0100
Received: from hanwen by muurbloem.xs4all.nl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Jan 2007 01:14:30 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: muurbloem.xs4all.nl
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
In-Reply-To: <7vk5zh7b7d.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37470>

Junio C Hamano escreveu:
> I've seen this "bad line length character" mentioned in #git and
> on this list but nobody seems to have hunted down what this is.
> 
> 	http://www.gelato.unsw.edu.au/archives/git/0603/17807.html
> 
> is another (Google finds some others for the error message on
> xcb list but that is about fetch-pack which is totally different
> codepath).

if you need another example where this is happening, the anongit
repo for lilypond seems to have gotten in this state as well,

[hanwen@haring tmp]$ git clone git://git.sv.gnu.org/lilypond.git
Initialized empty Git repository in /tmp/lilypond/.git/
fatal: protocol error: bad line length character
fetch-pack from 'git://git.sv.gnu.org/lilypond.git' failed.


pushing/pulling over ssh+git and http still work.
  

(git 1.5.0rc2, not sure what git.sv.gnu.org is running)

-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
