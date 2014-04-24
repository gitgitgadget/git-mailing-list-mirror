From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What is missing from Git v2.0
Date: Thu, 24 Apr 2014 13:28:50 -0500
Message-ID: <535957e225e7b_3241f112ecc3@nysa.notmuch>
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
 <5358ca1a55a69_1f7b143d3101c@nysa.notmuch>
 <8738h3ayom.fsf@fencepost.gnu.org>
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
X-From: git-owner@vger.kernel.org Thu Apr 24 20:39:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdOYN-0001sd-CD
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 20:39:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758203AbaDXSjS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 14:39:18 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:54786 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753427AbaDXSjR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 14:39:17 -0400
Received: by mail-ob0-f179.google.com with SMTP id vb8so3096212obc.24
        for <git@vger.kernel.org>; Thu, 24 Apr 2014 11:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=+q91YTeYssL1TytotnIyjaRm4dqNKHg58StYaMY2HcI=;
        b=I3vyg6Msu8YBV+OHtI8uglofwqJ8d58F3Ix2MqU0jfsbXSxUCPj0hsVl3B8Q8QKSyu
         q3+OhVD+Fa/3UUdip3Fomrd5b1OLPCSh9W6x1bouQan5gtJdioiI2jEPxPynGkVKdlmN
         10qQvAGuNp2UbicERU/Gg4ZsmwhRX4hN523MDIhO3MdIMwM4YGtf/LMBzsy5P/SFyYoa
         NV8BmS2XEondbD3YT0SZ/q5XfjjxY5NwIHAG0qA9OiqMIBeN/Iob/irU2QIhO54Yt2wg
         7VoqOQpxJFVEpXO19i2qWyBkA5dzr6jqOxJ4z6iDUnPHBrsvRqSig0/zQ1QGzOn6QvyY
         Ay+A==
X-Received: by 10.60.40.39 with SMTP id u7mr2878930oek.56.1398364757021;
        Thu, 24 Apr 2014 11:39:17 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id ci10sm20831289oec.0.2014.04.24.11.39.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Apr 2014 11:39:15 -0700 (PDT)
In-Reply-To: <8738h3ayom.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246992>

David Kastrup wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> > David Kastrup wrote:
> >> The people having to read and understand scripts written in the
> >> expectation of default aliases.
> >
> > Which are imaginary.
> 
> And I prefer them to stay that way since then one does not need to worry
> about them.

If everybody was afraid of moving because of imaginary fears like you, nothing
would get done in this world. Rational people distinguish the imaginary from
the real.

-- 
Felipe Contreras
