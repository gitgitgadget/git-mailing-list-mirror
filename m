From: Chris Leong <walkraft@gmail.com>
Subject: Re: diff -G with case insensitivity
Date: Thu, 16 Feb 2012 11:33:36 +1100
Message-ID: <CAJ6vYjcxNJ_OHLiV6x2kTqEafetMT-0BXHu1YdxK-DMJZRre0w@mail.gmail.com>
References: <CAJ6vYjejtZkupy750rvz6HW_0SNPyBVTa78DO4nY8Bi368neQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 16 01:34:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxpIu-0003LL-Dj
	for gcvg-git-2@plane.gmane.org; Thu, 16 Feb 2012 01:34:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752063Ab2BPAd6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Feb 2012 19:33:58 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:53772 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751436Ab2BPAd5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2012 19:33:57 -0500
Received: by bkcjm19 with SMTP id jm19so1481093bkc.19
        for <git@vger.kernel.org>; Wed, 15 Feb 2012 16:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=nAzXe2cPMqsNQ2OfQ3Om+KOlPmTln0EFBoEJbDBNBbM=;
        b=o8IwxnVKFHEyKcBDrv5dIN+HP6rOjSxuc7CVih7UWZgIhrNV7/58BiobEgLJcagXCV
         YLi3eCWS1/gTUzqVk7loCi8w5NqaIiB7tXMzY+cK6T+SGSF8FodCwoW0ZLF94jAXzAuW
         osx2Q0tRAbY+Fq1R4L0BflZx/U0YV6FrnmCUw=
Received: by 10.205.131.13 with SMTP id ho13mr144249bkc.58.1329352436250; Wed,
 15 Feb 2012 16:33:56 -0800 (PST)
Received: by 10.205.34.200 with HTTP; Wed, 15 Feb 2012 16:33:36 -0800 (PST)
In-Reply-To: <CAJ6vYjejtZkupy750rvz6HW_0SNPyBVTa78DO4nY8Bi368neQw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190868>

Also, is there a method to restrict it to only showing the chunks that
match - rather than files?

On Thu, Feb 16, 2012 at 11:18 AM, Chris Leong <walkraft@gmail.com> wrote:
> Is there any way to run diff -G with a case insensitivity flag?
