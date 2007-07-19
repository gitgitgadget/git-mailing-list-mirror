From: "Geoff Russell" <geoffrey.russell@gmail.com>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Thu, 19 Jul 2007 16:40:33 +0930
Message-ID: <93c3eada0707190010r10d048q72353304b9751770@mail.gmail.com>
References: <858x9ez1li.fsf@lola.goethe.zz>
	 <alpine.LFD.0.999.0707180912430.27353@woody.linux-foundation.org>
	 <vpq4pk1vf7q.fsf@bauges.imag.fr>
	 <alpine.LFD.0.999.0707181004330.27353@woody.linux-foundation.org>
	 <85644hxujp.fsf@lola.goethe.zz>
	 <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org>
	 <85abttwa7m.fsf@lola.goethe.zz>
	 <alpine.LFD.0.999.0707181710271.27353@woody.linux-foundation.org>
	 <20070719053858.GE32566@spearce.org> <85vechudrl.fsf@lola.goethe.zz>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 19 09:10:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBQ9l-0003Sf-Rt
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 09:10:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757391AbXGSHKf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 03:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757464AbXGSHKf
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 03:10:35 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:57142 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757391AbXGSHKe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 03:10:34 -0400
Received: by py-out-1112.google.com with SMTP id d32so883805pye
        for <git@vger.kernel.org>; Thu, 19 Jul 2007 00:10:33 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QtsHbG5K/XHjuwqWcqGMGjgImk7+SZ7tqPcE+sSmLN5qDaEF0w17disyhY/7W465pe3zeqEtQg1Xy/7ZPK4wUewDheZAH7cSejaPIjygKAanNnFHe3ygTHsKCOaa1hoGN+PtdvZU8rZDMOHMWHJCry7jne8DMNkg3MRC/ds10l8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lTVWl4XHpOfpPi5UbM/RhnPNdUyLvgQ4U48vWMZLYl1YlGMB/MIrWkhkIzpEH6NuJN0vFzx7QBOy6HJ/UloCmc4UiCiVReXTbA+xsjfEi+ODbPxOK27fDM3UUjA+rgYbhQuFZAcPlPctTn5Y7R1AJ9RttwcTZ5RTzl52KPdalXQ=
Received: by 10.64.184.16 with SMTP id h16mr4129415qbf.1184829033154;
        Thu, 19 Jul 2007 00:10:33 -0700 (PDT)
Received: by 10.65.216.17 with HTTP; Thu, 19 Jul 2007 00:10:33 -0700 (PDT)
In-Reply-To: <85vechudrl.fsf@lola.goethe.zz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52947>

Dear gits,

When I first started using git, I naively did

           $ mkdir NEWDIR && chmod BLAH NEWDIR
           $ git add NEWDIR

I just expected that this was content in the current directory that I
wanted tracked
together with the permissions.

It wasn't ... I spent a day or 2 thinking I was stupid, my version of git was
corrupt, my machine was busted, .... etc.  Eventually of course, I read the
documentation (when all else fails) and realised that this perfectly obvious
behaviour was not supported.  The behaviour was obviously so obvious
that eventually
an error message was added telling all the people who hadn't
read the documentation that trying to add a directory was 'fatal'.

I put up with and work around this behaviour because git is so bloody
brilliant at everything else.  But it would be nice if it worked.

Cheers,
Geoff Russell
