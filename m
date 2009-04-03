From: Changsheng Jiang <jiangzuoyan@gmail.com>
Subject: Re: How to init a empty repo for pushing?
Date: Sat, 4 Apr 2009 02:27:56 +0800
Message-ID: <eafc0afe0904031127v24fafa20m37ab5436ebfe211a@mail.gmail.com>
References: <eafc0afe0904031117rbfd55cft5f40f1b45df1e454@mail.gmail.com> 
	<20090403182312.GA15071@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 03 20:31:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lpo9B-0008Jh-Nj
	for gcvg-git-2@gmane.org; Fri, 03 Apr 2009 20:29:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935190AbZDCS2Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Apr 2009 14:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934610AbZDCS2P
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Apr 2009 14:28:15 -0400
Received: from ti-out-0910.google.com ([209.85.142.190]:63382 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933792AbZDCS2O convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Apr 2009 14:28:14 -0400
Received: by ti-out-0910.google.com with SMTP id i7so1144373tid.23
        for <git@vger.kernel.org>; Fri, 03 Apr 2009 11:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2cBNZYpYO6P/CFzK6J7E2N37iC9YNjPfI8if450HpDg=;
        b=MfcRg2yTd4i7ByqIREm26q7fTTThn93am/VnUBGmL3ixMTKFG02TxgWsHBhSwBiiBy
         HQL0Wgm6RZiSuC38ATfmoL++5d1c/b5poYz3TiNGogydsOyd8ItYzALceq/MUCxcVlOi
         IN7a4QKpRTjWIYprFzn5NdWqduFJWld9FdiOY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=maS9Zjf1grWtj7f0OkqrHJ6NEE1WpGAN4JNsCrAz8MZUpnjSbZfZnUcxBNEqkLJhlD
         VLWKf62waMSTvU5myfIAVKEdEkEbzWQUJo/aUlFcq5Ps5fHaBmDwSOV1ZJ3srCXtPCNk
         N9TdvL8yVDPXxSwBkHgXJ/sLW3w2NL/UVfOo4=
In-Reply-To: <20090403182312.GA15071@coredump.intra.peff.net>
Received: by 10.110.16.15 with SMTP id 15mr2071943tip.53.1238783291218; Fri, 
	03 Apr 2009 11:28:11 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115552>

On Sat, Apr 4, 2009 at 02:23, Jeff King <peff@peff.net> wrote:
> On Sat, Apr 04, 2009 at 02:17:33AM +0800, Changsheng Jiang wrote:
>
>> Just 'git init' in server, then 'git push server' after 'git remote
>> add server ...' =C2=A0in laptop gives error.
>
> It's hard to say without seeing the error message, but I'm assuming i=
t
> was along the lines of "No refs in common".
>
> By default, "git push server" will push matching branches (i.e., ones
> that both the client and the server have in common). To push a new
> branch, you say "git push server $BRANCH", or even just "git push --a=
ll
> server".
Thanks, 'git push --all server' works.

>
> -Peff
>

Changsheng Jiang
