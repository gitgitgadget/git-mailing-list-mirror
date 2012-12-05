From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC] Add basic syntax check on shell scripts
Date: Wed, 5 Dec 2012 12:43:30 +0700
Message-ID: <CACsJy8BtX9fMkGDoVGKzgz7SSinbt0561B1ZKHu6fs+n8ewKGg@mail.gmail.com>
References: <201212021417.25525.tboegi@web.de> <7vzk1vrs63.fsf@alter.siamese.dyndns.org>
 <CACsJy8BxviWRHqGvptsJVmkFM6HQa9HnLWsh5V6Ec6Fqv52sGA@mail.gmail.com> <7vobi9mwt4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 06:44:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tg7mO-00027N-8u
	for gcvg-git-2@plane.gmane.org; Wed, 05 Dec 2012 06:44:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751643Ab2LEFoD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2012 00:44:03 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:39121 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803Ab2LEFoB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2012 00:44:01 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so4773180oag.19
        for <git@vger.kernel.org>; Tue, 04 Dec 2012 21:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=l8cTX9TzhXVpkDSKr7XEK0Wep1WXCSzVkmsHZAbwPh8=;
        b=TWO5wyKLwlzgTHhcy/oC18Swx9GfBSJdK9k2G1Dup7qdLkli0BEOCVjUQuZE5K/h9w
         nx3V3723Kzx7Y4RGJizbN3Sq+YMhy5b00KapAD5jKPzVimVQ62f+oqCdWmlFSyFjVOwW
         zlaMJSzDMZa2JF7ivQkrn4eaeVEmToz9samLnvTUYF4NeBTJVBGJWkxaXTkvbfiOssNS
         zhCqnCQWZ4S2EmFQQJRZ908Hoc+l4MKACRwBs1sVKrO8q76RUCmxKgmnMt6CTFvjjV2+
         /yPz+pjufcOgYHniFE3N1/1bMpd42sKUSNeMXX4UdnbGjVeBDPMAMsMCG6cvX4D1tKYN
         B+hA==
Received: by 10.182.179.100 with SMTP id df4mr9857947obc.59.1354686241194;
 Tue, 04 Dec 2012 21:44:01 -0800 (PST)
Received: by 10.182.51.138 with HTTP; Tue, 4 Dec 2012 21:43:30 -0800 (PST)
In-Reply-To: <7vobi9mwt4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211104>

On Wed, Dec 5, 2012 at 2:39 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Or a project commit hook?
>
> Surely.  It is OK to have "cd t && make test-lint" in your
> pre-commit hook.

No, what I meant is a shared pre-commit script that all git devs are
encouraged (or forced) to install so bugs are found locally rather
than after patches are sent to you. The hook content does not really
matter.
-- 
Duy
