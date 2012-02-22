From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: contrib/git-move-refs.py not exists in cvs2svn-2.3.0
Date: Wed, 22 Feb 2012 21:05:57 +0100
Message-ID: <4F454AA5.5010502@alum.mit.edu>
References: <1329909939769-7308023.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: supadhyay <supadhyay@imany.com>
X-From: git-owner@vger.kernel.org Wed Feb 22 21:06:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0IS2-0007Sy-8P
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 21:06:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752630Ab2BVUGF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 15:06:05 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:36229 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752369Ab2BVUGE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 15:06:04 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q1MK5vS7000720
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 22 Feb 2012 21:05:57 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.27) Gecko/20120216 Lightning/1.0b2 Thunderbird/3.1.19
In-Reply-To: <1329909939769-7308023.post@n2.nabble.com>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191275>

On 02/22/2012 12:25 PM, supadhyay wrote:
> I have run the cvs2git tool to migrate my CVS repository to git. I am able
> to finish successfully. Now as the last recommended steps from
> http://cvs2svn.tigris.org/cvs2git.html , I found to run
> "contrib/git-move-refs.py" but in my cvs2svn-2.3.0 I can not see any file
> name like "git-move-refs.ph", I have one file "git-move-tags.py".  Is this
> is the same file ?

This program was added in the trunk version of cvs2svn; it is not in
release 2.3.0.  I recommend using the trunk version for your conversion
anyway, as it includes a number of improvements (some git-relevant) and
it would be released already except for a few loose ends that I haven't
gotten back to.

cvs2svn/cvs2git/cvs2etc is a project separate from git and it has its
own mailing list to which your conversion questions should probably be
directed:

    users@cvs2svn.tigris.org

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
