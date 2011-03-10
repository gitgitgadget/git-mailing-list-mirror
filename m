From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Summer of Code project ideas due this Friday
Date: Wed, 9 Mar 2011 18:10:17 -0600
Message-ID: <20110310001017.GA24169@elie>
References: <AANLkTinpVKBjcqxaCGH0vp82kpKsO2uCBPdMoMKco6Ex@mail.gmail.com>
 <20110303185918.GA18503@sigill.intra.peff.net>
 <AANLkTinXZDq5FJxMmxUuWpCGgMYb3HH774eLJCojmnOz@mail.gmail.com>
 <20110303203323.GA21102@sigill.intra.peff.net>
 <20110309174956.GA22683@sigill.intra.peff.net>
 <AANLkTinpAOE06YX-m=ptQM_y-QMGpVmjewDxWopkXJkQ@mail.gmail.com>
 <20110309215841.GC4400@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 10 01:10:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxTSa-0001zR-TK
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 01:10:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752604Ab1CJAK1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2011 19:10:27 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:35465 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237Ab1CJAK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2011 19:10:26 -0500
Received: by qwd7 with SMTP id 7so827459qwd.19
        for <git@vger.kernel.org>; Wed, 09 Mar 2011 16:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=yhL4WDli7eAVPTx2tlXng1Sd3PdCTr6k34phcD39/OM=;
        b=WV8oT6PX6qgs4x51MYkp+ob8r555siptECe4CKzy8azaPuIcF/8iyoHenjEiJcCKpa
         H931q3uY05gmUaYfxqHpgZt6OqnX7hnLRHeXvkSJoMYi5djLXTv0TuWokGR8OWyZQlAx
         nzdHvMPSfhmbttPdMsO5Ih2nS2VbKIW/qkV5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=X55i7+0bX45JHbv1gC27uQT8qujW6UWZIKGZpc9tgypy2joZZPRY2qkfwzHccHKiFh
         cg13sdEzHT1XcRZ19ZXTpLZf19smsI9xvo4WMpH7oJFpT6Fpb4ERhjV3V7mscxgjtPo0
         YmTG1fQILaGvuEhCOgBuORbddtwnsM/MjDOf4=
Received: by 10.229.78.22 with SMTP id i22mr1596081qck.28.1299715825638;
        Wed, 09 Mar 2011 16:10:25 -0800 (PST)
Received: from elie ([69.209.61.99])
        by mx.google.com with ESMTPS id d21sm876298qck.40.2011.03.09.16.10.22
        (version=SSLv3 cipher=OTHER);
        Wed, 09 Mar 2011 16:10:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110309215841.GC4400@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168776>

Hi,

Jeff King wrote:

> If you have any ideas, please add them to the page!

Thanks for a pointer.  Some ideas still at the "throw them against the
wall and see if they stick" stage: please feel free to add to the page
if you think you can find subsets with the right scope.  Later today I
can look more carefully.

1. Cross-compilable msysgit: ideally, allowing someone to run
   "make msysgit-installer" on Linux from an msysgit-source.git repo
   to get an installer.  Nice subsets to start with might be msys.dll
   (I think there has been some work on that already) and the basic
   msys utilities.

2. Merge libgit2 into git.git: polish the existing code in libgit2 so
   that standard git can use it.  Presumably this would happen by
   porting one function at a time, not by making git link to libgit2
   immediately.  People familiar with libgit2 might be able to pick
   out particularly interesting subsets to start with (diff
   generation?).

3. Remote helpers: bidi git remote-svn (or one-way remote-hg, or
   remote-cvs, or ...).

4. filter-branch killer: using fast-import's new features to implement
   common filter-branch operations (--subdirectory-filter,
   --prune-empty, obliterating certain files) faster.

5. rev-list: Coping with timeskew.

6. shallow clone: Push support.

7. fixing workdirs (and alternates), along the lines explained in the
   thread <http://thread.gmane.org/gmane.comp.version-control.git/150559>.
   I would be very much interested in this.

7. packfilev4.
