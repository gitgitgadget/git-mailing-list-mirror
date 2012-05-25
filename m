From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [GSoC] Designing a faster index format - Progress report
Date: Fri, 25 May 2012 18:31:14 +0700
Message-ID: <CACsJy8As2SQwEi2vHAQA+OeH+TjoCzzcknFbQ2tGXaWX7zsHVA@mail.gmail.com>
References: <20120523122135.GA58204@tgummerer.unibz.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, trast@student.ethz.ch, gitster@pobox.com,
	mhagger@alum.mit.edu
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 25 13:31:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXskJ-0004nv-Pp
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 13:31:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757293Ab2EYLbr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 May 2012 07:31:47 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:45212 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757146Ab2EYLbq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2012 07:31:46 -0400
Received: by wibhj8 with SMTP id hj8so6829542wib.1
        for <git@vger.kernel.org>; Fri, 25 May 2012 04:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=avm7uim+0axM8FI+y3BK/yYdS99lbDUjJovwGdW6sRE=;
        b=uMs/wY3XHIKCcBI+LaxbitS3+HiFHOGaHrycXWB7TXKgy3nCc61uFFfzW3oJT1o0JV
         FHlf3h0IH0Ox0zIDhsb2f6SiJxqW8r26ZpG0ez/r8HLA1v7u07bmt+x3LPnbUJhCjkHT
         NL3QFsQCEAi8LdFZoF7Ik9MwWnkJtQO4cClLrWt6GB19yJKezuHgFr1IAuGzYyO4aiN1
         4OQCQBUowHwyaYJTR1h8W/E8nsqcSSjhRX7w7Rw2xn0dutR/ugK8QRn0iFKd5yfJZIlx
         rimaxCWmi8WWPnZd9kTZ3tQLbvT6/6Eudw2Qe4qorCAk0iM7y3hlCGDhM88CQC0735lS
         eCuw==
Received: by 10.216.226.218 with SMTP id b68mr1677172weq.167.1337945505144;
 Fri, 25 May 2012 04:31:45 -0700 (PDT)
Received: by 10.223.64.208 with HTTP; Fri, 25 May 2012 04:31:14 -0700 (PDT)
In-Reply-To: <20120523122135.GA58204@tgummerer.unibz.it>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198474>

On Wed, May 23, 2012 at 7:21 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> == Outlook for the next week ==
>
> - Start working on actual git code
> - Read the header of the new format

I know it's out of scope, but it would be great if you could make
ls-files read the new index format directly. Having something that
actual works will ensure we don't overlook anything in the new format.
We can then learn from ls-files lesson (especially how to handle both
new/old format) and come up with api/in-core structures for the rest
of git later.
-- 
Duy
