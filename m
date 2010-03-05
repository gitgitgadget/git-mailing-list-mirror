From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: gitignore broken in git 1.7.0.1: slash checks leading dirs
Date: Fri, 5 Mar 2010 09:15:53 -0600
Message-ID: <20100305151553.GB24748@progeny.tock>
References: <4B90C701.3070308@gmail.com>
 <4B90C974.2050405@viscovery.net>
 <20100305151248.GA24748@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jiri Slaby <jirislaby@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Mar 05 16:15:49 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnZFj-0000Wa-O2
	for gcvg-git-2@lo.gmane.org; Fri, 05 Mar 2010 16:15:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753426Ab0CEPPm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Mar 2010 10:15:42 -0500
Received: from mail-pz0-f194.google.com ([209.85.222.194]:46352 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753056Ab0CEPPl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Mar 2010 10:15:41 -0500
Received: by pzk32 with SMTP id 32so1410444pzk.4
        for <git@vger.kernel.org>; Fri, 05 Mar 2010 07:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=e1BqSbFVhxToFNQg1OQppAdnh7gVfgQN3dQj5Ag/zQ0=;
        b=dBdYsilM402qAjG8wKyq+vpNHzXfL3tOhP+UYz+OMnvtXKswdBc8wJZeh8nFwoSYOh
         oOKRTVZ7MN/qAulx/3+V820z3EbDbjzlUGI1UlZwlh+5SsdoCus2F/g93+u20LrLap2T
         VDXFBtabQ5EgjSBf5Y9KODxtGZb5Nvwu0pvYk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=LLw1yojn+AgNfdrqs6EcgjGpaZy15EHEBgvw/JBNA5b1uhwucqncRHoQGKvun6yuNz
         hPSuZAUxLPfhN+F38Ud3rsxMmlQ7FHXHqFPdld9cHXKSLYraCnb0snr8TIVzcmM7XliY
         EwXq3+1gSyTskzI0gavI3/GZN7lWDPEvAdLoU=
Received: by 10.142.208.21 with SMTP id f21mr688168wfg.311.1267802141007;
        Fri, 05 Mar 2010 07:15:41 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm1518273iwn.0.2010.03.05.07.15.40
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 05 Mar 2010 07:15:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100305151248.GA24748@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141582>

Jonathan Nieder wrote:
> Johannes Sixt wrote:
>> Jiri Slaby schrieb:
>
>>> having 'linux' line in .gitignore makes 'include/linux/vga_switcheroo.h'
>>> to be ignored
[...]
>> and this citation confirms my expectation. Note that it says "pathname",
>> not "filename". 'include/linux' is a "pathname".
>
> It would be more precise to say this citation does not have much to do
> with it.  'include/linux' contains a slash, so that paragraph does not
> describe what it means.

Curse my quick reading.  Sorry for the nonsense, please ignore.

My suggested patch still might make sense, though. :)

Jonathan
