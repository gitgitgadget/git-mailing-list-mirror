From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] ciabot: Add a revamped Perl version.
Date: Sat, 11 Jun 2011 18:30:17 -0700
Message-ID: <4BBBDDED-A41F-469B-9F0C-617A3855B41F@gmail.com>
References: <BANLkTin+U2x-Lk_qKrGD4hbxnRWySgHFLA@mail.gmail.com>
Mime-Version: 1.0 (iPhone Mail 8C148a)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"gitster@pobox.com" <gitster@pobox.com>
To: JD Horelick <jdhore1@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 12 03:39:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QVZeA-0005jt-B2
	for gcvg-git-2@lo.gmane.org; Sun, 12 Jun 2011 03:39:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752582Ab1FLBiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jun 2011 21:38:11 -0400
Received: from mail-pz0-f51.google.com ([209.85.210.51]:34863 "EHLO
	mail-pz0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752204Ab1FLBiK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Jun 2011 21:38:10 -0400
X-Greylist: delayed 465 seconds by postgrey-1.27 at vger.kernel.org; Sat, 11 Jun 2011 21:38:10 EDT
Received: by pzk26 with SMTP id 26so1724044pzk.10
        for <git@vger.kernel.org>; Sat, 11 Jun 2011 18:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:references:in-reply-to:mime-version
         :content-transfer-encoding:content-type:message-id:cc:x-mailer:from
         :subject:date:to;
        bh=RbLDVD4Trrahv58R/OMgyhad+0doV65f1kia04sErKY=;
        b=ghHHQLzFKp3V6fCTszXm382iQMzNQeF4DvBml/ryBGG/8KBhl58dWVaxqKw0toFIBQ
         7PaDB60gHyJrcIqUVs+szEZn+ChhJ7+QGoe9OBvpXjhI3Iv6pkevPZxA0eC9/qJjTCs/
         8Rh8nqlNdSf7q3s6jCRM3L5WnSmILuGC9CICI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:in-reply-to:mime-version:content-transfer-encoding
         :content-type:message-id:cc:x-mailer:from:subject:date:to;
        b=pVDwx2aIiGACxVel1RtBQijms7wkEBg6JptWC7lK99Prbhto8qxOtBb3Go2ryXr36U
         X9Suf+PjKlt4QgHqtLP8AEZK2iBZrcK17dh52ojyjPTwDTO6XsOaCMcW57YV1e+SORvR
         A8GXNFh23SSbhVsatWmDETVCUAVbjZBwN46ow=
Received: by 10.68.19.131 with SMTP id f3mr1617518pbe.379.1307842224639;
        Sat, 11 Jun 2011 18:30:24 -0700 (PDT)
Received: from [192.168.1.13] (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id y2sm3488008pbi.51.2011.06.11.18.30.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 11 Jun 2011 18:30:22 -0700 (PDT)
In-Reply-To: <BANLkTin+U2x-Lk_qKrGD4hbxnRWySgHFLA@mail.gmail.com>
X-Mailer: iPhone Mail (8C148a)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175650>

On Jun 11, 2011, at 3:35 PM, JD Horelick <jdhore1@gmail.com> wrote:

> Attached (and pasted below, but I believe Gmail messes up the
> whitespace) is a patch for a new ciabot script that is the revamped
> version of the old Perl script.

You can use "git send-email" with gmail to avoid these issues.  See the manpage for the details; it includes a gmail example.

> [snip]
> +#
> +# The master location of this file is in the Cogito repository
> +# (see http://www.kernel.org/git/).
> +#

s/Cogito/git/

Cheers,
David