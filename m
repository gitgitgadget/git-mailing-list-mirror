From: Raul Dias <raul@dias.com.br>
Subject: same files on different paths on different branches
Date: Thu, 17 Mar 2011 21:06:12 -0300
Message-ID: <4D82A1F4.4060801@dias.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 18 01:13:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0NK8-0006Dg-KQ
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 01:13:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755078Ab1CRANf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 20:13:35 -0400
Received: from rack.swi.com.br ([66.216.97.12]:39495 "EHLO rack.swi.com.br"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754333Ab1CRANe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 20:13:34 -0400
X-Greylist: delayed 536 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Mar 2011 20:13:34 EDT
X-Received-SPF: no SPF record found
Received: from [10.1.1.3] (unknown [187.112.180.199])
	(Authenticated sender: raul@dias.com.br)
	by rack.swi.com.br (Postfix) with ESMTPA id 47A8031380B7
	for <git@vger.kernel.org>; Fri, 18 Mar 2011 00:04:36 +0000 (UTC)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.14) Gecko/20110223 Lightning/1.0b2 Thunderbird/3.1.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169287>

Hi,

I want to know if the following is possible to accomplish with git.
(please reply to me too)

A project is composed of many sub-modules (not in git sense).
These sub-modules are developed independently of the main project.
They need to be reattached to the projects' tree.

The problems:
    1 - a sub-module's tree does not have any projects file.
    2 - when a sub-module is re-attached to the main project, its files
are spread in many places (different from the the sub-module layout).


Ideally the project would understand which files are the same, even on
different places and apply the changes in the right files.
This way a merge/cherry picking would keep the history information.

Is it possible to accomplish something similar to this?
I understand that this is not how a git super-project works.
I don't think it is possible with different git repositories.

I tried with a empty branch technique. 
Created an empty branch with no history.
Started a sub-module (non git) there and tried to propagate the changes.
Git almost did the right thing.
A change in branch submodule's
    /foo/a.txt
should have gone to branch master's
    /bar/foo/a.txt
but instead it went to
    /bar/somethingelse/a.txt (which is the same as /bar/foo/a.txt)


So is it possible to get closer to this with git  in a way or another?


Thanks
-rsd
