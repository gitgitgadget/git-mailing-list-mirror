From: Carlos Santana <neubyr@gmail.com>
Subject: Re: immutable tags?
Date: Mon, 28 Dec 2009 14:39:53 -0600
Message-ID: <92c9564e0912281239h49f9138ena8bbb3a63a337a55@mail.gmail.com>
References: <92c9564e0912281204h13c6a566w95069023e6909eda@mail.gmail.com>
	 <alpine.DEB.2.00.0912281223440.24130@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Mon Dec 28 21:40:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPMNj-00012p-Rm
	for gcvg-git-2@lo.gmane.org; Mon, 28 Dec 2009 21:40:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbZL1Uj4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Dec 2009 15:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbZL1Ujz
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Dec 2009 15:39:55 -0500
Received: from mail-fx0-f225.google.com ([209.85.220.225]:63810 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181AbZL1Ujy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Dec 2009 15:39:54 -0500
Received: by fxm25 with SMTP id 25so4830669fxm.21
        for <git@vger.kernel.org>; Mon, 28 Dec 2009 12:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fCXYaNNLLr5BgOJmmoB94V6zF6ZbkVtNJGaHWtOVVIo=;
        b=xXxJI+AXnknGY2n21531YqooLbDJCxD7dOrOeILnVjyBASqwZr/Pt5OhocWRn9iVeO
         c2DztFmWQYJ+/assf0jERFH8Hx/A2HFmHq4kTti8R01rYzT2ErfZe/hmvEEBWOxAuGsY
         raJmx6UqqXnmxYygsGXJTM1inFJszH5OlNcpA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lCdiuDKHvEtW7Dw4FUlMKF5/1wYcpZFyJmiSEiWTL5j1ldW0vpA16jXplEtujF8r0z
         /p0MohkHRWaF6VHWNwPD/vFLZ7TpBzqYFk3O3fRjrKeVwdpN79drNPusf+MZj+L4i46i
         NlNrWYAks57Vb+hmC3AVXzzyq/fwU53DpqGBA=
Received: by 10.223.132.204 with SMTP id c12mr7432517fat.80.1262032793489; 
	Mon, 28 Dec 2009 12:39:53 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.0912281223440.24130@asgard.lang.hm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135761>

Thanks for the reply David.
I think 'tagged directory' wasn't the appropriate phrase here.

In Subversion like systems branches and tags are same, i.e., both are
created using 'svn copy'. Branches are generally created for separate
line of development and tags for releasing software. So developers
follow convention of not checking in anything into tags. Otherwise
they are same.

I know that creating branches/tags doesn't involve copying files into
new directory in case of git. It will act as a pointer and make note
of changes thereafter. What I am not sure is difference between
branches and tags. Is it left to developer to follow subversion like
convention or git provides some mechanism to 'lock' tags?

-
CS.



On Mon, Dec 28, 2009 at 2:25 PM,  <david@lang.hm> wrote:
> On Mon, 28 Dec 2009, Carlos Santana wrote:
>
>> I would like to know if there is any difference between branches and
>> tags. Is it only conceptual - convention to be followed by a develop=
er
>> or some technical difference? =A0e.g. : Is it possible to create
>> immutable tags so that nothing can be checked in to that 'tagged
>> directory'?
>
> tags are pointers into the tree. tags do not change.
>
> in git directories are not tagged, so I'm not sure what you are worki=
ng
> towards here.
>
> David Lang
>
>
