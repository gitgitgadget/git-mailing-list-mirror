From: Mike Ralphson <mike.ralphson@gmail.com>
Subject: Re: [PATCH] Remove useless if-before-free tests.
Date: Thu, 26 Feb 2009 13:48:25 +0000
Message-ID: <e2b179460902260548g32e5be97p138a9d8fb5d5ef78@mail.gmail.com>
References: <871w7bz1ly.fsf@rho.meyering.net> <47B995CC.2000809@gmx.ch>
	 <87skznhqk6.fsf@rho.meyering.net>
	 <7vzlts9ag8.fsf@gitster.siamese.dyndns.org>
	 <87ir0gx5bn.fsf@rho.meyering.net>
	 <7vskzk99fd.fsf@gitster.siamese.dyndns.org>
	 <87tzk0tzjz.fsf@rho.meyering.net>
	 <7vd4qo7fsc.fsf@gitster.siamese.dyndns.org>
	 <877igup6fl.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Jim Meyering <jim@meyering.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 14:50:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lcgcd-0001y9-TI
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 14:49:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753870AbZBZNs3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Feb 2009 08:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753295AbZBZNs2
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 08:48:28 -0500
Received: from qw-out-2122.google.com ([74.125.92.24]:63216 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753211AbZBZNs2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Feb 2009 08:48:28 -0500
Received: by qw-out-2122.google.com with SMTP id 5so980243qwi.37
        for <git@vger.kernel.org>; Thu, 26 Feb 2009 05:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=kC+gApBjAHbpyTJRmzT9tlHDtF34EbG9Jfnc7zW9Jiw=;
        b=q2GpBtrudIY0Wj5bvfJAAEj5RF36WDA9X3gAt3xevVyfM2TkYpxX9FBUd31ED+uK6c
         l1IbK1SZjU5/UNxqFPypAl4BhzAqD5Lu7mOTpdskOUJCFCQ56grIkRZz5oR4+QnialIf
         QRLOZxBlML/Q7Opu/vTvNTunNm2lEZqsYOWEU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SpQhQSZbXbgTyhCqRzyFpAxpq47wyhWOwFvaR4eLB1xkGaABJlz05Vw9AXcUE8uj/6
         +kEyVctbPibuc7Fj93xVjCDl4Zor579BHzw9yAM3y8Lj9pPjJMnKOV5sxLDi8u5GyiUH
         +Lv1G1CAq+BunPUMuCgkJoAHWXLv6xf1GQ//g=
Received: by 10.224.36.194 with SMTP id u2mr2173678qad.83.1235656105575; Thu, 
	26 Feb 2009 05:48:25 -0800 (PST)
In-Reply-To: <877igup6fl.fsf@rho.meyering.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111562>

2008/2/24 Jim Meyering <jim@meyering.net>:
> Too bad coverity is closed-source. =C2=A0I'll bet it could do this ea=
sily.

http://scan.coverity.com/

Courtesy of announcement on LWN.

git currently isn't on the ladder, but could be submitted by our
gentle leader, if the license terms[1] were acceptable.

Mike

[1] http://scan.coverity.com/policy.html#license
