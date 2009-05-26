From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH 2/2] t8005: convert CP1251 character set to ISO8859-5
Date: Tue, 26 May 2009 09:57:41 -0500
Message-ID: <xZbeuW5cnER48WqsONW1BxZmepHjuwJtRUnpLAV0nv4mheMkGHT26g@cipher.nrlssc.navy.mil>
References: <7vhbzd85ux.fsf@alter.siamese.dyndns.org> <p2A1PR1KFf_G_uMMwQZtVeaDE_VcBr8lFjs9Jsg_OIkeypNbwPPRHP32EUHJ4leCZsycUOhFjHc@cipher.nrlssc.navy.mil> <p2A1PR1KFf_G_uMMwQZtVXPPBSNcQqEAV1ZnkoQLMJaPzWwJrkH_HCs5Kbt70yQlltZJxs4WxXo@cipher.nrlssc.navy.mil> <7vskiw4ooe.fsf@alter.siamese.dyndns.org> <7vhbzc4oht.fsf@alter.siamese.dyndns.org> <20090525092027.GA22382@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 26 16:58:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8y6H-0007yR-OI
	for gcvg-git-2@gmane.org; Tue, 26 May 2009 16:57:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751669AbZEZO5t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2009 10:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753736AbZEZO5s
	(ORCPT <rfc822;git-outgoing>); Tue, 26 May 2009 10:57:48 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:45450 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229AbZEZO5s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2009 10:57:48 -0400
Received: by mail.nrlssc.navy.mil id n4QEvfUb024168; Tue, 26 May 2009 09:57:41 -0500
In-Reply-To: <20090525092027.GA22382@coredump.intra.peff.net>
X-OriginalArrivalTime: 26 May 2009 14:57:41.0834 (UTC) FILETIME=[51B4A2A0:01C9DE12]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120004>

Jeff King wrote:
> On Fri, May 22, 2009 at 06:06:06PM -0700, Junio C Hamano wrote:
> 
>> It also appears that we do not need OLD_ICONV anymore, as our Makefile
>> suggests for older releases.
>>
>> It would be nice if people with older Solaris can check if I am not
>> breaking things for them...
> 
> Git builds fine on my Solaris 8 test box with this patch. It also builds
> fine if I drop OLD_ICONV, so it may be that we can unconditionally do
> so (but I don't have any older boxen to test with).
> 
> With current 'next' and NO_PERL set, I can pass every test except:

Oh, and have the recent changes that are now in next _allowed_ any new tests to
pass that were previously failing?

-brandon
