From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: Intricacies of submodules
Date: Fri, 18 Apr 2008 09:41:34 +0800
Message-ID: <46dff0320804171841n7124525akeed0c680089770f1@mail.gmail.com>
References: <47F15094.5050808@et.gatech.edu>
	 <1208317795.26863.91.camel@goose.sun.com>
	 <87lk3c4ali.fsf@jeremyms.com>
	 <1208461808.26863.129.camel@goose.sun.com>
	 <46a038f90804171306t22491685p87d7445d44f00879@mail.gmail.com>
	 <7vabjsnrda.fsf@gitster.siamese.dyndns.org>
	 <bd6139dc0804171400x515b3c8br3cb1501cca8a6d0a@mail.gmail.com>
	 <46a038f90804171425q1cc4cff4m6b783252040a3b26@mail.gmail.com>
	 <bd6139dc0804171427i6bf2813at719c8dec13bc225c@mail.gmail.com>
	 <46a038f90804171431q51215be8od41792293712ca9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: sverre@rabbelier.nl, "Junio C Hamano" <gitster@pobox.com>,
	"Roman V. Shaposhnik" <rvs@sun.com>,
	"Jeremy Maitin-Shepard" <jbms@cmu.edu>,
	"Avery Pennarun" <apenwarr@gmail.com>,
	stuart.freeman@et.gatech.edu, git@vger.kernel.org
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 18 03:42:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmfcM-00041s-Ir
	for gcvg-git-2@gmane.org; Fri, 18 Apr 2008 03:42:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752421AbYDRBli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 21:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752435AbYDRBli
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 21:41:38 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:36690 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363AbYDRBlh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 21:41:37 -0400
Received: by an-out-0708.google.com with SMTP id d31so82810and.103
        for <git@vger.kernel.org>; Thu, 17 Apr 2008 18:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=HJpfs5iKyJOjG259hn3U3Qu+TfzhqXXD2Z568G6/zeQ=;
        b=uRbEOBxbB93YZ/vSJKJIcsmd4D+i9AiCuK67D8zMww5uXvdTjXLHsU8A7xCYgEa7JHj7m82yIJjRUgQYPSSgIuvq6aIzvHLgL9mdldG+cMiXfEFdecx3O187GH/oEYzwyOpDItjFMxxzASg+LhnB2E5jdI3Y11tcbN808EaQncc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Morigk20TyuWXXNqEMo7YPyYy7hMjQlm1DChe9BIqk0VznfrqezlXAwQKPoGvLmqEIXYDXBZrHcujb6b8L9+wOG0+jhvxEP9r7XQnAQ4z8rWeremLSeVj9989JG0b2x3Kpo6RQQboSOFQFm2g9iZ9guKEQo5Qr+LLrb3hvp9VMc=
Received: by 10.100.173.9 with SMTP id v9mr3924106ane.39.1208482894431;
        Thu, 17 Apr 2008 18:41:34 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Thu, 17 Apr 2008 18:41:34 -0700 (PDT)
In-Reply-To: <46a038f90804171431q51215be8od41792293712ca9@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79860>

On Fri, Apr 18, 2008 at 5:31 AM, Martin Langhoff
<martin.langhoff@gmail.com> wrote:
> On Thu, Apr 17, 2008 at 6:27 PM, Sverre Rabbelier <alturin@gmail.com> wrote:
>  >  >  >  Because of that an in-tree '.gitconfig' would have no security risks
>  >  >  >  as long as it is not 'used' until after the clone.
>  >  >
>  >  >  This is not true. A pre-commit hook or pre-checkout hook could be destructive.
>  >
>  >  But, those won't be executed till after the review, so everything
>  >  would be good still, wouldn't it?
>
>  No. A local review can be quite "active", involving changing branches,
>  moving patches around, and fixing sh*t up. The hooks available offer
>  plenty of danger if the repo can set them and make them active:
>
>  $ ls .git/hooks/
>  applypatch-msg  post-commit   post-update     pre-commit  update
>  commit-msg      post-receive  pre-applypatch  pre-rebase
>
AFAIK, hooks are not cloned automatically. So where do the destructive
hooks come from?

-- 
Ping Yin
