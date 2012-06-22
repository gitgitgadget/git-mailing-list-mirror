From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git bisect/checkout and changes to .gitignore
Date: Fri, 22 Jun 2012 12:31:31 +0200
Message-ID: <4FE44983.30209@viscovery.net>
References: <CAPTjJmq4zv6dBR2Z-HfM7CJoxfprSdJEYYELuyBfahw2PkZ4Lw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Chris Angelico <rosuav@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 22 12:31:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Si19Q-0008Nm-Rd
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jun 2012 12:31:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762042Ab2FVKbg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jun 2012 06:31:36 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:18509 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1762034Ab2FVKbf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2012 06:31:35 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Si19I-0004My-AA; Fri, 22 Jun 2012 12:31:32 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id E47731660F;
	Fri, 22 Jun 2012 12:31:31 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <CAPTjJmq4zv6dBR2Z-HfM7CJoxfprSdJEYYELuyBfahw2PkZ4Lw@mail.gmail.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200433>

Am 6/22/2012 9:51, schrieb Chris Angelico:
> At my workplace we use git to manage all of our source code. Every now
> and then, we decide that some particular file oughtn't to be
> git-managed, and add it into .gitignore and remove it from the
> repository (for instance, configuration files that become
> per-developer).
> 
> Is there a way to checkout an old version of the repository (before
> the file was added to .gitignore), then return to the current state,
> without destroying these sorts of files? Currently, checking out the
> old version quietly "takes control" of the file, and then checking out
> a newer one deletes it.
> 
> I've read through the man pages for 'git checkout' and 'gitignore' and
> searched the one for 'git config' (it's a little large to read all
> of), without seeing an option to preserve files on checkout. Is there
> a way to do this, and if so, where can I find it?

Files mentioned in .gitignore are considered garbage. But your file is
precious, hence, you should not list it in .gitignore.

Here is a thread that is worthwhile to read. I posted a patch

http://thread.gmane.org/gmane.comp.version-control.git/185724/focus=185733

but it was dismissed, see

http://thread.gmane.org/gmane.comp.version-control.git/185724/focus=185746

-- Hannes
