From: Johan Herland <johan@herland.net>
Subject: Re: [RFC/PATCHv2 1/3] Documentation/git-svn: Promote the use of
 --prefix in docs + examples
Date: Sun, 6 Oct 2013 15:46:57 +0200
Message-ID: <CALKQrgdruayiosT1nQSXGn44T4dGbjNYquuq5tZjyiNSQNd6rw@mail.gmail.com>
References: <20131003190139.GA8710@dcvr.yhbt.net>
	<1381015833-696-1-git-send-email-johan@herland.net>
	<1B588C9FE7614A6080C98FD340530DA5@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	Eric Wong <normalperson@yhbt.net>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sun Oct 06 15:47:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VSofu-0004oi-U3
	for gcvg-git-2@plane.gmane.org; Sun, 06 Oct 2013 15:47:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753189Ab3JFNrG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Oct 2013 09:47:06 -0400
Received: from mail12.copyleft.no ([188.94.218.224]:53971 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752883Ab3JFNrF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Oct 2013 09:47:05 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1VSofm-0002ld-Bv
	for git@vger.kernel.org; Sun, 06 Oct 2013 15:47:02 +0200
Received: from mail-pd0-f172.google.com ([209.85.192.172])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1VSofm-000ICv-22
	for git@vger.kernel.org; Sun, 06 Oct 2013 15:47:02 +0200
Received: by mail-pd0-f172.google.com with SMTP id z10so6000122pdj.17
        for <git@vger.kernel.org>; Sun, 06 Oct 2013 06:46:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=kf9q3HOQ/5mUI5LxZAAB6Ogzv9AZqrpSNlBtjpjjV0Y=;
        b=OCHXNQcbGJNaXQI3+AfQzNoUuiF6Vk83pEpHaNPA8NcpS+WPlnhJYKL0tdJbYeDT/r
         b3XbJZz3/bejYV+vT40wbzZIMVTzXSUVwHMOGONbn0ybQjeO/sDCpXY+yVrpckwsKDvm
         oyaSLNMMMaZVWz9rbIri4NrpnGNzzTAOZffKt4HZ1rGMk06XhsdSPvLOCLI/33fKCx36
         ji6KHlBZ0l4zdXkmBl1Ke7m5OBKyunaWTPuR8jkXNJYYTLgZ3maqXEUFn7Q14eEpm8R5
         Ih+QkEaBcK9Yy8hrFwaJbLqp8oOel5fcN3CauwlecUdxQrsyRCfISNCvN9gLazplt+X3
         P05Q==
X-Received: by 10.66.121.201 with SMTP id lm9mr26537620pab.80.1381067217836;
 Sun, 06 Oct 2013 06:46:57 -0700 (PDT)
Received: by 10.70.24.226 with HTTP; Sun, 6 Oct 2013 06:46:57 -0700 (PDT)
In-Reply-To: <1B588C9FE7614A6080C98FD340530DA5@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235739>

On Sun, Oct 6, 2013 at 11:51 AM, Philip Oakley <philipoakley@iee.org> wrote:
> From: "Johan Herland" <johan@herland.net>
>> Cc: Eric Wong <normalperson@yhbt.net>
>
> Excuse my ignorance, but what is the "Carbon copy:" line meant to signify?
> Should it be a double "Signed-of-by:" or one of the other "-by:" lines?

No, it's not a Signed-off-by, it's merely a hint to someone that they
might want to take a closer look at this patch.

In this case, I'm Cc-ing Eric Wong, as he is the main git-svn author,
and I consider his feedback on these patches very valuable. When I add
a Cc: to the commit message, git send-email picks it up, and adds him
to the Cc-list of the resulting email. I could have achieved the same
by passing --cc "Eric ..." directly to git-send-email, but sometimes
there might be quite a while between preparing the commit and running
git send-email, and in those cases adding the Cc to the commit message
saves me from forgetting to Cc him when I some time later get around
to running git send-email.

That said, my hope is obviously that Eric will have the
time/energy/motivation to review these patches, so that I (or someone
else) can later replace the "Cc:" line with a corresponding
"Reviewed-by:" or "Acked-by:". Even if that does not happen, and the
"Cc:" line ends up in the recorded history of Git, I don't consider
that a big problem either; a 'git log origin/master | grep "^\s*Cc: "
| wc -l' yields 148 existing cases...

Hope that helps,

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
