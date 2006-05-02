From: "Bertrand Jacquin" <beber.mailing@gmail.com>
Subject: Re: Features ask for git-send-email
Date: Wed, 3 May 2006 00:46:24 +0200
Message-ID: <4fb292fa0605021546i45c740c4i42c64125b8c560e@mail.gmail.com>
References: <4fb292fa0604290630r19edd7ejf88642e33b350d1d@mail.gmail.com>
	 <1146573417.14059.21.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 03 00:46:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fb3db-0002oL-TA
	for gcvg-git@gmane.org; Wed, 03 May 2006 00:46:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965025AbWEBWq1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 May 2006 18:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965026AbWEBWq1
	(ORCPT <rfc822;git-outgoing>); Tue, 2 May 2006 18:46:27 -0400
Received: from nproxy.gmail.com ([64.233.182.187]:28473 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965025AbWEBWq0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 May 2006 18:46:26 -0400
Received: by nf-out-0910.google.com with SMTP id n15so23033nfc
        for <git@vger.kernel.org>; Tue, 02 May 2006 15:46:24 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kflk2r79PEk6ErXAhNYfZYuc/xYWB3xtX5qrTxLFjLfG5sPa9s0a6KsqwqLmA6uZI061W998XmCUx4QMlH53/BfZ7Et/mYY7YBoBr65RboViWMTEYHYv8i1skhfqaJYNtKEhIR6TB+yk0PLw5VItqe0L317H/L0u2PAZNxyFHWU=
Received: by 10.48.217.17 with SMTP id p17mr252536nfg;
        Tue, 02 May 2006 15:46:24 -0700 (PDT)
Received: by 10.49.2.19 with HTTP; Tue, 2 May 2006 15:46:24 -0700 (PDT)
To: "David Woodhouse" <dwmw2@infradead.org>
In-Reply-To: <1146573417.14059.21.camel@pmac.infradead.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19435>

On 5/2/06, David Woodhouse <dwmw2@infradead.org> wrote:
> On Sat, 2006-04-29 at 15:30 +0200, Bertrand Jacquin wrote:
> > Could it be possible to add a features in git-send-email.perl to
> > accept a differrent charset as iso-8859-1 ? I would like to send
> > fr_FR.utf8 mail as I use git to manager a latex files tree which are
> > written in utf8.
> >
> > Any objection ?
>
> Seems reasonable. I think we just forgot to include the Content-Type:
> header. This fixes it...

I tryed it. I used this patch again master git git release

And I got the following with git-send-email :

Use of uninitialized value in hash element at /usr/bin/git-send-email line 437.
Use of uninitialized value in hash element at /usr/bin/git-send-email line 437.
<>: missing or malformed local part
Use of uninitialized value in hash element at /usr/bin/git-send-email line 437.
Use of uninitialized value in hash element at /usr/bin/git-send-email line 437.
<>: missing or malformed local part

And with my smtp server :

2006-05-03 00:44:01 unexpected disconnection while reading SMTP
command from localhost (localhost.localdomain) [127.0.0.1]

Is it a known bug ? I can't send mail with patch thow :/ I tried to
add Mime-Version: 1.0 too but I got the sam.

--
Beber
#e.fr@freenode
