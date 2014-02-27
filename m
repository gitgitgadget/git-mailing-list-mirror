From: Stephen Leake <stephen_leake@stephe-leake.org>
Subject: Re: `git stash pop` UX Problem
Date: Thu, 27 Feb 2014 07:22:12 -0600
Message-ID: <85mwhc3d2z.fsf@stephe-leake.org>
References: <530B0395.5030407@booking.com>
	<CANUGeEbPrPp8Sa-KEKSxNDWJShdkDBTkQyXv7tDJ6ReH6MXrHw@mail.gmail.com>
	<vpqlhx0a3cb.fsf@anie.imag.fr> <20140226003938.GA6809@ruderich.org>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 27 14:22:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJ0uq-0001Zj-Gu
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 14:22:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752344AbaB0NWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 08:22:16 -0500
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.227]:27570 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751068AbaB0NWQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Feb 2014 08:22:16 -0500
Received: from [75.87.81.6] ([75.87.81.6:52627] helo=TAKVER)
	by cdptpa-oedge03 (envelope-from <stephen_leake@stephe-leake.org>)
	(ecelerity 3.5.0.35861 r(Momo-dev:tip)) with ESMTP
	id 3A/0B-02678-60C3F035; Thu, 27 Feb 2014 13:22:15 +0000
In-Reply-To: <20140226003938.GA6809@ruderich.org> (Simon Ruderich's message of
	"Wed, 26 Feb 2014 01:39:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (windows-nt)
X-RR-Connecting-IP: 107.14.168.142:25
X-Cloudmark-Score: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242821>

Simon Ruderich <simon@ruderich.org> writes:

> On Mon, Feb 24, 2014 at 05:21:40PM +0100, Matthieu Moy wrote:
>> One easy thing to do OTOH would be to show a hint at the end of "git
>> stash pop"'s output, like
>
> I think that's a good idea. It makes it obvious that Git has kept
> the stash and that the user should drop it when he's done - if he
> wants to.

+1

This does not mean I don't _also_ think 'git add' dropping the stash
when the last conflict is resolved is a good idea. If that is
implemented, 'stash pop' might have to mention that effect as well; that
does make things more complicated.

-- 
-- Stephe
