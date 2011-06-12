From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Command-line interface thoughts
Date: Sun, 12 Jun 2011 08:06:33 +0200
Message-ID: <4DF45769.4020403@alum.mit.edu>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com> <m339jps1wt.fsf@localhost.localdomain> <BANLkTinidLbQ_FcVEiGSK91uXYWaKk7MKA@mail.gmail.com> <201106051311.00951.jnareb@gmail.com> <BANLkTik+xhd5QQ09QiPSH1bFAndzipKtrw@mail.gmail.com> <7vwrgza3i2.fsf@alter.siamese.dyndns.org> <4DF08D30.7070603@alum.mit.edu> <20110609161832.GB25885@sigill.intra.peff.net> <4DF10ADA.5070206@alum.mit.edu> <7v8vtayhnm.fsf@alter.siamese.dyndns.org> <20110609200403.GA3955@sigill.intra.peff.net> <7v4o3xwe5z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Scott Chacon <schacon@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 12 08:06:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QVdp3-0006Ra-Tz
	for gcvg-git-2@lo.gmane.org; Sun, 12 Jun 2011 08:06:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432Ab1FLGGw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jun 2011 02:06:52 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:43593 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710Ab1FLGGw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2011 02:06:52 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.134] (p54BEC62C.dip.t-dialin.net [84.190.198.44])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p5C66Z4D030039
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 12 Jun 2011 08:06:35 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.17) Gecko/20110424 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <7v4o3xwe5z.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175651>

On 06/10/2011 11:48 PM, Junio C Hamano wrote:
> In short, the proposed "NEXT" does not help in a situation with conflicts,
> and makes the user experience worse.

The idea of "NEXT" and its friends would indeed be marginal if it only
applied to "git diff".  The real gain in learnability comes from using
the same idioms in other commands where they make sense; for example,

    # More consistent alternative to the special "--ours" option:
    git checkout OURS -- Makefile

    # This would add more completeness to the
    # "git checkout <tree-ish> -- PATH" command, and would remain the
    # default if no <tree-ish> is specified:
    git checkout NEXT -- Makefile

    # I had to look up the current way to spell this
    # ("git show :Makefile"), but this variant would be obvious
    # by analogy with the other uses of NEXT:
    git show NEXT:Makefile

and of course also in the proposed "git put" command.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
