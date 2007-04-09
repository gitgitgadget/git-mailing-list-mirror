From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH 0/8] git-repack --max-pack-size
Date: Mon, 9 Apr 2007 11:54:17 -0700
Message-ID: <56b7f5510704091154o2a52d563p1c0c72519447a1eb@mail.gmail.com>
References: <46197814.5010909@gmail.com>
	 <alpine.LFD.0.98.0704082229290.28181@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>, danahow@gmail.com
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Apr 10 01:47:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Haz0R-0000Sx-AB
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 20:54:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbXDISyT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 14:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbXDISyT
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 14:54:19 -0400
Received: from nz-out-0506.google.com ([64.233.162.238]:37007 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932231AbXDISyS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 14:54:18 -0400
Received: by nz-out-0506.google.com with SMTP id s1so1099443nze
        for <git@vger.kernel.org>; Mon, 09 Apr 2007 11:54:17 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FY+Vls/XOCZq1PG6hwSPYY0TTX6SDP5nYa1Ktvl9N2SjVUhT/fNntON2nv0JUmTZ3p+EwshLAYCAD2+wvN3xe5YDt9lKdKDS4fSgrcBX3iyxko3eOIAUXCStFU0OlmV/diroArzg70HgDUouM8FYIDnP1LmQulN0zC00/+R8lj0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MT456KgdbHM7hhkDOp/lsjiWRaZO4y9jRiJNMF1ZlsSFb0+J+kYK78XD88tgERaSikINymTGM3vmFtnEJno8qMVrUXruRFpbXY3QL60RkzJYagViwOl8FE9CCm5etpK79Ju7HsC8pmjgeJ6Zfj89oppjjGH7gPf+g+IPZWnSEtU=
Received: by 10.114.195.19 with SMTP id s19mr1046658waf.1176144857263;
        Mon, 09 Apr 2007 11:54:17 -0700 (PDT)
Received: by 10.114.46.4 with HTTP; Mon, 9 Apr 2007 11:54:17 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.98.0704082229290.28181@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44084>

On 4/8/07, Nicolas Pitre <nico@cam.org> wrote:
> On Sun, 8 Apr 2007, Dana How wrote:
>
> > After reviewing others' comments,  this latest patchset
> > touches 2/3 fewer files and 1/6 fewer lines,  and
> > introduces no behavior not seen elsewhere in git.
>
> I'm starting to like it, but...
>
> I have some extensive changes that touch the same area more or less.
> And so far I think it might be easier to rebase your changes on top of
> mine rather than the other way around.
>
> So I'd like if my changes would be merged first and then yours to be
> applied afterwards.  They still have some issues left anyway.
>
> I'm trying to format my changes now and send them tonight.
Thanks for sending them out.
I guess I'll update mine to apply after yours once
yours show up in the appropriate branch.

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
