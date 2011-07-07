From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH/RFC 3/3] upload-archive: use start_command instead of
 fork
Date: Thu, 07 Jul 2011 20:21:03 +0200
Message-ID: <4E15F90F.8090300@kdbg.org>
References: <1310038989-5724-1-git-send-email-kusmabite@gmail.com> <1310038989-5724-4-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 07 20:21:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QetCM-00086a-SR
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jul 2011 20:21:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755839Ab1GGSVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jul 2011 14:21:10 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:47835 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755568Ab1GGSVI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2011 14:21:08 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 00BBFCDF87;
	Thu,  7 Jul 2011 20:21:04 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id B697619F42F;
	Thu,  7 Jul 2011 20:21:04 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.18) Gecko/20110616 SUSE/3.1.11 Thunderbird/3.1.11
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <1310038989-5724-4-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176766>

Am 07.07.2011 13:43, schrieb Erik Faye-Lund:
> -	if (!enter_repo(buf, 0))
> -		die("'%s' does not appear to be a git repository", buf);
> -
>  	/* put received options in sent_argv[] */
>  	sent_argc = 1;
> -	sent_argv[0] = "git-upload-archive";
> +	sent_argv[0] = "archive";

Is git-archive a valid replacement of enter_repo() followed by
git-upload-archive?

-- Hannes
