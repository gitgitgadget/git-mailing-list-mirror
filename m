From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What is missing from Git v2.0
Date: Thu, 24 Apr 2014 03:23:54 -0500
Message-ID: <5358ca1a55a69_1f7b143d3101c@nysa.notmuch>
References: <CAMP44s17h4Tjg+VaMF0atLep8t-0HVp4UDr1WE2wYnEuZ07eaQ@mail.gmail.com>
 <53557071.5040500@gmail.com>
 <xmqqtx9m8obr.fsf@gitster.dls.corp.google.com>
 <CAHGBnuMty-86jfUto=L3muhgEVwVE70FQQY2FJ1bn7AUjfEtLQ@mail.gmail.com>
 <xmqqk3ah5i55.fsf@gitster.dls.corp.google.com>
 <5356c1a61f6d8_463e11ef310a5@nysa.notmuch>
 <20140422213039.GB21043@thunk.org>
 <alpine.DEB.2.02.1404221523060.14881@nftneq.ynat.uz>
 <53588713347b7_59ed83d308cf@nysa.notmuch>
 <CAHYYfeHeJYZ67chSTQk2grsFGr07KXcVNR-T6kOPo0bVYDm59g@mail.gmail.com>
 <53588f448d817_59ed83d3084e@nysa.notmuch>
 <CAHYYfeFKW93GH+6-ssR5L_uoo3OL2-LFAsj-4+8uEmL0BhT3ow@mail.gmail.com>
 <5358bae8ab550_1f7b143d31037@nysa.notmuch>
 <877g6fb2h6.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: James Denholm <nod.helm@gmail.com>, David Lang <david@lang.hm>,
	Theodore Ts'o <tytso@mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 10:34:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdF79-0008Ud-0Y
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 10:34:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753021AbaDXIeb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 04:34:31 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:43757 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752879AbaDXIeV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 04:34:21 -0400
Received: by mail-ob0-f181.google.com with SMTP id gq1so2338835obb.12
        for <git@vger.kernel.org>; Thu, 24 Apr 2014 01:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=TBkYCkvj333zD53JeZtYDCamR4Oui2/F/2+t7OPQgEo=;
        b=KQ9dmJV4fKEw7bFfs+kbKzvGAIO0M8MS8oeI0G/7DFD/SDeaQN13AFcLBPXDX0DAyc
         BiPlGlltELoHJEg7uW3YWJmYD29EaetbHcpf5LsUdV1Yo90jgAfvP6rn54zuvEmJWSvK
         9tSXlqz1mBLF4IMfPgNf7aA7QUWPWxKnHOfit6ULEN3sP6W+Z1RgvQWlU/i9yZqUgfK5
         H55fEDESQI5qf0HknAZMGvzuSK8ylj48HH0am6bJn+GsC7Tzc40BIGQC6lC6n6zXQqvo
         A7Mg2iS40y6EIqqg54AiAM/CpMBEFJ3SiSrS5Jbc92RCVUe7yWtJOIySl+Yfi2/SJ2+/
         3QOQ==
X-Received: by 10.182.29.33 with SMTP id g1mr334471obh.53.1398328460389;
        Thu, 24 Apr 2014 01:34:20 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id a7sm1404580obf.19.2014.04.24.01.34.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Apr 2014 01:34:19 -0700 (PDT)
In-Reply-To: <877g6fb2h6.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246948>

David Kastrup wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > James Denholm wrote:
> >> Felipe Contreras wrote:
> >> >This is a false dichotomy; there aren't just two kinds
> >> > of Git users.
> >> >
> >> > There is such a category of Git users who are not
> >> > fresh-out-of-the-boat, yet not power users either.
> >> 
> >> Oh, I didn't mean to suggest a dichotomy of any kind. However these are the
> >> two groups (I suggest) are the most immediately relevant - one calls for
> >> change, and the other would be negatively impacted.
> >
> > Nobody would be negatively impacted. Who would be impacted negatively
> > by having default aliases?
> 
> The people having to read and understand scripts written in the
> expectation of default aliases.

Which are imaginary.

> > And I have showed they are not problems.
> 
> You managed to convince yourself, so feel free to put aliases in every
> Git you use and distribute.

There is evidence for the claim that there won't be those problems. You have
absolutely no evidence there there will.

-- 
Felipe Contreras
