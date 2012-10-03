From: Jeremy Morton <admin@game-point.net>
Subject: Re: Fixing the p4merge launch shell script
Date: Wed, 3 Oct 2012 08:34:46 +0000 (UTC)
Message-ID: <loom.20121003T103315-553@post.gmane.org>
References: <506B7AFB.1070700@game-point.net> <7vipas5qpu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 03 10:41:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJKVv-0008BZ-BQ
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 10:41:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613Ab2JCIky (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 04:40:54 -0400
Received: from plane.gmane.org ([80.91.229.3]:57416 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751439Ab2JCIkv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 04:40:51 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TJKUz-0001EO-8v
	for git@vger.kernel.org; Wed, 03 Oct 2012 10:40:09 +0200
Received: from 81.145.51.162 ([81.145.51.162])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Oct 2012 10:40:09 +0200
Received: from admin by 81.145.51.162 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Oct 2012 10:40:09 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 81.145.51.162 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:14.0) Gecko/20100101 Firefox/14.0.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206873>

Junio C Hamano <gitster <at> pobox.com> writes:

> 
> Jeremy Morton <admin <at> game-point.net> writes:
> 
> > I've noticed that the p4merge shell script could do with some
> > improvement when it comes to merging.  Because p4merge throws up an
> > error when one of the files it's given to diff is "/dev/null", git
> > needs to create a temporary empty file and pass that to p4merge when
> > diffing a file that has been created/deleted (eg. create file, git add
> > ., git diff --cached).
> > ...
> > Thoughts?  Is there an easier way to do this?
> 
> Which version of git?  Perhaps you do not have ec245ba (mergetool:
> Provide an empty file when needed, 2012-01-19) yet?
> 

That patch fixes the mergetool part, but the part I was referring to was the
difftool part, which still has this problem.

Best regards,
Jeremy Morton (Jez)
