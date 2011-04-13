From: Joshua Juran <jjuran@gmail.com>
Subject: Re: Gitbox
Date: Wed, 13 Apr 2011 13:29:42 -0700
Message-ID: <991C9EA2-48A4-4D10-B859-F5A01E565109@gmail.com>
References: <A2315DA1-780C-4024-B774-9AD5F9AA0DB6@medialab.com> <1302721187.21900.4.camel@drew-northup.unet.maine.edu> <1E5D7DCE-B3B3-4CC7-8F40-4ED48E76907D@gmail.com> <1302722214.22161.5.camel@drew-northup.unet.maine.edu> <86vcyigcqy.fsf@red.stonehenge.com> <1302725089.22408.11.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Daniel Searles <dsearles@medialab.com>, git@vger.kernel.org,
	oleganza@gmail.com
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Wed Apr 13 22:29:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QA6hD-0007kO-ND
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 22:29:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758515Ab1DMU3r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2011 16:29:47 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44642 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757492Ab1DMU3q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2011 16:29:46 -0400
Received: by iwn34 with SMTP id 34so866619iwn.19
        for <git@vger.kernel.org>; Wed, 13 Apr 2011 13:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        bh=arvdY+kBfsGBbpzYk0ieFb9cw858hG4q7PSUlTPNcY4=;
        b=R+C0ZOgUMFm5MEUCkB92CYQHSNbFj8Cc5JjJowceEZL8F9eki2EVuh3waHlUeh2mPa
         qqggwLh+yTcOUSYOEteOx1RDVfDg9WP5jEdOJpQimhoVoSnGe+D8NAjt/5msIRR3WJbi
         rb3i3CL9NVhaSAXDb6UYeyiTa6rfSBWpp1Z4w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=nMhNmCbyBv5aoyHixfngd7k3Es4ENZ9ddiddMfn69YHEbpyhp0VLgdX4F5eMqFsHGy
         M1Qe47HYcYLdQCdXzBMjuIIcONqoNMPf84bezI6pPNO8FmwTjCf8/Oa+Zeq08WQ/A+SU
         l9s7Kw2i6EjCNeCCud3/48jDQ/LllSTEqEcSc=
Received: by 10.231.185.196 with SMTP id cp4mr8571895ibb.56.1302726586083;
        Wed, 13 Apr 2011 13:29:46 -0700 (PDT)
Received: from zaphod.jjuran.dyndns.org (c-71-227-175-60.hsd1.wa.comcast.net [71.227.175.60])
        by mx.google.com with ESMTPS id i3sm654629iby.6.2011.04.13.13.29.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Apr 2011 13:29:45 -0700 (PDT)
In-Reply-To: <1302725089.22408.11.camel@drew-northup.unet.maine.edu>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171485>

On Apr 13, 2011, at 1:04 PM, Drew Northup wrote:

> On Wed, 2011-04-13 at 12:41 -0700, Randal L. Schwartz wrote:
>>>>>>> "Drew" == Drew Northup <drew.northup@maine.edu> writes:
>>
>> Drew> He also clearly stated that he's not calling git command-line  
>> tools...
>>
>> Drew> "Gitbox neither links (statically or dynamically) against Git  
>> nor uses
>> Drew> custom interfaces to interact with it. Git binaries are  
>> provided for
>> Drew> your convenience only."
>>
>> Huh?  How do you get "not using git CLI" there?  He's not using  
>> *custom*
>> interfaces, but the *standard* interfaces are more than enough.
>>
>> He's made new porcelein, and using the plumbing directly.  That's
>> exactly why we have plumbing in git, right?
>
> If that's what he's doing then why does he state that the git binaries
> are "for your convenience only"

I suspect he considers it convenient to download the app and use it  
immediately without having to install Git manually, but wants to  
clarify that GitBox works with later versions as well.  In other  
words, Git 1.7.3.2 is provided for *convenience*, not due to  
compatibility restrictions.

> --strongly implying his program will work
> in the absence thereof?

Strongly implying?  I read the exact opposite -- GitBox clearly  
depends on an external git binary.

> I'm hoping he just made a typo--as what he said
> is there in plain English, and is somewhat contradicted by the next
> sentence.

It's ambiguous.  The next sentence clarifies it, ruling out one  
interpretation and therefore confirming the other.  In regular  
expressions this is called backtracking.

> If you wish to dispute my interpretation of his grammar
> please contact me directly and don't bother the rest of the list.

I decline your request; I think it's better to have a public record of  
the issue being settled, if for no other reason than that others don't  
waste time making points that I've already made.

Josh
