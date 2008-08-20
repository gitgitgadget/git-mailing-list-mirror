From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: git-cvsimport - losing changes in subsequent pulls of a CVS branch
 that I thought I wasn't modifying in the GIT repo.
Date: Wed, 20 Aug 2008 08:24:25 +0200
Message-ID: <48ABB899.4090608@alum.mit.edu>
References: <48AA6F8E.70807@bluelane.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Matthias Urlichs <smurf@smurf.noris.de>,
	Piet Delaney <piet.delaney@gmail.com>,
	Piet Delaney <pdelaney@bluelane.com>
To: piet@bluelane.com
X-From: git-owner@vger.kernel.org Wed Aug 20 08:25:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVh8U-0004jd-OP
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 08:25:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751714AbYHTGYf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 02:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751701AbYHTGYf
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 02:24:35 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:42270 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522AbYHTGYe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 02:24:34 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id m7K6OQXY004216
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 20 Aug 2008 08:24:26 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.16) Gecko/20080724 Thunderbird/2.0.0.16 Mnenhy/0.7.5.666
In-Reply-To: <48AA6F8E.70807@bluelane.com>
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92965>

Pete/Piet Delaney wrote:
> I'm running into a problem with git-cvsimport.  [...]
> 
> I'll take another stab at it tomarrow. Any thoughts or
> recommendations appreciated.

If this is a one-time conversion (i.e., you don't need to actively track
a live CVS repository), then I suggest that you try cvs2svn/cvs2git [1].
 It can migrate to git via a git-fast-import output stream [2].  All
cvsps-based tools necessarily have problems because cvsps (a) doesn't
output enough information for a reliable conversion and (b) gets
confused by certain patterns that commonly occur in CVS repository
histories.  cvs2svn can handle every CVS repository that we have seen
and is also highly configurable [3].

Michael

[1] http://cvs2svn.tigris.org/
[2] http://cvs2svn.tigris.org/cvs2git.html
[3] http://cvs2svn.tigris.org/features.html
