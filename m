From: Gerhard Wiesinger <lists@wiesinger.com>
Subject: Re: Metadata and checkin file date
Date: Tue, 27 Apr 2010 21:41:56 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1004272139080.5630@bbs.intern>
References: <alpine.LFD.2.00.1004270719320.17234@bbs.intern> <m3sk6hck8b.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 27 21:42:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6qg1-00078R-5f
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 21:42:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756745Ab0D0Tmb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 15:42:31 -0400
Received: from chello084112167138.7.11.vie.surfer.at ([84.112.167.138]:37386
	"EHLO wiesinger.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754900Ab0D0Tma (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Apr 2010 15:42:30 -0400
Received: from bbs.intern (localhost [127.0.0.1])
	by wiesinger.com (8.14.4/8.14.4) with ESMTP id o3RJfuNi011037;
	Tue, 27 Apr 2010 21:41:56 +0200
Received: from localhost (gerhard@localhost)
	by bbs.intern (8.14.4/8.14.4/Submit) with ESMTP id o3RJfucd011033;
	Tue, 27 Apr 2010 21:41:56 +0200
In-Reply-To: <m3sk6hck8b.fsf@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-MailScanner-Information-wiesinger-com: Please contact the ISP for more information
X-wiesinger-com-MailScanner-ID: o3RJfuNi011037
X-MailScanner-wiesinger-com: Found to be clean
X-MailScanner-SpamCheck-wiesinger-com: not spam, SpamAssassin (not cached,
	score=-4.351, required 4.5, autolearn=not spam, ALL_TRUSTED -1.80,
	AWL 0.05, BAYES_00 -2.60)
X-MailScanner-From: lists@wiesinger.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145938>

On Tue, 27 Apr 2010, Jakub Narebski wrote:

> Gerhard Wiesinger <lists@wiesinger.com> writes:
>
>> Hello,
>>
>> I'm new to git and I'm looking for the following features:
>> 1.) Metadata for
>>    a.) directory versioning (e.g. add/rm, mv)
>>    b.) rights (basic: chmod, chow, chgrp, extended: extended
>> attributes like ACLs and selinux), necessary for versioning e.g. /etc
>> 2.) Original file dates (checkin date) on clone and pull (and not
>> checkout date)
>>
>> Is this possible? Any plans if missing?
>
> Git is distributed version control system (DVCS), not a backup system.
> It is used mainly for distributed development of programs.  Therefore
> it supports natively only those parts of metadata that make sense for
> VCS, namely symlinks (with workaround for filesystems that do not have
> support for symbolic links) and the executable permission for files.
>
> File ownership does not make sense for VCS, as other people that clone
> your repository do not have the same set of users that you have, and
> might not have the same set of groups that you have.  Neverthemind that
> their filesystem might not support notion of file ownership, not only
> do not have support for extended attributes and the like.

I would suggest that only with special switches like --preserve-chmod 
--preserver-owner --preserve-group , etc. where one can guarantee user, 
groups, etc. See also my second post for arguments.

> If you really, really need this, you can use additional tools to
> preserve metadata, like Metastore or git-cache-meta, or even ready
> tools that use Git as bckend like IsiSetup or bup (well, bup use
> git package format, not git itself...), see this Git Wiki page:
> https://git.wiki.kernel.org/index.php/InterfacesFrontendsAndTools
>

Will have a look at them.

Thnx.

Ciao,
Gerhard

--
http://www.wiesinger.com/
