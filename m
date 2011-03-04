From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH/RFC] init, clone: support --real-git-dir for .git file
Date: Fri, 4 Mar 2011 13:39:39 +0700
Message-ID: <AANLkTik3+g10ihwc4wZK0bFBKr0TMBF9M5BtzW_O1vBA@mail.gmail.com>
References: <1299156201-12149-1-git-send-email-pclouds@gmail.com>
 <7v8vwv927a.fsf@alter.siamese.dyndns.org> <AANLkTimG7Hg4YxJbMVaXVkZ1CRb0ttK6RAYEoRQ_4iW4@mail.gmail.com>
 <7v4o7j8lxg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 04 07:40:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvOgT-0002qz-CF
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 07:40:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423Ab1CDGkL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2011 01:40:11 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59843 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103Ab1CDGkK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2011 01:40:10 -0500
Received: by wyg36 with SMTP id 36so1810325wyg.19
        for <git@vger.kernel.org>; Thu, 03 Mar 2011 22:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=a2N7Mz3op8aJlfM+DNuufZNUzFuR+L6RBxZ47fmeb9s=;
        b=GkJPA0bwyxT/8DzjsQL2YkeakWKXI0LQTN2Rezr7bp0hLBHsYAo1Yz6uCCZc3rk92m
         ycdu/DFkhXvMok0mcbN8nOqYJZ39fDfJtTv8IIQ9BhgfMI9gIrY/IVckTlXCwMW7nuLy
         fl6OIHVJpw7xxfm7YZzc0UkJCoH2Utf7gkR2k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=a5GjhrtAn+t1lfrQpSVcOPJqPQGfMYldPdI+sPLToJ/gOV2mwTOwgIgtsyraE8T452
         XMmkh4R9/QVSkwCo6P7KoqujeGCnYr782RElqA0gRMlfHQb125BebD7jwUMDtmiY6AKx
         BNO6dufaTN6MbMJQCVbKuyYVuXzN4r6uySwwQ=
Received: by 10.216.82.13 with SMTP id n13mr225099wee.1.1299220809069; Thu, 03
 Mar 2011 22:40:09 -0800 (PST)
Received: by 10.216.239.5 with HTTP; Thu, 3 Mar 2011 22:39:39 -0800 (PST)
In-Reply-To: <7v4o7j8lxg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168429>

On Fri, Mar 4, 2011 at 1:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> Moving .git away from existing repos/worktrees I have.
>
> You are only saying you want to move it, not saying why you want to move
> it.
>
> That is not an explanation _why_ it is useful to be able to do so.

The same reason why I don't want to place .git close to worktree in
the first place (paranoid, throwaway worktree, disk constraint...). If
I'm going to make a policy that "there must be no .git under ~/w", new
repos with --real-git-dir are ok, but what about old repos?
-- 
Duy
