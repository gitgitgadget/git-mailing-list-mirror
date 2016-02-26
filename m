From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Fwd: git clone does not respect command line options
Date: Fri, 26 Feb 2016 15:34:53 +0700
Message-ID: <CACsJy8BK=2aKg68msH9vawHrXr=PsQYgs6sGXy0koy459MYfSA@mail.gmail.com>
References: <CAMDzUtzoiJWzckTX818HJV=su0eEP35gsNDJ=+k_me08EDvxRg@mail.gmail.com>
 <CAMDzUtxQPMty0Nncr7Yj3up6Zb6F-E0QudOMOZO_jG-Goq0YBg@mail.gmail.com>
 <20160226073444.GA26340@sigill.intra.peff.net> <CAMDzUty5oWjS=4kvvYL7XNCY=xHm3N=+kaeT_zTtpkaMakMrmA@mail.gmail.com>
 <20160226075948.GA26994@sigill.intra.peff.net> <CA+P7+xpuiUQgWYRgVrwKkv27KiJGQ0COrR93cFzQzn2uVA6ypQ@mail.gmail.com>
 <20160226082437.GB26994@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Guilherme <guibufolo@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 26 09:35:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZDs0-00065d-Io
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 09:35:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753564AbcBZIfZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 03:35:25 -0500
Received: from mail-lb0-f170.google.com ([209.85.217.170]:33252 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935AbcBZIfY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 03:35:24 -0500
Received: by mail-lb0-f170.google.com with SMTP id ep2so10827884lbb.0
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 00:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/PHIXYtuAWUeohZ2Az3745Z8Y+lzKjnx4lyrJpjpUlU=;
        b=rCTgsEjyxLmsFWHWfwL6ztvzRv+UpANYSLVovpAg1iUGheRBKRZIUqDcdZoPklarMr
         bEt5wUyFfUkEoQI3z1yyZhi2CQkSA819JztIkdZxBW6SvI9M3OvViBbiC24bdkwJT8Nv
         2H82iNmAe95qN/DCKxxC3ZqH7r88Lm4jKhGm4F5DkCBAj4V6y1wV33VAnm4lLGxJVhlh
         RhoBeLrZ+7Spopv7hIK30gLCpF3vRPPQ/r7v49e6QDOZKEHLOlFEEEuq1W1V/eCnZpZb
         f0nvZh2M1tHBPltlXm2ZSD4WD6PGQrmFkODmNCJRM/6Mdnzjj+jEmJs8V/dkA++ZiSdy
         wHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/PHIXYtuAWUeohZ2Az3745Z8Y+lzKjnx4lyrJpjpUlU=;
        b=FUGGkPgQA3lLQPzp6WXdCV7pZXDb9UU2aaAC32KFEYoncDOFa0RdCRnSSqtFCe6zAM
         NXej2mU+Pv51Umluahit51/JHwhEd63j80XxgKlb/y9mhohUwuBtAdyrz8truJF+cI1y
         l/lTXWraUpOmUB6SRDXhg+PCiGZ3nA1Cirk8NPjqsTiS9jOyTBgCXww5g3lTVjSfC4Iy
         wt7ZTk6RR1YUq1b3SBMuwYLJdNhMw409xsvc73cK2OTP0EvI805L4f91Oz9NlFx6Dtts
         074qzt4vKSanQPouMk7uxKPKFCK3MH+I8cHPu5Z4x6Jyv0BW+U+V69jV7bRdr5lLGObK
         bycg==
X-Gm-Message-State: AD7BkJKWC2XF3WFv2mO466bOuZoiuSTr5CUSQ+FOOWFdk0ZCio/05xAXUXsIuMXCTh9JFf1DH2OpDVzilTZEtw==
X-Received: by 10.112.166.68 with SMTP id ze4mr117512lbb.137.1456475722754;
 Fri, 26 Feb 2016 00:35:22 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Fri, 26 Feb 2016 00:34:53 -0800 (PST)
In-Reply-To: <20160226082437.GB26994@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287553>

On Fri, Feb 26, 2016 at 3:24 PM, Jeff King <peff@peff.net> wrote:
> As an alternative, it would be nice to have some config syntax for
> "clear the list". Maybe something like an empty string, which I think
> has no meaning for the current multi-valued variables (at least not for
> credential helpers or refspecs). That would allow something like:
>
>   git -c credential.helper= clone ...
>
> to do what you'd expect.

I've been thinking of -= instead. It's unambiguous. And you can use
wildcards on both sides. "credential.helper -= *" means delete that
key, "credential.* -= *" deletes all credential.* keys.
credential.helper -= abc only deletes it if the previous value is abc.
-- 
Duy
