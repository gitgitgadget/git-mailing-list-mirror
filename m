From: "Whit Armstrong" <armstrong.whit@gmail.com>
Subject: Re: is it possible filter the revision history of a single file into another repository?
Date: Fri, 19 Dec 2008 08:08:23 -0500
Message-ID: <8ec76080812190508v2ef0f982pab66a698f06a80d5@mail.gmail.com>
References: <8ec76080812180551p8c97a0dqa2025e67792946c7@mail.gmail.com>
	 <8ec76080812180619k78a28e30t591b514148202869@mail.gmail.com>
	 <8ec76080812181151y4a5a6f5cna57785c935032e77@mail.gmail.com>
	 <200812191044.47830.thomas.jarosch@intra2net.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Thomas Jarosch" <thomas.jarosch@intra2net.com>
X-From: git-owner@vger.kernel.org Fri Dec 19 14:09:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDf6u-0008MI-Io
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 14:09:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752882AbYLSNI0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 08:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752853AbYLSNI0
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 08:08:26 -0500
Received: from rn-out-0910.google.com ([64.233.170.185]:59091 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752780AbYLSNIZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2008 08:08:25 -0500
Received: by rn-out-0910.google.com with SMTP id k40so711709rnd.17
        for <git@vger.kernel.org>; Fri, 19 Dec 2008 05:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=yYHu9K4peVJo/86VHHTtxXeqR9nTVAeBOilHI2Mxlyk=;
        b=Tpd1kvvUhoAyLe7l8QxyVAovGjuqQU2tgOMYXddyxaTvrhcwJ+UN5QgBNpFKoH915g
         9IRsr2LCna3hB/0sSracOT7TZaord4+r1fotNWCBTkErOc+gJO6PNmlEWFDCKbS5LbNg
         lcXYAAhCrrlUUCam6mFdcuMLZ1gIiwqXLWLGg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=CVjSdwL5HtOBNVnDCmPXvr+V/O3JWhboAYi94/WRm0b4zYd3TixkkwWu7BSJ3Eurvw
         TUSs0PMdFqIhfgfLM4mFmk+YFbadQvEoynpsnkt2ATulIGhLlAYGxzHANYHeaR31eQk5
         teX8sbIDsdEF7Q3/Upw8vqB1v+JG2lQqS/DO4=
Received: by 10.151.43.13 with SMTP id v13mr1528662ybj.46.1229692103874;
        Fri, 19 Dec 2008 05:08:23 -0800 (PST)
Received: by 10.151.125.1 with HTTP; Fri, 19 Dec 2008 05:08:23 -0800 (PST)
In-Reply-To: <200812191044.47830.thomas.jarosch@intra2net.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103562>

thanks, Thomas. I could definitely pull from your tree.  seems like
the path of least resistance to get my repo split.

Cheers,
Whit


On Fri, Dec 19, 2008 at 4:44 AM, Thomas Jarosch
<thomas.jarosch@intra2net.com> wrote:
> On Thursday, 18. December 2008 20:51:38 Whit Armstrong wrote:
>> Sorry, seem to be getting this error:
>> `/home/whit/dvl/risk.metrics.utils/RiskMetrics/.git-rewrite/t/../index.new'
>>: No such file or directory
>>
>> do I need to set up the index file first?
>
> Hmm, I guess you have an empty commit in your repository like I did.
> This is currently a corner case in update-index, which does not create empty
> index files. I posted a patch a few days ago and Junio posted an updated
> version of that. I could send you my version for git 1.6.0.5 if you need it.
>
>> Is there a good site that documents this procedure?
>
> A good start is the git-filter-branch man page and the mailinglist archive.
>
> Thomas
>
>
