From: Joshua Roys <roysjosh@gmail.com>
Subject: Re: git refuses to work with gvim
Date: Mon, 12 Oct 2009 14:29:43 -0400
Message-ID: <4AD37597.3010807@gmail.com>
References: <20091012134312.236d250e@gzip.coli.uni-saarland.de> <vpq8wfgg4u1.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: sebastian@CoLi.Uni-SB.DE, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Oct 12 20:36:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxPlD-00010D-Q3
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 20:36:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757587AbZJLSbH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 14:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757582AbZJLSbG
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 14:31:06 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:52017 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757585AbZJLSbE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 14:31:04 -0400
Received: by qw-out-2122.google.com with SMTP id 9so638985qwb.37
        for <git@vger.kernel.org>; Mon, 12 Oct 2009 11:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=DHGTxbrC8PjVIhdOJwnuUkmJnypIO8gIuidgNQyNMbM=;
        b=eF6jDO66Y4MFwQ2YCbeZ1222s0dqFElGXn8pZmYPuucPN6aRnda+QfaYs3qscyDxhf
         FyhDtDUgKzCy45hBXxYN5wyQ/rMBND174TuKkwIE1NXHnsuV/2/tBxNIPwybLnELoNVH
         3wslWmpmljqJmtDXNPEp7lkW5KIOKkjNg3x14=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=Z2szUNvtgyWGpJuPznmPdG/2aWSX5hEdm6QvkMk8EUDNkJTaCxkMxxncm4Xhz5dS3b
         IkoxcwddWz01YHWttiIPgkKYqepLJ52Lf2CirRfbdC5Y7BwGLnAMpkR3z9/P7ZFTXR6n
         lk31qgk7/tGSOZ8eZewzyzMYHnQ6fsdyPI7nI=
Received: by 10.224.26.92 with SMTP id d28mr5017155qac.301.1255372197176;
        Mon, 12 Oct 2009 11:29:57 -0700 (PDT)
Received: from sis-JRR.stl.gtri.gatech.edu (sis-JRR.stl.gtri.gatech.edu [130.207.197.190])
        by mx.google.com with ESMTPS id 20sm2466585yxe.2.2009.10.12.11.29.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 Oct 2009 11:29:56 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.4pre) Gecko/20090922 Fedora/3.0-2.7.b4.fc11 Lightning/1.0pre Thunderbird/3.0b4
In-Reply-To: <vpq8wfgg4u1.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130045>

On 10/12/2009 08:43 AM, Matthieu Moy wrote:
> sebastian@CoLi.Uni-SB.DE writes:
>
>> # git commit something
>> fatal: no commit message?  aborting commit.
>> #
>
> The problem is that gvim returns immediately, and lets the window
> opened (try it in a terminal, "gvim foo.txt" returns immediately). Git
> expects the commit message to be written and saved when $EDITOR
> returns.
>
> A quick search for "wait" in the man pages tells me that
>
>    GIT_EDITOR='gvim -f' git commit
>
> works.
>
> (BTW, this is in no way specific to Git, 99% applications calling
> $EDITOR will expect the same behavior)
>

Hello,

Also, a :help nofork leads to gui-fork and guioptions, which tells you 
that you can add the following to .vimrc (not .gvimrc, see :help go-f):
set guioptions+=f

--
Joshua Roys
