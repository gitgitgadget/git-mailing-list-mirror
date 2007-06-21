From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Basename matching during rename/copy detection
Date: Thu, 21 Jun 2007 09:00:47 +0100
Message-ID: <200706210900.49702.andyparkins@gmail.com>
References: <20070621030622.GD8477@spearce.org> <7vsl8m3sph.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	govindsalinas <govindsalinas@yahoo.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 21 10:00:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1Hb6-0006Iz-Bq
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 10:00:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752460AbXFUIAw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 04:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752405AbXFUIAw
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 04:00:52 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:60085 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752243AbXFUIAv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 04:00:51 -0400
Received: by ug-out-1314.google.com with SMTP id j3so523804ugf
        for <git@vger.kernel.org>; Thu, 21 Jun 2007 01:00:51 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=X4KEKn8CkOI+Q60u3OicH6pSAJ6SzuEr/ikiGnMhvGKhakW27ldAOnv7QwScrmCiMt2SPhHzYHG3MRWe6ZQcH1Tgh3BrXzHnb2MXih5Xj6uHLYo8Q0MHUkroxSq+hQj9PYRSCXThiRCUt6kcqwf9MUSnv+uZSWyHdJyb1sTa3WM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=YpT+WBjX9aGSUXNbZ6prfA4Z3qB4WEp0MB09aE+eJVatRuWMn+6ywTGZvH1rg+KQTRuyC5p82EmKufbAELCqzexkPAi7Cvmv1TRGgIM6f7KRcJWnIRM7WdDFNd3IPUPtDgU5WOBXKmzaKj3nlssoZ46ZxLfJN2F9iULdnxfT0rs=
Received: by 10.82.136.4 with SMTP id j4mr3310784bud.1182412850878;
        Thu, 21 Jun 2007 01:00:50 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id z33sm2975139ikz.2007.06.21.01.00.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 21 Jun 2007 01:00:50 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <7vsl8m3sph.fsf@assigned-by-dhcp.pobox.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50606>

On Thursday 2007 June 21, Junio C Hamano wrote:

> Having many "identical files" in the preimage is just stupid to
> begin with (if you know they are identical, why are you storing
> copies, instead of your build procedure to reuse the same file),
> so the algorithm did not bother finding a better match among
> "equals".

That's a really poor argument; it's not git's place to impose restrictions on 
what is stored in it.

What if it's not a build environment at all but a home directory that's being 
stored - should no one be allowed to store copies of files because 
it's "stupid"?  What if it's a collection of images that all started out the 
same, but have gradually had detail added (which is actually what I do in my 
GUI programs for toolbar images)?  What about files that are used as flags, 
and are all identically empty.

None of those seems like an abuse of a VCS to me.  In fact, I'd say it's one 
of git's strengths that a duplicate file in the working tree doesn't take up 
any extra space in the repository.


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
