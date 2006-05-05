From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] Git wiki
Date: Fri, 05 May 2006 08:26:52 +0200
Organization: At home
Message-ID: <e3er79$6s4$1@sea.gmane.org>
References: <20060505005659.9092.qmail@science.horizon.com> <20060505062236.GA4544@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri May 05 08:27:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbtmO-00006E-Oc
	for gcvg-git@gmane.org; Fri, 05 May 2006 08:27:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbWEEG1E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 May 2006 02:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbWEEG1D
	(ORCPT <rfc822;git-outgoing>); Fri, 5 May 2006 02:27:03 -0400
Received: from main.gmane.org ([80.91.229.2]:13798 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750978AbWEEG1C (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 May 2006 02:27:02 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FbtmE-0008WC-Fu
	for git@vger.kernel.org; Fri, 05 May 2006 08:26:58 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 05 May 2006 08:26:58 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 05 May 2006 08:26:58 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19601>

Fredrik Kuivinen wrote:

> On Thu, May 04, 2006 at 08:56:59PM -0400, linux@horizon.com wrote:
>> What people who are asking for explicit rename tracking actually want
>> is automatic rename merging.  If branch A renames a file, and branch B
>> corrects a typo on a comment somewhere, they'd like the merge to
>> both patch and rename the file.  If you can do that, you have met the
>> need, even if your solution isn't the one the feature requester
>> imagined.
> 
> I don't know if you already know this, if you do it might be valuable
> for other readers.
> 
> If the rename is detected by the current rename detection code
> (git-diff-tree -M) then the merge case described above is handled
> perfectly fine by the current git. That is, the rename is followed and
> the patch fixing the typo is applied to the renamed file. This assumes
> that the default merge strategy (recursive) is used.

And if you do 'commit - rename, no changes - commit' sequence then rename
will be detected. 

-- 
Jakub Narebski
Warsaw, Poland
