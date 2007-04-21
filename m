From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Why SHA are 40 bytes? (aka looking for flames)
Date: Sat, 21 Apr 2007 19:06:52 +0200
Message-ID: <e5bfff550704211006t59cb49h179685d694a1d75a@mail.gmail.com>
References: <e5bfff550704210635r4008c3c6tf5f55f970bf85e44@mail.gmail.com>
	 <9e4733910704210837y3ac3654ekb60654ef6fc397fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Nicolas Pitre" <nico@cam.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 21 19:07:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfJ3L-0000QA-GC
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 19:07:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753258AbXDURGy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Apr 2007 13:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753528AbXDURGy
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 13:06:54 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:18240 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753258AbXDURGy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2007 13:06:54 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1166235wra
        for <git@vger.kernel.org>; Sat, 21 Apr 2007 10:06:53 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VUZSPhBWvz705YY/IcIQCRYUTO6zhTSSPSxq4P7jvChLcwInSKQ+LsbQ1s4Kts9j8hhuJGXy7EvHA1rDuT/mBMG2iHcDYQooWOCutJQCGc8P1/KbZfee5wydXote7OG0J899e0jjgGejNSCz5VOrZZ4aD0sG87gBGLeAbB7qvvA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=daEO7/K8O6yO8bn+Bb3FcyvIe/A59Ecep9m7nuvoG53f65ggr7r39Iye0KoslgS1ofocw3Zglnil/VHvYc+E2Hl2AGzlZvY/6bEfisGgpY+ENB335+8+FD1p5x46Jp84UcqqLyKF3XpPZDj2NAbN3isus8fA3DhAzY09AcrYf64=
Received: by 10.114.89.1 with SMTP id m1mr1757251wab.1177175212966;
        Sat, 21 Apr 2007 10:06:52 -0700 (PDT)
Received: by 10.114.61.6 with HTTP; Sat, 21 Apr 2007 10:06:52 -0700 (PDT)
In-Reply-To: <9e4733910704210837y3ac3654ekb60654ef6fc397fc@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45180>

On 4/21/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> On 4/21/07, Marco Costalba <mcostalba@gmail.com> wrote:
> > Well, why to store always the full length SHA?
>
> When Shawn gets done with full compression the SHAs would get stored
> in the packfile once  and then be replaced with a token generated from
> the compression algorithm. Compression tokens are designed to use the
> minimal number of bits depending on frequency of occurrence.
>

Currently in Lunux tree there are about 445.424 objects (git
count-objects -v), if each object has his 40 bytes name it is about
20MB to store sha *once*, probably with no real disambiguate need to
be that much.

Marco
