From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/2] Add possibility to store configuration in ~/.config/git/config file
Date: Sat, 26 May 2012 10:53:27 +0200
Message-ID: <vpq62bjnx14.fsf@bauges.imag.fr>
References: <1337975239-17169-1-git-send-email-nguyenhu@ensibm.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	NGUYEN Huynh Khoi Nguyen <nguyenhu@ensibm.imag.fr>
To: NGUYEN Huynh Khoi Nguyen <nguyenhu@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Sat May 26 10:53:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYCl5-0008Io-1L
	for gcvg-git-2@plane.gmane.org; Sat, 26 May 2012 10:53:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752034Ab2EZIxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 May 2012 04:53:33 -0400
Received: from mx1.imag.fr ([129.88.30.5]:55829 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751904Ab2EZIxc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2012 04:53:32 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q4Q8jNKF008450
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 26 May 2012 10:45:23 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SYCka-0003rW-Km; Sat, 26 May 2012 10:53:28 +0200
In-Reply-To: <1337975239-17169-1-git-send-email-nguyenhu@ensibm.imag.fr>
	(NGUYEN Huynh Khoi Nguyen's message of "Fri, 25 May 2012 21:47:18
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sat, 26 May 2012 10:45:24 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q4Q8jNKF008450
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1338626725.07017@qDP2S9LsNbgvvTP8RhCXNw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198543>

NGUYEN Huynh Khoi Nguyen <nguyenhu@ensimag.imag.fr> writes:

> +			sprintf(config_path, "%s/.config/git/config", home);

It's not terribly important, but if we are to use something that looks
like XDG, I'd rather have a real support for it. ~/.config/ is the
default, but the spec
http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
also define $XDG_CONFIG_HOME that may override the default and we may
want to support $XDG_CONFIG_DIRS too.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
