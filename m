From: Raf =?utf-8?b?OC0p?= <rdugau@cisco.com>
Subject: Re: git fetch --prune removes branches from origin/ with inconsistent case in path names
Date: Mon, 30 Mar 2015 13:58:59 +0000 (UTC)
Message-ID: <loom.20150330T155535-398@post.gmane.org>
References: <CAJz8ETuFC=STDRbPOxsTDdYbuMh0phdR3AYCzW3AvOrSAmKpWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 30 16:05:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YcaJm-0003me-8h
	for gcvg-git-2@plane.gmane.org; Mon, 30 Mar 2015 16:05:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753414AbbC3OFT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2015 10:05:19 -0400
Received: from plane.gmane.org ([80.91.229.3]:43747 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753260AbbC3OFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2015 10:05:16 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1YcaJM-0003Y3-BC
	for git@vger.kernel.org; Mon, 30 Mar 2015 16:05:04 +0200
Received: from aer01-mda2-dmz-wsa-8.cisco.com ([173.38.209.13])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 30 Mar 2015 16:05:04 +0200
Received: from rdugau by aer01-mda2-dmz-wsa-8.cisco.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 30 Mar 2015 16:05:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 173.38.209.13 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:36.0) Gecko/20100101 Firefox/36.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266454>

Lee Winder <lee.winder <at> gmail.com> writes:

> 
> When using git fetch --prune, git will remove any branches from
> remotes/origin/ that have inconsistent case in folder names.
> ...
> Thanks
> Lee
> 


Hello,

Same type of issue here using Jenkins.

In a gitBash console:
$ git branch --list
* feature/testCI1
  feature/testCI2

In Jenkins Console output (git plugin is 2.3.5):
Seen branch in repository origin/Feature/testCI1
Seen branch in repository origin/Feature/testCI2

Both are running on Windows
