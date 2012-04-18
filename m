From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Tags/Branches missing in GIT
Date: Wed, 18 Apr 2012 09:34:12 +0200
Message-ID: <4F8E6E74.7020403@alum.mit.edu>
References: <1334728490216-7475869.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: supadhyay <supadhyay@imany.com>
X-From: git-owner@vger.kernel.org Wed Apr 18 09:34:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKPPC-0005XD-Dl
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 09:34:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272Ab2DRHeS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Apr 2012 03:34:18 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:46448 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188Ab2DRHeR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2012 03:34:17 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q3I7YCAE008288
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 18 Apr 2012 09:34:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120410 Thunderbird/11.0.1
In-Reply-To: <1334728490216-7475869.post@n2.nabble.com>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195843>

On 04/18/2012 07:54 AM, supadhyay wrote:
> I have migrated our version control from CVS to Git (with the help of this
> link  http://cvs2svn.tigris.org/cvs2git.html) and from git I do clone to
> gitolite on the same server.
>
> Now when end user verify their code in GIT (using Tortoisegit/Egit) they
> found differences in number of tags and brances. Some of CVS tags/brances
> are not exists in GIT and some of the new tags created by GIT which is not
> in CVS.
>
>
> Can any one please update me this is known issue or not and how to resolve
> this ?

Questions about cvs2svn/cvs2git belong on the cvs2svn mailing list [1] 
(as I have told you twice before).

It is of course the mission of cvs2git to convert all CVS history 
including all branches and tags.  So if you think you have found a 
problem, you need to provide more detail about how you ran cvs2git and 
what makes you think that the results are incorrect.  Please see the 
cvs2svn FAQ [2] for information about reporting suspected bugs in 
cvs2svn/cvs2git.

[1] users@cvs2svn.tigris.org
[2] http://cvs2svn.tigris.org/faq.html#gettinghelp

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
