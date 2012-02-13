From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 6/8] gitweb: Highlight interesting parts of diff
Date: Mon, 13 Feb 2012 20:58:17 +0100
Message-ID: <201202132058.18001.jnareb@gmail.com>
References: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com> <m3lio8s57v.fsf@localhost.localdomain> <20120213075451.1bc20885@mkiedrowicz.ivo.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michal Kiedrowicz <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 20:58:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx22i-000068-Or
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 20:58:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755890Ab2BMT61 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 14:58:27 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:63624 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754877Ab2BMT60 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 14:58:26 -0500
Received: by eaah12 with SMTP id h12so1901405eaa.19
        for <git@vger.kernel.org>; Mon, 13 Feb 2012 11:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=m67lGyAyramXXj0nATqU9JXeaUP5DJw3H9d+yB9Nfxw=;
        b=c/vGxaivvoLnhozb4WgnsMBbuoBo85BSyF72bOHRQMFKsss1RMLBlGPwAin4SZuz18
         /5OiDAx3NUeqKzvO1UIsCj7h1r013r1el48iH5VkW6SqQwwsvOJ9uc6A21XPMv3KrcB5
         fKDUEdwlnJq+KcLXyQr+CQRprnnY/cfCSMWBk=
Received: by 10.213.26.8 with SMTP id b8mr2238117ebc.88.1329163105003;
        Mon, 13 Feb 2012 11:58:25 -0800 (PST)
Received: from [192.168.1.13] (aeho143.neoplus.adsl.tpnet.pl. [79.186.196.143])
        by mx.google.com with ESMTPS id o49sm64419986eei.0.2012.02.13.11.58.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 13 Feb 2012 11:58:24 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20120213075451.1bc20885@mkiedrowicz.ivo.pl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190655>

Michal Kiedrowicz wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:
> > Jakub Narebski <jnareb@gmail.com> writes:
[...]
> > > Anyway I have send to git mailing list a patch series, which in one
> > > of patches adds esc_html_match_hl($str, $regexp) to highlight
> > > matches in a string.  
> 
> Yeah, I saw that but after seeing that they accept different arguments
> I decided to leave them alone.
> 
> > > Your esc_html_mark_range(), after a
> > > generalization, could be used as underlying "engine".
> > > 
> > > Something like this, perhaps (untested):
> 
> I think I'll leave it to you after merging both these series to
> master :)
 
Yes, you are right.  Let's do it when we actually need it.

[...]
> > >    # Highlight selected fragments of string, using given CSS class,
> > >    # and escape HTML.  It is assumed that fragments do not overlap.
> > >    # Regions are passed as list of pairs (array references).
> > >    sub esc_html_hl {
[...]
> > Actually we can accomodate both operating on string and operating on
> > array of characters in a single subroutine.  Though it can be left for
> > later commit, anyway...

-- 
Jakub Narebski
Poland
