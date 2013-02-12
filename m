From: MikeW <mw_phil@yahoo.co.uk>
Subject: Re: A good Git technique for referring back to original files
Date: Tue, 12 Feb 2013 10:19:54 +0000 (UTC)
Message-ID: <loom.20130212T110458-119@post.gmane.org>
References: <loom.20130212T085620-989@post.gmane.org> <vpq1ucl9agt.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 12 11:20:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5Cyh-0006pN-9E
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 11:20:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756434Ab3BLKUR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 05:20:17 -0500
Received: from plane.gmane.org ([80.91.229.3]:39790 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755527Ab3BLKUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 05:20:16 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1U5CyW-0006N1-2j
	for git@vger.kernel.org; Tue, 12 Feb 2013 11:20:32 +0100
Received: from static.kpn.net ([static.kpn.net])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 12 Feb 2013 11:20:32 +0100
Received: from mw_phil by static.kpn.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 12 Feb 2013 11:20:32 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 188.204.2.113 (Mozilla/5.0 (Windows NT 5.1; rv:18.0) Gecko/20100101 Firefox/18.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216143>

Matthieu Moy <Matthieu.Moy <at> grenoble-inp.fr> writes:

> 
> MikeW <mw_phil <at> yahoo.co.uk> writes:
> 
> > Since git is so good at tracking file content, I wondered whether
there was any
> > technique using git that would simplify the back-referencing task.
> 
> I'm not sure I understand the question, but if you want to add meta-data
> to Git commits (e.g. "this Git commit is revision 42 in CVS repository
> foo"), then have a look at git-notes. It won't give you directly
> "reference to other VCS", but at least can be used as a storage
> mechanism to store these references.
> 
Thanks for the reply.

In my work environment both the SDK and the original files are available
(in an enclosing directory).

--SDK_content
  |
  SDK_subproj1-- ...
  |            |
  |            content
  |
  SDK_subproj2- ...
  |            |
  |            content
  |
  SDK_subprojN- ...
  |            |
  |            content
  |
  Working_SDK ... (under git, baseline generated from subproj1..N)
               |
               content derived from subproj1..N


What I had in mind was something I could run over, say, SDK_content
(alternatively, from within Working_SDK, referring back to SDK_content)
which would note the changed files in Working_SDK and locate the
original files in SDK_subproj1..N letting me merge the changes back.
