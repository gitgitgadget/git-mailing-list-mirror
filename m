From: Brad King <brad.king@kitware.com>
Subject: Re: What's cooking in git.git (Oct 2011, #01; Tue, 4)
Date: Thu, 06 Oct 2011 11:55:37 -0400
Message-ID: <4E8DCF79.50200@kitware.com>
References: <7vvcs49ofl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 17:55:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBqIS-0002dM-NR
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 17:55:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964962Ab1JFPzj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 11:55:39 -0400
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:52008 "HELO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756381Ab1JFPzi (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Oct 2011 11:55:38 -0400
Received: from mail-yx0-f177.google.com ([209.85.213.177]) (using TLSv1) by na3sys009aob102.postini.com ([74.125.148.12]) with SMTP;
	Thu, 06 Oct 2011 08:55:38 PDT
Received: by mail-yx0-f177.google.com with SMTP id 11so3360140yxi.36
        for <git@vger.kernel.org>; Thu, 06 Oct 2011 08:55:37 -0700 (PDT)
Received: by 10.150.11.14 with SMTP id 14mr723152ybk.381.1317916537628;
        Thu, 06 Oct 2011 08:55:37 -0700 (PDT)
Received: from [192.168.1.220] (66-194-253-20.static.twtelecom.net. [66.194.253.20])
        by mx.google.com with ESMTPS id j13sm15824387ani.19.2011.10.06.08.55.35
        (version=SSLv3 cipher=OTHER);
        Thu, 06 Oct 2011 08:55:36 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:6.0) Gecko/20110812 Thunderbird/6.0
In-Reply-To: <7vvcs49ofl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182962>

On 10/4/2011 10:12 PM, Junio C Hamano wrote:
> [Stalled]
>
> * hv/submodule-merge-search (2011-08-26) 5 commits
>   - submodule: Search for merges only at end of recursive merge
>   - allow multiple calls to submodule merge search for the same path
>   - submodule: Demonstrate known breakage during recursive merge

The above three commits are independent of the other two, no?
They form a complete topic demonstrating and fixing a merge bug
independent from pushing.  The other commits:

>   - push: Don't push a repository with unpushed submodules
>    (merged to 'next' on 2011-08-24 at 398e764)
>   + push: teach --recurse-submodules the on-demand option
>   (this branch is tangled with fg/submodule-auto-push.)
>
> The second from the bottom one needs to be replaced with a properly
> written commit log message.

are a separate topic.

-Brad
