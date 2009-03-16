From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] Give error when no remote is configured
Date: Mon, 16 Mar 2009 16:01:07 -0400
Message-ID: <76718490903161301qca2214cta87411bad1b0b8b5@mail.gmail.com>
References: <alpine.LNX.1.00.0903110139450.19665@iabervon.org>
	 <7vocw2x7ob.fsf@gitster.siamese.dyndns.org>
	 <alpine.LNX.1.00.0903161204240.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, bernie@codewiz.org,
	git@vger.kernel.org, Giovanni Bajo <rasky@develer.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Mar 16 21:04:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjJ2S-0002f8-Pu
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 21:03:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753441AbZCPUBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 16:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758166AbZCPUBK
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 16:01:10 -0400
Received: from rv-out-0506.google.com ([209.85.198.237]:12584 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758643AbZCPUBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 16:01:09 -0400
Received: by rv-out-0506.google.com with SMTP id g37so1746126rvb.1
        for <git@vger.kernel.org>; Mon, 16 Mar 2009 13:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=YjRgtMA8Cjj+1943p1yQFp3BYpOil8g0eiVxg+CBhDI=;
        b=LKiWu4otejiT+vY8MxMHEhkHIJZPu2HxucRk+dqkwCFAxYiWV4kDWv+oX+od4V7bqW
         H8NDOWesnciR46AU6OuceiqMOIiZxcJGl4hNVPFPbh2mnSzWrC6GJbLNgEqnY1QhcF9e
         SHfk3UyPw5YSwchm/cPYHKsOoivFT44wXEAAI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=McV9kaT001AenZdUYu5DGqBXmtiXyfcG7Pr1Zk/DpOXEjlaTeBte9yykULIMVfl5ga
         GYDDqygsiLVIdIsksvP0Cfa/Ml6gQp12QpHNMa3z7NQWBkW4GcLjDlDpfiLD9FqojwKw
         9yMbr7VAH0QlM4+VNytO4ypNnH/oQeeJ8Q5Yo=
Received: by 10.140.136.5 with SMTP id j5mr2472682rvd.167.1237233667346; Mon, 
	16 Mar 2009 13:01:07 -0700 (PDT)
In-Reply-To: <alpine.LNX.1.00.0903161204240.19665@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113358>

On Mon, Mar 16, 2009 at 12:55 PM, Daniel Barkalow <barkalow@iabervon.org> wrote:
> No default remote is configured for your current branch, and the default
> remote "origin" is not configured either.

The use of "default" twice is slightly confusing. Perhaps:

No remote is configured for the current branch, and the default
remote "origin" is not configured either.

j.
