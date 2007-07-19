From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [REVISED PATCH 2/6] Introduce commit notes
Date: Thu, 19 Jul 2007 15:33:47 +0100
Message-ID: <200707191533.48641.andyparkins@gmail.com>
References: <Pine.LNX.4.64.0707152326080.14781@racer.site> <200707191158.37713.andyparkins@gmail.com> <Pine.LNX.4.64.0707191209200.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Alberto Bertogli <albertito@gmail.com>,
	Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 19 16:34:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBX50-0003dA-K5
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 16:34:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764894AbXGSOd4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 10:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938312AbXGSOdy
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 10:33:54 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:12894 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S938303AbXGSOdw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 10:33:52 -0400
Received: by ug-out-1314.google.com with SMTP id j3so419220ugf
        for <git@vger.kernel.org>; Thu, 19 Jul 2007 07:33:51 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=fJrOuS54mhkDosNmjs3eYdtHk/AePBXZhQgnGn6aUvodnPUywbYHfCDMQKM0Msc5hlt5BsH9VbktBNkwk/A7ye+iS2D+eMfhmBuUWa4dZ+DT152Nf4o880iGzbTFWKDUOR7/2FK7PWQm0EizUcR4ygFH9u+ZXt5sZMjAvQTosL8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=a5JQ2wvpP31nqNX6Dyox6zKfc+2UrAKiOuiJra+fGlmLZOi4BdPXIitOIRonVMS6VoJtjEeqv/6kn9imMswdHisRF0Xa68ajNkrt1g4GFxkh57DWoXh3ZM7p3EM8giCtmyLk+4io8YMlpLrjIQvNnjsPKt3shk893Appmjyexo0=
Received: by 10.67.19.9 with SMTP id w9mr1197230ugi.1184855631880;
        Thu, 19 Jul 2007 07:33:51 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTPS id z37sm3785186ikz.2007.07.19.07.33.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 19 Jul 2007 07:33:51 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <Pine.LNX.4.64.0707191209200.14781@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52993>

On Thursday 2007 July 19, Johannes Schindelin wrote:

> > In the case of the notes system, is there not a big hole available
> > because the layout is under tight control?
>
> No.  It is a tree object, referenced from a ref.  You can always check it
> out, modify it, and check it in.  If only by mistake.

I was arguing for the tree-index being special cased though (ideally with an 
invalid filename), such that it could never actually be checked out or 
checked in, but would be maintained automatically "git-side".  For backwards 
compatibility, it would be optional; and making it an invalid filename 

It was only a suggestion to answer Junio's request for a "hole" through which 
a tree-object index could be poked.

If we're only talking about the notes tree, then would it matter that it could 
be checked out and checked in?  If someone chose to do that then it would be 
their own fault when the index didn't work.  If I wanted I could 
edit .git/objects/ directly - I wouldn't expect poor git to work correctly 
afterwards though.



Andy


-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
