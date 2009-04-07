From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Tue, 7 Apr 2009 12:11:15 +0200
Message-ID: <46a038f90904070311n6606e678y43f716cbc05a397f@mail.gmail.com>
References: <20090404220743.GA869@curie-int> <20090405000536.GA12927@vidovic>
	 <20090405T001239Z@curie.orbis-terrarum.net>
	 <20090405035453.GB12927@vidovic> <20090405070412.GB869@curie-int>
	 <20090405190213.GA12929@vidovic>
	 <alpine.DEB.1.10.0904051419490.6245@asgard.lang.hm>
	 <20090405225954.GA18730@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: david@lang.hm, "Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
X-From: git-owner@vger.kernel.org Tue Apr 07 12:13:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lr8Ig-0003m1-U2
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 12:13:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752379AbZDGKLT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 06:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751802AbZDGKLT
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 06:11:19 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:46686 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977AbZDGKLS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 06:11:18 -0400
Received: by bwz17 with SMTP id 17so2233143bwz.37
        for <git@vger.kernel.org>; Tue, 07 Apr 2009 03:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pUOOveud4mAboFKNE0H98RNKbM8OCiQHjBNSkzaHZM0=;
        b=FhbqBJIbX3u8y1ZfWL2KcDnSzmw1hEaUWVzlIDh5YR8hFRpHSzhp5mSCQEKW1qI8Rq
         dO+GMLOs8/Vwn5Snk1u0ldmfQ3IlPapH6TbDmrvw1VgTnZOn6fiVDl9X6NJArTfzEpdF
         OoYNHNFgrTih13KL4Pct0Cjv6xusk2Rpv7hwg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cmq2AS5vrU77uzM6Eeh+GPJ702EJQhF1del/nNY1uFdy0v/VHofL1N6rdt5j9JsJVi
         j6BXkeQIt8LAeGAeONUwnYuKex75FzSpM/2220lDax1UNH5VLRWdUktFUHqTiMdYirrz
         C2uwcvZRQQUhMCCzRy9+TjYsmYLM23CM5alMs=
Received: by 10.223.103.194 with SMTP id l2mr4174599fao.55.1239099075313; Tue, 
	07 Apr 2009 03:11:15 -0700 (PDT)
In-Reply-To: <20090405225954.GA18730@vidovic>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115943>

On Mon, Apr 6, 2009 at 12:59 AM, Nicolas Sebrecht
<nicolas.s-dev@laposte.net> wrote:
> What about the rsync solution given in this thread?

Also, HTTP is excellent for initial clones, possibly better than rsync
in some cases.

The Gentoo team has good reasons to do things their way, and it's IMHO
a wart in git that initial clones of large repos. But we do have valid
workarounds (as above) so they can use them .

cheers,



martin
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
