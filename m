From: Francesco Pretto <ceztkoml@gmail.com>
Subject: Re: [PATCH] Documentation: enhanced "git for CVS users" doc about
 shared repositories
Date: Wed, 07 Nov 2007 01:46:07 +0100
Message-ID: <47310ACF.4030103@gmail.com>
References: <472F99F8.4010904@gmail.com>	<7v8x5cmern.fsf@gitster.siamese.dyndns.org>	<4730E056.7080809@gmail.com> <7vd4unez2l.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 07 01:46:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpZ3r-0008Ty-VY
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 01:46:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754910AbXKGAqN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 19:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753956AbXKGAqN
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 19:46:13 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:32268 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754712AbXKGAqM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 19:46:12 -0500
Received: by ug-out-1314.google.com with SMTP id z38so49440ugc
        for <git@vger.kernel.org>; Tue, 06 Nov 2007 16:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=VaLxZyK9kkB7hIvCQJrPvS8RWWrFrJ01NS0oDJTxtzs=;
        b=amV8sShREbKJltFPB2iSuPIAIQgob93G0FngiG243PrqWW+sT+UIVc15pLxiIwIPlkEP4FK0VZrp+UzPByrPc8ObXvX+TkmZkbcP2iSJwaVDSjqMWlSB4C4ZkoU94ZbQoBFNcRqLFr6g0GkApJQ5VfmWgyfEc+Rm12UKO8Z1Etc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=dvVRV8VwMebpo7/afILYo7GsD8QKnLHxdaGMz2vvvdY3M55GjZtCBnP2HnEFE7sw/jq6EwcO4AouM8zDBvqmtYx2BPm1h2EiWzyJ8WJefnA0QFDrHFc6CNrM86nElHuccBNdiv5BzKnNS6dhtXfUY2C6bsdZdLVCJECKJLUh3js=
Received: by 10.66.252.18 with SMTP id z18mr112885ugh.1194396371064;
        Tue, 06 Nov 2007 16:46:11 -0800 (PST)
Received: from ?192.168.1.14? ( [87.0.185.143])
        by mx.google.com with ESMTPS id l22sm186146uga.2007.11.06.16.46.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 06 Nov 2007 16:46:10 -0800 (PST)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <7vd4unez2l.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63760>

Junio C Hamano ha scritto:
> 
> Honestly speaking, I am not too thrilled about making the
> cvs-migration document much longer than what it currently is.
> 

Honestly speaking, you've spent too much time in looking for every possible
objections against these simple additions. At least it should be less than the
time I've spent in measuring every single word of this patch, hoping you could
consider them for inclusion. You gave me lot of attentions (I am grateful of this,
really) so I should probably be surprised of the cleanliness of git code, of the
rigor of the code style, of the clarity of the documentation. But unfortunately,
I am not. I simply tried to make this document more useful and helpful for a
wider audience of people that could ever consider of using git in their life.
And yes, I decided to so because I had trouble myself during initial configurations.
What's the problem if a document called "git for CVS users" is more explicated?
What's the problem if it contains as many as possible informations to set up
git in a viable way and, hopefully, to learn something on how it does work?

I'm sad. Not only because you refused a documentation patch, but because i could
have sent a "Bug: Documentation Sucks!" to the ml and i would have obtained the
same thing: nothing.

Francesco

P.S.:

>> +------------------------------------------------
>> +$ usermod -a -G $group $username
>> +------------------------------------------------
> 
> I tend to edit /etc/group with vi ;-) and I suspect these two
> commands are specific to the distro you happen to use.

You were right with usermod (groupadd is ok): that "-a" switch is redhat syntax.
Six years of Linux Standard Base and this is still an unsolved problem...
