From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 2/3] mergetool-lib: specialize xxdiff options when in
	diff mode
Date: Thu, 2 Apr 2009 18:56:12 -0700
Message-ID: <20090403015610.GB52576@gmail.com>
References: <1238668246-762-1-git-send-email-davvid@gmail.com> <1238668246-762-2-git-send-email-davvid@gmail.com> <200904022320.55334.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Fri Apr 03 03:58:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpYfP-0005p8-8A
	for gcvg-git-2@gmane.org; Fri, 03 Apr 2009 03:57:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756216AbZDCB4R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 21:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755581AbZDCB4R
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 21:56:17 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:28216 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755260AbZDCB4Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 21:56:16 -0400
Received: by rv-out-0506.google.com with SMTP id f9so922571rvb.1
        for <git@vger.kernel.org>; Thu, 02 Apr 2009 18:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=xXxFTmfWKXuxC8khFREBS5Nfu6Vh/1vzzT7JmbmF2gA=;
        b=iVG4X7xKsEPDO7PrBmno+sfLorV16niEA2JyAWEU0esB8IWZ2AMaajE3AaEiW3s/+U
         TNBxaFxBXCIB1Bx7ABq2OO86vppDt0vn4AEvWXUPEn3Sn7RA0mFDuoaU7DLT1u3pmgbg
         L2Z/tpIb36ORCBy/6gTvIZLcYzemc1XW1WtNg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=QG2UXxjey8B+xOfJiN5728Z+vljWbCehp7PwJr99O8Nwa13UGp1cadzQw3vwqr88bC
         wclAfkbzcWKv97po77aTMXxao55PfhksNgSLCiIuNyhF60gvkCAgLDFIlBgR7yVvmIa2
         ZGPEDodPfEKlCdqndOvxG+iYJU2addxUlcQkg=
Received: by 10.141.37.8 with SMTP id p8mr269968rvj.18.1238723774936;
        Thu, 02 Apr 2009 18:56:14 -0700 (PDT)
Received: from gmail.com (wdas-1.disneyanimation.com [12.188.26.1])
        by mx.google.com with ESMTPS id k37sm5138053rvb.18.2009.04.02.18.56.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Apr 2009 18:56:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200904022320.55334.markus.heidelberg@web.de>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115508>

On  0, Markus Heidelberg <markus.heidelberg@web.de> wrote:
> David Aguilar, 02.04.2009:
> > We don't need '-merged-file', 'save as', and the merge-status exit
> > code when in diff mode
> 
> I guess the same as for xxdiff and kdiff3 also applies to opendiff,
> ecmerge and emerge. But since I don't have them installed, I'm not
> entirely sure not to break something.
> On the other hand it should be save, since they were just copied from
> git-mergetool without adjustment for diff use.
> 
> Markus
> 

I have opendiff on a mac at work so I'll give it a test there
and send a patch once it's working.

-- 
		David
