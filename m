From: Thomas Singer <thomas.singer@syntevo.com>
Subject: Re: Has anyone looked at Gettext support for Git itself?
Date: Sun, 16 May 2010 18:53:12 +0200
Message-ID: <4BF022F8.6080805@syntevo.com>
References: <AANLkTinlDF-aKDjwvgZEqtUgzW7MCIuElQ_RfJn_RkZp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 16 18:58:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODhB0-0000Kv-Ts
	for gcvg-git-2@lo.gmane.org; Sun, 16 May 2010 18:58:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753668Ab0EPQ6u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 May 2010 12:58:50 -0400
Received: from syntevo.com ([85.214.39.145]:46896 "EHLO syntevo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753394Ab0EPQ6t (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 May 2010 12:58:49 -0400
X-Greylist: delayed 376 seconds by postgrey-1.27 at vger.kernel.org; Sun, 16 May 2010 12:58:49 EDT
Received: from [127.0.0.1] (localhost [127.0.0.1]) with ESMTPSA id 4FE8C608016
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <AANLkTinlDF-aKDjwvgZEqtUgzW7MCIuElQ_RfJn_RkZp@mail.gmail.com>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147194>

> Have there
> been any discussions of adding internationalization support to Git
> itself? I.e. the interface messages that the core Git utilities emit.

>From me perspective of a developer who is invoking the Git executable from
our application: ensure that there is a way to tell Git to output text in a
fixed language, so other applications (e.g. ours) can parse the output.(1)

-- 
Best regards,
Thomas Singer
=============
syntevo GmbH
http://www.syntevo.com
http://blog.syntevo.com

(1) Yes, I know that this is not 100% safe, because messages can be
different in different Git version.
