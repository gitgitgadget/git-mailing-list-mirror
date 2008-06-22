From: Johannes Gilger <heipei@hackvalue.de>
Subject: Re: about c8af1de9 (git status uses pager)
Date: Sun, 22 Jun 2008 09:24:20 +0200
Message-ID: <20080622072420.GA5161@dualtron.vpn.rwth-aachen.de>
References: <alpine.LNX.1.10.0806212319410.22036@fbirervta.pbzchgretzou.qr> <20080621214241.GA3839@dualtron.vpn.rwth-aachen.de>
Reply-To: Johannes Gilger <heipei@hackvalue.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 22 09:25:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAJww-0003ay-5y
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 09:25:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbYFVHYY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 03:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbYFVHYY
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 03:24:24 -0400
Received: from avalon.gnuzifer.de ([85.10.199.84]:36494 "EHLO
	avalon.gnuzifer.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913AbYFVHYX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 03:24:23 -0400
Received: from u-5-028.vpn.rwth-aachen.de ([137.226.101.28]:42065 helo=localhost)
	by avalon.gnuzifer.de with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <heipei@hackvalue.de>)
	id 1KAJvx-0005Jx-Tf
	for git@vger.kernel.org; Sun, 22 Jun 2008 09:24:22 +0200
Content-Disposition: inline
In-Reply-To: <20080621214241.GA3839@dualtron.vpn.rwth-aachen.de>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-SA-Exim-Connect-IP: 137.226.101.28
X-SA-Exim-Mail-From: heipei@hackvalue.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85750>

On 21/06/08 23:42, Johannes Gilger wrote:
> Wow, I just noticed it myself. Why was that changed? I don't know about 
> your status lines, but I for one find it really annoying. Anything 
> that's in a pager isn't visible in my console afterwards. What's next? 
> git branch in a pager too?

Seems like I got ahead of myself there. After setting the core.pager to 
less -FRSX everything works fine ;)

Regards,
Jojo
-- 
Johannes Gilger <heipei@hackvalue.de>
http://hackvalue.de/heipei/
GPG-Key: 0x42F6DE81
GPG-Fingerprint: BB49 F967 775E BB52 3A81  882C 58EE B178 42F6 DE81
