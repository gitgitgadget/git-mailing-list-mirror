From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC PATCH] During a shallow fetch, prevent sending over unneeded objects
Date: Fri, 16 Aug 2013 16:51:07 +0700
Message-ID: <CACsJy8CDGgKftp0iBB8MYjMawKhxZ1JQ+xAYb0itpaCOjFHWxg@mail.gmail.com>
References: <20130711220127.GK10217@login.drsnuggles.stderr.nl>
 <CACsJy8CP6pGRwEn6H=cbKxTMuOjzAF3=Qh8qsLbJaw6feK3NMw@mail.gmail.com>
 <7vfvukbrqh.fsf@alter.siamese.dyndns.org> <CACsJy8BahoGcDcLjSaHA-62_KQE2wD-p5oeJOOA4nk8ZRfXrEA@mail.gmail.com>
 <20130812080203.GK10217@login.drsnuggles.stderr.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Matthijs Kooijman <matthijs@stdin.nl>,
	Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 16 11:51:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAGh5-0007Bg-R7
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 11:51:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755336Ab3HPJvj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Aug 2013 05:51:39 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:39651 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755334Ab3HPJvh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Aug 2013 05:51:37 -0400
Received: by mail-ob0-f177.google.com with SMTP id f8so1811489obp.8
        for <git@vger.kernel.org>; Fri, 16 Aug 2013 02:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=zCjNcJFSH68H3TjdMRPkkcliD2Z3+8ahgj0CbR4CdG4=;
        b=NB0xqoIXlDXgACU6Rgm23FbxIB20NWaaUMMpgvmwzGHbhJwZY11GGKyCueLjXVpseu
         NzJxYtNvBa0zzZ4irpKkDCBuiWKV6qXOeDBcRG/YCf93ix2g06p+++0kjtLce2cXqZfh
         WcUnR+u7htW3VOwKdmvnbG4GomC4wgpY3yNHi1avcqxDzATX9fA/ujfRWYmKpYlQabM5
         RW6a0NCZQ9EPWvnAqeXnOihCG6h2Qtes5KyhVAFzlNzXyD5eNqUBWMf7+Pdj8XoLAQKC
         4Clk+bT9Mf/kedrsdqhO8PFbKgNNce02Nka/lyFf1xS+PEbOJ5QGpysWXaNYg8dHNp6C
         VaCg==
X-Received: by 10.182.29.233 with SMTP id n9mr587990obh.38.1376646697395; Fri,
 16 Aug 2013 02:51:37 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Fri, 16 Aug 2013 02:51:07 -0700 (PDT)
In-Reply-To: <20130812080203.GK10217@login.drsnuggles.stderr.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232407>

On Mon, Aug 12, 2013 at 3:02 PM, Matthijs Kooijman <matthijs@stdin.nl> wrote:
> Hi Duy,
>
>> OK. Mathijs, do you want make a patch for it?
> I'm willing, but:
>  - I don't understand the code and all of your comments well enough yet
>    to start coding right away (though I haven't actually invested enough
>    time in this yet, either).
>  - I'll be on vacation for the next two weeks.
>
> When I get back, I'll re-read this thread properly and reply where I
> don't follow it. Feel free to continue discussing the plan until then,
> of course :-)

I thought a bit but my thoughts often get stuck if I don't write them
down in form of code :-) so this is what I got so far. 4/6 is a good
thing in my opinion, but I might overlook something 6/6  is about this
thread. I'm likely offline this weekend, so all is good :-D
-- 
Duy
