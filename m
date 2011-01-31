From: Sam Vilain <sam@vilain.net>
Subject: Re: [RFC] fast-import: notemodify (N) command
Date: Tue, 01 Feb 2011 11:37:41 +1300
Message-ID: <4D4739B5.6080103@vilain.net>
References: <1255083738-23263-1-git-send-email-johan@herland.net> <1255083738-23263-8-git-send-email-johan@herland.net> <20110131183350.GB31826@burratino> <AANLkTi=3P0xc3mJj5Tsg_P26SAXmgVfCk1VeYQ=k2UtT@mail.gmail.com> <20110131190128.GC32374@burratino> <AANLkTikxFSa1CSujk2zgh4K8SWCuKHRrDRFVNt9JPGo0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	vcs-fast-import-devs@lists.launchpad.net, git@drmicha.warpmail.net,
	chriscool@tuxfamily.org, Johannes.Schindelin@gmx.de,
	trast@student.ethz.ch, Johan Herland <johan@herland.net>,
	gitster@pobox.com, git@vger.kernel.org,
	Augie Fackler <durin42@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 31 23:37:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pk2Ne-0005Fb-PE
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 23:37:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756537Ab1AaWhu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Jan 2011 17:37:50 -0500
Received: from mx3.orcon.net.nz ([219.88.242.53]:50610 "EHLO mx3.orcon.net.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756354Ab1AaWht (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jan 2011 17:37:49 -0500
Received: from Debian-exim by mx3.orcon.net.nz with local (Exim 4.69)
	(envelope-from <sam@vilain.net>)
	id 1Pk2NX-0004Id-RR
	for git@vger.kernel.org; Tue, 01 Feb 2011 11:37:47 +1300
Received: from [60.234.254.246] (helo=mail.utsl.gen.nz)
	by mx3.orcon.net.nz with esmtp (Exim 4.69)
	(envelope-from <sam@vilain.net>)
	id 1Pk2NX-0004IS-Jk
	for git@vger.kernel.org; Tue, 01 Feb 2011 11:37:47 +1300
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 7D6EC2E023; Tue,  1 Feb 2011 11:37:47 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on naos.lan
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=unavailable version=3.3.1
Received: from [192.168.1.54] (arcturus.lan [192.168.1.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 0BC322E021;
	Tue,  1 Feb 2011 11:37:42 +1300 (NZDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <AANLkTikxFSa1CSujk2zgh4K8SWCuKHRrDRFVNt9JPGo0@mail.gmail.com>
X-Enigmail-Version: 1.1.2
X-DSPAM-Check: by mx3.orcon.net.nz on Tue, 01 Feb 2011 11:37:47 +1300
X-DSPAM-Result: Innocent
X-DSPAM-Processed: Tue Feb  1 11:37:47 2011
X-DSPAM-Confidence: 0.5564
X-DSPAM-Probability: 0.0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165769>

On 01/02/11 10:19, Sverre Rabbelier wrote:
> That's another thing Augie mentioned that he (and I guess the hg
> community at large) dislikes, the fact that they're not propagated.

This is not a "fact".

If you add configuration in your git config to fetch and push the refs,
then they are propagated.

Just because you disagree with the current interface or defaults doesn't
mean the design is wrong.  I hear the same arguments against submodules,
which is a shame because the message isn't getting through to people
that the porcelain can and should be extended to make people's lives
easier.  It's just that instead of second-guessing what shape they
should take, the design and plumbing are written so that people can
write scripts to make it work.

It's a slower path, but you end up with a better tool at the end of it.

Sam
