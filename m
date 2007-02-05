From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Deprecation/Removal schedule
Date: Mon, 5 Feb 2007 16:50:56 +0100
Message-ID: <81b0412b0702050750m5760ce61le34acc8adfdb8081@mail.gmail.com>
References: <7v8xfdnlqm.fsf@assigned-by-dhcp.cox.net>
	 <eq6tj6$80m$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 05 16:51:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HE67c-0000ML-Rm
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 16:51:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbXBEPu7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 10:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbXBEPu7
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 10:50:59 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:50179 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401AbXBEPu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 10:50:58 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1331380uga
        for <git@vger.kernel.org>; Mon, 05 Feb 2007 07:50:57 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KZbWN1Q6/o8Yab82tKMnPOHKCxgK8ZT9ly/ilgr7yuntUnbJycaSGv2mkIPNninGNyjwvvcT5yJwTkflso3KDEsXtOZBHZfYy3aL5+JKozrZnCKowtrWZbhrL4b7TfJLrmfroqzbu8p9A9H7Rmk9ncGNgwHg1wiYVnaFfVYNYs4=
Received: by 10.78.47.15 with SMTP id u15mr1103094huu.1170690656791;
        Mon, 05 Feb 2007 07:50:56 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Mon, 5 Feb 2007 07:50:56 -0800 (PST)
In-Reply-To: <eq6tj6$80m$2@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38755>

On 2/5/07, Jakub Narebski <jnareb@gmail.com> wrote:
> Junio C Hamano wrote:
>
> > * git-lost-found
> >
> >   Although it has served us well, I think it is about to outlive
> >   its usefulness, thanks to the recent "reflog by default"
> >   change.
>
> I agree. If it is needed, perhaps this functionality should be made
> as an option to git-fsck.
>

I have reflog off by default (and never missed it yet), so leave it
at least as option to git-fsck, please. Besides, how do you find
lost objects which were not mentioned in any reflog? (because
of a bug someone made in reflog code, for example)
