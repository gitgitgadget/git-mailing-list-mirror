From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Unresolved issues #3
Date: Thu, 17 Aug 2006 21:49:54 -0700
Message-ID: <44E546F2.7070902@gmail.com>
References: <7vpseyelcw.fsf@assigned-by-dhcp.cox.net>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 18 06:50:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDwJB-00009p-JO
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 06:50:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbWHREuF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 00:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbWHREuF
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 00:50:05 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:62025 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932381AbWHREuC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Aug 2006 00:50:02 -0400
Received: by py-out-1112.google.com with SMTP id z74so1794549pyg
        for <git@vger.kernel.org>; Thu, 17 Aug 2006 21:50:01 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=I7//uDZ9Qwf1sELR4kdofzkr88bFv+UIDnH+tglylMxZ30OgKdyubDtCtCyMukmA6rzaHt0pEEL3P0q5ZN6wYXIC+rmZRzropMO5WhCl26t29uKiFSKyqF1RuFn5CKtgtbCMkxvT+G2IH2IUYLsTkGsK7BuYq/vSGWcmQvDu1FM=
Received: by 10.35.38.17 with SMTP id q17mr5065998pyj;
        Thu, 17 Aug 2006 21:50:01 -0700 (PDT)
Received: from ?10.0.0.6? ( [68.234.172.127])
        by mx.gmail.com with ESMTP id h41sm2374180pyh.2006.08.17.21.50.00;
        Thu, 17 Aug 2006 21:50:01 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpseyelcw.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25626>

Junio C Hamano wrote:
...
> * "A Large Angry SCM" wrote a nice summary, "Git files data
>   formats documentation".
> 
>   Message-ID: <44D51D47.9090700@gmail.com>
> 
>   With one final update by Nico yesterday, I think it is ready
>   for inclusion.
> 
>   Does somebody care to make a patch out of it to add it to
>   Documentation/technical/, maybe removing pack-format.txt there
>   after making sure all it talks about is covered by the new
>   documentation?
> 
>   I do not have enough "virginity" to spot omissions in the
>   description anymore, so comments from somebody new to the
>   system are very much appreciated.
> 

Two things:

1) I disagree with Nico's assessment that, other than his, there can not
exist any type 2 packs that have bit 6 set to mean copy from result.

2) The document, if included into the core Git documentation, would be
viewed as more authoritative than it actually is. It's really just a set
of (structured) notes on various aspects of the files Git reads and
writes, pulled from various sources. Little or no attempt was made to
separate "implementation artifact" from intended structure.
