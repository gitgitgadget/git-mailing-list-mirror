From: Johannes Gilger <heipei@hackvalue.de>
Subject: Re: about c8af1de9 (git status uses pager)
Date: Sat, 21 Jun 2008 23:42:41 +0200
Message-ID: <20080621214241.GA3839@dualtron.vpn.rwth-aachen.de>
References: <alpine.LNX.1.10.0806212319410.22036@fbirervta.pbzchgretzou.qr>
Reply-To: Johannes Gilger <heipei@hackvalue.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 22 00:29:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KABa3-0007K8-JA
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 00:29:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbYFUW2Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jun 2008 18:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbYFUW2Q
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jun 2008 18:28:16 -0400
Received: from avalon.gnuzifer.de ([85.10.199.84]:46351 "EHLO
	avalon.gnuzifer.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142AbYFUW2P (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jun 2008 18:28:15 -0400
X-Greylist: delayed 2730 seconds by postgrey-1.27 at vger.kernel.org; Sat, 21 Jun 2008 18:28:15 EDT
Received: from u-5-074.vpn.rwth-aachen.de ([137.226.101.74]:40886 helo=localhost)
	by avalon.gnuzifer.de with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <heipei@hackvalue.de>)
	id 1KAAr5-0003j5-Hz
	for git@vger.kernel.org; Sat, 21 Jun 2008 23:42:43 +0200
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.10.0806212319410.22036@fbirervta.pbzchgretzou.qr>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-SA-Exim-Connect-IP: 137.226.101.74
X-SA-Exim-Mail-From: heipei@hackvalue.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85734>

On 21/06/08 23:21, Jan Engelhardt wrote:
> 
> Since git 1.5.6, `git status` always invokes a pager, which is really 
> annoying when the output is less than the number of terminal rows 
> available. Can I turn that off somehow or do I need to send a reverting 
> patch?
> 

Wow, I just noticed it myself. Why was that changed? I don't know about 
your status lines, but I for one find it really annoying. Anything 
that's in a pager isn't visible in my console afterwards. What's next? 
git branch in a pager too?

Regards,
Jojo

-- 
Johannes Gilger <heipei@hackvalue.de>
http://hackvalue.de/heipei/
GPG-Key: 0x42F6DE81
GPG-Fingerprint: BB49 F967 775E BB52 3A81  882C 58EE B178 42F6 DE81
