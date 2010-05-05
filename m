From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: [PATCH v2] An alias that starts with "!!" runs in the current
 directory.
Date: Wed, 05 May 2010 23:22:59 +0100
Message-ID: <1273098179.723.10.camel@dreddbeard>
References: <1273019122.16093.6.camel@ubuntu.ubuntu-domain>
	 <20100505005153.GC25390@coredump.intra.peff.net>
	 <4BE115EF.8010306@viscovery.net>
	 <20100505070131.GA11265@coredump.intra.peff.net>
	 <19425.9169.537598.876589@winooski.ccs.neu.edu>
	 <7v1vdql4c9.fsf@alter.siamese.dyndns.org>
	 <19425.54504.163875.379151@winooski.ccs.neu.edu>
	 <19425.58290.42871.986460@winooski.ccs.neu.edu>
Reply-To: wmpalmer@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jared Hance <jaredhance@gmail.com>, git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Thu May 06 00:23:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9n0G-0001fJ-Tl
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 00:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374Ab0EEWXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 May 2010 18:23:34 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:36061 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224Ab0EEWXd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 May 2010 18:23:33 -0400
Received: by wyb35 with SMTP id 35so749279wyb.19
        for <git@vger.kernel.org>; Wed, 05 May 2010 15:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=taSu+2LpAD4TT0TTXhToZOck1OlzCvntX3CTC74HLvc=;
        b=pEIUbViTwm9JanBUi7wMqelQ+uSG+ChTUksZ1rRWc/MZmBuGn64TnbAUPqH6NZ10r9
         WIiUXn5wNBADNs7g9Zen1RQyiF/vCuOsZLeA6/NGybKrIUFPbSb29PCSQ50LgoPw4ZkF
         MBxF9dr23nRfD6draHo2fV1REmQMoZdGeU5ec=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=ip7cstsqCg2v7JtBSj7iUijrJJGgv0ggvqHgESOtp9/81D65iCKCsVdpGK5sGjDWGw
         gSGvNod+qNx6VErAsyaJ1Lk/V62ovrzQxFb6CPzJvzq/yBbKCTK9j2eOOrdvSHNuJnxw
         bwXU3IjcX9oRrBI3WbiVZ/kPzD8LBWxdQAs54=
Received: by 10.227.132.68 with SMTP id a4mr3454715wbt.44.1273098211567;
        Wed, 05 May 2010 15:23:31 -0700 (PDT)
Received: from [192.168.0.129] (5acc34b2.bb.sky.com [90.204.52.178])
        by mx.google.com with ESMTPS id x14sm2010002wbs.18.2010.05.05.15.23.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 05 May 2010 15:23:30 -0700 (PDT)
In-Reply-To: <19425.58290.42871.986460@winooski.ccs.neu.edu>
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146427>

On Wed, 2010-05-05 at 17:31 -0400, Eli Barzilay wrote:
> With "!"-prefixed shell aliases, the shell command not only gets
> executed at the repository top level, but there is no way to know the
> current directory of the original call.  This adds "!!"-prefixed aliases
> as a similar variant for "!"-prefixed ones, but the commands are
> executed in the original directory instead of the top level.
> 
> Signed-off-by: Eli Barzilay <eli@barzilay.org>

Is there any precedent for the "!!" syntax? Something like ".!", "./!",
or "!(.)" would make the intention more clear, I'd think, as well as
leaving room for other extensions to be added later, and some
explicit-opposite, like "/!", to complement it. (It's not like people
are going around with binaries called "!", is it?)

Ignore my suggestions if it turns out that "!!" is used by other things,
but this one seems to be begging for someone else to come along with a
"me too!"


-- 
-- Will
