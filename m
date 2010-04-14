From: Johannes Gilger <heipei@hackvalue.de>
Subject: Re: git log of remote repositories.
Date: Wed, 14 Apr 2010 11:33:02 +0000 (UTC)
Message-ID: <slrnhsba0k.h9q.heipei@dualtron.heipei.net>
References: <u2n3abd05a91004131625k500e79bbsc8ffa6455a85332d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 14 13:33:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O20qZ-0001C8-7U
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 13:33:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754961Ab0DNLdW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 07:33:22 -0400
Received: from lo.gmane.org ([80.91.229.12]:45834 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754967Ab0DNLdV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 07:33:21 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1O20qL-00013w-Cy
	for git@vger.kernel.org; Wed, 14 Apr 2010 13:33:17 +0200
Received: from u-7-245.vpn.rwth-aachen.de ([137.226.103.245])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Apr 2010 13:33:17 +0200
Received: from heipei by u-7-245.vpn.rwth-aachen.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Apr 2010 13:33:17 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: u-7-245.vpn.rwth-aachen.de
User-Agent: slrn/0.9.9p1 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144865>

On 2010-04-13, Aghiles <aghilesk@gmail.com> wrote:
> I have a local branch that is a tracking a remote branch. I want to see
> what are the modifications upstream, _before_ I pull. I tried
> 'git log origin' but that's only the point from where I pulled last.
>
> Is there a way to do that?
AFAIK no, the operations have to be local.

In order to see if there are any new changes to be pulled you could do
this: git fetch --dry-run

Greetings,
Jojo

-- 
Johannes Gilger <heipei@hackvalue.de>
http://heipei.net
GPG-Key: 0xD47A7FFC
GPG-Fingerprint: 5441 D425 6D4A BD33 B580  618C 3CDC C4D0 D47A 7FFC
