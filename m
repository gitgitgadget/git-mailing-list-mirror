From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Patchbombing or not, that is the question
Date: Sat, 27 Nov 2010 11:27:57 -0600
Message-ID: <20101127172757.GA1858@burratino>
References: <AANLkTi=C4opog2SfU9R_=dSOGY_5+0WYtFL8BNqcOwUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 27 18:28:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMOZH-00078x-I0
	for gcvg-git-2@lo.gmane.org; Sat, 27 Nov 2010 18:28:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752999Ab0K0R2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Nov 2010 12:28:07 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:41488 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752971Ab0K0R2E (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Nov 2010 12:28:04 -0500
Received: by gwj20 with SMTP id 20so1380282gwj.19
        for <git@vger.kernel.org>; Sat, 27 Nov 2010 09:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=KvyCRIuNoU2LW/Z3BJBFNZltrItdfK3fFORgpyKGte8=;
        b=KjYEwjFloFOQdXV7uXKinr5kzFNfqcoA4qsIurw0dhcWj7Eyib2CSlFJ4agNPSzF9Z
         i5bPjtKsjP/TIXJLYpeas5Ya3QG8WW9hF2VHSuSXQZUt5JmLeD+mUld7tFZTwWuMkWmZ
         nbOS34aSz+8cvPceO4ZgX3WghgE9KnFqRcvy4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=qNKv2BOV3ogHa0A/yWvsKqW4+fqqe+C0flNLE/BuFo1MxGn8smoWr+p16KqwjV47b+
         fpY1mOcfJKrg1agtQuEGZyfoAvzQmU17vZ1kYvvjStKEKLvzLEnWXtfnjS0SNmpEsQWK
         Axc28AoR1yf7zGCeBQpJRnDrp/Ty6TEOhese8=
Received: by 10.150.211.6 with SMTP id j6mr7308374ybg.137.1290878883231;
        Sat, 27 Nov 2010 09:28:03 -0800 (PST)
Received: from burratino (adsl-68-255-101-216.dsl.chcgil.ameritech.net [68.255.101.216])
        by mx.google.com with ESMTPS id t9sm2111804ybe.21.2010.11.27.09.28.01
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 27 Nov 2010 09:28:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=C4opog2SfU9R_=dSOGY_5+0WYtFL8BNqcOwUw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162316>

Giuseppe Bilotta wrote:

> I prepared a bunch of patches to add support to some other browsers to
> git-web--browse (opera, seamonkey, elinks). Currently I did one patch
> per browser. Should I squash them all together?

Yeah, I'd squash them.  (But I think either way would be fine.)

Could you support

	[browser "chromium-browser"]
		cmd=chromium-browser

while at it? :)
