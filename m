From: "Philipp A. Hartmann" <pah@qo.cx>
Subject: Re: [PATCH] contrib: GnomeKeyring support + generic helper implementation
Date: Sun, 26 Aug 2012 20:16:44 +0200
Message-ID: <503A680C.3090406@qo.cx>
References: <1345741068-11004-1-git-send-email-pah@qo.cx> <7vfw7cyx4n.fsf@alter.siamese.dyndns.org> <20120824213342.GB16285@sigill.intra.peff.net> <7vzk5kx8so.fsf@alter.siamese.dyndns.org> <7vr4qtv94h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Erik Faye-Lund <kusmabite@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, John Szakmeister <john@szakmeister.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 26 20:25:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5hWY-0005h1-SE
	for gcvg-git-2@plane.gmane.org; Sun, 26 Aug 2012 20:25:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754815Ab2HZSZO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Aug 2012 14:25:14 -0400
Received: from mail.sorgh.de ([88.198.99.83]:57056 "EHLO mail.sorgh.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754629Ab2HZSZM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Aug 2012 14:25:12 -0400
X-Greylist: delayed 502 seconds by postgrey-1.27 at vger.kernel.org; Sun, 26 Aug 2012 14:25:11 EDT
Received: from [172.16.42.5] (g230082099.adsl.alicedsl.de [92.230.82.99])
	by mail.sorgh.de (Postfix) with ESMTPSA id 959CE2009E;
	Sun, 26 Aug 2012 20:18:23 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.6esrpre) Gecko/20120817 Icedove/10.0.6
In-Reply-To: <7vr4qtv94h.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204304>

n 26/08/12 19:46, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Jeff King <peff@peff.net> writes:
>>
>>> However, the shared bits are simple enough that maybe that is not a
>>> concern. An interesting test would be to add a 5/4 porting Erik's win32
>>> credential helper, since that is the platform least like our other ones.
>>
>> Very true.

In principle, I agree that with the current set of helper
implementations, the generic infrastructure may not yet pay off.

>>> So I am OK with this series, but I am also OK with leaving it at patch
>>> 1, and just keeping the implementations separate.
>>
>> Amen.
> 
> Just to make sure we do not leave loose ends, could somebody try to
> see if the new "generic helper" infrastructure is useful to shrink
> Erik's win32 credential helper implementation?

I'll try to give it a shot now, although I won't be able to test it.
I'll send the results as a single 5/4 addition to the previous series.

> If we see much code reduction and improved clarity, this refactoring
> may worth keeping.  Otherwise it may be sufficient to drop the later
> ones in the series.  Without knowing which, it is hard to decide.

If we decide that the generic implementation is useful, I'll then resend
the reordered series adding the generic helper first, then refactoring
the existing ones and adding the new one for GnomeKeyring last.

Thanks,
  Philipp
