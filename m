From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What is missing from Git v2.0
Date: Fri, 25 Apr 2014 14:27:15 -0500
Message-ID: <535ab7137ac2_48b3d8330866@nysa.notmuch>
References: <20140424195559.GA1336@luc-arch>
 <CALZVapn0gEHc7t2fjk7YGd2o0yfpGLu0JCgUtdREvROC8_mqXg@mail.gmail.com>
 <5359c9d612298_771c15f72f02a@nysa.notmuch>
 <CAGK7Mr6dss7BF-srQ3SqeZe2hAe9nS07fGe--ka1rvC5hXvbSA@mail.gmail.com>
 <20140425133520.GC11124@thunk.org>
 <535a9f375e196_3984aa530c46@nysa.notmuch>
 <20140425182459.GA29329@sigill.intra.peff.net>
 <535aa905cd59c_44cee6530ccb@nysa.notmuch>
 <20140425185731.GA31454@sigill.intra.peff.net>
 <535ab03711d81_471d7d930822@nysa.notmuch>
 <20140425191236.GA31637@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Theodore Ts'o <tytso@mit.edu>,
	Philippe Vaucher <philippe.vaucher@gmail.com>,
	Javier Domingo Cansino <javierdo1@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 25 21:37:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdlwV-00022r-Pn
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 21:37:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753608AbaDYThp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 15:37:45 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:58107 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753148AbaDYTho (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 15:37:44 -0400
Received: by mail-ob0-f175.google.com with SMTP id wp4so4733791obc.6
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 12:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=bQ+isM0hlMbWBsBQM2eFUXtg5vAIAod0NaYbTmbwGzI=;
        b=B3OsgMaZku+VaY0+E4dUumJZymaspLtiF4zy2MB3jBb3DXpmWmPhnaB38Mvr2LE213
         rLlOkrKkxKD7BW3Z9t/qwnMoYZ6NWQYksX/nIFGuJMHIZG0cMAi7DjVlBotUG0bGcYHb
         VegYSBv0+1qyqap7Pg90UR4KcIbyHUcefLG7QDMQ012KeNibxB4UEqws2t5TkXz+Q0jY
         HlJN5uMxJcJTVZXzwWoviFcA//ycrJxxp7otO2BKt+cWriDjifzmqKdzpuyDWcDS/L4A
         tmmJWbOFPUBGMOzGyK621PN/S5kl4q7/OOPfaXAyUdfEkiWFQmzE/nz55DtlW+1LDn+C
         WHyw==
X-Received: by 10.60.140.201 with SMTP id ri9mr2327762oeb.74.1398454663883;
        Fri, 25 Apr 2014 12:37:43 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id f9sm17449347obm.2.2014.04.25.12.37.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Apr 2014 12:37:42 -0700 (PDT)
In-Reply-To: <20140425191236.GA31637@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247109>

Jeff King wrote:
> On Fri, Apr 25, 2014 at 01:57:59PM -0500, Felipe Contreras wrote:
> 
> > > Maybe I was not clear in my response, so let me try again. I do _not_
> > > necessarily agree that we need to move away from the name index.
> > 
> > So you agree that "the index" is a bad name, and you agree "staging area" is a
> > better name, yet you don't agree we should move away from the term "index"?
> 
> I don't agree that "the index" is a "bad" name, because that implies
> some objective level of "bad".
> 
> I do think the name "staging area" is fine, and I think it may even be
> better than "index", if we were picking a name out of the blue.

> The way you have phrased it seems like you are trying to create a logical
> contradiction: A is bad, B is good, therefore we should move from A to B.

A _is_ bad, and B _is_ good. That's what I, and many people, have argued, and
that's what the vast majority of people have agreed.

> But that neglects the cost of moving.

And you neglect the benefits of moving.

It is very clear that the costs of moving are negligible in comparison to the
benefits.

But you *always* resist any change, so of course you wouldn't agree on change.
And that's why nothing ever changes.

-- 
Felipe Contreras
