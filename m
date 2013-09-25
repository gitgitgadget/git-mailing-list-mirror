From: Stefan =?utf-8?b?TsOkd2U=?= <stefan.naewe@gmail.com>
Subject: Re: [Bug] git show crashes with deepened shallow clone
Date: Wed, 25 Sep 2013 18:08:31 +0000 (UTC)
Message-ID: <loom.20130925T200459-360@post.gmane.org>
References: <5242F78C.5060607@atlas-elektronik.com> <524300FF.5000801@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 25 20:09:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOtWD-000343-PO
	for gcvg-git-2@plane.gmane.org; Wed, 25 Sep 2013 20:08:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515Ab3IYSIx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Sep 2013 14:08:53 -0400
Received: from plane.gmane.org ([80.91.229.3]:34377 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750783Ab3IYSIx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Sep 2013 14:08:53 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1VOtW6-0002v8-2N
	for git@vger.kernel.org; Wed, 25 Sep 2013 20:08:50 +0200
Received: from dslb-088-071-039-164.pools.arcor-ip.net ([88.71.39.164])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 Sep 2013 20:08:50 +0200
Received: from stefan.naewe by dslb-088-071-039-164.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 Sep 2013 20:08:50 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 88.71.39.164 (Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.57 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235361>

Stefan N=C3=A4we <stefan.naewe <at> atlas-elektronik.com> writes:

> Am 25.09.2013 16:47, schrieb Stefan N=C3=A4we:
> This is what it gives me if I use my script (slightly modified=20
> to also run make) with 'git bisect run':
>=20
> 6035d6aad8ca11954c0d7821f6f3e7c047039c8f is the first bad commit

And to answer myself once more:

That's fixed in

   6da8bdc fetch-pack: do not remove .git/shallow file when --depth is =
not specified"

Sorry for all the noise.

Stefan
