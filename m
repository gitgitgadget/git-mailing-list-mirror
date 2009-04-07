From: demerphq <demerphq@gmail.com>
Subject: Re: non-ascii filenames issue
Date: Tue, 7 Apr 2009 10:26:14 +0200
Message-ID: <9b18b3110904070126i354fc100l69b6ce3c9cd19d49@mail.gmail.com>
References: <20090405093640.GA9803@home> <87ab6v2zor.fsf@iki.fi>
	 <20090405100127.GA12126@home>
	 <43d8ce650904050351p72590d52l8861b3901f95201a@mail.gmail.com>
	 <alpine.DEB.2.00.0904060823400.21376@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: John Tapsell <johnflux@gmail.com>, Git <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Tue Apr 07 10:28:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lr6fe-0007CF-Qs
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 10:28:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753504AbZDGI0V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 04:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751946AbZDGI0T
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 04:26:19 -0400
Received: from mail-gx0-f160.google.com ([209.85.217.160]:33180 "EHLO
	mail-gx0-f160.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752040AbZDGI0R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 04:26:17 -0400
Received: by gxk4 with SMTP id 4so5584694gxk.13
        for <git@vger.kernel.org>; Tue, 07 Apr 2009 01:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+7yV0oEc5sZtX6eHs/OZbXcZZkYiw8dCGFiQ795hkBc=;
        b=simmLesN35VRldjXj3aROPf+qMfBOgqFtx9PzTGMroL2s3rbuYTiNM92WDPrHc8OzQ
         K6IuycajKvSrf6DdXDRs01azGg8zWk4aD0bLXqoxKFkPnQGm8VwM2GhtyofuqZwWc2IB
         RF6Pj7TnfGsdU9wZ2y0Y2t2bSIRy7FLIHTfcU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=osLi10Kl/DAhVbxqcYgYIv6xcIWjAsTgsvr0ds1x6/Nbg9pS9vdb5lzPpO58FLJXHH
         b73zkTW2i2PNX/6zLw4cUwhHHENksaSefAQJTd0P7QQmQ9o86EVxL0/70wmP0Sb4tklf
         TEobWvc1HtsvCI7H4ut9T7zJGk237VIxW7SqE=
Received: by 10.231.16.70 with SMTP id n6mr1148538iba.0.1239092774610; Tue, 07 
	Apr 2009 01:26:14 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.0904060823400.21376@ds9.cixit.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115937>

2009/4/6 Peter Krefting <peter@softwolves.pp.se>:
> John Tapsell:
>
>> Unfortunately not, because for some absolutely crazy reason, there is no
>> way at all to tell what encoding the string is in.  It never occured to
>> anyone that it might actually be useful to be able to read the filename in
>> an unambiguous way.
>
> It comes from the Unix tradition, unfortunately, that file names are just a
> stream of bytes, instead of a stream of characters mapped to a byte
> sequence. The "stream of bytes" think worked back when everyone used ASCII,
> but as soon as other character encodings were used (i.e back in the 1970s or
> so), that assumption broke.

Those interested in this subject may find the following document on
the creation of utf8 interesting.

http://www.cl.cam.ac.uk/~mgk25/ucs/utf-8-history.txt

cheers,
Yves

-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
