From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What is missing from Git v2.0
Date: Thu, 24 Apr 2014 13:25:47 -0500
Message-ID: <5359572b40d4f_3241f112ecf6@nysa.notmuch>
References: <alpine.DEB.2.02.1404221523060.14881@nftneq.ynat.uz>
 <53588713347b7_59ed83d308cf@nysa.notmuch>
 <CAHYYfeHeJYZ67chSTQk2grsFGr07KXcVNR-T6kOPo0bVYDm59g@mail.gmail.com>
 <53588f448d817_59ed83d3084e@nysa.notmuch>
 <CAHYYfeFKW93GH+6-ssR5L_uoo3OL2-LFAsj-4+8uEmL0BhT3ow@mail.gmail.com>
 <5358bae8ab550_1f7b143d31037@nysa.notmuch>
 <877g6fb2h6.fsf@fencepost.gnu.org>
 <5358ca1a55a69_1f7b143d3101c@nysa.notmuch>
 <20140424134106.GA27035@thunk.org>
 <CALbm-EbBj1hCF=rFfeBbzeVmffRHVEEE=HSbVZxw-=-=p2BvEQ@mail.gmail.com>
 <20140424154717.GB7531@thunk.org>
 <CALbm-Ea4oAQ+JsYu6Zo06ONMbtp8AhgFqDC485BRKsM36EVQXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	David Kastrup <dak@gnu.org>,
	James Denholm <nod.helm@gmail.com>, David Lang <david@lang.hm>,
	Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Stefan Beller <stefanbeller@gmail.com>,
	Theodore Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Apr 24 20:36:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdOVT-0006Cd-P4
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 20:36:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757694AbaDXSgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 14:36:17 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:52933 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754533AbaDXSgP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 14:36:15 -0400
Received: by mail-oa0-f44.google.com with SMTP id n16so3102593oag.3
        for <git@vger.kernel.org>; Thu, 24 Apr 2014 11:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=ZSmDV3AvIrcG8uFh3YI2Q74tVy/ehGVOwK8XCiyiGTc=;
        b=C04PWmM4mre/dg6ISX6SlX74i5+oeYm5dq5doNPpmrvuPfT2fjTeDv1YjW8/NM8mqr
         7Dy3d9ZwIcHz8DuIqBHXW006hU0EVbL+br/X9tAvF2cj1YWsO1gtuK0Ibpn1+pJoIeze
         mWWYYMLuBUqK5+m9LSYpQSOGa1vud3gqKQac0Bafl+BAOZv2e7FZ7/Xyvpas0NaEnokT
         cPDMDFQOryDOXoWcdeg9INEV7nKlvhIqCHHPQxufiGRgaEuStdr5AdlvOmi/VxMt3eHy
         5VqB8WbWCDuN/dMaZXqm8e5fAeH79A3xEHqTBZx7ZdszXb5kbP9eu9PD1rjrpZPDX2bR
         33Pw==
X-Received: by 10.60.58.7 with SMTP id m7mr2759097oeq.59.1398364575120;
        Thu, 24 Apr 2014 11:36:15 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id wy2sm10078875obc.21.2014.04.24.11.36.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Apr 2014 11:36:14 -0700 (PDT)
In-Reply-To: <CALbm-Ea4oAQ+JsYu6Zo06ONMbtp8AhgFqDC485BRKsM36EVQXw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246989>

Stefan Beller wrote:
> I may have missunderstood.
> 
> So today you cannot commit if you don't provide an email address
> (usually the first time you try to commit, git asks to "git config
> --global author.email=<you@mail.here>"), if I remember correctly, so
> there is definitely a valid (i.e. user approved) email address.

That's not true, that's only the case if you don't have a fully qualified
hostname, like 'localhost', but if you do, like localhost.redhat, then Git
assumes your email is user@localhost.redhat, and it's valid.

-- 
Felipe Contreras
