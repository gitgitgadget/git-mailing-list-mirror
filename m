From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH v2] Custom compression levels for objects and packs
Date: Tue, 8 May 2007 23:24:05 -0700
Message-ID: <56b7f5510705082324q4e054b75l7021dc08ec31392@mail.gmail.com>
References: <4640FBDE.1000609@gmail.com>
	 <7vk5vi27ko.fsf@assigned-by-dhcp.cox.net>
	 <56b7f5510705081725v655d2ce1j28712507cfa7fa55@mail.gmail.com>
	 <7vr6pqy1ty.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>, danahow@gmail.com,
	"Nicolas Pitre" <nico@cam.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 09 08:24:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hlfb1-0005I8-Ib
	for gcvg-git@gmane.org; Wed, 09 May 2007 08:24:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966005AbXEIGYL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 02:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934820AbXEIGYL
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 02:24:11 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:49659 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934790AbXEIGYK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 02:24:10 -0400
Received: by wr-out-0506.google.com with SMTP id 76so101665wra
        for <git@vger.kernel.org>; Tue, 08 May 2007 23:24:09 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l13Sk68SHYBVqNGzQxawgGjATVFt5Ogvl+veGjCgpvVHuzbeHCK9+aiG6lxfpD+JLjalkFqjwfYuQG2+1SeWH14dvmiFpWxBCM+J5HCyGNse7+dGfeRuWYYhdjL6i7VPp9zgCv852P7gHLtCr96vhOCJTyP5m1SC84ZpEIMEXu0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sdJevbwXou7syRX/iZL82JVJhu5p+Y4tHbgI8W1ht4O2XcgwKC05vLNvOmtSNVmgZJsz/u4YccQyZ0UsQWhQWu5NlRnk6zh9HHZRuLP13NrJoYg8oZw2MjUjTTdEQOm+oRDd5ZIUYv/smZRXWHR/IOq6HLzxcET6jXMfsZhCitM=
Received: by 10.114.153.18 with SMTP id a18mr55726wae.1178691845923;
        Tue, 08 May 2007 23:24:05 -0700 (PDT)
Received: by 10.115.58.7 with HTTP; Tue, 8 May 2007 23:24:05 -0700 (PDT)
In-Reply-To: <7vr6pqy1ty.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46666>

On 5/8/07, Junio C Hamano <junkio@cox.net> wrote:
> "Dana How" <danahow@gmail.com> writes:
> > On 5/8/07, Junio C Hamano <junkio@cox.net> wrote:
> >> Dana How <danahow@gmail.com> writes:
> >> > This applies on top of the git-repack --max-pack-size patchset.
> >> Hmph, that makes the --max-pack-size patchset take this more
> >> trivial and straightforward improvements hostage.  In general,
> >> I'd prefer more elaborate ones based on less questionable
> >> series.
> > The max-pack-size and pack.compression patches touch the same lines.
> > I thought my options were:
> > * Submit independently and make you merge; or
> > * Make one precede the other.
> > Since max-pack-size has been out there since April 4 and
> > the first acceptable version was May 1 (suggested by 0 comments),
> > I didn't realize it was a "questionable series".
> No, what I meant was that it is much "more elaborate" series
> than this custom compression which is much "less questionable".
>
> I think this custom compression is 1.5.2 material.  I have not
> studied the code for the max-pack-size enough to be confident to
> put it in 1.5.2, at least not yet, and was planning to park the
> latter in 'next' until 1.5.2 final.
OK, thanks for guesstimating the overall schedule.  I was starting to wonder
what the next step(s) should be.

I will incorporate your & Nicolas's comments and send out a new custom
compression patch tomorrow.  I *think* I addressed everyone's comments
on max-pack-size, but let me know if you find anything else when you get
around to it.

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
