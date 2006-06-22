From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: gitk lower pane (commit and files view) scrollbar extends past gitk window
Date: Thu, 22 Jun 2006 09:10:24 +0200
Message-ID: <81b0412b0606220010p6c2e62ffv3914abafd95e4bb2@mail.gmail.com>
References: <e7ber7$qh9$1@sea.gmane.org>
	 <20060622023546.28cb4291.froese@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org,
	"Paul Mackerras" <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Jun 22 09:10:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtJKe-0005Nk-LB
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 09:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbWFVHK0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 03:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751761AbWFVHK0
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 03:10:26 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:20280 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751057AbWFVHKZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jun 2006 03:10:25 -0400
Received: by ug-out-1314.google.com with SMTP id a2so322749ugf
        for <git@vger.kernel.org>; Thu, 22 Jun 2006 00:10:24 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rfmDoxAVmwpBg6xqJSxgtbO96wJWywk4xT/snejCHTsYnil7OgZmAEcOusdzYKzRKkQlhPzQ5VQV/1aYjHMXWHtlHAUyUUMjvr113nQbvgytN4oxbBLdVhnItu+Cd6YQ8di96IxEpmdGrrOrocUuK+/931UaJQLSXFvEjEyBUl0=
Received: by 10.78.177.3 with SMTP id z3mr239897hue;
        Thu, 22 Jun 2006 00:10:24 -0700 (PDT)
Received: by 10.78.37.7 with HTTP; Thu, 22 Jun 2006 00:10:24 -0700 (PDT)
To: "Edgar Toernig" <froese@gmx.de>
In-Reply-To: <20060622023546.28cb4291.froese@gmx.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22303>

On 6/22/06, Edgar Toernig <froese@gmx.de> wrote:
> Jakub Narebski wrote:
> >
> > In gitk from the current 'next' branch, post git version 1.4.0
> > (blob ba4644f) scrollbar for lower pane, i.e. for commitdiff and files
> > (Comments) views extends past the bottom of the gitk window. Therefore
> > I cannnot see lower part of commit diff if it is larger than window height.
>
> Yes, and the search field at the bottom is invisible too.  Removing
> line 431:
>
>         .ctop conf -width $geometry(width) -height $geometry(height)
>
> seems to fix it and the window still gets the right size.
>

No, it does not. It gets the default geometry, not the one it had last time.
