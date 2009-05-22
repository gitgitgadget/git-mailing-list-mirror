From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: can anybody explain the following to a git noob?
Date: Fri, 22 May 2009 11:03:29 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrnh1d1k1.17t.sitaramc@sitaramc.homelinux.net>
References: <855e4dcf0905212046o3e1d6ec6l487829a0a411dcaf@mail.gmail.com>
 <32541b130905212202q9aed54cn892171b7e654812f@mail.gmail.com>
 <855e4dcf0905212244r454a5c21w7bdbfb566a28efb8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 22 13:03:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7SXW-0005c9-4b
	for gcvg-git-2@gmane.org; Fri, 22 May 2009 13:03:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754314AbZEVLDm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2009 07:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753453AbZEVLDl
	(ORCPT <rfc822;git-outgoing>); Fri, 22 May 2009 07:03:41 -0400
Received: from main.gmane.org ([80.91.229.2]:48269 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752577AbZEVLDl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2009 07:03:41 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1M7SXN-0004YE-G5
	for git@vger.kernel.org; Fri, 22 May 2009 11:03:41 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 May 2009 11:03:41 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 May 2009 11:03:41 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119725>

On 2009-05-22, Tim Uckun <timuckun@gmail.com> wrote:

> directory.  So the fact that the test directory is misbehaving is
> because a directory in the vendor hierarchy has a .git folder?
>
> I'll have to clean up all those and see if the problem remains.

I believe those look like submodule directories to git,
which are handled quite differently.

man git-submodule maybe a good starting point
