From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: What's in git.git (Aug 2009, #01; Wed, 05)
Date: Fri, 07 Aug 2009 09:01:43 -0500
Message-ID: <dSTzkQzxc8zstXelCsOfpeKtZA6klAYAoFqmV5dstEQ@cipher.nrlssc.navy.mil>
References: <7vd479x6hx.fsf@alter.siamese.dyndns.org> <MEhvdM_GHnyaFj9ZU3lxKS47vmOk5BKslGm0FxkE_lg0SQT5Zx6KhA@cipher.nrlssc.navy.mil> <20090807123346.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 16:02:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZQ1O-0005ab-Gn
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 16:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756750AbZHGOBu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2009 10:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756178AbZHGOBu
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 10:01:50 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:41322 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756752AbZHGOBt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2009 10:01:49 -0400
Received: by mail.nrlssc.navy.mil id n77E1hXq005262; Fri, 7 Aug 2009 09:01:46 -0500
In-Reply-To: <20090807123346.6117@nanako3.lavabit.com>
X-OriginalArrivalTime: 07 Aug 2009 14:01:43.0508 (UTC) FILETIME=[98248140:01CA1767]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125196>

Nanako Shiraishi wrote:
> Quoting Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
> 
>> Junio C Hamano wrote:
>>> The 1.6.4 release seems to have been quite solid, and there is no
>>> brown-paper-bag bugfixes on 'maint' yet ;-).
>> Found one.
>>
>> I didn't realize the whole git-am discussion did _not_ result in a
>> fix being applied.  But git-am will currently refuse to apply any
>> patch from email that does not have "From " or "From: " in the first
>> three lines of the email.  For those of us whose mail servers prepend
>> many lines of the form:
>>
>> Received: from XXX ([XXX]) by XXX with Microsoft SMTPSVC(6.0.3790.2825);
>> 	 Tue, 14 Jul 2009 07:24:06 -0500
> 
> According to an already hashed out discussion, that isn't a mbox format that has been supported, so it isn't even a bug. For details, see e.g.
> 
>     http://thread.gmane.org/gmane.comp.version-control.git/123338/focus=123355
> 
> And Nicolas Sebrecht has been working with Junio to implement an enhancement to add support for the "individual piece of email" format.

Commit b3f041fb0f7de167dbb6711b0a231d36c4b5de08 titled 'git-am support for
naked email messages (take 2)' by H. Peter Anvin from December 2005 seems
to indicate otherwise.

IMHO, I think something was indeed broken here, but it is a moot point
since it will all be fixed (or "enhanced" depending on your POV) soon. :)

-brandon
