From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: cherry-pick / pre-commit hook?
Date: Mon, 27 Dec 2010 03:37:29 -0600
Message-ID: <20101227093729.GB1201@burratino>
References: <m2wrnktcl2.wl%dave@boostpro.com>
 <20101208175324.GB5687@burratino>
 <m2oc8wt0xc.wl%dave@boostpro.com>
 <20101208220514.GA8865@burratino>
 <m2d3oo9cwr.wl%dave@boostpro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dave Abrahams <dave@boostpro.com>
X-From: git-owner@vger.kernel.org Mon Dec 27 10:38:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PX9Wr-0005MN-1b
	for gcvg-git-2@lo.gmane.org; Mon, 27 Dec 2010 10:38:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378Ab0L0Jhu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Dec 2010 04:37:50 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:56205 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753043Ab0L0Jhs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Dec 2010 04:37:48 -0500
Received: by gwj20 with SMTP id 20so4431467gwj.19
        for <git@vger.kernel.org>; Mon, 27 Dec 2010 01:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=dTykYaqsSjfsHIn/lMQuZ6lfZ8A3yh6UuEMdLbTjv6w=;
        b=cmWswuYcNHNvUptk/MWUoIorRYhQaIae2Gx+0DtF9m2XIBdsbMGVNPT08Y2DKqiy7i
         y3RB7BmiEQOjRWb75J4DsDbyZ3sf8YBxhHD2D7zuKiSrYUpnXJuejU+uYKPsw4ufO5pR
         JNFIl59q2TXtPAGDFEMaehDddk/39+7vFyGP8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=GEicVlS2/qMqSul3eZHqu3duHRBUjwZprU/1ZBBPkj1McwBeS+g/arPSS91hi68HwH
         JOKQWwd6PvhW8VXbBr0zvuE3QeBDYFxiwg/iIiLjD1bJLrcTDqew0DfekU8cfdpwqkh4
         G6T9KGSUhSPRRfwZ9LJzA9aNr/ghmrDI6M8S0=
Received: by 10.236.105.226 with SMTP id k62mr6041341yhg.53.1293442667757;
        Mon, 27 Dec 2010 01:37:47 -0800 (PST)
Received: from burratino (c-76-126-174-171.hsd1.ca.comcast.net [76.126.174.171])
        by mx.google.com with ESMTPS id z1sm2839643yhc.8.2010.12.27.01.37.45
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 27 Dec 2010 01:37:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <m2d3oo9cwr.wl%dave@boostpro.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164217>

Dave Abrahams wrote:

> if you're going to have a "pre-commit hook" concept,
> but not run that hook for some kinds of commits, then that fact needs
> to be documented.

True, and thanks for a reminder.  Suggested wording?

The current githooks(5) says

 pre-commit
	This hook is invoked by git commit, and can be bypassed with
	--no-verify option.

and leaves the question of whether it is invoked by git cherry-pick
unanswered.
