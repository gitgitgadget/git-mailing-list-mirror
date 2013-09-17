From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: sparse checkout file with windows line endings doesn't work
Date: Tue, 17 Sep 2013 18:35:41 +0700
Message-ID: <CACsJy8CRoZYWExHMjwG3ZOv=eJ9irq_mM_bM78ss_DssSq7szw@mail.gmail.com>
References: <SDZQSFBTWig9IERCPVQvNjIyNDgyMzQ@IBMLT4>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Martin Gregory <marting@adelaideinterim.com.au>
X-From: git-owner@vger.kernel.org Tue Sep 17 13:36:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLtZp-0005oD-73
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 13:36:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752515Ab3IQLgN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 07:36:13 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:38141 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340Ab3IQLgM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 07:36:12 -0400
Received: by mail-ob0-f179.google.com with SMTP id wn1so5181416obc.10
        for <git@vger.kernel.org>; Tue, 17 Sep 2013 04:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=LqhcDO0eITq6gNStpJ1/pT0r88YZwogGW1FSrJ3rs5U=;
        b=Z7wD4M/pn2920yFPpNDcVcrwizL2aFNcLGJXWxgiGQVTJGgXy1OGm5Y2PQzMXxdKCF
         l3yKiOh+xGsfrw4tPrpeZjbbj73O2ovxcB5q2/go7VdNw90bnvrqsLbiH9QbCR1TsLA1
         yS9ptqUU92fL/GIgxHiw9yRuVUKvlzGOcVfhU6nHIyDyPzSoGGyLUT+QswoEXkjNl7K4
         g2jZqu2wKmkLj/Zwho0phgHP4EwB2oFRoQ9eOnSW6wplA2/X+r1WPN0942ZRzHcjlll/
         /IYxZNgGsZhe1mDxCnlEDxS78TQWp0Ai0tGfoSuEWN3s88MkyOenxdT39mvqAIPs/w3e
         ip+g==
X-Received: by 10.60.70.134 with SMTP id m6mr29694657oeu.14.1379417771912;
 Tue, 17 Sep 2013 04:36:11 -0700 (PDT)
Received: by 10.182.49.233 with HTTP; Tue, 17 Sep 2013 04:35:41 -0700 (PDT)
In-Reply-To: <SDZQSFBTWig9IERCPVQvNjIyNDgyMzQ@IBMLT4>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234872>

On Mon, Sep 16, 2013 at 8:20 PM, Martin Gregory
<marting@adelaideinterim.com.au> wrote:
> Hi,
>
> Please see  http://pastebin.com/zMXvvXuy
>
> It shows that if the .git/info/sparsecheckout file is in windows format
> (windows line ending) then it doesn't work.

And it does work for me with CRLF endings (again tested on Linux). Can
you send me your sparse-checkout file? Zip it if needed. I just wanted
to make sure there's no weird visible characters there. If none is
found, then I don't know what causes your problem. Perhaps msys guys
can help.
-- 
Duy
