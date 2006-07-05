From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: git reset --hard include/linux/config.h
Date: Wed, 5 Jul 2006 19:29:07 +0200
Message-ID: <81b0412b0607051029q175928faq113b81de8c11db30@mail.gmail.com>
References: <20060705165801.GA11822@mars.ravnborg.org>
	 <81b0412b0607051005s59315296tfb68345959a14c1b@mail.gmail.com>
	 <20060705171406.GA17834@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 05 19:29:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyBBb-0001iW-UI
	for gcvg-git@gmane.org; Wed, 05 Jul 2006 19:29:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964897AbWGER3K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Jul 2006 13:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbWGER3K
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Jul 2006 13:29:10 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:32460 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964897AbWGER3J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jul 2006 13:29:09 -0400
Received: by nf-out-0910.google.com with SMTP id g2so1318233nfe
        for <git@vger.kernel.org>; Wed, 05 Jul 2006 10:29:08 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=A5sHN80xE4iqcXL/qwteDFPDhkyONpQDw8BzRd+MEQ1v1Ahr7WObEdxaCodDHeZBSbJLxQd9iWsUVdMkg6pf+q+NIzBUrqRHwnhHwTh7yo1HrBUVGLLEH/0vUaILXRz8q+NxVJhctuzpd/EpRRldGx4iC8p/K/RSkKfWXjnDWn0=
Received: by 10.78.177.3 with SMTP id z3mr2408530hue;
        Wed, 05 Jul 2006 10:29:08 -0700 (PDT)
Received: by 10.78.37.7 with HTTP; Wed, 5 Jul 2006 10:29:07 -0700 (PDT)
To: "Sam Ravnborg" <sam@ravnborg.org>
In-Reply-To: <20060705171406.GA17834@mars.ravnborg.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23359>

On 7/5/06, Sam Ravnborg <sam@ravnborg.org> wrote:
> On Wed, Jul 05, 2006 at 07:05:27PM +0200, Alex Riesen wrote:
> > On 7/5/06, Sam Ravnborg <sam@ravnborg.org> wrote:
> > >Also what is the right command to bring back a file to the original
> > >state after doing some modifications that was not needed anyway?
> >
> > git checkout HEAD include/linux/config.h
>
> Thanks!
>
> By the way - the modifications to include/linux/config.h was not lost.
> But git apperantly managed to be fooled to think the file was
> up-to-date.

After that checkout or after reset --hard? Both is quiet unusual, though
