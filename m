From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2014, #09; Tue, 29)
Date: Wed, 07 May 2014 16:38:44 -0500
Message-ID: <536aa7e4d07c7_76ff7a52ec36@nysa.notmuch>
References: <xmqq7g67iwxc.fsf@gitster.dls.corp.google.com>
 <20140505184546.GB23935@serenity.lan>
 <xmqqd2fqcv7s.fsf@gitster.dls.corp.google.com>
 <20140507080558.GH23935@serenity.lan>
 <xmqqvbtha04t.fsf@gitster.dls.corp.google.com>
 <536a96e762dc4_76ff7a52ec44@nysa.notmuch>
 <20140507204420.GB9035@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: John Keeping <john@keeping.me.uk>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 07 23:49:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi9ib-0006Jp-PN
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 23:49:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752425AbaEGVte (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 17:49:34 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:60226 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751992AbaEGVtc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 17:49:32 -0400
Received: by mail-oa0-f41.google.com with SMTP id m1so2041337oag.14
        for <git@vger.kernel.org>; Wed, 07 May 2014 14:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=35NCE+tAL83wQUmdeBcHTV9DXb1YxjbriZrBn+e2v9c=;
        b=c8ZNxE4PA3F2bcLwTkNtPqu5wmt0+JHzapZ365dr6dK1SrKnSTNHam9aW94QnDtsTt
         0MUyocRZf10rKK3Xr9N24VOLybHQJ8IoxeJ2M1W72uBcU2PgIGTdzsEWO9+LbYUhP7i1
         32Ozi1eNOfYfF0rLb8Si0Iod5x7D2Op0211eXRb3BdqN0W2JEYD2jh9f/YTNkk13Px/+
         Fr5N+ko4DQQSBsZvojmru2cPNwZi5GT7F3wk/v06rVhuVodLnbNo4L/FtzgphzBeO+uM
         CSDF4nX5puU4L/fdRcmDnapIIXhKvtfOCtish2qJcw6NSo0wF5R0dxGH3z9oPX2cNFJm
         B6bg==
X-Received: by 10.182.205.135 with SMTP id lg7mr48578650obc.32.1399499372486;
        Wed, 07 May 2014 14:49:32 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id 10sm37082088obq.18.2014.05.07.14.49.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 May 2014 14:49:31 -0700 (PDT)
In-Reply-To: <20140507204420.GB9035@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248382>

John Keeping wrote:
> On Wed, May 07, 2014 at 03:26:15PM -0500, Felipe Contreras wrote:
> > Junio C Hamano wrote:
> > > Your git-integrate might turn into something I could augment my
> > > workflow with with some additions.
> > > 
> > >  - specifying a merge strategy per branch being merged;
> > 
> > git-reintegrate[1] supports this.
> > 
> > >  - support evil merges or picking a fix-up commit;
> > 
> > git-reintegrate supports this.
> > 
> > >  - leaving an empty commit only to leave comment in the history.
> > 
> > Done[2].
> > 
> > 
> > > and until that happens, I'll keep using the Reintegrate script found
> > > in my 'todo' branch.
> > 
> > My git-reintegrate supports everything John's git-integrate and in
> > addition it supports generating the commands from an existing branch,
> > like your Reintegrate. IOW; it's superior.
> 
> And yet the documentation is unchanged from the version you copied in
> from git-integration.

Not much has changed since v0.1 since that version already worked
perfectly. But I'll update it.

> Personally I would much rather use a project which takes time to
> document all of the features rather than relying on reading the code
> to figure out the options.

And I would rather use a project that concentrates on having the
features users need.

> More features does not make a project superior.

No, better features do.

Either way. Documentation updated.

-- 
Felipe Contreras
