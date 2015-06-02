From: Mattias =?utf-8?b?VmFubmVyZ8OlcmQ=?= 
	<mattias.vannergard@gmail.com>
Subject: Re: FW: Query on git submodules
Date: Tue, 2 Jun 2015 11:27:31 +0000 (UTC)
Message-ID: <loom.20150602T132450-920@post.gmane.org>
References: <4C328B7D13677A4EAF715D0755A6D7EE25C56C89@irsmsx110.ger.corp.intel.com> <4C328B7D13677A4EAF715D0755A6D7EE25C589BF@irsmsx110.ger.corp.intel.com> <20150526170125.GC31115@book.hvoigt.net> <4C328B7D13677A4EAF715D0755A6D7EE25C5AD9E@irsmsx110.ger.corp.intel.com> <loom.20150602T113612-540@post.gmane.org> <20150602111720.GB7442@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 13:29:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzkO2-0000Zy-Je
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 13:29:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751891AbbFBL3f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 07:29:35 -0400
Received: from plane.gmane.org ([80.91.229.3]:52002 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753091AbbFBL3d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 07:29:33 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1YzkNk-0000Nq-U0
	for git@vger.kernel.org; Tue, 02 Jun 2015 13:29:21 +0200
Received: from 194.103.240.26 ([194.103.240.26])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 13:29:20 +0200
Received: from mattias.vannergard by 194.103.240.26 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 13:29:20 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 194.103.240.26 (Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.81 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270525>

Heiko Voigt <hvoigt <at> hvoigt.net> writes:

> 
> What exactly is the feature of using a tag instead of a commit id like 
it
> is currently the default? A tag should be nailed to a commit anyway or
> does it change in your situation? In that case I would say it is a
> branch.
> 
> Cheers Heiko
> 


Essentially, it is a commit, but an annotated tag is easier to read, 
than the SHA-1.

And, I don't want gerrit to track a tag, but I want gerrit to track a 
branch.

BR
/Mattias
