From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: Re* How to generate pull-request with info of signed tag
Date: Sat, 17 Dec 2011 18:57:15 +0530
Message-ID: <871us3l45o.fsf@linux.vnet.ibm.com>
References: <874nx1korf.fsf@linux.vnet.ibm.com> <7vbor8jw0h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 17 14:27:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbuIW-0000Eu-Ln
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 14:27:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752188Ab1LQN13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Dec 2011 08:27:29 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:49989 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830Ab1LQN11 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2011 08:27:27 -0500
Received: from /spool/local
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <git@vger.kernel.org> from <aneesh.kumar@linux.vnet.ibm.com>;
	Sat, 17 Dec 2011 06:27:27 -0700
Received: from d03relay01.boulder.ibm.com (9.17.195.226)
	by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	Sat, 17 Dec 2011 06:27:24 -0700
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id pBHDRNRg124028
	for <git@vger.kernel.org>; Sat, 17 Dec 2011 06:27:23 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id pBHDRMTE023497
	for <git@vger.kernel.org>; Sat, 17 Dec 2011 06:27:22 -0700
Received: from skywalker.linux.vnet.ibm.com ([9.124.94.203])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id pBHDRGu7023224;
	Sat, 17 Dec 2011 06:27:18 -0700
In-Reply-To: <7vbor8jw0h.fsf@alter.siamese.dyndns.org>
User-Agent: Notmuch/0.10.2+102~g61445d1 (http://notmuchmail.org) Emacs/23.3.1 (x86_64-pc-linux-gnu)
x-cbid: 11121713-2398-0000-0000-000002CCC610
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187383>

On Fri, 16 Dec 2011 08:56:14 -0800, Junio C Hamano <gitster@pobox.com> wrote:
> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
> 
> > I am using git from master branch and wanted to try the signed pull
> > request. I have pushed the signed tag to repo.or.cz, but not sure how to
> > generate pull request with signed tag information?
> 
> The correct script should grok the following command line:
> 
>  $ git request-pull v1.7.7.4 git://git.kernel.org/pub/scm/git/git.git v1.7.7.5
> 
> and include
> 
>     are available in the git repository at
> 
>       git://git.kernel.org/.../git.git tag v1.7.7.5
> 
>     for you to fetch changes up to 66c1...
> 
> but we didn't loosen the code that inspects the publishing repository to
> allow asking for a tag that points at an older part of the history to be
> pulled.
> 

Tested-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

-aneesh
