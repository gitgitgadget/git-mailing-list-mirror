From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: How can I automatically create a GIT branch that represents a
 sequence of tags?
Date: Sun, 11 Aug 2013 08:20:26 +0200
Message-ID: <20130811062026.GG25779@paksenarrion.iveqy.com>
References: <CAFw3YtRLgUGGn9JV5K3P9XtMBcBeO7=VSM7PekSxtW6xCsfZ1Q@mail.gmail.com>
 <20130810232026.GF25779@paksenarrion.iveqy.com>
 <52071E2E.2020001@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>,
	Kristian Freed <kristian.freed@gmail.com>,
	git <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Aug 11 08:17:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8Oxu-00023p-1k
	for gcvg-git-2@plane.gmane.org; Sun, 11 Aug 2013 08:17:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751956Ab3HKGQz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Aug 2013 02:16:55 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:57374 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774Ab3HKGQy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Aug 2013 02:16:54 -0400
Received: by mail-la0-f54.google.com with SMTP id ea20so3874682lab.41
        for <git@vger.kernel.org>; Sat, 10 Aug 2013 23:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=AVdJJ9c8CVLNf7WCYed9o1W78PSvO7chby8jD7ZtYQs=;
        b=GmbjxHn5fpmkOdDP79xkQwuHl8eC53ZuRIbuYiqo/V7oiOc6cxGQC4AmG7Kgodgr4Q
         iW1I+ytrHn55LDKbmfpcypX+CKIVZ8xHPJWFKS6NxTg/gkg/Or+dMUXwbG1Cd80HY9+i
         Q/jaQkLyA3smTy+fXoKi8dM9lOgbwLPQWtzPrJgSrnVNGIgR6neXZg4Xi0Xwp8f0pRBt
         VKiQQXn2VUhrQeETxD3hZD+MysLNf4w7KxrJGuuA7eEe/erQ3mDbs8XZgMWJMebDjLuK
         ag7G18q6y71vjvC2bnde//Qb9oc0pY4elNnWUG1GEiONNBFkVS1tRwsPZCfVxngHetGI
         C5sw==
X-Received: by 10.112.135.99 with SMTP id pr3mr7274305lbb.23.1376201809851;
        Sat, 10 Aug 2013 23:16:49 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id u20sm285259lbh.7.2013.08.10.23.16.48
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 10 Aug 2013 23:16:48 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1V8P0s-0002Wu-8K; Sun, 11 Aug 2013 08:20:26 +0200
Content-Disposition: inline
In-Reply-To: <52071E2E.2020001@alum.mit.edu>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232122>

On Sun, Aug 11, 2013 at 07:16:30AM +0200, Michael Haggerty wrote:
> On 08/11/2013 01:20 AM, Fredrik Gustafsson wrote:
> > [...]
> > It would be very hard to do a tool such as you describe, the reason=
 is
> > that there's no sane way to order your tags. Git today show tags
> > alphabetically, all versions does not have a alphabtic order. [...]
> > It would be quite easy to make a script that create such branch for=
 you,
> > if you only can sort the tags somehow.
>=20
> GNU sort has a nice option that can sort this way:
>=20
>   -V, --version-sort
>      Sort by version name and number.  It behaves like a standard sor=
t,
>      except that each sequence of decimal digits is treated numerical=
ly
>      as an index/version number.

That's a nice feature, I remember we had  that one as a feature request
for git tag just a few days ago. It works well with git.git version
numbers but won't be usefull in this case for git.git since git.git has
other tags too (like the gitgui version tags). However if you've a nice
namespace for the tags where you only tags versions, it might be an
alternative.

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
