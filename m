From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Thu, 11 Sep 2008 20:30:40 -0400
Message-ID: <48C9B830.2060903@gmail.com>
References: <20080909132212.GA25476@cuci.nl> <alpine.LFD.1.10.0809111527030.23787@xanadu.home> <20080911194447.GD1451@cuci.nl> <200809112205.16928.jnareb@gmail.com> <20080911202228.GG1451@cuci.nl>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, Nicolas Pitre <nico@cam.org>,
	Theodore Tso <tytso@mit.edu>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Fri Sep 12 02:32:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kdwaf-0003Qx-Ut
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 02:32:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752987AbYILAap (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 20:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751893AbYILAap
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 20:30:45 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:41450 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848AbYILAap (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 20:30:45 -0400
Received: by gxk9 with SMTP id 9so17953852gxk.13
        for <git@vger.kernel.org>; Thu, 11 Sep 2008 17:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=MDKcnMPD5i+RdjWPh/3BnGG5gPKKmYA8xq+tKK6X2OQ=;
        b=qajEbSOT6MhBwd4JRgX/bfpjZw/G0JdIw/VPUuLLWwb29D54nPhKvam4TVQHZD8aaE
         I67tmExNBFKpmT/HYYrzSkbF9BgS5Ni1pFZd3JGvDqFqEnisRgTcOGo5wsAQ7bDxOvna
         PU/4YLxO1QgvDH37LSNpqU0TUAf6uWgYy64w4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=hExZ5tMm8xRcfkht19APCr3Dwy6/n+ixC+qq9G28t4hl8ALpNpckHj8QU9ruJytXZy
         IONvqWKDyrNeLKQ0csZDJn5irjvADbocS+D5/7INNm3SCG1g3cthldNkEi6B/+3IeOMc
         LFpDvOIzLvrIH1JSldhmNOnirC3k9MCNU/2fs=
Received: by 10.90.86.10 with SMTP id j10mr4134079agb.22.1221179443327;
        Thu, 11 Sep 2008 17:30:43 -0700 (PDT)
Received: from ?10.0.0.6? ( [66.177.19.100])
        by mx.google.com with ESMTPS id 15sm12096407wrl.3.2008.09.11.17.30.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Sep 2008 17:30:42 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <20080911202228.GG1451@cuci.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95676>

Stephen R. van den Berg wrote:
> Jakub Narebski wrote:
>> Stephen R. van den Berg wrote:
>>> Well, the principle of least surprise dictates that they should be kept
>>> by gc as described above, however...
>>> I can envision an option to gc say "--drop-weak-links" which does
>>> exactly what you describe.
> 
>> Well, IIRC the need for this was one of the causes of "death" of 'prior'
>> header link proposal...
> 
> As I understood it, one of the causes of death of the "prior" link
> proposal was that it was unclear if it pulled in the linked-to commits
> upon fetch.  In the "origin" case, the default is *not* to fetch them.

And that's WRONG. Both prior and origin must fetch them if they're 
reference in the header.
