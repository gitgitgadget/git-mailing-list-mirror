From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH/RFC] config: Add --null/-z option for null-delimted output
Date: Tue, 19 Jun 2007 19:26:19 +0200
Message-ID: <20070619172619.GH19725@planck.djpig.de>
References: <f2t6na$5bi$1@sea.gmane.org> <11821227322913-git-send-email-frank@lichtenheld.de> <Pine.LNX.4.64.0706190151160.4059@racer.site> <7v645kyba8.fsf@assigned-by-dhcp.pobox.com> <20070619021252.GE19725@planck.djpig.de> <Pine.LNX.4.64.0706191208300.4059@racer.site> <20070619152139.GF19725@planck.djpig.de> <Pine.LNX.4.64.0706191655490.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 19 19:26:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0hTL-0005Sv-5n
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 19:26:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757678AbXFSR03 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 13:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757108AbXFSR03
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 13:26:29 -0400
Received: from planck.djpig.de ([85.10.192.180]:1936 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752791AbXFSR03 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 13:26:29 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id C899E88102;
	Tue, 19 Jun 2007 19:26:26 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5xHonJNkp8a8; Tue, 19 Jun 2007 19:26:20 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id BC86A88105; Tue, 19 Jun 2007 19:26:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0706191655490.4059@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50498>

On Tue, Jun 19, 2007 at 04:57:21PM +0100, Johannes Schindelin wrote:
> [foo "bar\nbaz"]
> 	key = value
> gives
> 
> foo.barbaz.key=value

for me this gives

foo.barnbaz.key=value

which is the intended behaviour AFAICT
(you mean the actual string '\' 'n' here, right? '\n' gives a syntax
error, also the intended behaviour)

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
