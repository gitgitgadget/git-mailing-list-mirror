From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb improvements
Date: Mon, 6 Oct 2008 01:54:06 +0200
Message-ID: <200810060154.06934.jnareb@gmail.com>
References: <00a201c92701$54ec6980$fec53c80$@se> <m34p3rq7og.fsf@localhost.localdomain> <00b201c92739$36585eb0$a3091c10$@se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "'git'" <git@vger.kernel.org>
To: "Tjernlund" <tjernlund@tjernlund.se>
X-From: git-owner@vger.kernel.org Mon Oct 06 01:55:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmdRZ-0006qd-Cn
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 01:55:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbYJEXyL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Oct 2008 19:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbYJEXyK
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 19:54:10 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:11923 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881AbYJEXyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2008 19:54:09 -0400
Received: by ug-out-1314.google.com with SMTP id k3so1544175ugf.37
        for <git@vger.kernel.org>; Sun, 05 Oct 2008 16:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=T7dNGOL3quUiyo1lPYbro0CXHugqfReoRAWU99U0yqw=;
        b=LIkCFuqSWR4GzHLWIR9uUTvIUyAICZw0Pf+qcJQm7PRmeJ/t6oRnw9jxnWsbGLMfeH
         rGy+7b8dleTJss2MwN0ly2Oa87JLxdN/K74Jk2oiN2VcSJbfVeP0PofA7oe8LotOoCmS
         cLdv2OVwNrEKrRUDI1NTIe9dWWzh8x538zqCI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=acleEiA5GlqMAFdgzKpC09PEXKiLFz2ug644Km28gr936YL+KPJYo1nU4dFLM2kjA3
         FTsO3eEbB6gDSoOb6leYbRaDBuKlGxNXvLVkbIYbuyikUvNTvVPmKoqKhfWh4bLjW9qx
         SfJz2GiMQcQ4DS4yM0WrCCdnvDwkXw4d05wU4=
Received: by 10.210.120.7 with SMTP id s7mr5398273ebc.76.1223250847463;
        Sun, 05 Oct 2008 16:54:07 -0700 (PDT)
Received: from ?192.168.1.11? (abwo50.neoplus.adsl.tpnet.pl [83.8.238.50])
        by mx.google.com with ESMTPS id 23sm10353209eya.7.2008.10.05.16.54.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 05 Oct 2008 16:54:06 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <00b201c92739$36585eb0$a3091c10$@se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97554>

On Mon, 6 Oct 2008, Tjernlund wrote:
> Jakub Narebski wrote:
>> "Tjernlund" <tjernlund@tjernlund.se> writes:

>>> 2) looking at a merge like:
>>> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=66120005e65eed8a05b14a36ab448bdec42f0d6b
>>>    is somewhat confusing. It really doesn't tell you which commits that is
>>>    included in the merge.
>> 
>> I don't understand you there. First, you have "(merge: 0d0f3ef 9778e9a)"
>> in the navbar, so you can easily go to commit view for parents. Second,
>> among commit headers you have two "parent", where SHA-1 of a commit is
>> hidden link, and there are also 'commit' and 'diff' link for those.
> 
> hmm, looks like I overlooked "(merge: 0d0f3ef 9778e9a)" part. However, I can't
> find the "ALSA: make the CS4270 driver a new-style I2C driver" from within
> this page.

I think you don't quite understand the situation. The history looks
like this:

    M      Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6
    |\
    | 2    ALSA: ASoC: Fix another cs4270 error path
    | *    ALSA: make the CS4270 driver a new-style I2C driver
    | |
    1 |    Merge git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi-rc-fixes-2.6  

Parents of commit 'M' (for merge) are '1' and '2', not 2,* or 1,2,*.

Now the fact that commit message for merge contains shortlog of merged
branch does not mean that there must be direct link to such shortlog.
You can go to shortlog (well, kind of) if you click on second parent,
_then_ click on shortlog link at top of the page.

-- 
Jakub Narebski
Poland
