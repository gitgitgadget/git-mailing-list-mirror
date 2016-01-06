From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: Questions on passing --depth to git-clone vs. git-fetch
Date: Wed, 6 Jan 2016 14:04:22 +0100
Message-ID: <568D10D6.7020707@gmail.com>
References: <n6j1cs$p4$1@ger.gmane.org>
 <CACsJy8D5DeDOCd1tn876s3+2fBR6e-X1UANkAeiw8tzAeDcDng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 06 14:04:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGnli-0000sm-Gc
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jan 2016 14:04:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751809AbcAFNEr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2016 08:04:47 -0500
Received: from plane.gmane.org ([80.91.229.3]:41004 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751601AbcAFNEq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2016 08:04:46 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1aGnlY-0000nJ-Ae
	for git@vger.kernel.org; Wed, 06 Jan 2016 14:04:40 +0100
Received: from 131.228.216.134 ([131.228.216.134])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 06 Jan 2016 14:04:40 +0100
Received: from sschuberth by 131.228.216.134 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 06 Jan 2016 14:04:40 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 131.228.216.134
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <CACsJy8D5DeDOCd1tn876s3+2fBR6e-X1UANkAeiw8tzAeDcDng@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283440>

On 1/6/2016 13:41, Duy Nguyen wrote:

> I think the culprit is the "git remote add" line. "git clone --depth"
> by default will fetch only one branch (aka --single-branch option in
> git-clone). But I suspect when you add a new remote, the default

Now that you mention it I see this being documented as part of 
--single-branch instead of --depth, which I think is confusing. I'll 
send a patch.

-- 
Sebastian Schuberth
