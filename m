From: "Rob Sanheim" <rsanheim@gmail.com>
Subject: Re: alias g to git in .gitconfig?
Date: Fri, 3 Oct 2008 11:25:53 -0400
Message-ID: <fc113d400810030825l75f9451dwc4cbf68807be0b5b@mail.gmail.com>
References: <fc113d400810021951hf95ff35qb1ccb4af45a71abe@mail.gmail.com>
	 <20081003031014.GA24367@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 03 17:27:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlmYb-0007lO-56
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 17:27:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbYJCPZz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 11:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbYJCPZz
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 11:25:55 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:60595 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775AbYJCPZy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 11:25:54 -0400
Received: by wa-out-1112.google.com with SMTP id v27so824810wah.21
        for <git@vger.kernel.org>; Fri, 03 Oct 2008 08:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=h5CwlVJW1lVvF8cG2JTvhKm2rXdQNVTf5nSUhKxBrVc=;
        b=Vtt7Pqlb+x0z8vLrjEhdc1iv4S+4xNdDxIJzmaCgn2rLggcfTo/LZvOJMORaQB2XdS
         kDvg5QANGuZV4T4E6E6HY59QBIo7zv6nR/gTCQJDd4E/jTbREAGCxvosgkMMZ45IMkNh
         WuDicslMtgk9Z3R+oipRKt6cn8MMrhLnazLys=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Ep0m3/ICPdMlSv5g+J+G1Z84hp5O29nwSMwQN3OtU4PXnDWuehVojJu96i03K3fZSr
         uz5jbtTnFbg5sxGL3Cl6RWoaU1YgRSU5ntflAff0jl2T+hqJh7ZwUD/p+E+SWTEoxqvm
         WICsJ2m9YR1DSdh60KlOs6IxnB4Oo3W6oUPRw=
Received: by 10.114.13.10 with SMTP id 10mr1367559wam.106.1223047553465;
        Fri, 03 Oct 2008 08:25:53 -0700 (PDT)
Received: by 10.115.79.2 with HTTP; Fri, 3 Oct 2008 08:25:53 -0700 (PDT)
In-Reply-To: <20081003031014.GA24367@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97432>

Thanks, that did it.

On Thu, Oct 2, 2008 at 11:10 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Rob Sanheim <rsanheim@gmail.com> wrote:
>> This is pretty trivial, but I'm a lazy typist.
>>
>> Is it possible to alias 'g' to git via git config, instead of via
>> bash?  If I do a plain bash alias then none of the nice autocompletion
>> from git-contrib work with 'g'.
>
> No, you'll need to alias 'g' to git in bash, and then if you still
> want completion you'll need to also register the compgen to call
> _git completion routine.  Its two lines:
>
>        alias g=git
>        complete -o default -o nospace -F _git g
>
> --
> Shawn.
>
