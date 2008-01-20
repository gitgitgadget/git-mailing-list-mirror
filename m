From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Also use unpack_trees() in do_diff_cache()
Date: Sun, 20 Jan 2008 23:34:23 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801202331380.5731@racer.site>
References: <alpine.LFD.1.00.0801181911560.2957@woody.linux-foundation.org> <7vfxwu9s2z.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801191133330.2957@woody.linux-foundation.org> <alpine.LFD.1.00.0801191709380.2957@woody.linux-foundation.org>
 <alpine.LSU.1.00.0801200142170.5731@racer.site> <15ECE22B-FCBB-4F12-919B-694E48D48E0D@zib.de> <alpine.LSU.1.00.0801201515060.5731@racer.site> <alpine.LSU.1.00.0801201519320.5731@racer.site> <alpine.LFD.1.00.0801201144300.2957@woody.linux-foundation.org>
 <alpine.LFD.1.00.0801201338140.2957@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steffen Prohaska <prohaska@zib.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 00:35:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGjh9-0000A7-S9
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 00:35:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756120AbYATXel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2008 18:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756098AbYATXel
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 18:34:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:57914 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756072AbYATXek (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2008 18:34:40 -0500
Received: (qmail invoked by alias); 20 Jan 2008 23:34:37 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp037) with SMTP; 21 Jan 2008 00:34:37 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/mzZBJkDnmDayruuDOoSocxm0lxdvDbqD9FXXjsj
	OXaNp3GCkrE/h0
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.1.00.0801201338140.2957@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71202>

Hi,

On Sun, 20 Jan 2008, Linus Torvalds wrote:

> In addition, we now have the infrastructure to generate *better* output, 
> so if we want to make "git diff HEAD" generate a nice combined diff, 
> this sets the stage for that.

Note: "git diff HEAD" as it is now still holds value; it tells you about 
_all_ changes -- staged and unstaged -- and I have to admit that I used it 
a lot (as "git diff HEAD -- file | git apply -R"; note the absence of 
"--index" to the call to apply, otherwise "git checkout file" would have 
done the same).

So if we ever do combined diffs for "git diff HEAD", I want an option to 
turn them off, too.

Ciao,
Dscho
