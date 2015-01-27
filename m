From: Andreas Gruenbacher <agruen@gnu.org>
Subject: Re: patch-2.7.3 no longer applies relative symbolic link patches
Date: Tue, 27 Jan 2015 15:26:01 +0000 (UTC)
Message-ID: <ma8am9$t01$1@ger.gmane.org>
References: <CA+5PVA7rVy6Li_1haj1QmGG0D6avLB5Xej=2YGt6K-11kKHR5A@mail.gmail.com>
	<CA+5PVA4bs6CYU8MHn1JqBjnb-5wYJT2Tjqa65=v2uSPL8c7dYw@mail.gmail.com>
	<CA+55aFxbY21vBbPs5qCFPT1HSBbaeS+Z2Fr9So1r3rXrMWe_ZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 27 16:30:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YG85j-00017U-3I
	for gcvg-git-2@plane.gmane.org; Tue, 27 Jan 2015 16:30:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753215AbbA0PaH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2015 10:30:07 -0500
Received: from plane.gmane.org ([80.91.229.3]:32941 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752119AbbA0PaF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2015 10:30:05 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1YG85b-00011i-Sa
	for git@vger.kernel.org; Tue, 27 Jan 2015 16:30:03 +0100
Received: from 80-110-112-196.cgn.dynamic.surfer.at ([80.110.112.196])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Jan 2015 16:30:03 +0100
Received: from agruen by 80-110-112-196.cgn.dynamic.surfer.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Jan 2015 16:30:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 80-110-112-196.cgn.dynamic.surfer.at
User-Agent: Pan/0.139 (Sexual Chocolate; GIT bf56508
 git://git.gnome.org/pan2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263069>

On Mon, 26 Jan 2015 12:44:33 -0800, Linus Torvalds wrote:
> I've considered that for a while already, because "patch" _does_ kind of
> understand them these days, although I think it gets the cross-rename
> case wrong because it fundamentally works on a file-by-file basis.

Patch handles cross-renames correctly nowadays; if not, it's a bug.

That's not enough to solve the symlink problem unfortunately.

Andreas
