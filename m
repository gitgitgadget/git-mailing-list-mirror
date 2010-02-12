From: Ron Garret <ron1@flownet.com>
Subject: Re: Individual file snapshots
Date: Fri, 12 Feb 2010 09:24:27 -0800
Organization: Amalgamated Widgets
Message-ID: <ron1-278C58.09242712022010@news.gmane.org>
References: <ron1-CD3223.04030512022010@news.gmane.org> <alpine.DEB.2.00.1002121316260.10583@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 12 18:24:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfzGE-0004uq-0M
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 18:24:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757327Ab0BLRYx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 12:24:53 -0500
Received: from lo.gmane.org ([80.91.229.12]:55612 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757253Ab0BLRYw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 12:24:52 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NfzG6-0004ov-6J
	for git@vger.kernel.org; Fri, 12 Feb 2010 18:24:50 +0100
Received: from 68-190-211-184.dhcp.gldl.ca.charter.com ([68.190.211.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 18:24:50 +0100
Received: from ron1 by 68-190-211-184.dhcp.gldl.ca.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 18:24:50 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 68-190-211-184.dhcp.gldl.ca.charter.com
User-Agent: MT-NewsWatcher/3.5.1 (Intel Mac OS X)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139728>

In article <alpine.DEB.2.00.1002121316260.10583@ds9.cixit.se>,
 Peter Krefting <peter@softwolves.pp.se> wrote:

> Ron Garret:
> 
> > I would like to be able to store snapshots of individual files without 
> > making a commit on the main branch.
> 
>    git hash-object -w filename
> 
> will add the file to the object database, outputting it's hash value.
> 
>    git tag mytag hashvalue
> 
> creates a tag "mytag" pointing to that file.
> 
>    git show mytag
> 
> will output the file you put in.

Ah, cool!  Thanks.  I knew about git hash-object, but I did not know 
that you could tag the resulting hash.  I thought you could only tag 
commit objects.

rg
