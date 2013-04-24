From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] submodule: fix quoting in relative_path()
Date: Wed, 24 Apr 2013 21:12:39 +0200
Message-ID: <51782EA7.8000500@kdbg.org>
References: <cover.1366314439.git.john@keeping.me.uk> <cover.1366314439.git.john@keeping.me.uk> <6e4122f3eedec3f520028b5598b78e0d59e5d12b.1366314439.git.john@keeping.me.uk> <7vfvyn4g46.fsf@alter.siamese.dyndns.org> <20130419074632.GC2278@serenity.lan> <7vmwsu31vh.fsf@alter.siamese.dyndns.org> <517199AB.50109@kdbg.org> <7vehe6z10t.fsf@alter.siamese.dyndns.org> <20130424081536.GT2278@serenity.lan> <7vehdzgar1.fsf@alter.siamese.dyndns.org> <20130424162850.GU2278@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Apr 24 21:12:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV57Y-0007RM-9m
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 21:12:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757328Ab3DXTMo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 15:12:44 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:49848 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757057Ab3DXTMn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 15:12:43 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id E2D55CDF83;
	Wed, 24 Apr 2013 21:12:39 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 802FB19F480;
	Wed, 24 Apr 2013 21:12:39 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <20130424162850.GU2278@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222300>

Am 24.04.2013 18:28, schrieb John Keeping:
> On Wed, Apr 24, 2013 at 09:21:38AM -0700, Junio C Hamano wrote:
>> J6t meant a patch to remove the entire case...esac and replace it
>> with a single liner (target=${target#"$curdir"/}).
> 
> Ah, I missed the "six-liner" part.  But that doesn't work because we
> break out of the do...while loop when "$target" starts with "$curdir/"
> and replacing the case statement will remove that.

Yeah, right, _that_ is what I missed ;-)

-- Hannes
