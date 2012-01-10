From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 6/6] clone: print advice on checking out detached HEAD
Date: Tue, 10 Jan 2012 12:54:11 +0700
Message-ID: <CACsJy8D=eVfhZOC3m3H50WZxa_Ep_UVYD_ZaEVj8H1C1z7+PRQ@mail.gmail.com>
References: <1325771380-18862-1-git-send-email-pclouds@gmail.com>
 <1326023188-15559-1-git-send-email-pclouds@gmail.com> <1326023188-15559-6-git-send-email-pclouds@gmail.com>
 <7v4nw4cs1x.fsf@alter.siamese.dyndns.org> <CACsJy8CuYkzFVrEG6T2HUAwJGnjit2xWt3VSN-9USt7h+B_CBw@mail.gmail.com>
 <7vlipgb1r1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 10 06:54:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkUfZ-00078n-G3
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 06:54:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752643Ab2AJFyo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 00:54:44 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:52009 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752371Ab2AJFyn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 00:54:43 -0500
Received: by bkvi17 with SMTP id i17so181259bkv.19
        for <git@vger.kernel.org>; Mon, 09 Jan 2012 21:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=IAwe0RCJLn7gN/qw6cmPiEFXfONWA20FJ7isy5xExG4=;
        b=tStk5un3AyAPiWPU1rcQ9prMOWbHu3MvCcx5BLxV550b6usKnCSEfAtVFV1Y4Xfjmv
         czVVPyEftQVzcUht6zieDfL6NgnI2WNn0doixV3PdVCSfxGfPzjwxzuE3MgiIhgwO6K2
         ztWLowuWLBFa70K03VNy8Qf3r2EFVYyh4DZT4=
Received: by 10.204.154.136 with SMTP id o8mr8399709bkw.112.1326174882193;
 Mon, 09 Jan 2012 21:54:42 -0800 (PST)
Received: by 10.204.66.77 with HTTP; Mon, 9 Jan 2012 21:54:11 -0800 (PST)
In-Reply-To: <7vlipgb1r1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188220>

On Tue, Jan 10, 2012 at 11:49 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> 2012/1/10 Junio C Hamano <gitster@pobox.com>:
>>> This patch makes 100% sense _if_ we let clone result in a repository with
>>> a detached HEAD, which I am not sure if it is a good idea, or if it is
>>> better to fail the attempt to clone to give incentive to the owner of the
>>> remote repository to fix it.
>>
>> Then a hostile remote can stop users from cloning his repository by
>> detaching HEAD? That's not nice.
>
> That's crazy talk. Why does anybody from a hostile remote to begin with?

The point is, why punish client for remote's problems? If I have to
talk to upstream and wait for them to fix their repository, I might as
well give up cloning and move on. It's OK to annoy users to the point
that they ask upstream for a fix, but we should not disallow clone in
that case.
-- 
Duy
