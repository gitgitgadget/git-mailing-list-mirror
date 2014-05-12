From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Should git-remote-hg/bzr be part of the core?
Date: Mon, 12 May 2014 11:40:08 -0500
Message-ID: <5370f968d378c_222d12973081b@nysa.notmuch>
References: <537008f06ceb8_8e47492f89f@nysa.notmuch>
 <53709788.2050201@alum.mit.edu>
 <CAHVLzcmqdkf4fMTok+HsXcDOQ5Oz2QdZti3FuzgBUa2T6AWnfA@mail.gmail.com>
 <5370c32d7ffc7_168f13a72fc6b@nysa.notmuch>
 <CAHVLzckDnfFQpZ-u8qdmKqaCNk62b_K_yinfamBPgm1oST1eLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>,
	git-fc <git-fc@googlegroups.com>,
	Richard Hansen <rhansen@bbn.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Antoine Pelisse <apelisse@gmail.com>,
	Christophe Simonis <christophe@kn.gl>,
	Dusty Phillips <dusty@linux.ca>, Jeff King <peff@peff.net>,
	John Keeping <john@keeping.me.uk>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 12 18:51:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjtRX-00054U-BF
	for gcvg-git-2@plane.gmane.org; Mon, 12 May 2014 18:51:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758651AbaELQvG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2014 12:51:06 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:59963 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753927AbaELQvE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2014 12:51:04 -0400
Received: by mail-oa0-f52.google.com with SMTP id eb12so8501058oac.39
        for <git@vger.kernel.org>; Mon, 12 May 2014 09:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=2OoMnExEX5lXdRALYxuCPVqNIeI/3SrHQs0Nb939mWo=;
        b=iduNSIdvflSEg2A4qmrkHatCvr0vRqyb95Jr67ZnzkrRJdBCoHfkgqB9CmHGYDo4Y+
         IvyZiUXsh92OY0rwQtrMytnMvKyVocl+Nw7QPup801n2fQejPm0BP2b3jCTQQ0CL9uVW
         fQ5ykd4w6kib2F64XwKxBEqMc8bptXCa64jF8N/0IoQIJD8+p+UV+7dNyHQZAJzvpY1l
         vWv0LtV118sgLR7FxuSuJLoWTnPcJI8iRsRnQzcgOIKbQFNIrqUA/9+ZYAkqmEDFRNzX
         S7LWSvJxqbFsLFCZkxA05ccssvZ45bQllPOzV2fqZ+HF8GZ7cr+fRu2lClsJ7mj8k5m5
         jgKg==
X-Received: by 10.60.44.204 with SMTP id g12mr35434365oem.38.1399913463437;
        Mon, 12 May 2014 09:51:03 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id w8sm41802664oel.14.2014.05.12.09.51.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 May 2014 09:51:02 -0700 (PDT)
In-Reply-To: <CAHVLzckDnfFQpZ-u8qdmKqaCNk62b_K_yinfamBPgm1oST1eLQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248712>

Paolo Ciarrocchi wrote:
> On Mon, May 12, 2014 at 2:48 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> > Paolo Ciarrocchi wrote:
> > > On Mon, May 12, 2014 at 11:42 AM, Michael Haggerty <mhagger@alum.mit.edu>wrote:
> 
> > > While I agree with you the this project is managed in a bit conservative
> > > way
> >
> > Only a bit? I don't think I've been involed in a more conservative open
> > source project.
> >
> > > you should really improve how you communicate with other developers,
> > > it's such a pity your contributions are some times not included in
> > > git.git just because of your attitude.
> >
> > But that's a theory. You don't *know* that they would have been included
> > had I used a different attitude.
> 
> Well, you could at least try to act and communicate differently.

I have, it doesn't make a difference.

> > In fact, people have contacted me privately saying similar things, and
> > I'll give you the same challenge I gave them. If you think a different
> > attitude would get my patches in, how about *you* write the commit
> > messages and the discussions for one of my stuck patch series. I'll send
> > the mails as if I had written the content.
> 
> No, sorry but I'm NOT interested in lying to git community.

Yeah, that's what I thought. I know what the result of such experiment
would be though.

-- 
Felipe Contreras
