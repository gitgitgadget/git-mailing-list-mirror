From: Simon Ruderich <simon@ruderich.org>
Subject: Re: [PATCH] gitweb: Fix the author initials in blame for non-ASCII
 names
Date: Fri, 30 Aug 2013 20:31:08 +0200
Message-ID: <20130830183108.GA4240@ruderich.org>
References: <20130829163935.GA9689@ruderich.org>
 <1377851821-5412-1-git-send-email-avarab@gmail.com>
 <xmqqppsvyrzj.fsf@gitster.dls.corp.google.com>
 <xmqqhae7yrls.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: "=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason" <avarab@gmail.com>,
	git@vger.kernel.org,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 30 20:31:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFTTY-000162-HI
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 20:31:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756161Ab3H3SbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 14:31:12 -0400
Received: from zucker.schokokeks.org ([178.63.68.96]:50102 "EHLO
	zucker.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755173Ab3H3SbL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 14:31:11 -0400
Received: from localhost (pD9E97994.dip0.t-ipconnect.de [::ffff:217.233.121.148])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by zucker.schokokeks.org with ESMTPSA; Fri, 30 Aug 2013 20:31:08 +0200
  id 0000000000000032.000000005220E4EC.00006FEB
Content-Disposition: inline
In-Reply-To: <xmqqhae7yrls.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2013-03-19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233460>

On Fri, Aug 30, 2013 at 11:13:19AM -0700, Junio C Hamano wrote:
> I think in this function the filehandle is called $fd, not $fh.  Has
> any of you really tested this???

I did, but I applied the change by hand without applying the
patch directly and didn't notice the difference. Sorry for that.

Regards
Simon
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
