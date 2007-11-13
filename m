From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] user-manual: Talk about tracking third-party snapshots
Date: Tue, 13 Nov 2007 16:38:50 +0100
Message-ID: <200711131638.50437.jnareb@gmail.com>
References: <11949569992214-git-send-email-msmith@cbnco.com> <fhcb29$ef$2@ger.gmane.org> <87zlxi88op.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 16:39:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrxrC-0002jj-0W
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 16:39:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755488AbXKMPi5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 10:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755344AbXKMPi5
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 10:38:57 -0500
Received: from fk-out-0910.google.com ([209.85.128.187]:44038 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755324AbXKMPi4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 10:38:56 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1840321fkz
        for <git@vger.kernel.org>; Tue, 13 Nov 2007 07:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=d7vdRls8Wm6XOL2Eop8dwTbGKs4DGIxqVw9Ski9Y0tU=;
        b=n8+cRb5JF286xXS3isGJC6KS/Om+rJk8TCzNP2AVdCw9bzjamcnjwmd8ZYwsr2aVAVp34haM13EXI1s9PHFX8BXoi1ubhT3NRgvZNqKM7NkRvJs3CtCMuVwvC1Fs63/qkRk92oY9iLIY6TPc0mz9McpMREku0WAkIVvX5mBb9dM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=jb6mrwu/8o/fqkpSTm1T2ANR5dgeazYSEY0zISnchXeTPeGoH1nPyEaxOjKSIBftBN0rMWGLU9Pmwst729kU681qchLPtpstNzXCH1+n1TdLLj+1mU8qVlR42cGkM8EoDOVkzNJpj7MGRVwApXdc7Msrf38/PNxjytl8AmJGY7o=
Received: by 10.82.124.10 with SMTP id w10mr15326864buc.1194968334869;
        Tue, 13 Nov 2007 07:38:54 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.220.125])
        by mx.google.com with ESMTPS id z34sm82936ikz.2007.11.13.07.38.51
        (version=SSLv3 cipher=OTHER);
        Tue, 13 Nov 2007 07:38:52 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <87zlxi88op.fsf@osv.gnss.ru>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64809>

Sergei Organov wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Michael Smith wrote:
>>
>>> +You can use the gitlink:git-cherry[1] command to display the commit
>>> +IDs that are only present on your local branch, or only on the remote
>>> +branch, respectively:
>>
>> I think git-cherry is deprecated in favor of "git log --left-right" (with
>> appropriate format, for example '--abbrev-commit --pretty=oneline')
>>
>> BTW. that means that git-cherry can be removed from git-help output,
>> I think.
> 
> And from core-tutorial.txt:1567:
> 
> 4. Use `git cherry origin` to see which ones of your patches
>    were accepted, and/or use `git rebase origin` to port your
>    unmerged changes forward to the updated upstream.
> 
> ???

On one hand, core-tutorial is old documentation, dating before
--left-right option to git-log.

On the other hand I have forgot that git-cherry does more throghout
checking if patch was accepted upstream (by checking changeset).


Sorry for the noise...
-- 
Jakub Narebski
Poland
