From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Intricacies of submodules
Date: Thu, 17 Apr 2008 17:06:27 -0300
Message-ID: <46a038f90804171306t22491685p87d7445d44f00879@mail.gmail.com>
References: <47F15094.5050808@et.gatech.edu>
	 <46dff0320804110904w531035f4w79c1889bc90c09ee@mail.gmail.com>
	 <7vmyo0owep.fsf@gitster.siamese.dyndns.org>
	 <1207970038.10408.8.camel@ginkgo>
	 <7vlk3jlkrr.fsf@gitster.siamese.dyndns.org>
	 <1208202740.25663.69.camel@work.sfbay.sun.com>
	 <7vd4or7wdt.fsf@gitster.siamese.dyndns.org>
	 <1208317795.26863.91.camel@goose.sun.com>
	 <87lk3c4ali.fsf@jeremyms.com>
	 <1208461808.26863.129.camel@goose.sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jeremy Maitin-Shepard" <jbms@cmu.edu>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Ping Yin" <pkufranky@gmail.com>,
	"Avery Pennarun" <apenwarr@gmail.com>,
	stuart.freeman@et.gatech.edu, git@vger.kernel.org
To: "Roman V. Shaposhnik" <rvs@sun.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 22:30:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmaO6-0002Wf-2T
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 22:07:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753036AbYDQUGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 16:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753030AbYDQUGb
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 16:06:31 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:1716 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753022AbYDQUGa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 16:06:30 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1234297ugc.16
        for <git@vger.kernel.org>; Thu, 17 Apr 2008 13:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=oKdreK+DGIZ9/iM44ADTxi1+/SHGWwpk0YqKivHvuSY=;
        b=aIoIbqiY8AUa17DiLJIpPTI2BbRDf/I1v6FTigjxa3hVtknENwoxx/vKCSilDVFmX4EVUufb2SmK9BY1biq8eFxBd7mzYSX+0ILZPbSLDIBzJBDBjeA/lWcQU8VIwvatTdIVu1n4pDNIzPo7sDvrjiqN37otbMlDod5WRljDSXk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pSTQjMRrTDplAL1SNW5dlbnbSb21y4+ZNnBI6EACFXuVi9ZlL28MxwFKS4JwIPsA2me1r4UCE1JzTiUioL1OXuROsF/HKloRzyDaC01plF6wOvHX032Ar7/tGmJUslAuete3mtDHvz5ViHrGT/eN/d67JfbtsZREotygTPeCm3M=
Received: by 10.66.242.5 with SMTP id p5mr8866249ugh.87.1208462787644;
        Thu, 17 Apr 2008 13:06:27 -0700 (PDT)
Received: by 10.66.252.2 with HTTP; Thu, 17 Apr 2008 13:06:27 -0700 (PDT)
In-Reply-To: <1208461808.26863.129.camel@goose.sun.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79818>

On Thu, Apr 17, 2008 at 4:50 PM, Roman V. Shaposhnik <rvs@sun.com> wrote:
>  There are two things at play: first of all, I usually *do* trust the
>  content of the repository. Call it matter of personal preference,

I think most people here split the trust into "before or after
compilation". I must trust that I can clone/checkout code safely so I
can review it.

Running the code contained in the repo we are discussing a completely
different matter.  Even before compilation, Makefiles and configure
scripts may shoot you in the foot or in the face. But you had at least
a chance to review it.

cheers,


n
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
