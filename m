From: Andreas Ericsson <ae@op5.se>
Subject: Re: Using doxygen (or something similar) to generate API docs [was
 [PATCH 4/4] Add a function string_list_longest_prefix()]
Date: Tue, 11 Sep 2012 03:01:25 +0200
Message-ID: <504E8D65.9030000@op5.se>
References: <1347169990-9279-1-git-send-email-mhagger@alum.mit.edu> <1347169990-9279-5-git-send-email-mhagger@alum.mit.edu> <7vbohfser4.fsf@alter.siamese.dyndns.org> <504DBA62.3080001@alum.mit.edu> <7v1ui9q21a.fsf@alter.siamese.dyndns.org> <20120910163310.GE9435@sigill.intra.peff.net> <504E27D7.8010505@op5.se> <504E3DA8.7040906@alum.mit.edu> <20120910215633.GB1537@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 11 03:01:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBErE-0001Rp-6n
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 03:01:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752264Ab2IKBBc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 21:01:32 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:36902 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208Ab2IKBBb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 21:01:31 -0400
Received: by lbbgj3 with SMTP id gj3so24770lbb.19
        for <git@vger.kernel.org>; Mon, 10 Sep 2012 18:01:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=U6oARwb1I52x24MK/iEJIk4XHcpBq70QkQ1rRmLBMZA=;
        b=G3dU2nPzThEWnAry63h+Sxy6ENpFbnbR9Vl3cWGcWo1Dovyjo1F9WGe1CzR6p7x+tW
         1kx8gAVdOsNcisWIwEtbS3x9ZiY+vt6anuFAnDC/JcDiNA/9tOVvAT55FhGZaIJPsitB
         pIIbMjV04xoWYL3HT1aOdCeHYjwakn+UmzirL+m+YhiRNdb673KBj7BSr+qGhf5CFgsD
         yXZO61vyAHtTA7x2JrPh4YU8mzef75pPCfyuVIa2faLt1fJ0re+qImQlGGJglBJIBk+h
         RQpZ0VG+z9RhnwxmPvTiHNEPQUg4p7en+7T8w1rMkOQcEUfe5r5Z3qozcTFyZ2eBN7TQ
         6DlA==
Received: by 10.112.41.161 with SMTP id g1mr5537092lbl.59.1347325289510;
        Mon, 10 Sep 2012 18:01:29 -0700 (PDT)
Received: from vix.int.op5.se (c80-217-218-226.bredband.comhem.se. [80.217.218.226])
        by mx.google.com with ESMTPS id ly17sm15517744lab.2.2012.09.10.18.01.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 10 Sep 2012 18:01:28 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120828 Thunderbird/15.0
In-Reply-To: <20120910215633.GB1537@sigill.intra.peff.net>
X-Gm-Message-State: ALoCoQlR3AAPcswZK6JpVtAFj8Bv2bpF3B3GY/rLtZa7P3vySMQNvY6KfuorCOZBH5vVMsQJmWh5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205207>

On 09/10/2012 11:56 PM, Jeff King wrote:
> On Mon, Sep 10, 2012 at 09:21:12PM +0200, Michael Haggerty wrote:
> 
>> I'm renaming this thread so that the bikeshedding can get over ASAP.
> 
> Thanks. :)
> 
>>>>     http://tomdoc.org/
>>>>
>>>> Looks much nicer to me than most doxygen I've seen. But again, it's been
>>>> a while, so maybe doxygen is nicer than I remember.
>>
>> I don't have a personal preference for what system is used.  I mentioned
>> doxygen only because it seems to be a well-known example.
>>
>>  From a glance at the URL you mentioned, it looks like TomDoc is only
>> applicable to Ruby code.
> 
> Yeah, sorry, I should have been more clear; tomdoc is not an option
> because it doesn't do C. But what I like about it is the more
> natural markup syntax. I was wondering if there were other similar
> solutions. Looks like "NaturalDocs" is one:
> 
>    http://www.naturaldocs.org/documenting.html
> 
> On the other hand, doxygen is well-known among open source folks, which
> counts for something.  And from what I've read, recent versions support
> Markdown, but I'm not sure of the details. So maybe it is a lot better
> than I remember.
> 

Markdown is supported, yes. There aren't really any details to it.
I don't particularly like markdown, but my colleagues tend to use
it for howto's and whatnot and it can be mixed with other doxygen
styles without problem.


>>> Doxygen has a the very nifty feature of being able to generate
>>> callgraphs though. We use it extensively at $dayjob, so if you need a
>>> hand building something sensible out of git's headers, I'd be happy
>>> to help.
> 
> It has been over a decade since I seriously used doxygen for anything,
> and then it was a medium-sized project. So take my opinion with a grain
> of salt. But I remember the callgraph feature being one of those things
> that _sounded_ really cool, but in practice was not all that useful.
> 

It's like all tools; Once you're used to it, it's immensely useful. I
tend to prefer using it to find either code in dire need of refactoring
(where the graph is too large), or engines and exit points. For those
purposes, it's pretty hard to beat a good callgraph.

>> My plate is full.  If you are able to work on this, it would be awesome.
>>   As far as I'm concerned, you are the new literate documentation czar :-)
> 
> Lucky me? :)
> 

I think he was talking to me, but since you seem to have volunteered... ;)

> I think I'll leave it for the moment, and next time I start to add some
> api-level documentation I'll take a look at doxygen-ating them and see
> how I like it. And I'd invite anyone else to do the same (in doxygen, or
> whatever system you like -- the best way to evaluate a tool like this is
> to see how your real work would look).
> 

That's one of the problems. People follow what's already there, and there
are no comments there now so there won't be any added in the future :-/

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
