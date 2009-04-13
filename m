From: Andy Lester <andy@petdance.com>
Subject: Re: C internals cleanup
Date: Sun, 12 Apr 2009 23:29:16 -0500
Message-ID: <A60582E3-0374-4922-B6C9-42BCF2DCAFFB@petdance.com>
References: <22578EEA-DB8B-4DAF-B217-FF13DC8A3EC7@petdance.com> <7v4owtw623.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 13 06:30:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtDop-0003lO-QI
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 06:30:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751919AbZDME3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 00:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbZDME3S
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 00:29:18 -0400
Received: from huggy.petdance.com ([72.14.176.61]:48986 "EHLO
	huggy.petdance.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751098AbZDME3R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 00:29:17 -0400
Received: from mel.petdance.com (uniqua.petdance.com [64.81.227.163])
	by huggy.petdance.com (Postfix) with ESMTP id 2A077AC8E7;
	Mon, 13 Apr 2009 00:29:17 -0400 (EDT)
In-Reply-To: <7v4owtw623.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116412>

> The general rule of thumb is to do such a clean-up before you start to
> work on something of substance.

I guess that's all in how one defines "substance." :-)

My ultimate goal is to get more stringent error-checking, to get more  
compiler warnings enabled, and to get a splint target.  splint is  
fantastic for tracking all sorts of memory and logic problems, but  
benefits greatly from getting the const qualifiers in place.  Even gcc  
will be happier.

Thanks for the recap.  It's hard to absorb what you just described  
just from reading mailing list history.

xoa

--
Andy Lester => andy@petdance.com => www.petdance.com => AIM:petdance
