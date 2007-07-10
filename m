From: Gerrit Pape <pape@smarden.org>
Subject: Re: git-svn problems with branches containing spaces
Date: Tue, 10 Jul 2007 13:42:35 +0000
Message-ID: <20070710134236.2870.qmail@986bac8bfff25d.315fe32.mid.smarden.org>
References: <3F225D5F64550C4AA5F23286244275D4298C84@srvkrsexc07.nov.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 10 15:42:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8Fz5-0001Kb-IY
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 15:42:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752677AbXGJNmT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 09:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752861AbXGJNmT
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 09:42:19 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:58583 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752405AbXGJNmS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 09:42:18 -0400
Received: (qmail 2871 invoked by uid 1000); 10 Jul 2007 13:42:36 -0000
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <3F225D5F64550C4AA5F23286244275D4298C84@srvkrsexc07.nov.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52068>

On Wed, Jun 27, 2007 at 08:53:06AM +0200, Ewald, Robert wrote:
> As I have reported yesterday on IRC, git-svn has problems with branches
> containing spaces.
> I get the following message, when I want to clone from the repository
> containing a branch with a space.
> Cloning until the revision the branch is created everything works fine.
> 
> fatal: refs/remotes/Modbus Error Limit Fix: cannot lock the ref
> update-ref -m r1897 refs/remotes/Modbus Error Limit Fix
> ff0819c8e9c97c24e9865bc868c503fd9b64f980: command returned error: 128
> 
> Thanks for your help.

Hi, the same problem has been reported some time ago through
 http://bugs.debian.org/430518

There's a patch attached to the report, but from a first glance, I don't
think it's the solution.

Thanks, Gerrit.
