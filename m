From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH v2] blame: Add option to show author email instead of name
Date: Thu, 21 Oct 2010 13:38:17 -0700
Message-ID: <A4458F9B-04F5-42EF-86AB-6744E9DAE1C5@sb.org>
References: <7vsk02ypj5.fsf@alter.siamese.dyndns.org> <1287535323-20347-1-git-send-email-kevin@sb.org> <20101021180525.GA11501@burratino> <79AB0864-E151-468E-9C86-EBCAD929938B@sb.org> <20101021203210.GA12685@burratino>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 21 22:38:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P91u5-0005o1-Jy
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 22:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756823Ab0JUUiU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 16:38:20 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:55268 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756744Ab0JUUiT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 16:38:19 -0400
Received: by pzk3 with SMTP id 3so2609pzk.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 13:38:19 -0700 (PDT)
Received: by 10.142.226.1 with SMTP id y1mr1231909wfg.292.1287693499141;
        Thu, 21 Oct 2010 13:38:19 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id e14sm3027273wfg.8.2010.10.21.13.38.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 13:38:18 -0700 (PDT)
In-Reply-To: <20101021203210.GA12685@burratino>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159563>

On Oct 21, 2010, at 1:32 PM, Jonathan Nieder wrote:

> Kevin Ballard wrote:
>> On Oct 21, 2010, at 11:05 AM, Jonathan Nieder wrote:
> 
>>> Bonus nit: does this belong in annotate-tests.sh or does it only apply
>>> to "git blame" and not "git annotate"?  If the latter, a note in the
>>> commit message would be helpful.
>> 
>> --show-email originally only applied to git-blame. I tweaked the
>> patch to make it apply to git-annotate simply because check_count
>> can't handle the format of git-blame, but the intention of the
>> change wasn't to make it apply to git-annotate in the first place.
>> You'll note I also didn't document it in the manpage for
>> git-annotate. If you think it's better to move it into
>> annotate-tests.sh, I can do that, but that does mean officially
>> declaring git-annotate as supporting --show-email.
> 
> No preference, since I never use "git annotate" myself.  In fact,
> long term, I'd rather see a "git blame --format=<template>" appearing
> and "git annotate" replaced with a thin script wrapping "git blame".
> 
> Anyway, whatever you decide, it would be nice to document it in the
> commit message, no?  e.g.:
> 
> 	The tests and documentation only affect "git blame",
> 	because...

Will do.

-Kevin Ballard
