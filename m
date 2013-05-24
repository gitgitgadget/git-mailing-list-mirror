From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [QUERY] How do you sort completions?
Date: Fri, 24 May 2013 17:03:27 +0530
Message-ID: <CALkWK0k=nVHOBe5SgRH9xQK1+yAYBzbNMqsWxhYPo0MTZPp63g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 24 13:34:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfqGD-0007ny-Mo
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 13:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753915Ab3EXLeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 07:34:08 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:45866 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752459Ab3EXLeH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 07:34:07 -0400
Received: by mail-ie0-f169.google.com with SMTP id u16so12076263iet.28
        for <git@vger.kernel.org>; Fri, 24 May 2013 04:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=mnL6mQaD0fnIA7mfEZHO9lDOj2IUsXyXuOP/wAE87rg=;
        b=ktFsdlr7m3fBEDGJOuR64vjyibPDaLPx/BppULOowqmfsyK2v87T5MQAlFw4/9IJDm
         IuCpzfDtaiisgncddEyRtZMu/GpPiu9VbLbPzDho/0Ksdv6tkCx/sBhtmaZzRHxk19GB
         0dzyMku3m2+9FfR+rpnH42k7tnm7bzsgSjkP3GEjs9hVjGZfvLQCvHa3ksoFOy6AG4d5
         mvwza7ZKFYAk25Ro9nDWf+N4nbH6BxZiglxuxn295Zy8U/OjbgkgbWJBWxW5nUkjcJ8I
         cF1qzM/lc9wdmAIt9eU3+aR4nFBgzSKDtQs/TGvI46DXixfViFC9ZL1q0svdNlxljL0P
         cNNw==
X-Received: by 10.50.11.72 with SMTP id o8mr2163259igb.44.1369395247303; Fri,
 24 May 2013 04:34:07 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Fri, 24 May 2013 04:33:27 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225347>

Hi,

I'm not able to sort completions for some weird reason.  No matter
what I order I insert stuff into COMPREPLY, bash seems to auto-sort
them lexically.  I tried to pass --sort='-committerdate' to git
for-each-ref so I can get a sensible 'git checkout <TAB>' reply, and
I'm very annoyed that it doesn't work.

I thought it was bash's complete builtin doing the implicit sorting,
so I read the manual with no success.  Is readline doing it?  If so,
why am I not getting the ordering even in zsh (which doesn't use
readline)?

What am I missing?

Ram
