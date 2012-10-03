From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: push.default documented in "man git-push"?
Date: Wed, 3 Oct 2012 14:22:39 +0530
Message-ID: <CALkWK0n2o64K4wHDGiHjEcC3BEkoT1tmbhS5=zYzJzwKyAUJvg@mail.gmail.com>
References: <CAN7QDoK4WCuRMu+KV6ACo9miR9_eFEE510J5PDiPk+BXLyQG9Q@mail.gmail.com>
 <CALkWK0mxLQNOE8kZUJrxYQMWXpzZW0uS+N2iGXxdRmCXTzYcBQ@mail.gmail.com>
 <CAN7QDoJ=PKt_1zW58648tcaT7MP1MTVJo9E4PW5g93K_tO91Jw@mail.gmail.com>
 <CALkWK0nQu_vvLGu=j2CDkGcKtp-T401kDyhD5_iMqQrkGk9K8Q@mail.gmail.com> <7vbogk90zk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Glasser <glasser@davidglasser.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 10:58:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJKmQ-0004lc-B0
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 10:58:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481Ab2JCIxG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 04:53:06 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:44295 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010Ab2JCIw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 04:52:59 -0400
Received: by qchd3 with SMTP id d3so5353429qch.19
        for <git@vger.kernel.org>; Wed, 03 Oct 2012 01:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4Y1RYQwh98KNHH+NF+S1O4dBIHkRVZOzR+pw1fB6gXw=;
        b=wLh31EnqUD1kcJuqONiut7JnaZyJ0LructeC6WvaJZwXQpxfGLnryqsqaiiHtRlFbq
         uadb6Eff2dXb4Y7n93joXESQQvHJ1/UmG0I8QsnOovBx6nvNPp/AsWowlT6mIb2qRVCg
         G9CDInZMUu8n07YR7vobwXNb8wnKV3m1w1ZBIODQ1bf8/7fJ2t1mRyIQa5QnZuzL4Ngt
         f9KXeYLn5YtRd014fdtQ/fq4Up8BBls7H3CMnw/RqVpd25uMvHXLtFI5IB99A0ozyCnG
         8oU7fdFAy//kGGYTzCuRRmtGAWVLUyuluUDSbJeRGTsLkPUd802JaS+KNcnNvJRgMa9X
         BReg==
Received: by 10.224.173.84 with SMTP id o20mr6285186qaz.3.1349254379234; Wed,
 03 Oct 2012 01:52:59 -0700 (PDT)
Received: by 10.49.84.105 with HTTP; Wed, 3 Oct 2012 01:52:39 -0700 (PDT)
In-Reply-To: <7vbogk90zk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206875>

Junio C Hamano wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>> [...]
>> --8<--
>
> FYI: the above is not a scissors line.

Excerpt from git-mailinfo[1]:

--scissors::
	Remove everything in body before a scissors line.  A line that
	mainly consists of scissors (either ">8" or "8<") and perforation
	(dash "-") marks is called a scissors line, and is used to request
	the reader to cut the message at that line.  If such a line
	appears in the body of the message before the patch, everything
	before it (including the scissors line itself) is ignored when
	this option is used.

Does it need to be updated to say that a space is required between the
perforation and the scissors?

Ram
