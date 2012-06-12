From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCHv5] rebase [-i --exec | -ix] <CMD>...
Date: Tue, 12 Jun 2012 11:23:26 +0200
Message-ID: <4FD70A8E.7050502@in.waw.pl>
References: <1339325076-474-1-git-send-email-Lucien.Kong@ensimag.imag.fr> <1339488312-6349-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Tue Jun 12 11:23:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeNKB-0001A0-0s
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 11:23:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752491Ab2FLJXi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 05:23:38 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:38347 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750937Ab2FLJXh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 05:23:37 -0400
Received: from amanda.fuw.edu.pl ([193.0.82.254] helo=[192.168.121.139])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SeNK4-0003Ap-JZ; Tue, 12 Jun 2012 11:23:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.3) Gecko/20120329 Icedove/10.0.3
In-Reply-To: <1339488312-6349-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199773>

On 06/12/2012 10:05 AM, Lucien Kong wrote:
> +-x <cmd>::
> +--exec <cmd>::
> +	Append "exec <cmd>" after each commit application line. <cmd>
> +	will be interpreted as one or more shell commands (see
> +	INTERACTIVE MODE below).
> ++
> +This option has to be used along with the `--interactive` option
> +explicitly.  You may execute several commands between each commit
> +applications.  For this, you can use one instance of exec:
Hi,

this is still grammatically fishy, and has "between each commit
applications", which was corrected above, but not here.

> +	git rebase -i --exec "cmd1; cmd2; ...".
> ++
> +You can also insert several instances of exec, if you wish to only
> +have one command per line. For example:
s/instances of exec/instances of --exec/

> +	git rebase -i --exec "cmd1" --exec "cmd2" ...
> ++
> +If --autosquash is used, the "exec" lines will not be appended for the
> +intermediate commits, and will only appear at the end of each
> +squash/fixup series.
> +

Zbyszek
