From: "S. M. Ibrahim (Lavlu)" <smibrahim@gmail.com>
Subject: Re: hosting multiple project in single git repository
Date: Thu, 14 May 2009 13:14:09 +0600
Message-ID: <4997275b0905140014u72375d73vf23b67acf9930b53@mail.gmail.com>
References: <4997275b0905131031q3c572854r4b0a899ca43063be@mail.gmail.com>
	 <4997275b0905131046s407e334ag6783a6365c89fe10@mail.gmail.com>
	 <4997275b0905131048t1b5c1427w85a2f96964ea16b6@mail.gmail.com>
	 <32541b130905131058i54dfa56ck8938aab96cb1d442@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 14 09:14:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4V90-0007f1-63
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 09:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754281AbZENHOL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 May 2009 03:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752863AbZENHOK
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 03:14:10 -0400
Received: from mail-qy0-f133.google.com ([209.85.221.133]:50560 "EHLO
	mail-qy0-f133.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753859AbZENHOJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 May 2009 03:14:09 -0400
Received: by qyk39 with SMTP id 39so2117025qyk.33
        for <git@vger.kernel.org>; Thu, 14 May 2009 00:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ykIOco9nPxIcovDbRcJyAS9oNdNOP9Y9+lFGtghY9Qo=;
        b=DkmFoucYn0HiCefQPVy5FVLwJt6RRhgCkJZzzsZ/uKgYndJhuwQGTZcs7ynvEg360S
         CSJaW7ZBHzG9YKNmmEAc1DRa9kuv1FP6GUt1fLjESoTfa11p9NPAcam1r/wh6g4gepAx
         U+zcYQDgLlYxF1xILT+tmL+bzI0lB4DM6df4c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Pj94hjRY2C0IUWGBrq55xgdbFdhobKAY9ojt7c8n4pVEqukinOkg/RwR2otZQmffSU
         EKjvJEq/1h6NlDXbUvEBunXZDOq7doAD1aOLq1ffl0D5kwV8/tZFTvO5cLpdukpNcFH2
         8i23MXr4fO6G/7y3B2/Wj2exH+QgGDOo1ROTo=
Received: by 10.224.3.10 with SMTP id 10mr2363697qal.149.1242285249115; Thu, 
	14 May 2009 00:14:09 -0700 (PDT)
In-Reply-To: <32541b130905131058i54dfa56ck8938aab96cb1d442@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119158>

2009/5/13 Avery Pennarun <apenwarr@gmail.com>:
> On Wed, May 13, 2009 at 1:48 PM, S. M. Ibrahim (Lavlu)
> <smibrahim@gmail.com> wrote:
>> in our company we are moving all our subversion repository to git.
>> git-svn is working really nice. but facing a problem. we have one sv=
n
>> repository where we hosted two projects and both the projects are
>> under development. project a is trunk and project b is branch/xxxx .
>> and project b was copied from trunk . we have plan to merge this two
>> project in future. what is the best way to maintain this two project
>> in git ? should we make to different git repository .
>
> If they both branched from the same place and they might be merged
> back together someday, then keeping them in the same repository seems
> rather harmless. =C2=A0And you can always split the repositories late=
r if
> you want. =C2=A0Similarly, you can check out the same repository in t=
wo
> different local directories on two different branches and it's
> essentially equivalent to having two repositories in the first place.
>
> What problems are you having with the setup as it is now?
>
> Have fun,
>
> Avery
>
thanks for reply. we imported the hole svn repository in git. now the
project b is a branch of the repository. and project a is the master .
can you please show me a little example how can i pull and push from
and to particular branch.

my plan is to use two different folder for these two project.

thanks


--=20
S. M. Ibrahim Lavlu
software engineer, php
somewhere in...
http://www.somewherein.net

bangla blog: http://www.somewhereinblog.net
my blog: http://www.lavluda.com
mac blog: htttp://www.mac-talks.com
