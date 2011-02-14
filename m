From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [1.8.0 RFD] Homogeneous use of short options
Date: Mon, 14 Feb 2011 22:19:11 +0700
Message-ID: <AANLkTikFEQTrt+vw5tJ+prSB0Krb9VOZFg+Wn0G_Movr@mail.gmail.com>
References: <4D594460.1040206@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Feb 14 16:21:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp0ER-0007UZ-Sk
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 16:20:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755721Ab1BNPUb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 10:20:31 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:60702 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755218Ab1BNPU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 10:20:28 -0500
Received: by wyb28 with SMTP id 28so4818425wyb.19
        for <git@vger.kernel.org>; Mon, 14 Feb 2011 07:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=yqpPfJ+8ZF+lM/iuJTY2hCRzZwcie87GPfaPWR0tYv4=;
        b=JRGY8K4fhtzgZ4I9DJKxhrap9jLaMniF8bxURihVv+00MtEupIhh9ZFnkGAYHwOuub
         NSFbVRW/mXqIWuSDDQBLDzek2g24Gk+Ojb1cIimWQNKcbN+Lg2sfoSUFQO2LAnB03Chz
         Z+nxl4ec+Ct0NbpajPjUJ2hgUxwwYdiXVISU0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=HFZoVApIxKs5js0yfIXsrAPQH4vdpgb1SZVXyZoegtR49nqjiv6x8H1sJK5DkGnakY
         1PRgyCguL4LJGB2lggXnN+fk6UiaDfvmzymxlxZq4l4NviO8YFLQAnCnXdTRthSCLeCX
         QfZ+wwpUEWCjZzdXVOcmgZej0UnD2xVJiT4CU=
Received: by 10.216.50.72 with SMTP id y50mr781330web.28.1297696827314; Mon,
 14 Feb 2011 07:20:27 -0800 (PST)
Received: by 10.216.66.144 with HTTP; Mon, 14 Feb 2011 07:19:11 -0800 (PST)
In-Reply-To: <4D594460.1040206@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166726>

On Mon, Feb 14, 2011 at 10:04 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Proposal:
> Make our use of short options more homogeneous.
>
> ...
>
> Risks:
> Users and scripts may obviously depend on the current options names.
>
> Migration plan:
> Introduce new options first (1.7.x) along with warnings in the release
> notes (optionally, make the commands output warnings). Then change the
> behavior in 1.8.0.

Sometimes I think we could just add a new "root" name for total UI
redesign. Say all commands starting with "gic" (or whatever name it
is, "gt" may be even shorter) will have new/consistent behavior while
"git" ones remain unchanged (or changed gradually and sloooowly). It
happened with bazaar (baz vs bzr) long ago.
-- 
Duy
