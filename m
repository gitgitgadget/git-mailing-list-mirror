From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What is missing from Git v2.0
Date: Thu, 24 Apr 2014 13:17:07 -0500
Message-ID: <535955235cd75_3241f112ecb@nysa.notmuch>
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
To: tytso@mit.edu, Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 20:27:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdON4-0001yG-22
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 20:27:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758808AbaDXS1h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 14:27:37 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:46343 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758784AbaDXS1f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 14:27:35 -0400
Received: by mail-ob0-f175.google.com with SMTP id wp4so3101648obc.34
        for <git@vger.kernel.org>; Thu, 24 Apr 2014 11:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=bQq0eluIQKBW94DPMHyEaujNSGbleNd6Altwk8/wKKc=;
        b=TEhOToQzPChQXwLZnuTQxFPmQBSEcJEghO9PhI3Vq0UQrAoNnsbdrqqIvK3NDbUCCm
         rxPamrNjJnzvxbYTAnqpvRoZv54LNuvBSxNLSKWhizru14uG1H6qycpxLK9/5XCK8HPM
         7YFbcsqAkf7SUX7xggbXkQxY+t+70iU51d8AnXFf3CTtq4MaLVt4B1Ch8aXxxcyz09N/
         7PLxRwyRJ6PXyS5VtnVVTTd88ZIeFdMlU/xB7jX1QsIFb7rDBaHpVRIs5QpBVvmt/e2n
         LkfWzWhgFsazzFqHCUK6dg5QxpfqPiiBBIuSgvGI71j+E8lYGMuWU3ac5VwJLkLJgxOO
         kKoQ==
X-Received: by 10.182.74.234 with SMTP id x10mr2751343obv.1.1398364055294;
        Thu, 24 Apr 2014 11:27:35 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id te6sm20697620oec.2.2014.04.24.11.27.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Apr 2014 11:27:34 -0700 (PDT)
In-Reply-To: <20140424154717.GB7531@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246986>

tytso@ wrote:
> On Thu, Apr 24, 2014 at 05:00:13PM +0200, Stefan Beller wrote:
> > > I don't even think we need to query the user to fill out all of the
> > > fields.  We can prepopulate a lot of the fields (name, e-mail address,
> > > etc.) from OS specific defaults that are available on most systems ---
> > > specifically, the default values we would use the name and e-mail
> > > address are not specified in a config file.
> > 
> > Please don't. Or you end up again with Commiters like sb@localhost,
> > sbeller@(None) or alike. I mean it's just one question once you setup
> > a new computer, so I'd really like to see that question and then
> > answer myself (at university/employer I might put in another email
> > address than at home anyway, and I'm sure my boxes have no sane
> > defaults)
> 
> But that's no worse than what we have today.  What if we print what
> the defaults were, which might help encourage the user to actually run
> the "git config -e" command?

In addition we shouldn't consider user@host a valid e-mail. In the vast
majority of cases it's not.

http://article.gmane.org/gmane.comp.version-control.git/232027

-- 
Felipe Contreras
