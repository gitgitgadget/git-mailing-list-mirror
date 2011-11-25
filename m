From: Ruedi Steinmann <ruediste@student.ethz.ch>
Subject: Re: [PATCH] Fix https interactive authentication problem
Date: Fri, 25 Nov 2011 12:10:26 +0000 (UTC)
Message-ID: <loom.20111125T125630-755@post.gmane.org>
References: <F6A589D6B10801478E0DE246A9EF187C1BD5E8@MBX12.d.ethz.ch> <20111123225121.GA23357@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 25 13:15:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTuh1-0001Aq-Js
	for gcvg-git-2@lo.gmane.org; Fri, 25 Nov 2011 13:15:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754913Ab1KYMPm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Nov 2011 07:15:42 -0500
Received: from lo.gmane.org ([80.91.229.12]:44154 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754876Ab1KYMPl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Nov 2011 07:15:41 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RTugl-00010s-G1
	for git@vger.kernel.org; Fri, 25 Nov 2011 13:15:35 +0100
Received: from 80-218-216-248.dclient.hispeed.ch ([80.218.216.248])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 25 Nov 2011 13:15:31 +0100
Received: from ruediste by 80-218-216-248.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 25 Nov 2011 13:15:31 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 80.218.216.248 (Mozilla/5.0 (X11; Linux i686; rv:7.0.1) Gecko/20100101 Firefox/7.0.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185927>

Jeff King <peff <at> peff.net> writes:

> 
> Hmm. What version of git are you using?
> 

Hi Jeff,

I'm a little short of time at the moment, I'll come to this back later. So just
the quick infos. I discovered the error in my preinstalled version of git
(1.7.5.4). I reproduced the error with the version of git I have the source code
of: (which I should have done before, sorry)

../git/git/git clone https://n.ethz.ch/...
Cloning into 'masterthesis'...
warning: templates not found /home/ruedi/share/git-core/templates
Username for 'n.ethz.ch': 
Password for 'n.ethz.ch': 
error: The requested URL returned error: 401 (curl_result = 22, http_code = 401,
sha1 = 4e69f4215f0d8c02ec1c29aadcd4ea39bb4e7c5e)
error: Unable to find 4e69f4215f0d8c02ec1c29aadcd4ea39bb4e7c5e under
https://n.ethz.ch/.../masterthesis.git
Cannot obtain needed commit 4e69f4215f0d8c02ec1c29aadcd4ea39bb4e7c5e
while processing commit 0fa41a9d4b3282891173ec54c04e0e3763867807.
error: Fetch failed.

I am working with the git repository from https://github.com/gitster/git.git.

>From the first few lines of my commit from gitk:

Parent: 017d1e134545db0d162908f3538077eaa1f34fb6 (Update 1.7.8 draft release
notes in preparation for rc4)
Branch: master
Follows: v1.7.7.4, v1.7.8-rc3

Hope this helps

Cheers
Ruedi
