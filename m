From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git-annotate dies when a patch is missing trailing newline
Date: Thu, 2 Mar 2006 16:07:00 +1300
Message-ID: <46a038f90603011907h6d0d4450w426afb9ada33ddb0@mail.gmail.com>
References: <46a038f90603011653l7956d5dat99d88a7da98d21b6@mail.gmail.com>
	 <7vslq1d1pr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 02 04:08:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEeA2-0000mu-9q
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 04:07:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbWCBDHE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 22:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWCBDHE
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 22:07:04 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:49096 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751380AbWCBDHB convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Mar 2006 22:07:01 -0500
Received: by wproxy.gmail.com with SMTP id i24so305030wra
        for <git@vger.kernel.org>; Wed, 01 Mar 2006 19:07:01 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HUYey3p8dy1ZKv7gr9N2KG+jxALswihIEtH2NZ8YTzakC2rqiR9vZA9tj2pxDph4iqsMlQ8bO5/hw4jn3bO4xK2/pjUSwjISoV945Et4M8xWU/MYrKEdi2PDlOTHgjeAxZYqcH+xia5jd7rX5Xt/EA7lLKVqc/IQHDM3q21c3g0=
Received: by 10.54.110.5 with SMTP id i5mr524173wrc;
        Wed, 01 Mar 2006 19:07:00 -0800 (PST)
Received: by 10.54.71.5 with HTTP; Wed, 1 Mar 2006 19:07:00 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vslq1d1pr.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17042>

On 3/2/06, Junio C Hamano <junkio@cox.net> wrote:
> "Martin Langhoff" <martin.langhoff@gmail.com> writes:
>
> > git-annotate is dying when a patch is missing trailing newline. There
> > _are_ valid situations where code files are not expected to have
> > trailing newlines. Just thing of that glorious programming language,
> > PHP.
>
> Does this help?

Yes, excellent! BTW, I just realized that git-cvsserver is in master,
but the "git-annotate -S" patch isn't there, so cvs annotate dies. Is
anything holding the patch back in next?

cheers,


martin
