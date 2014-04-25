From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What is missing from Git v2.0
Date: Fri, 25 Apr 2014 13:27:17 -0500
Message-ID: <535aa905cd59c_44cee6530ccb@nysa.notmuch>
References: <5358bae8ab550_1f7b143d31037@nysa.notmuch>
 <877g6fb2h6.fsf@fencepost.gnu.org>
 <5358ca1a55a69_1f7b143d3101c@nysa.notmuch>
 <20140424134106.GA27035@thunk.org>
 <20140424195559.GA1336@luc-arch>
 <CALZVapn0gEHc7t2fjk7YGd2o0yfpGLu0JCgUtdREvROC8_mqXg@mail.gmail.com>
 <5359c9d612298_771c15f72f02a@nysa.notmuch>
 <CAGK7Mr6dss7BF-srQ3SqeZe2hAe9nS07fGe--ka1rvC5hXvbSA@mail.gmail.com>
 <20140425133520.GC11124@thunk.org>
 <535a9f375e196_3984aa530c46@nysa.notmuch>
 <20140425182459.GA29329@sigill.intra.peff.net>
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
X-From: git-owner@vger.kernel.org Fri Apr 25 20:37:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wdl0V-0004Qi-3P
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 20:37:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754093AbaDYShs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 14:37:48 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:64866 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753608AbaDYShp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 14:37:45 -0400
Received: by mail-oa0-f42.google.com with SMTP id i4so4665323oah.1
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 11:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=sU8ZRpdPyyau/hcpDYXlz3fSAlfBI+o55hKNWZsR2is=;
        b=adBTqaF6zhdzk5J0lz3sjfOb0P/nxkdymXjcCGxbYrX/axvXY+GYhH297oBSfsDuCf
         SA1FkRPtbcoQn+bYUEIs4zHLNiij+4XKEdLjAnbVxoaZWzlTqsi0JdJc5QRGy9bR1qHY
         epfFFnHB5jm/gK+hJy2yFmKtV8648ciOxsT9u0I+FpP9J0WWthokuZFsvquJHLdPqJNV
         8Q/aGWMDOH4SIR1+2moTIUA+tEemojRgZpRhdcgoqxJTwcv1dZdoD894TQJnkNHk2fNc
         UB4da7EIszX74Pw8RKHERnJ6y4grxaVdDMx7IwVs3J2y8i45pFgUI3OFQgpYlMzAqcD5
         knuQ==
X-Received: by 10.182.75.225 with SMTP id f1mr2723588obw.66.1398451065341;
        Fri, 25 Apr 2014 11:37:45 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id zm8sm17120581obc.16.2014.04.25.11.37.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Apr 2014 11:37:44 -0700 (PDT)
In-Reply-To: <20140425182459.GA29329@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247092>

Jeff King wrote:
> On Fri, Apr 25, 2014 at 12:45:27PM -0500, Felipe Contreras wrote:
> 
> > When I say literally everbody agreed to move away from the name "index" (except
> > Junio and another guy) I mean it. I even composed a list:
> > 
> > http://article.gmane.org/gmane.comp.version-control.git/233469
> > 
> > Jeff King, Jonathan Nieder, Matthieu Moy, they all agreed.
> 
> With reference to my name, your email says:
> 
>   Jeff King:
>   "staging area" makes perfect sense
> 
> But here's that statement in context[1]:
> 
>   So the term "staging area" makes perfect sense to me; it is where we
>   collect changes to make a commit. I am willing to accept that does not
>   to others (native English speakers or no), and that we may need to
>   come up with a better term. But I think just calling it "the stage" is
>   even worse; it loses the concept that it is a place for collecting and
>   organizing.
> 
> In other words, I was saying that the term makes sense to me, and
> primarily comparing favorably to a worse proposal. I am not commenting
> at all on a plan to change names, which is what you are claiming above.
> 
> I do think the term "staging area" is fine, but picking a term is only
> step one of a plan. The rest is deciding how to make the change, and
> whether it is worth it. I remain undecided on the latter bits. Please
> don't quote me out of context in a way that implies that I am decided.

I specifically said everybody agreed to "move away from the name 'index'", I
didn't say everybody agreed on the "staged area" although the vast majority
did, and I didn't say anybody agreed on my patches, although some did.

I think I was clear.

-- 
Felipe Contreras
