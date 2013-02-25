From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] Fix msvc build
Date: Sun, 24 Feb 2013 22:54:55 -0800
Message-ID: <7vehg4288w.fsf@alter.siamese.dyndns.org>
References: <510AB766.4030806@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 25 07:55:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9ryE-0003p0-SX
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 07:55:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756682Ab3BYGzE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 01:55:04 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39164 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756283Ab3BYGzD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 01:55:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 97BF29987;
	Mon, 25 Feb 2013 01:55:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=o548YKaLk7XVaoCd4YTpSTk4Sas=; b=ZyvJhX0xXECfr7jiay9K
	kHbreVTKuBgZ9LBCIAvjtffBeteo1+j79cTGusrhOdtAYwpjlIeTsZAoCZmejJti
	/UMzcRVjOMBb5F1tUrZFNXyWT3IQOXuO24J0wqeZH8Qfb2D5JxZ0PyZ2euY6Pko1
	meAnD3m52mFEX14w9XoZFac=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=jG1uRdiIvI6lzJbLovPq5v4YF2vmdpKYqJ1m8uhitYcn2D
	M1DNJh9FH6c8Jz0q6dB+RmAQcLlL7x2Oyd/B1/98qRH+Ts2zFAD90fnVOdHCh5Px
	wNGviVzwii1tZL24ZBW7TmxQ1jGwmVo0mL+kGHSZaTIeGTpr2tOJlRmpCSZrg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DCFB29977;
	Mon, 25 Feb 2013 01:54:59 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AECA79930; Mon, 25 Feb 2013
 01:54:57 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 45453434-7F18-11E2-BA78-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217042>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> As I mentioned recently, while discussing a cygwin specific patch
> (see "Version 1.8.1 does not compile on Cygwin 1.7.14" thread), the
> MSVC build is broken for me.
>
> The first 4 patches fix the MSVC build for me. The final patch is
> not really related to fixing the build, but it removed some make
> warnings which were quite irritating ...
>
> Note that I used the Makefile, with the Visual C++ 2008 command
> line compiler on Windows XP (SP3), to build a vanilla git on MinGW.
> I'm not subscribed to the msysgit mailing list, nor do I follow the
> msysgit fork of git, so these patches may conflict with commits in
> their repository.

Did anything further happen to this topic in the Windows land?
