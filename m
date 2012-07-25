From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] The Makefile.PL will now find .pm files itself.
Date: Wed, 25 Jul 2012 16:56:17 -0500
Message-ID: <20120725215617.GI4732@burratino>
References: <1343186471-1024-1-git-send-email-schwern@pobox.com>
 <1343186471-1024-4-git-send-email-schwern@pobox.com>
 <20120725211143.GA5455@burratino>
 <501069E9.2000009@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca, normalperson@yhbt.net
To: Michael G Schwern <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 23:56:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Su9ZE-0005Fu-OT
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 23:56:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909Ab2GYV4X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 17:56:23 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:39269 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751062Ab2GYV4W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 17:56:22 -0400
Received: by gglu4 with SMTP id u4so1274380ggl.19
        for <git@vger.kernel.org>; Wed, 25 Jul 2012 14:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=5rGJfC456JAHhA2ecqgOkezcYx/gCYEQepHmHHgucV4=;
        b=WaGdFopzYsIDTusGE+9IgMgudEffNrssjSXcf6onxlykx+45aD71S9AAVllGww1vC4
         upTEo7Ait3hCMHnOlaBpq7sU70QFjR9SkctIpBUn4LJ+NdylhscHkuQm1LGj3IgPLqaT
         ymtlPqbO0nL/86CJoRZZMYHz2TWd8wOG84AwF6mtpoaeEJ6+28BI2/9reVoyzzjJBFMm
         XaGB9sJhYjjgs1wLV5ESCQykVUkrlBJuCcz9gGj7kOmv1bx8LAVrp9dyOv2Scj+g5/vS
         WbcG2B6+CjKwP9ekuXuOwPXjsLufxSrmctauKdYBixj/2Hm+vouDtxuwtrsqER4mJB+n
         fZIg==
Received: by 10.236.200.167 with SMTP id z27mr25554548yhn.131.1343253382433;
        Wed, 25 Jul 2012 14:56:22 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id e19sm19786910ann.10.2012.07.25.14.56.20
        (version=SSLv3 cipher=OTHER);
        Wed, 25 Jul 2012 14:56:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <501069E9.2000009@pobox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202205>

Michael G Schwern wrote:
> On 2012.7.25 2:11 PM, Jonathan Nieder wrote:

>> Who are these comments in perl/Makefile.PL addressed to?
>
> Somebody adding, renaming or deleting a .pm file.
>
>> Why would such a person be looking at perl/Makefile.PL?
>
> Because sometimes they do wacky things

Not convincing at all. ;-)

But my made-up justification about people making other changes to
perl/Makefile.PL convinced me, so keeping the comments seems fine to
me now.

[...]
>                             For my purposes, I just preserved the comment.

That's what I feared and how cruft collects.  Sorry for the lack of
clarity.

Thanks,
Jonathan
