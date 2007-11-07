From: Johannes Gilger <heipei@hackvalue.de>
Subject: Re: git push refspec problem
Date: Wed, 07 Nov 2007 16:22:58 +0100
Message-ID: <4731D852.2080500@hackvalue.de>
References: <7B37E361-9606-447C-B853-001182688AFA@nc.rr.com> <Pine.LNX.4.64.0711071510480.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: James <jtp@nc.rr.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 07 16:23:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpmkP-0000VS-JH
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 16:23:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753554AbXKGPWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 10:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754682AbXKGPWo
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 10:22:44 -0500
Received: from avalon.gnuzifer.de ([85.10.199.84]:35648 "EHLO
	avalon.gnuzifer.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753554AbXKGPWn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 10:22:43 -0500
Received: from 6-142.vpn.rwth-aachen.de ([134.130.246.142]:59905)
	by avalon.gnuzifer.de with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <heipei@hackvalue.de>)
	id 1Ipmjo-0004bc-3w; Wed, 07 Nov 2007 16:22:40 +0100
User-Agent: Thunderbird 2.0.0.6 (X11/20070803)
In-Reply-To: <Pine.LNX.4.64.0711071510480.4362@racer.site>
X-Enigmail-Version: 0.95.2
OpenPGP: id=42F6DE81;
	url=http://pgpkeys.pca.dfn.de/pks/lookup?op=get&search=0x58EEB17842F6DE81
X-SA-Exim-Connect-IP: 134.130.246.142
X-SA-Exim-Mail-From: heipei@hackvalue.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63822>

Johannes Schindelin wrote:
> Hi,
> 
> On Wed, 7 Nov 2007, James wrote:
> 
>>        fetch = +refs/heads/*:refs/remotes/origin/*
> 
> This is a refspec.
> 
>>        push = ssh://james@my.server.com/home/james/scm/git/project.git/
> 
> This is a URL.  It does not specify any refs.  But "push =" expects a URL.

I think Johannes meant to say "But 'push =' expects a refspec." (the
manpage even says so).

About your problem: If you want to pull from a git:// repository and
push to another with ssh:// (or in general when having two different
repositories for pushing and fetching) in my novice understanding
you would need two remotes. In your case, can't you just use your
ssh-url for fetching as well?

Regards,
Jojo

-- 
Johannes Gilger <heipei@hackvalue.de>
http://hackvalue.de/heipei/
GPG-Key: 0x42F6DE81
GPG-Fingerprint: BB49 F967 775E BB52 3A81  882C 58EE B178 42F6 DE81
