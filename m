From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: cannot fetch arm git tree
Date: Mon, 24 Jan 2011 08:21:09 +0100
Message-ID: <4D3D2865.4020408@viscovery.net>
References: <AANLkTikRrewCLGDTU7DjVssjpxz-EFK8AhRScAGPRumg@mail.gmail.com> <20110116092315.GA27542@n2100.arm.linux.org.uk> <20110116110819.GG6917@pengutronix.de> <AANLkTinrZ0GnT71GCueUUpAXM5ckq+LBd0RjA51DMR-a@mail.gmail.com> <20110116134248.GD27542@n2100.arm.linux.org.uk> <4D398C43.1000306@vollmann.ch> <20110121134728.GO14956@pengutronix.de> <20110121135725.GR13235@n2100.arm.linux.org.uk> <4D3997FE.5030109@vollmann.ch> <20110121145025.GS13235@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Detlef Vollmann <dv@vollmann.ch>,
	=?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
	<u.kleine-koenig@pengutronix.de>,
	Jello huang <ruifeihuang@gmail.com>, git@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
X-From: git-owner@vger.kernel.org Mon Jan 24 08:21:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PhGjr-0000ZF-0Q
	for gcvg-git-2@lo.gmane.org; Mon, 24 Jan 2011 08:21:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761Ab1AXHVP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jan 2011 02:21:15 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:43654 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751580Ab1AXHVP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jan 2011 02:21:15 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PhGjf-0003tI-Uz; Mon, 24 Jan 2011 08:21:12 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 93B5C1660F;
	Mon, 24 Jan 2011 08:21:11 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <20110121145025.GS13235@n2100.arm.linux.org.uk>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165437>

Am 1/21/2011 15:50, schrieb Russell King - ARM Linux:
>  SetEnv GIT_PROJECT_ROOT /var/www/git
>  SetEnv GIT_HTTP_EXPORT_ALL
>  ScriptAlias /git/ /usr/libexec/git-core/git-http-backend/
> 
> Great.  Deciding that it will be http://servername.example.com/git/ is
> really damned annoying as that's traditionally where gitweb lives,
> which requires a different script alias.
> ...
> I'm really not interested in working out how to bodge this into working
> along side the existing gitweb setup by adding lots of rewrite rules,...

It has been worked out for you already. It's just a single rule (although
a bit longish). Look for 'ScriptAliasMatch' in
http://www.kernel.org/pub/software/scm/git/docs/git-http-backend.html

-- Hannes
