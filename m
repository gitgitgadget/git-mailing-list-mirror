From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/4] {fast-export,transport-helper}: style cleanups
Date: Thu, 9 May 2013 06:06:37 -0500
Message-ID: <CAMP44s3LCmhvomr9WAhWVusR1=jihO4KigSOYkoL7i=D-nAMDA@mail.gmail.com>
References: <1368062218-22440-1-git-send-email-felipe.contreras@gmail.com>
	<1368062218-22440-4-git-send-email-felipe.contreras@gmail.com>
	<CAEBDL5XZhEo14WKiz2m3KFRX+NsTFhmcz3adSti33RATMd897w@mail.gmail.com>
	<CAMP44s1R4YmyCFEQVRwSH6x-nDO-1=vDcA02C7F86GJk0zkS6g@mail.gmail.com>
	<CALkWK0m3AG5iw1gCAAepmzJeZD_s9cm-eYC-cnSaVmn=FvSNag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Szakmeister <john@szakmeister.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 09 13:06:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaOgN-0002yU-Lx
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 13:06:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754022Ab3EILGj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 07:06:39 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:41756 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753198Ab3EILGj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 07:06:39 -0400
Received: by mail-lb0-f177.google.com with SMTP id 13so2843517lba.8
        for <git@vger.kernel.org>; Thu, 09 May 2013 04:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=80F9AEljJEts30tVq/4KMw1xE6KAgvjmIGw8U5WE7tM=;
        b=HKIqd+CeeNTA9BZiDDLoG3FSsm9w42teWjXNevFe/w8aTq/fXt63CEG++3IOBSrEe2
         C7SbS/JSDb92Ubnzgty5M7DzHifiEqIQErxf3LoUfLMRQf/vxjaiun/qbYq+Ra7MFa9S
         y/pcpuOrvK4/0UJjIN4aceqKHDiRpXjqU4Cu1HZfJT12QGjz+6fBPWtoJJ2CEJfqOdmh
         CgZQyg4QKxaVmFVYqQ6og7l3jwcrXMVNblOFuz7QMsLC5IpQY5WmduL2Ohz6lrzvTykt
         GhehsY6jmk70TdDsrw+ulH6uJyMnEhnCDtKfE0aYmYj1YN/5Ct+Bd49RulyzzYI1Z+H1
         EPmA==
X-Received: by 10.112.125.130 with SMTP id mq2mr5108162lbb.103.1368097597457;
 Thu, 09 May 2013 04:06:37 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Thu, 9 May 2013 04:06:37 -0700 (PDT)
In-Reply-To: <CALkWK0m3AG5iw1gCAAepmzJeZD_s9cm-eYC-cnSaVmn=FvSNag@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223727>

On Thu, May 9, 2013 at 5:24 AM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> AFAIK neither the git or the Linux code-style specify how multiple
>> lines with open parenthesis should align.
>
> git style inherits from linux style.  See Chapter 9 of
> Documentation/CodingStyle in linux.git.  It has elisp snippets you can
> stick in your .emacs.

I don't see anything in Chapter 9 mentioning the alignment of
parenthesis. This has been discussed multiple times in the Linux
mailing lists, nobody cares enough about it to add such alignment
guidelines to the documentation.

-- 
Felipe Contreras
