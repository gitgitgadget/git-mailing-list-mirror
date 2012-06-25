From: Andy Hawkins <andy@gently.org.uk>
Subject: Re: Urgent: Issue with GIT ...
Date: Mon, 25 Jun 2012 13:02:37 +0000 (UTC)
Organization: Gently
Message-ID: <slrnjugobd.8ie.andy@atom.gently.org.uk>
References: <1340624980925-7562097.post@n2.nabble.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 25 16:45:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjAXV-00012c-HQ
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 16:45:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756832Ab2FYOpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jun 2012 10:45:09 -0400
Received: from plane.gmane.org ([80.91.229.3]:33073 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755632Ab2FYOpG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 10:45:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1SjAXH-0000rY-HN
	for git@vger.kernel.org; Mon, 25 Jun 2012 16:45:03 +0200
Received: from cpc2-swin2-0-0-cust495.3-1.cable.virginmedia.com ([81.109.93.240])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 25 Jun 2012 16:45:03 +0200
Received: from andy by cpc2-swin2-0-0-cust495.3-1.cable.virginmedia.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 25 Jun 2012 16:45:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: cpc2-swin2-0-0-cust495.3-1.cable.virginmedia.com
User-Agent: slrn/pre1.0.0-18 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200581>

Hi,

In article <1340624980925-7562097.post@n2.nabble.com>,
           guruprasad<guruprasadkinI@gmail.com> wrote:
> 5) If i do some changes to files in B, commit and push to remote branch, I
> am unable to pull the changes done and merge into A. I have set
> "receive.denycurrentbranch=ignore" in git config.

Sounds like you're trying to push into a remote non-bare repository.

What I'd do is:

1. On 'A', create a bare repository.
2. Somewhere else on 'A', clone this repository. Work and push to the bare
in step 1 when necessary.
3. On 'B', also clone the repository from 1. Work and push to the bare when
necessary.

I don't think it's a good idea to push to a repository that has checked out
files. I seem to remember this being mentioned in Pro Git.

Andy
