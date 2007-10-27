From: Johannes Gilger <heipei@hackvalue.de>
Subject: Re: [POSSIBLE BUG] 'git log' option --no-color adds bogus empty line
Date: Sat, 27 Oct 2007 11:36:58 +0200
Message-ID: <472306BA.5060409@hackvalue.de>
References: <e5bfff550710270210g6d363b40of597c3160124fb85@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Marco Costalba <mcostalba@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 27 11:38:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ili7k-0003AF-7M
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 11:38:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752073AbXJ0JiU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2007 05:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751982AbXJ0JiU
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Oct 2007 05:38:20 -0400
Received: from avalon.gnuzifer.de ([85.10.199.84]:46406 "EHLO
	avalon.gnuzifer.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751955AbXJ0JiT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2007 05:38:19 -0400
Received: from 0-104.vpn.rwth-aachen.de ([134.130.240.104]:33796)
	by avalon.gnuzifer.de with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <heipei@hackvalue.de>)
	id 1Ili7U-0007J1-JA; Sat, 27 Oct 2007 11:38:16 +0200
User-Agent: Thunderbird 2.0.0.6 (X11/20070803)
In-Reply-To: <e5bfff550710270210g6d363b40of597c3160124fb85@mail.gmail.com>
X-Enigmail-Version: 0.95.2
OpenPGP: id=42F6DE81;
	url=http://pgpkeys.pca.dfn.de/pks/lookup?op=get&search=0x58EEB17842F6DE81
X-SA-Exim-Connect-IP: 134.130.240.104
X-SA-Exim-Mail-From: heipei@hackvalue.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62481>

Marco Costalba wrote:
> Form git tree:
> 
> $ git log -n 1 8d863c98b2f9b0d37 | wc
>       7      28     246
> 
> $ git log --no-color -n 1 8d863c98b2f9b0d37 | wc
>       8      28     247
> 
> $ git --version
> git version 1.5.3.2.124.g648db

Hi,

using git version 1.5.3.4.383.gd90a7 i can't confirm this, the two
outputs are of the same length here.

Regards,
Johannes

-- 
Johannes Gilger <heipei@hackvalue.de>
http://hackvalue.de/heipei/
GPG-Key: 0x42F6DE81
GPG-Fingerprint: BB49 F967 775E BB52 3A81  882C 58EE B178 42F6 DE81
