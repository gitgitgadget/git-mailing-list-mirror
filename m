From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Fwd: vcs-svn and friends
Date: Wed, 21 Sep 2011 18:40:08 -0500
Message-ID: <20110921234008.GA23439@elie>
References: <CAFfmPPOBZ6cXG51mDHbj2VRDzjvH46Q7=_LvUWeMq0SGR40S1g@mail.gmail.com>
 <20110915100106.GB2328@elie>
 <CA+gfSn9KVN2iDCevd0s+TjYHNupDez8NiKZycP3pgBCkYiraFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Michael Barr <davidbarr@google.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 22 01:40:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6WOu-0001hb-Lj
	for gcvg-git-2@lo.gmane.org; Thu, 22 Sep 2011 01:40:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218Ab1IUXkQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Sep 2011 19:40:16 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:46823 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172Ab1IUXkO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2011 19:40:14 -0400
Received: by iaqq3 with SMTP id q3so2186243iaq.19
        for <git@vger.kernel.org>; Wed, 21 Sep 2011 16:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ZHk5XHVdaha8gv9OXqWgfXvEID7h9jy4ov1gjm1AQU4=;
        b=tXPIV44awSXGtQ8DE87ByX7vmonSjqFJWEJncM5GPcu7qnzwD/pFwrM1vRQxQep1/U
         8TyMM5x/c0UguDWRo0bLwTKFunh+TmRDWDbX5Eh7fDRYs63zLA1aIGXc4gWAzYAeFXl+
         OUTybyioQAMPtHCZS/hsHMmReTeMN3ovKCzQI=
Received: by 10.231.4.131 with SMTP id 3mr2582559ibr.30.1316648414294;
        Wed, 21 Sep 2011 16:40:14 -0700 (PDT)
Received: from elie (c-67-173-1-13.hsd1.il.comcast.net. [67.173.1.13])
        by mx.google.com with ESMTPS id j2sm8639857ibx.11.2011.09.21.16.40.13
        (version=SSLv3 cipher=OTHER);
        Wed, 21 Sep 2011 16:40:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CA+gfSn9KVN2iDCevd0s+TjYHNupDez8NiKZycP3pgBCkYiraFQ@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181867>

Dmitry Ivankov wrote:

>> =C2=A0- 3bba32e9 ("fast-import: allow top directory as an argument f=
or some
>> =C2=A0 commands"): I'm not sure what the motivation is --- is this j=
ust
>> =C2=A0 about the principle of least surprise, or did it come up in p=
ractice
>> =C2=A0 somewhere?
>
> (to ease one's reading, commands are ls, copy and move top directory)
>
> Haven't seen them in practice. It seemed possible with svn import: if=
 there were
> no branches at start, and then someone did svn mv . trunk. But it
> turns out that my
> svn client doesn't allow such move. So more like a least surprise pur=
pose.

With that information in mind, it sounds like a reasonable change in
principle (though I haven't looked over the code at all).  Could you
propose a log message explaining it (both the original motivation and
the actual impact)?

Thanks,
Jonathan
