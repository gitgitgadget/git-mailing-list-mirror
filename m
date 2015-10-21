From: Johan Laenen <johan.laenen+cygwin@gmail.com>
Subject: Re: Commit 5841520b makes it impossible to connect to github from behind my company's firewall.
Date: Wed, 21 Oct 2015 07:19:40 +0000 (UTC)
Message-ID: <loom.20151021T091641-32@post.gmane.org>
References: <loom.20151020T131513-529@post.gmane.org> <vpq37x54vav.fsf@grenoble-inp.fr> <cbf2c2c2c137445ebb9e2c5f1012cb10@EXMBNJE8.ad.twosigma.com> <xmqqr3kp8qqe.fsf@gitster.mtv.corp.google.com> <33632f538b4a406fb8f0e1eb2b016c43@EXMBNJE8.ad.twosigma.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 21 09:20:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZonhU-0005VN-Gk
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 09:20:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093AbbJUHUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2015 03:20:09 -0400
Received: from plane.gmane.org ([80.91.229.3]:36644 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751860AbbJUHUI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2015 03:20:08 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Zongm-0004wE-A0
	for git@vger.kernel.org; Wed, 21 Oct 2015 09:20:00 +0200
Received: from 193.191.180.236 ([193.191.180.236])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Oct 2015 09:20:00 +0200
Received: from johan.laenen+cygwin by 193.191.180.236 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Oct 2015 09:20:00 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 193.191.180.236 (Mozilla/5.0 (Windows NT 6.1; rv:41.0) Gecko/20100101 Firefox/41.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279972>

Enrique Tobis <Enrique.Tobis <at> twosigma.com> writes:

> There is something I don't understand, though. Johan must be configuring
his proxy either a) through git
> config files; or b) through environment variables. Johan says his proxy
uses NTLM authentication. If he
> is doing a), then my change should not have had any impact. We were
already setting CURLOPT_PROXYAUTH to
> CURLAUTH_ANY in that case. If it's b), then his proxy couldn't have been
using NTLM authentication. In the
> old code path, only _BASIC was available as an authentication mechanism.
That default is what prompted me
> to make the change in the first place.

Interesting!

I tried both git versions, the one with the revert of commit 5841520b and
the one without and both gave me the fatal error "Unknown SSL protocol error
in connection to github.com:443" when using the ~/.gitconfig [https] and
[http] proxy settings instead of using the https_proxy environment variable.

Greetings,

Johan
