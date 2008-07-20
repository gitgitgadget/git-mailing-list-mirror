From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [PATCH 2/2] git-add -a: add all files
Date: Sun, 20 Jul 2008 08:45:24 -0400
Message-ID: <76718490807200545l653bbda1l4d13f1e1e698c855@mail.gmail.com>
References: <alpine.DEB.1.00.0807161804400.8950@racer>
	 <alpine.DEB.1.00.0807171915420.8986@racer>
	 <7vtzeofjpi.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0807171940160.8986@racer>
	 <48806897.1080404@fastmail.fm>
	 <76718490807181318o228171f9j836aaca2edb9b377@mail.gmail.com>
	 <7vsku5grpr.fsf@gitster.siamese.dyndns.org>
	 <7vk5fhgrm6.fsf_-_@gitster.siamese.dyndns.org>
	 <905315640807192120k45b8c0e3k5b341e77c466dde@mail.gmail.com>
	 <alpine.DEB.1.00.0807201250530.3305@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Tarmigan <tarmigan+git@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Michael J Gruber" <michaeljgruber+gmane@fastmail.fm>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 20 14:46:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKYIy-0003H3-Pb
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 14:46:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753844AbYGTMp0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 08:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753933AbYGTMpZ
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 08:45:25 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:5804 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753729AbYGTMpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 08:45:25 -0400
Received: by yw-out-2324.google.com with SMTP id 9so343898ywe.1
        for <git@vger.kernel.org>; Sun, 20 Jul 2008 05:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=kEezyKhnL/PJ4FGQZHJlHs5bFWGvyCf2RewVB8CAqGI=;
        b=K+3RNY2iofbDP8nfSFLSsrO0Im5nEkqaQQy1Rz1dek/25n4zcu7TUtz5H8eJAx6kMO
         ON7gD3Q4XIFZi77QNOJTxtHi/X/CjlagBGhIyKlEHRoM20gsb7jh6gofW4IVVNsxXqY9
         6jeRu+IPZEMBr0SSEbvJb8DWScnJxdcha4UQ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=P2HccAqtasL2bHZYa33kCe8HmWEYHCzTGbW2hSTU+MIfRD8l5YdYcn31k/aIM7xkJ6
         UZK7Cc4PfDGzdTnXjKNGrhZY0GT+s8Q6v8CxppGi+R2J7SQJK1ebFQaYJfD1WSSNOdW8
         onsnhh+p/zaxNNfA5f6JOaVz8i37yiLp8GmZA=
Received: by 10.151.108.13 with SMTP id k13mr2457609ybm.150.1216557924211;
        Sun, 20 Jul 2008 05:45:24 -0700 (PDT)
Received: by 10.150.149.15 with HTTP; Sun, 20 Jul 2008 05:45:24 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807201250530.3305@eeepc-johanness>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89195>

On Sun, Jul 20, 2008 at 6:56 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Two things:
>
> - add and commit are two _different_ operations, not only in name, but
>  also in nature.  The fact that "commit -a" calls "add" is a _pure_
>  convenience.  It does not change the fact that "add" and "commit" are
>  completely, utterly different.
>
> - if you are a heavy user of "commit -a", chances are that your history is
>  not really useful, because you committed unrelated changes accidentally
>  in the same commit.
>
> The latter point, BTW, is the reason I _never_ teach the "-a" option
> (actually, I teach no option at all) in my first two Git lessons.

I don't like "commit -a" and never use it and wonder why a
short-option was wasted on it.

I do like the new "add -a" (thank you Junio) but I will rarely use it.
I had the "addremove" alias in my .gitconfig specifically because I
used it so infrequently that it was hard for me to remember when I did
need it. So I think that "add --addremove" would be fine and we don't
need to spend a short-option ("-a") on it.

Lastly, I point out that when I started with git, it became much
clearer when I began reading "git add" as "git stage". I think my
first alias was "staged => diff --cached". But I am someone who likes
to learn how the things I use work early on.

j.
