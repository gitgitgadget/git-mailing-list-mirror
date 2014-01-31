From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: A few contributor's questions
Date: Fri, 31 Jan 2014 10:48:42 -0800
Message-ID: <20140131184842.GA30398@google.com>
References: <8738k44808.fsf@fencepost.gnu.org>
 <20140131161924.GA4332@google.com>
 <87mwic2ijo.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri Jan 31 19:48:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9J95-0000m6-Lk
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jan 2014 19:48:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932515AbaAaSsv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jan 2014 13:48:51 -0500
Received: from mail-pd0-f181.google.com ([209.85.192.181]:60279 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932236AbaAaSsu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jan 2014 13:48:50 -0500
Received: by mail-pd0-f181.google.com with SMTP id y10so4583921pdj.40
        for <git@vger.kernel.org>; Fri, 31 Jan 2014 10:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=p9wZC4mZP15g703oER2XoCz6+dg3vWnf5FVDov7yw7s=;
        b=i3VtthILd4Za1Fm9GiWzBTNtOISE2AIsWYt3DKwtx3qeGN61fp8F53aG0BAhl8C/BS
         PTcPldFdMeixmc8QOGhwA6niaeqOas2Kg2QdHPyGmYCa/RcAwFLcfzaPTJHYdaUvpDGX
         /djAEBp0V2sW0HPDjtCBgKhiku7yKrSSpY9TE+aKgkQyK6Kvh+4vSzco6LaEJW7S6R3j
         w5q/iqgXT0Gkhk+qOhO7kmuWGISEUpPWfNLPPDa/pIYj89f79aO90B9kIC/MBYx93ZQu
         xF8qHvv8fFbe4/1b4x2//aXOEn/95O0VC01EAmpjOPEErC/2r4nuniY7MLvPs8RP3Cw+
         j73Q==
X-Received: by 10.68.134.130 with SMTP id pk2mr10215578pbb.167.1391194129826;
        Fri, 31 Jan 2014 10:48:49 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id tu3sm73432057pab.1.2014.01.31.10.48.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 31 Jan 2014 10:48:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87mwic2ijo.fsf@fencepost.gnu.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241313>

Hi,

David Kastrup wrote:

> Also whether or not this implies an assignment of copyright, it is a
> reasonable assumption for
[...]

Since I think we've completely gone off the rails:

I assume the problem you're trying to solve is that files don't have
clear enough notices of their licensing.  That could be a real problem
for people using the code, since if you no one gave you a license then
you don't have a license at all.  It's also a problem in that it makes
it harder to interpret the phrase "under the same open source license"
(though I have no idea how that could be read as "I give up my
copyright completely").

The way git currently works in that area is the same as the Linux
kernel:

 * the code is copyright by the authors and we try not to waste fuss
   on maintaining a comprehensive list in notices.  If you want to
   find the authors to negotiate special licensing, you get to do the
   work.

 * license is GPLv2-only where not otherwise specified

 * relicensing, when needed, happens by contacting all the copyright
   holders and getting their consent

I don't see anything weird about that.  But people using the code
might like clearer notices, so I personally would not mind an extra
line in most files stating the license.  (More than that and it
becomes absurd.)  That's all just my opinion --- Junio might think
differently, etc.

[...]
> It's verbose and cumbersome enough that I would not have been surprised
> if there'd be an established way of getting this information on record,
> preferably per-project rather than per-commit.

For relicensing the existing practice is to just contact people.  That
has the advantage that I can make a decision about whether to allow
relicensing code I've written in the context of how I expect it to be
used.  I expect that if you had a stance on GPLv2+ licensing of
contributions to git published in some place easily found by search
engines (for example a message on the mailing list), interested people
would not have too much trouble finding it when the time comes.

Hope that helps,
Jonathan
