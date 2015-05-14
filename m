From: Stefan Beller <sbeller@google.com>
Subject: Re: Problem with rerere forget
Date: Thu, 14 May 2015 11:57:03 -0700
Message-ID: <CAGZ79kZC-Kn4FbHgkifeDew7_qpGJSFDaqO=F=bok1FUzm=1Ew@mail.gmail.com>
References: <CAPt1q6fMMz61aZEJB9b+K6+kHFwkm+bMYXoKBj78GNJU+dWioA@mail.gmail.com>
	<CAGZ79kZ8Cy1Pp9cf7vExntbfe-YW5KjYx6Fogr3O94wDfwuOXg@mail.gmail.com>
	<CAPt1q6d3euApCKLUBjssyfBmeVw0TVYOqDmTZL79gN1TvtxdsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Alex Coppens <alex@nativetouch.com>
X-From: git-owner@vger.kernel.org Thu May 14 20:57:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsyJi-0006Hp-0i
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 20:57:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbbENS5F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 14:57:05 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:34469 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753360AbbENS5D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 14:57:03 -0400
Received: by iecmd7 with SMTP id md7so68772334iec.1
        for <git@vger.kernel.org>; Thu, 14 May 2015 11:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8vgpsTIvCuraPstQAmKqAxIAeByvxtgRxrFR1MX8a1A=;
        b=UstZxg5KVCzQ+jGJH7YjDE5UFFOV8lXTdq1+2MvUDT+dU5XwN2gsrKycEk5C9Bcl+o
         zcS3qHPnOb/oKK08XyN5Yi0G93aPsBqq6myjZsvXvucXg/GdHxbKroEjL/EHDcZW55EM
         qfVKEhhgB9QMfzoneB+dzptb1CZY2IEyYUp65SGcESCwG4cvTP8hWs/VDxA9l7/vSRwC
         wT/2pJ6NXvWqrJYhnCfjnMFmK1N1FfGDLL5TLQjixCIuc56wUl0kDoqd1+aVPjW8Qghp
         rLkPEcyF+XpVmeprA3gmT3HvXx9xp9b85gpvjeYD2uoacR5H/k13FDOGa1Gl1oG2u8qW
         H0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=8vgpsTIvCuraPstQAmKqAxIAeByvxtgRxrFR1MX8a1A=;
        b=M3/tJ+s5+7oegOx0O9ZJ1qnAsayz1lzw+U0k3nH/+qRdZ8ZCM+tGpOWq/uoAOhpmRX
         hHrRHw17qs8DLcy1O0KwglxLNowjOqjX6xcdmzauTuGXAVq8hoAvErs/E6u+q6CHeZZx
         Egi8o84cy+HEjT2cNgaZH8ErM5GY17RyCr7nMcRn2DYsRDkvrZUUEQ8GqZhIxzx29nEo
         fQpsZKk+ZnqW8deqg3CKpNTT9X5SwlN7kedeeATWfv7SulDlVFhukjTC5RKsdvIQtiAb
         u7SE5sY3QUUbmWB2keNxJDlFzjCSQPYEAby3QuUGfmT/Lr3IEIMOzfX6AjIetHsdjoZZ
         rwDg==
X-Gm-Message-State: ALoCoQkVOjDQZxV2Yt3MuBYnROLQSGmTxk7eKiOJIoS+ZxfTF1WxMcrsaOa/S8aEWUaJT9raiwJ/
X-Received: by 10.42.213.136 with SMTP id gw8mr16179726icb.95.1431629823363;
 Thu, 14 May 2015 11:57:03 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Thu, 14 May 2015 11:57:03 -0700 (PDT)
In-Reply-To: <CAPt1q6d3euApCKLUBjssyfBmeVw0TVYOqDmTZL79gN1TvtxdsA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269068>

On Thu, May 14, 2015 at 11:40 AM, Alex Coppens <alex@nativetouch.com> wrote:
> I use git version 2.2.1. I cannot provide an example repository that
> reproduces the error.
>
> What does git bisect do?

git bisect looks at the git history and performs a binary search on it to find
the commit which introduced a bug.
http://git-scm.com/docs/git-bisect

To find the bug that way, you'd need to get the source code of git and
compile it
yourself though (multiple times until the bug is found)
