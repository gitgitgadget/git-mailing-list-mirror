From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Initial push of a fully packed repo - why repack?
Date: Tue, 17 Apr 2007 14:28:06 +1200
Message-ID: <46a038f90704161928q4597c97ajd33106f119516328@mail.gmail.com>
References: <46a038f90704161812r143b6d27scbcc401ee77c4597@mail.gmail.com>
	 <alpine.LFD.0.98.0704162215520.4504@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Apr 17 04:28:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HddQS-0008D8-EM
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 04:28:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754295AbXDQC2J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 22:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754294AbXDQC2J
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 22:28:09 -0400
Received: from wx-out-0506.google.com ([66.249.82.232]:29969 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754295AbXDQC2H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 22:28:07 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1866365wxd
        for <git@vger.kernel.org>; Mon, 16 Apr 2007 19:28:06 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VwtBGzs7U77FxDt2lImYhwLMy9Ay356XhLDcYToWU1ayrIQ6iO/ZQwyUjEhJh4bXZ4JlsZrNIH9miGw+lS5hfLwIO6aqA+YcEgVlGzcn0es11h7DmikTs543mtD0F7umIb1ndfaEchCnyFJxjFc6zY4A+nYPxid2CbxyZRcqfB4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SqtcwX2mjILoKHV82T2MMUtoi752NlXssXZslYaCAaBQEuccPT+K2++9PDMhc3DUCckY9nCZEuuEGEx6z8qW/8mAYeM+3v+aXb09rlsDkoTwA5RIFtwdBFPExc5xsXhSMEqnmmlX8fDlfbf28zKcgiqNVMhvadDTrjNJVWrX/V8=
Received: by 10.90.52.18 with SMTP id z18mr5794071agz.1176776886840;
        Mon, 16 Apr 2007 19:28:06 -0700 (PDT)
Received: by 10.90.52.17 with HTTP; Mon, 16 Apr 2007 19:28:06 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.98.0704162215520.4504@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44710>

On 4/17/07, Nicolas Pitre <nico@cam.org> wrote:
> On Tue, 17 Apr 2007, Martin Langhoff wrote:
> > Does it make sense to detect and optimise for this case?
> Maybe...  Although the second repack during the push should be much much
> faster than the first one.

It is - but it still burns through perhaps 1 minute of CPU and IO
rewriting the exact same pack as you can see:

Generating pack...
Done counting 290123 objects.
Deltifying 290123 objects.
 100% (290123/290123) done
Writing 290123 objects.
 100% (290123/290123) done
Total 290123 (delta 234293), reused 290123 (delta 234293)

cheers,


martin
