From: "Yakov Lerner" <iler.ml@gmail.com>
Subject: Re: empty directories
Date: Mon, 23 Apr 2007 19:49:15 +0300
Message-ID: <f36b08ee0704230949n5dee717bu2f4107555f4300b@mail.gmail.com>
References: <f36b08ee0704230840xa37e149qffa15c5c685524c4@mail.gmail.com>
	 <81b0412b0704230919h3be7a67fqec431a6afb6e3760@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 23 18:49:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg1j5-00026l-He
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 18:49:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754054AbXDWQtR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 12:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754046AbXDWQtR
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 12:49:17 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:59161 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754054AbXDWQtQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 12:49:16 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1855755wxd
        for <git@vger.kernel.org>; Mon, 23 Apr 2007 09:49:15 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LSfAtUJzIoOo/BPW67N2M41//vocHur9FlKOUq7hhgf8sbtG+4xWynKuqAtUuEr6dl1owUKVqIoOCAPpIjCkrlknKnQzIrKt4Ra0cC0HyAw++sDHmLz2LDlXSv/DYZUGnilCizgx9w698a9+/64AIyQ2g+cevRXKD/DLOXoxvUw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rR7M45MQAhXS4S9Bl/JzpWhww3YnaYxP6poB72xmc1wlZh0mzZOkLN1I6MAFPFNKuuaShaf8fc7CiWgg86GW+F3cQNQ0hON/eO7PnCRsNGXZgIovgUupcr9Fse9lGXEeVtLzHZp2I7Ag/6yy3L7EKg/GM3Jmu/lO82tE2X8LO5U=
Received: by 10.90.90.16 with SMTP id n16mr952404agb.1177346955785;
        Mon, 23 Apr 2007 09:49:15 -0700 (PDT)
Received: by 10.90.73.8 with HTTP; Mon, 23 Apr 2007 09:49:15 -0700 (PDT)
In-Reply-To: <81b0412b0704230919h3be7a67fqec431a6afb6e3760@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45333>

On 4/23/07, Alex Riesen <raa.lkml@gmail.com> wrote:
> On 4/23/07, Yakov Lerner <iler.ml@gmail.com> wrote:
> > When I git-add empty directory (mkdir d1;git-add d1),
> > git refuses to add it [1].
> >
> > I was told on #git chan that git cannot store empty dirs.
>
> It can, just refuses to. Which considered good by most
>
> > But when I do
> >          git-add -f emptyDir # where emptyDir is empty dir
> > , emptyDir is added and then cloned. What does it mean ?
>
> $ git add -f emptyDir
> fatal: unable to index file emptyDir
>
> > Does it mean that if i git-add emptyDir with -f, it may break
> > something in the repo ? That I shall not try it ? Or it is ok ?
>
> It is not ok and it does not break anything. What git do you
> have, as I apparently cannot reproduce it.

It was 1.5.1.
In 1.5.1.2, it refuses to add, yes.
The message is:
fatal: emptyDir/../emptyDir: can only add regular files or symbolic links

Yakov
