From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH 2/2] completion: split __git_ps1 into a separate script
Date: Tue, 22 May 2012 23:07:37 +0200
Message-ID: <4FBC0019.6030702@in.waw.pl>
References: <1337719600-7361-1-git-send-email-felipe.contreras@gmail.com> <1337719600-7361-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ted Pavlic <ted@tedpavlic.com>,
	Thomas Rast <trast@student.ethz.ch>,
	=?UTF-8?B?U1pFREVSIEfDoWJvcg==?= <szeder@ira.uka.de>,
	Kerrick Staley <mail@kerrickstaley.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	=?UTF-8?B?VmlsbGUgU2t5dHTDpA==?= <ville.skytta@iki.fi>,
	Dan McGee <dan@archlinux.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 22 23:07:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWwJ3-00017C-QV
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 23:07:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326Ab2EVVHp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 17:07:45 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:37250 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756306Ab2EVVHo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 17:07:44 -0400
Received: from 69-mo7-2.acn.waw.pl ([85.222.93.69] helo=[192.168.0.150])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SWwIx-0007Zp-8o; Tue, 22 May 2012 23:07:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.3) Gecko/20120329 Icedove/10.0.3
In-Reply-To: <1337719600-7361-3-git-send-email-felipe.contreras@gmail.com>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198255>

On 05/22/2012 10:46 PM, Felipe Contreras wrote:
>  contrib/completion/git-completion.bash |  257 +---------------------------
>  contrib/completion/git-prompt.sh       |  287 ++++++++++++++++++++++++++++++++
>  t/t9903-bash-prompt.sh                 |    2 +-
>  3 files changed, 290 insertions(+), 256 deletions(-)
>  create mode 100644 contrib/completion/git-prompt.sh
Hi,
since git-prompt is not completion related anymore, should a different
directory be used?

Zbyszek
