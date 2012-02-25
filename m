From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: cvs2git multiple session for repository migration...
Date: Sat, 25 Feb 2012 16:14:20 +0100
Message-ID: <4F48FACC.30800@alum.mit.edu>
References: <1330092524040-7314909.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: supadhyay <supadhyay@imany.com>
X-From: git-owner@vger.kernel.org Sat Feb 25 16:14:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1JKT-0004SK-Bv
	for gcvg-git-2@plane.gmane.org; Sat, 25 Feb 2012 16:14:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756725Ab2BYPO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Feb 2012 10:14:27 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:42210 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756691Ab2BYPO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Feb 2012 10:14:27 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.134] (p54BECD5E.dip.t-dialin.net [84.190.205.94])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q1PFEKep000700
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 25 Feb 2012 16:14:21 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.27) Gecko/20120216 Lightning/1.0b2 Thunderbird/3.1.19
In-Reply-To: <1330092524040-7314909.post@n2.nabble.com>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191536>

On 02/24/2012 03:08 PM, supadhyay wrote:
> I am migrating my CVS repository to GIt. As I have multiple repository I
> want to start multiple session for cvs2git,but it failed to start. I
> received cvs2svn.lock file error ? Is there any workaround to start multiple
> cvs2git session (which migrate the CVS directory) ??
> 
> Thanks in advance...

Didn't I already mention that cvs2git questions should go to the cvs2svn
mailing list?

You can run cvs2git multiple times simultaneously; you just need to
ensure that each one has its own temporary directory.  You can do this
either with the --tmpdir=PATH option or by starting the instances in
separate directories.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
