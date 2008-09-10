From: "Ramagudi Naziir" <naziirr@gmail.com>
Subject: Re: rsync vs. git-push/pull ? (+kudus)
Date: Wed, 10 Sep 2008 09:35:44 +0300
Message-ID: <dfb262380809092335q3d61488gf680c91ac23e69da@mail.gmail.com>
References: <dfb262380809062311i3fffb900m5d73f5396b403dbe@mail.gmail.com>
	 <20080907073821.GA28289@linode.davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "David Brown" <git@davidb.org>
X-From: git-owner@vger.kernel.org Wed Sep 10 08:37:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdJK8-0000Mt-Oy
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 08:37:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751559AbYIJGfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 02:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751767AbYIJGfq
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 02:35:46 -0400
Received: from rv-out-0506.google.com ([209.85.198.225]:50218 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075AbYIJGfp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 02:35:45 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2254633rvb.1
        for <git@vger.kernel.org>; Tue, 09 Sep 2008 23:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=dMiAZ09HFvql8P1S5MmpXcoz0ZtmD82eX5ZZoQqQYIM=;
        b=uKR6bLaYqM5xLmQqGnJ7KoRAnVkCz62Uz7QMnx6wZ2PyvjDedrCQLlnkP0W0q9n6Ip
         fskfYtlCwLRwIl+zDcSxRu5bC0TyeIRqL1TnZw4Vn/Yiz8cHJMAdxhPVRdEkDfd0dSI4
         +oq/Bg8ciU9APSxtIz9eYaW1Sl7r3cLN90Ag4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=u+cLieT0JFKB0KQf77b8vMPufmNRcHi13P0WQzmHBVx5O5ZvmLsi3Y7ZgbQG+tWoE7
         d3OBMU4ZmOQ6u1rQGyxtqJ9UUZMKrm+WGby7p2hq9Y5ZuXG2yWUs6/6zF3mFsoOdratw
         I5+dULE6BjMrDKa0h22JPwMxX8LCByukifv7E=
Received: by 10.140.188.19 with SMTP id l19mr520853rvf.79.1221028544379;
        Tue, 09 Sep 2008 23:35:44 -0700 (PDT)
Received: by 10.141.29.1 with HTTP; Tue, 9 Sep 2008 23:35:44 -0700 (PDT)
In-Reply-To: <20080907073821.GA28289@linode.davidb.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95488>

Hi David,

On Sun, Sep 7, 2008 at 10:38 AM, David Brown <git@davidb.org> wrote:
> On Sun, Sep 07, 2008 at 09:11:47AM +0300, Ramagudi Naziir wrote:
>
>> I really prefer rsync to git-push/pull since it is much more easier -
>> It's one command that syncs my whole working folder, including the git
>> repositories..
>
> I used to do this quite a bit until after a few times I forgot to sync
> before changing things.  I solved this by creating a bare repo I could
> push/pull from, and pushing one of them to it, then fetching and
> merging in the other.

can you please elaborate on this technique ? I don't really get it.
You mean you have an empty git repository somewhere, with which you
are synchronizing all other repositories ?
>
> After getting more familiar with git, I now use git with push/pull for
> pretty much anything I want synchronized.  It nicely keeps track of
> what I've done, whereas it is easier with rsync, or even unison, to
> forget to do the sync.

so you have myriad of git repositories ? and you push/pull all of them
every time you move to another station ? I also have a lot of git
repositories, even for stuff other than source code projects.

thank you
naziir
>
> David
>
