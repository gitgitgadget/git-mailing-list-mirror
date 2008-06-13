From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: Re: [EGIT RFC] Commit behaviour
Date: Sat, 14 Jun 2008 00:07:59 +0200
Message-ID: <4852EFBF.6000406@gmail.com>
References: <1213313997-1520-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jun 14 00:09:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7HS9-0002GS-NF
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 00:09:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754650AbYFMWII (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 18:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754647AbYFMWIH
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 18:08:07 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:16412 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754562AbYFMWIF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 18:08:05 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2889416fgg.17
        for <git@vger.kernel.org>; Fri, 13 Jun 2008 15:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=BJK28vJREArqMsX5e+HSRes1YSdi15Js7PeLrLNUZRE=;
        b=gIXpnEk11n+XAOc4GjfxOCVwJ4F5nNyujh5K0ZCIwa3DKpqXIhvqU5hZPSi4xoEzXo
         7kKeEawm7H0UaCZzkvhfmcfgCkvbxvLyPMsHRuBiXlqJykM7N+XD6YmuNLgORQ1GLh5w
         fXaVXW5x+lKFZi3t9jY42ZxqzY4P6LSaZWlVs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=BIFXIvy0npZZoLjD58o6l05/B2FEUon5pQpcIWftZJVsz3oIshOznxN14BN51xg6ps
         1MKQ5a3lKGX7pS+Gt2nzglXcJMpu5VyvoZehSWMDIVPaWflUezhFjvMMBfXDqaco3C7X
         OowrSwBOJWgfib2TUolpt8Tcs6wBQJ+3kalSs=
Received: by 10.86.59.18 with SMTP id h18mr4698239fga.30.1213394881435;
        Fri, 13 Jun 2008 15:08:01 -0700 (PDT)
Received: from ?62.21.4.140? ( [62.21.4.140])
        by mx.google.com with ESMTPS id 4sm6013599fgg.9.2008.06.13.15.07.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 13 Jun 2008 15:08:00 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.13) Gecko/20080313 Iceape/1.1.9 (Debian-1.1.9-3)
In-Reply-To: <1213313997-1520-1-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84945>

Robin Rosenberg wrote:
> I got annoyed about having change my selection to a project to be able
> to commit. This tentative feature allows me to hit the commit button
> when any resource is selected and figure out which resources have been
> modified. This makes it much easier to commit. Only the toolbar commit
> is affected for now.

That's a nice idea! I also thought about that one day, as such feature 
already exists in (e.g.) Subclipse that I was used to.

> 
> Another twist would be to list all changed resources, but only enable
> the selected ones, or only the ones in in the same projects as the selected
> resources. Comments?

I think that only selected && changed ones should be listed. When user 
selects explicitly some resources, he/she is probably interested only in 
these ones. And he/she probably did it for easier selection than from 
list of all changed resources, isn't it?

> Code is not efficient either. This is question about the user interface.

Theses patches don't work for me however :/ When I introduce some change 
to a resource/file, even add it to index and click commit (toolbar or 
menu), commit action does nothing. It is - nothing happens. Can you 
reproduce this problem, or should I debug it on my instance? Or do I use 
it in some wrong way?


> Then we could ask ourselved, should we do something similar for Checkout
> and reset too? I think that is not as important as those operations are
> much less frequent.
> 
> -- robin

Well, I think that checkout (maybe reset too) would be useful too - to 
revert some file quickly.

-- 
Marek Zawirski [zawir]
marek.zawirski@gmail.com
