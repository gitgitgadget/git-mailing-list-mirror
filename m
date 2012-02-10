From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Jan 2012, #08; Tue, 31)
Date: Fri, 10 Feb 2012 11:43:23 +0700
Message-ID: <CACsJy8B_nsZnSarbRaBoxviK1xa_PVP0-DbnMiP9HkwzrztfJg@mail.gmail.com>
References: <7vlion3tr5.fsf@alter.siamese.dyndns.org> <7vsjijs9rq.fsf@alter.siamese.dyndns.org>
 <7vhayzs51s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, tbushnell@google.com, tytso@google.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 05:44:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RviLS-000439-Uw
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 05:44:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758355Ab2BJEnz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 23:43:55 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:60194 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754806Ab2BJEny (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 23:43:54 -0500
Received: by wics10 with SMTP id s10so1731119wic.19
        for <git@vger.kernel.org>; Thu, 09 Feb 2012 20:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=XYC7FLwv8y3+LWSDlxcG8yyWhDtf3uk3kFHBlesP2gA=;
        b=pyX2t+xZbJYn2fOr78JrYGKcs7T4+QUWrg1u+GDb/kaB03JzGqYNTNaZOdAfsuzjrP
         He1aDT2uqRy9JR+zD/EZ5faK0Sy/tE89FM+GbHdbg9x2PsHCzJpsa34kLICLcME1lerJ
         ro19NFTQX8M9rXnx+iVFVi57iakeZujHfZBQg=
Received: by 10.180.87.8 with SMTP id t8mr738455wiz.15.1328849033197; Thu, 09
 Feb 2012 20:43:53 -0800 (PST)
Received: by 10.223.2.139 with HTTP; Thu, 9 Feb 2012 20:43:23 -0800 (PST)
In-Reply-To: <7vhayzs51s.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190380>

2012/2/10 Junio C Hamano <gitster@pobox.com>:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> It turns out that this series, as a side effect, fixes a long-standing bug
>> that the --branch option cannot be used with the --mirror option.
>>
>> I am tempted to merge it also to 1.7.9.1 maintenance track. The issue is
>> minor (you can always clone with --mirror and then switch the branch with
>> "checkout") and it does not look like it warrants further backpointing to
>> 1.7.8 and older releases, though.
>>
>> Comments and/or objections?

No objections. Does it fix a failed test? If not, should we add a test
to record this side effect fix?

> Replying to myself.
>
> Regardless of "'refs/heads/$branch' is not found because we do not look
> for in the right place" issue, shouldn't the use of the --mirror without
> the --bare option forbidden or at least warned about?

--mirror implies --bare in cmd_clone() if I read it correctly.
-- 
Duy
