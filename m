From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v5 0/3] gitk: save only changed configuration on exit
Date: Sun, 22 Mar 2015 14:39:15 +1100
Message-ID: <20150322033914.GB14271@iris.ozlabs.ibm.com>
References: <1425441498-29416-1-git-send-email-max@max630.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Sun Mar 22 04:41:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZWlq-0005O6-Qg
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 04:41:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805AbbCVDlj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2015 23:41:39 -0400
Received: from ozlabs.org ([103.22.144.67]:54908 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751607AbbCVDlb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2015 23:41:31 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 3002E14016B; Sun, 22 Mar 2015 14:41:29 +1100 (AEDT)
Content-Disposition: inline
In-Reply-To: <1425441498-29416-1-git-send-email-max@max630.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266048>

On Wed, Mar 04, 2015 at 05:58:15AM +0200, Max Kirillov wrote:
> The changes:
> 
> * remove unused views_modified_names assignment
> * use if {[catch...] to check saving error
> * split error reporting from busy wait
> 
> The busy wait parameters are unchanged, mostly because I did not have time yet to test them.

Thanks, applied, with some rewording of the commit messages, and I
updated the error message that is shown when a stale temporary config
file exists to what I suggested previously.

Paul.
