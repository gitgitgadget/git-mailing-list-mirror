From: "Geoff Russell" <geoffrey.russell@gmail.com>
Subject: Re: importing cvs logical modules
Date: Thu, 25 May 2006 16:29:25 +0930
Message-ID: <93c3eada0605242359k204bfe79vabc323eddfafa5f@mail.gmail.com>
References: <93c3eada0605242148u4656bc31p96d84a16703f0fe0@mail.gmail.com>
	 <7vslmyzoit.fsf@assigned-by-dhcp.cox.net>
	 <93c3eada0605242302x24ca1272xd7bfc3a677b32845@mail.gmail.com>
	 <46a038f90605242316l4b0a0963m638f7a2e47936000@mail.gmail.com>
Reply-To: geoff@austrics.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 25 08:59:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fj9of-0002Ej-Od
	for gcvg-git@gmane.org; Thu, 25 May 2006 08:59:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965055AbWEYG71 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 02:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965056AbWEYG71
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 02:59:27 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:38978 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965055AbWEYG70 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 May 2006 02:59:26 -0400
Received: by wr-out-0506.google.com with SMTP id i34so1750373wra
        for <git@vger.kernel.org>; Wed, 24 May 2006 23:59:26 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EMLgYFnfSQJ5veNiLiLMugX3Yy4hb89C+Rn0OYhJ6oK8VzxOq8sCnI+G18d2Isxl4I57cwhL8CwgJLicxBmiyCi1jCB1IQ0nsuSoOQ0K7WGuO3+tlWmy0O0evbtxpXY+JlW/l2oLVWFjuLsJbfPu5ctMXAX0IjfpwB7dAYWwNzE=
Received: by 10.85.2.9 with SMTP id e9mr556135aui;
        Wed, 24 May 2006 23:59:25 -0700 (PDT)
Received: by 10.70.32.19 with HTTP; Wed, 24 May 2006 23:59:25 -0700 (PDT)
To: "Martin Langhoff" <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90605242316l4b0a0963m638f7a2e47936000@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20732>

On 5/25/06, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> On 5/25/06, Geoff Russell <geoffrey.russell@gmail.com> wrote:
> > The tight linkage is absolutely essential.
> >
> > When we tag the system, we
> > want to tag everything (not individually tag all 300 programs)
> > so that later we can to branch at that tag. Very few of our
>
> Then you want a single git repo/tree/project. The thing is how to work
> through your mangled CVS history.
>
> Two options there...
>
>  - Don't. Import from after the last directory reorg or from your last
> interesting release. Keep the cvs tree for people who really want to
> dig into the past. this has several advantages, as initial checkouts
> will be faster, import times shorter, less pain overall.

Yes, this is definitely on the shortlist of options.
If we can't keep all the history, we may as well make
a clean start. Thanks for the advice.

Cheers,
Geoff.
