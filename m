From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH 0/5] git-p4 filetype handling
Date: Fri, 23 Sep 2011 18:56:19 +0100
Message-ID: <4E7CC843.8080707@diamand.org>
References: <20110918012634.GA4578@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Vitor Antunes <vitor.hda@gmail.com>,
	Chris Li <git@chrisli.org>, Junio C Hamano <gitster@pobox.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Fri Sep 23 19:56:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R79zB-0006KH-HR
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 19:56:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166Ab1IWR4Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Sep 2011 13:56:25 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:32977 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127Ab1IWR4X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2011 13:56:23 -0400
Received: by wyg34 with SMTP id 34so4199304wyg.19
        for <git@vger.kernel.org>; Fri, 23 Sep 2011 10:56:22 -0700 (PDT)
Received: by 10.216.14.91 with SMTP id c69mr5713054wec.81.1316800582730;
        Fri, 23 Sep 2011 10:56:22 -0700 (PDT)
Received: from [86.26.7.206] (cpc1-cmbg14-2-0-cust973.5-4.cable.virginmedia.com. [86.26.7.206])
        by mx.google.com with ESMTPS id n21sm17549592wbp.2.2011.09.23.10.56.20
        (version=SSLv3 cipher=OTHER);
        Fri, 23 Sep 2011 10:56:21 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:6.0.2) Gecko/20110902 Thunderbird/6.0.2
In-Reply-To: <20110918012634.GA4578@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181980>

On 18/09/11 02:26, Pete Wyckoff wrote:
> Here's a series that includes some changes to make
> git-p4 handle p4 filetypes better.  This work was
> inspired by Chris Li, and includes some refactoring
> of the git-p4 tests that grew out of looking at
> Vitor's branch changes.
>
> It could use review for generic test beauty, as well
> as for the git-p4 filetype specifics in the code.

Modulo Junio's other comments, this looks sensible to me. I tried it on 
a sizeable tree and it didn't scramble anything (but that will only have 
tested the 'normal' filetypes).

Do we use $(some_command) rather than `some_command` now?

A few other small comments to follow.

Regards!
Luke


>
>   contrib/fast-import/git-p4 |   91 +++++++++++++-----
>   t/lib-git-p4.sh            |   55 +++++++++++
>   t/t9800-git-p4.sh          |  108 ++--------------------
>   t/t9801-git-p4-branch.sh   |  221 ++++++++++++++++++++++++++++++++++++++++++++
>   t/t9802-git-p4-filetype.sh |  107 +++++++++++++++++++++
>   5 files changed, 457 insertions(+), 125 deletions(-)
>
> Thanks,
>
> 		-- Pete
>
