From: Chris Packham <judge.packham@gmail.com>
Subject: Re: Identifying the commit ID from which a repo was cloned
Date: Mon, 15 Mar 2010 15:32:07 -0700
Message-ID: <a038bef51003151532n320e7c1oeabfcb7da124f391@mail.gmail.com>
References: <27910384.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: jateeq <jawad_atiq@hotmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 15 23:32:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrIpc-0006Er-Bm
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 23:32:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419Ab0COWcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 18:32:10 -0400
Received: from mail-px0-f198.google.com ([209.85.216.198]:46730 "EHLO
	mail-px0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932149Ab0COWcI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 18:32:08 -0400
Received: by pxi36 with SMTP id 36so2353800pxi.21
        for <git@vger.kernel.org>; Mon, 15 Mar 2010 15:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=s0iIws2a5oQ0xTiH4fiK7iOVwcIJADSdcCnHK4iv090=;
        b=Of9vjZ0+vdWxaaUUv0l9N0vs6Rn+zb5QvsI43M2yfFDeEx2nWvCVzkvST/yB3v/U8k
         YHuXbQPobPwp8/GuHIHxnZb2hX8jrJ3MEfmv9Q9wX3qdb+tIxw44pHXJ1hzbfFfTRUKO
         A8Tdihu3wCdODsxIp6eXdnqhcmdBHE/Q0Gvq4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=aIfu2pQ2FIcbQM6MQThckmgv7oMjisyGI5n+lKYJhTtWAx5Y80jWR/fmBpPyMbzCWR
         xwS06fRFRBcbq85zQTJ3KB9ABHRedjpxajPIUjvvAxniRnw7zjv7ONXUXxD6yzh4QoNr
         r4FeF4yF5467njj8MRAu5sbUKUbtDfjWiTOXg=
Received: by 10.115.99.14 with SMTP id b14mr6077759wam.210.1268692328030; Mon, 
	15 Mar 2010 15:32:08 -0700 (PDT)
In-Reply-To: <27910384.post@talk.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142267>

On Mon, Mar 15, 2010 at 2:06 PM, jateeq <jawad_atiq@hotmail.com> wrote:
>
> Hello,
>
> Once I clone, make changes and commit several times, I need to determine how
> many commits were made (and list them) since the repository was cloned. Does
> git remember this commit, and is there a command that can do this, or do I
> have to store the commit ID when i clone?
>
> Thank you,
> Jawad
> --
> View this message in context: http://old.nabble.com/Identifying-the-commit-ID-from-which-a-repo-was-cloned-tp27910384p27910384.html
> Sent from the git mailing list archive at Nabble.com.
>
> --

The origin/master reference is what you need. Pretty much the same
answer as one of your other questions
http://article.gmane.org/gmane.comp.version-control.git/141414
