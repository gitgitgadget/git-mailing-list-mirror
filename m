From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v4 2/2] submodule: fix handling of relative superproject
 origin URLs
Date: Thu, 24 May 2012 12:32:31 +1000
Message-ID: <CAH3AnrqekvFL3qvRh7HFCENG8-kO5xxnG113_xPqnhjHgxYtzA@mail.gmail.com>
References: <1337791554-31294-1-git-send-email-jon.seymour@gmail.com>
	<1337791554-31294-3-git-send-email-jon.seymour@gmail.com>
	<4FBD5B8C.60605@web.de>
	<CAH3AnrrYm_KeP64yDc+gujkYqj-kiuLQ4URHX5Z57vj5XXLfKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu May 24 04:32:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXNqx-0002qR-6b
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 04:32:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755469Ab2EXCcd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 May 2012 22:32:33 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:38048 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993Ab2EXCcc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2012 22:32:32 -0400
Received: by wgbdr13 with SMTP id dr13so7804938wgb.1
        for <git@vger.kernel.org>; Wed, 23 May 2012 19:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=kdPmx8tqSifNqMhCHGLgP1L0TRYr9HgsgdB4mifgD7M=;
        b=zjyRK7wdEfboTTmKGSzwXX8MiTTZWqCHAPlGR9Mxo/pcuyHduwuMBVlz+gjvsBdkbh
         v3H9j/GgAorN1ZYpIXXmxqoR2U2+lnoJkojq9hCv3s9ysRxOs2+idg1GNUAigxsdXRjn
         YAdUw0AmF7y2ZdgyoPpR/LmBM2tGZ6JBqtlq6PkKZSSg+2kFWhMhIZ7UJFJKsDWL6fzD
         7yyq8xKCqEPNbbtJfpONwBn7cBb9wgZHYGGCy7ENO/hgS1uqBZKSUjx0mzw5j9UbKpp7
         Jo7k2rV12Tgz9aHc8swORTx0AhgFDe6Fux5mvBWxAotRbk3cPmGOPp4S+gcRx+HM3EjN
         7OgA==
Received: by 10.216.143.223 with SMTP id l73mr15299641wej.97.1337826751796;
 Wed, 23 May 2012 19:32:31 -0700 (PDT)
Received: by 10.180.146.166 with HTTP; Wed, 23 May 2012 19:32:31 -0700 (PDT)
In-Reply-To: <CAH3AnrrYm_KeP64yDc+gujkYqj-kiuLQ4URHX5Z57vj5XXLfKw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198342>

On Thu, May 24, 2012 at 8:17 AM, Jon Seymour <jon.seymour@gmail.com> wrote:
> On Thu, May 24, 2012 at 7:50 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>> Am 23.05.2012 18:45, schrieb Jon Seymour:
>> Wouldn't that better be handled in the ".*/*)" case above to avoid
>> accidentally affecting the other cases?
>
> Yes, I think you are right. Thanks.
>

Turns out this case was necessary, but I don't fully understand why as
yet. I'll work that out and see if I can avoid doing it, otherwise I
will document why it is reasonable.

jon.
