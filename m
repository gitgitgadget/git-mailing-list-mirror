From: Michael G Schwern <schwern@pobox.com>
Subject: Re: OT: mail-based interfaces and web-based interfaces (Re: Extract
 Git classes from git-svn (1/10))
Date: Tue, 24 Jul 2012 23:20:12 -0700
Message-ID: <500F901C.4060508@pobox.com>
References: <5004B772.3090806@pobox.com> <20120717174446.GA14244@burratino>
 <5005F139.8050205@pobox.com> <20120717233125.GF25325@burratino>
 <7vy5mhwrdl.fsf@alter.siamese.dyndns.org> <500F23E4.9090306@pobox.com>
 <20120725025507.GB13236@dcvr.yhbt.net> <500F860E.5010909@pobox.com>
 <20120725055422.GB4503@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	robbat2@gentoo.org, Ben Walton <bwalton@artsci.utoronto.ca>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 08:20:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StuxL-0002Ap-7j
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 08:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932768Ab2GYGUQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 02:20:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36455 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932750Ab2GYGUO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 02:20:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DFDE5141;
	Wed, 25 Jul 2012 02:20:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=sasl; bh=GmUFDcR4kF69
	Ry7EH7R6MjHWrUo=; b=HWb7PA2ZCocNcZJiIvm2ovJ06l6At8EP18trOWs5TrkZ
	uOClQAu9CPg68Hwt6tLuAy8s7hO9sHBfsAoeG7R7BpIBdgaqPNVzP9+DQUDQxTvd
	dRDEHLn7wLUMvV0M7fvz6CzQ01rnNwkwehOP/B/Na+uQ0yijXk79emguMsp6/5s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=LzzY3n
	aGGFhMnCifPuqlWWJ0by5t4UK+DmoBwKeyiNoqpfqeaulB20FpQUCdGBKJDZLnmB
	hXaKz9/s14DwAr8pcHfn+nRVPyeww7hQu4DXIUsl4wWzbS6oJPjIc1CFL3Ym3gs1
	7JlEh3LkcgcjzpXUWk1OJlBe0GSB3QRMVmbT0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A4795140;
	Wed, 25 Jul 2012 02:20:14 -0400 (EDT)
Received: from windhund.local (unknown [71.236.173.173]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 269E6513F; Wed, 25 Jul
 2012 02:20:13 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:14.0)
 Gecko/20120713 Thunderbird/14.0
In-Reply-To: <20120725055422.GB4503@burratino>
X-Enigmail-Version: 1.4.3
X-Pobox-Relay-ID: CB5C3C62-D620-11E1-A168-01B42E706CDE-02258300!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202130>

On 2012.7.24 10:54 PM, Jonathan Nieder wrote:
>> And again, it *does not have to be zero sum*.  It doesn't have to be email VS
>> GUI.  You can have your cake and eat it too.
> 
> I assume you're talking about web-based interfaces that have gateways
> to email, that produce inboxes like this:
> 
>  24 Jul 02:46	GitHub	[github] msysgit/msysgit was forked by peters
>  23 Jul 10:27	GitHub	[msysgit/git] ce8ebc: vcs-svn: rename check_o
>  23 Jul 10:01	GitHub	[github] Comment created on issue 44 (new git
>  23 Jul 09:50	GitHub	[github] Comment created on issue 44 (new git
>  23 Jul 09:33	GitHub	[github] Comment created on issue 44 (new git
>  23 Jul 09:39	GitHub	[github] Comment created on issue 24 (Long fi
>  23 Jul 09:31	GitHub	[github] Comment created on issue 44 (new git
>  23 Jul 09:30	GitHub	[github] Comment created on issue 24 (Long fi
>  22 Jul 23:57	GitHub	[github] Comment created on issue 44 (new git
> 
> I call that pretending to have my cake, rather than having it. :)

That's kind of like pointing at RCS and saying "version control sucks and its
pointless to try and make it better!"  Mail gateways built by web sites suck
because they live in the web browser and email is an after thought.  Sound
familiar?

Here is a much better example of the RT mail gateway that Perl 5 development
uses.  They're a dev community still centered around email, so it has to
integrate well.
http://www.nntp.perl.org/group/perl.perl5.porters/2012/07/msg189716.html

And the corresponding ticket in the tracker.
https://rt.perl.org/rt3/Public/Bug/Display.html?id=113684

The initial report comes in either via the web tracker or via a command line
program (perlbug) that sends an email to the list.  Replies on either the
tracker or the mailing list are mirrored.  Duplicates are detected etc...
That's the sort of mail gateways I'm used to.


> Maybe some day someone will prove me wrong and make a nice web-based
> tool that I don't even need to know about that mines project mailing
> lists.  If I have to tweak my subject lines a little to help it out,
> that's fine with me.  I think patchwork is supposed to work this way.
> 
> But unless we're talking about splitting the mailing list into a bunch
> of mini mailing lists (like some bug trackers do), it doesn't change
> anything fundamental, so I'm not sure why we're discussing this.

I don't follow the bit about splitting the mailing list.


-- 
emacs -- THAT'S NO EDITOR... IT'S AN OPERATING SYSTEM!
