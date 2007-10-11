From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: RCS keyword expansion
Date: Thu, 11 Oct 2007 08:09:22 -0700
Message-ID: <86fy0hvgbh.fsf@blue.stonehenge.com>
References: <Pine.LNX.4.64.0710111542420.23849@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Karlsson <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Thu Oct 11 17:10:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ifzfb-0006cU-G4
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 17:09:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755354AbXJKPJZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 11:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754261AbXJKPJZ
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 11:09:25 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:36653 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752751AbXJKPJY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 11:09:24 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 93ED41DFD3B; Thu, 11 Oct 2007 08:09:23 -0700 (PDT)
x-mayan-date: Long count = 12.19.14.13.2; tzolkin = 4 Ik; haab = 10 Yax
In-Reply-To: <Pine.LNX.4.64.0710111542420.23849@ds9.cixit.se> (Peter Karlsson's message of "Thu, 11 Oct 2007 15:47:29 +0100 (CET)")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60607>

>>>>> "Peter" == Peter Karlsson <peter@softwolves.pp.se> writes:

Peter> I mainly want to have $Date$ expand in RCS/CVS manner, i.e to when the
Peter> file was last changed. Possibly even have an $Id$ that gives me
Peter> something useful (name and commit hash, perhaps?). Is it possible to do
Peter> this? Can it be done through git-cvsserver?

That's not a job for a source code manager to do.  It's a job for your
build/install tool.  See how "git --version" gets created in the core distro,
and follow that example.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
