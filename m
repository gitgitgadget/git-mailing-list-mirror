From: Eric Raible <raible@gmail.com>
Subject: Re: how to make gitk to use specified history information
Date: Mon, 16 Nov 2009 08:08:30 +0000 (UTC)
Message-ID: <loom.20091116T090441-576@post.gmane.org>
References: <4B01049A.5090402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 16 09:09:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9weE-0003VB-GZ
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 09:09:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005AbZKPIIt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 03:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751885AbZKPIIt
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 03:08:49 -0500
Received: from lo.gmane.org ([80.91.229.12]:43001 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751547AbZKPIIs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 03:08:48 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1N9wdp-0003Ly-B0
	for git@vger.kernel.org; Mon, 16 Nov 2009 09:08:53 +0100
Received: from adsl-75-23-155-167.dsl.pltn13.sbcglobal.net ([75.23.155.167])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Nov 2009 09:08:53 +0100
Received: from raible by adsl-75-23-155-167.dsl.pltn13.sbcglobal.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Nov 2009 09:08:53 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 75.23.155.167 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/532.0 (KHTML, like Gecko) Chrome/3.0.195.27 Safari/532.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132990>

Liu Yubao <yubao.liu <at> gmail.com> writes:

> I want to obtain an outline of history information, for example:
> 
>   a - b - c - d - h -i -j
>    \         /
>     e- f - g
> 
> I simplify the graph like this:
> 
>   a - c - d - j
>     \    /
>       g

"gitk --simplify-by-decoration"?

- Eric
