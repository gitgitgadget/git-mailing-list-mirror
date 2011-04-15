From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Re: [PATCH/resend] Documentation: update to git-merge-base --octopus
Date: Fri, 15 Apr 2011 10:43:53 +0200
Message-ID: <4DA80549.5040600@lyx.org>
References: <4DA47A4D.80909@lyx.org> <20110412194558.GB1209@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 15 10:44:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAedE-0002L0-LH
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 10:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752671Ab1DOInx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2011 04:43:53 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:54327 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910Ab1DOInv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2011 04:43:51 -0400
Received: by ewy4 with SMTP id 4so685399ewy.19
        for <git@vger.kernel.org>; Fri, 15 Apr 2011 01:43:50 -0700 (PDT)
Received: by 10.14.11.129 with SMTP id 1mr557034eex.43.1302857030469;
        Fri, 15 Apr 2011 01:43:50 -0700 (PDT)
Received: from [192.168.1.2] (i229113.upc-i.chello.nl [62.195.229.113])
        by mx.google.com with ESMTPS id r48sm1771152eei.23.2011.04.15.01.43.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Apr 2011 01:43:49 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <20110412194558.GB1209@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171598>

>> +When the option `--octopus` is given, the result of `git merge-base A B C`
>> > +will be '2', because '2' is the common ancestor of all branches.
> 
> Wouldn't it be easier to read if you had the option in the command line, i.e.
> 
>     The result of `git merge-base --octopus A B C` is '2' because...
> 
> without "When ... given" that now become noisewords?

Yes, that's much better. I included it in the rerolled patch series.

> Adding an example use of --octopus to the DISCUSSION section makes a
> lot of sense.  At first I thought this was being added to the
> DESCRIPTION section, which led me to suggest something like the
> following:
> 
> [..]
> 
> What do you think?

I like it, so I made a patch out of it and sent it to the list.

> For what it's worth, except for Junio's wording nitpick and the log message,
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks,

Vincent
