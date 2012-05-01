From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] gitweb-lib.sh: Set up PATH to use perl from /usr/bin
Date: Tue, 01 May 2012 19:50:44 +0200
Message-ID: <4FA02274.6070601@web.de>
References: <201205011323.45190.tboegi@web.de> <4FA00E09.2090708@in.waw.pl> <7vsjfjalx6.fsf@alter.siamese.dyndns.org> <4FA0176B.50300@in.waw.pl> <20120501170810.GA22444@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?VG9ycw==?= =?UTF-8?B?dGVuIELDtmdlcnNoYXVzZW4=?= 
	<tboegi@web.de>, jnareb@gmail.com, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 01 19:51:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPHDw-0004bf-9q
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 19:50:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758364Ab2EARur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 13:50:47 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:57585 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758334Ab2EARuq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 13:50:46 -0400
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de [172.19.20.108])
	by fmmailgate02.web.de (Postfix) with ESMTP id 795A71C400F4C
	for <git@vger.kernel.org>; Tue,  1 May 2012 19:50:45 +0200 (CEST)
Received: from birne.lan ([194.22.188.61]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0LdVdS-1RhvmQ2Ybq-00ikhs; Tue, 01 May 2012 19:50:44 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <20120501170810.GA22444@sigill.intra.peff.net>
X-Provags-ID: V02:K0:Oy/8zs+CvWV1qHEi9xRmoPyWgK5KfBtQEej6jKrulEm
 be4VjKje9gYu1ZG7HkHp4DKugNoJQpNjDJUhy2rmm+R4ngS/a0
 /LtziVB4UCq2VsZVG2zpEzcxSmNcdywwtXZOjPRreBnGSJ0M5G
 LwKryeTHJW0CIopGEmew1drwc5gOTMwGSyCMO6qkt8rW+56XFY
 44ST5u7HcCkbHgm4K8yaQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196712>

Thanks for all answers,
> I think the patch we want is just:
> 
> diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
> index 21d11d6..ae2dc46 100644
> --- a/t/gitweb-lib.sh
> +++ b/t/gitweb-lib.sh
> @@ -69,7 +69,7 @@ gitweb_run () {
>  	# written to web server logs, so we are not interested in that:
>  	# we are interested only in properly formatted errors/warnings
>  	rm -f gitweb.log &&
> -	perl -- "$SCRIPT_NAME" \
> +	"$PERL_PATH" -- "$SCRIPT_NAME" \
>  		>gitweb.output 2>gitweb.log &&
>  	perl -w -e '
>  		open O, ">gitweb.headers";
> 
> no? Torsten, does that fix your problem?
Yes, it does.

Should we go for that solution ?

/Torsten
