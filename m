From: Johannes Gilger <heipei@hackvalue.de>
Subject: Re: [PATCH] cmd_reset: don't trash uncommitted changes unless told
	to
Date: Wed, 25 Jun 2008 07:29:29 +0200
Message-ID: <20080625052929.GA23079@dualtron.vpn.rwth-aachen.de>
References: <20080624222105.GA24549@dervierte> <1214346098-24584-1-git-send-email-stevenrwalter@gmail.com>
Reply-To: Johannes Gilger <heipei@hackvalue.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 25 07:30:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBNaN-0004nv-J1
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 07:30:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753365AbYFYF3b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 01:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753294AbYFYF3b
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 01:29:31 -0400
Received: from avalon.gnuzifer.de ([85.10.199.84]:37924 "EHLO
	avalon.gnuzifer.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752589AbYFYF3a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 01:29:30 -0400
Received: from u-7-083.vpn.rwth-aachen.de ([137.226.103.83]:53788 helo=localhost)
	by avalon.gnuzifer.de with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <heipei@hackvalue.de>)
	id 1KBNZR-0004gd-8K
	for git@vger.kernel.org; Wed, 25 Jun 2008 07:29:29 +0200
Content-Disposition: inline
In-Reply-To: <1214346098-24584-1-git-send-email-stevenrwalter@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-SA-Exim-Connect-IP: 137.226.103.83
X-SA-Exim-Mail-From: heipei@hackvalue.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86230>

On 24/06/08 18:21, Steven Walter wrote:
> Give "reset --hard" a -f (force) flag, without which it will refuse to
> proceed if there are changes in the index or working tree.

Oh no. I can only agree and repeat myself, as I think this is nonsense. 
git is a tool, and like every tool you can hurt yourself with it if you 
don't read the manual and follow really simple guidelines. I used git 
reset --hard on a test-repo before using it on my real code, and it has 
never bit me since. Why do we have --hard then? It would be "An option 
which does nothing unless you also specify -f on the command-line".

Just my opinion, but I think quite a few people feel the same
Regards,
Jojo

-- 
Johannes Gilger <heipei@hackvalue.de>
http://hackvalue.de/heipei/
GPG-Key: 0x42F6DE81
GPG-Fingerprint: BB49 F967 775E BB52 3A81  882C 58EE B178 42F6 DE81
