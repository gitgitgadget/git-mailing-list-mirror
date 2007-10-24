From: Johannes Gilger <heipei@hackvalue.de>
Subject: Re: UI and git-completion.sh
Date: Wed, 24 Oct 2007 19:34:57 +0200
Message-ID: <471F8241.50308@hackvalue.de>
References: <20071023234617.45a4fc64@paolo-desktop>	<471E6EF0.2060403@midwinter.com> <86ve8x9z1f.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 24 20:13:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ikkj8-0006jh-82
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 20:13:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756155AbXJXSMr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 14:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756352AbXJXSMr
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 14:12:47 -0400
Received: from avalon.gnuzifer.de ([85.10.199.84]:60657 "EHLO
	avalon.gnuzifer.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755767AbXJXSMq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 14:12:46 -0400
X-Greylist: delayed 2192 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Oct 2007 14:12:45 EDT
Received: from 0-186.vpn.rwth-aachen.de ([134.130.240.186]:34191)
	by avalon.gnuzifer.de with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <heipei@hackvalue.de>)
	id 1Ikk9L-0000tl-Qj
	for git@vger.kernel.org; Wed, 24 Oct 2007 19:36:12 +0200
User-Agent: Thunderbird 2.0.0.6 (X11/20070803)
In-Reply-To: <86ve8x9z1f.fsf@blue.stonehenge.com>
X-Enigmail-Version: 0.95.2
OpenPGP: id=42F6DE81;
	url=http://pgpkeys.pca.dfn.de/pks/lookup?op=get&search=0x58EEB17842F6DE81
X-SA-Exim-Connect-IP: 134.130.240.186
X-SA-Exim-Mail-From: heipei@hackvalue.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62224>

Randal L. Schwartz wrote:
> Where is it?  I'm a zsh user, and would love to have git support.
> 

Another way to get git-completion support with zsh (works with 4.3.2) is to use 
the existing bash-completion and enable bash-completion for zsh via:
autoload bashcompinit
bashcompinit
in your .zshrc or similar. Btw, if you use gentoo you can install git with bash-completion, 
although i suppose that most people here are not using emerge to get their git ;).

Greetings,
Johannes

-- 
Johannes Gilger <heipei@hackvalue.de>
http://hackvalue.de/heipei/
GPG-Key: 0x42F6DE81
GPG-Fingerprint: BB49 F967 775E BB52 3A81  882C 58EE B178 42F6 DE81
