From: Johannes Gilger <heipei@hackvalue.de>
Subject: Re: why is git destructive by default? (i suggest it not be!)
Date: Tue, 24 Jun 2008 14:35:27 +0200
Message-ID: <20080624123527.GA6149@dualtron.vpn.rwth-aachen.de>
References: <200806241322.14224.jnareb@gmail.com> <28156.2147582465$1214307807@news.gmane.org> <4860E63B.6040709@dawes.za.net>
Reply-To: Johannes Gilger <heipei@hackvalue.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: David Jeske <jeske@google.com>, Jakub Narebski <jnareb@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Rogan Dawes <lists@dawes.za.net>
X-From: git-owner@vger.kernel.org Tue Jun 24 14:37:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB7l8-0000MQ-4q
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 14:36:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064AbYFXMfg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 08:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbYFXMfg
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 08:35:36 -0400
Received: from avalon.gnuzifer.de ([85.10.199.84]:48914 "EHLO
	avalon.gnuzifer.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446AbYFXMff (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 08:35:35 -0400
Received: from u-6-107.vpn.rwth-aachen.de ([137.226.102.107]:34776 helo=localhost)
	by avalon.gnuzifer.de with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <heipei@hackvalue.de>)
	id 1KB7k8-0003y4-4I; Tue, 24 Jun 2008 14:35:28 +0200
Content-Disposition: inline
In-Reply-To: <4860E63B.6040709@dawes.za.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-SA-Exim-Connect-IP: 137.226.102.107
X-SA-Exim-Mail-From: heipei@hackvalue.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86047>

On 24/06/08 14:19, Rogan Dawes wrote:
> One thing that I haven't seen addressed in this thread is the fact that if 
> you have a dirty working directory, and you "git reset --hard", whatever 
> was dirty (not yet in the index, or committed) will be blown away, and no 
> amount of reflog archeology will help you get it back.

I think the name of the command "reset" itself is a name which should 
prompt everyone to read a manpage before using it. I could understand 
that if "status" did something destructive people would get upset.
Other than that, git reset itself doesn't do anything destructive. Yeah, 
git reset --hard does, but hello, this is *reset* and *hard*, someone 
using this must really want what's about to happen. Nobody complaines 
about rm --force or anything.

As for putting safety-measure everywhere, I think that any further 
restricting of commands would be nonsense and just hindering the 
workflow. git is not something with a GUI and a recycle-bin. And it 
still is really hard to accidentaly lose anything in git.

Regards,
Jojo

-- 
Johannes Gilger <heipei@hackvalue.de>
http://hackvalue.de/heipei/
GPG-Key: 0x42F6DE81
GPG-Fingerprint: BB49 F967 775E BB52 3A81  882C 58EE B178 42F6 DE81
