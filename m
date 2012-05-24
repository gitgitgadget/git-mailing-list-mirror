From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: What's cooking in git.git (May 2012, #06; Wed, 23)
Date: Thu, 24 May 2012 07:36:58 +0200
Message-ID: <4FBDC8FA.9050501@lsrfire.ath.cx>
References: <7vmx4yzgce.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 24 07:37:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXQjZ-0002AS-C7
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 07:37:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752465Ab2EXFhG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 May 2012 01:37:06 -0400
Received: from india601.server4you.de ([85.25.151.105]:33247 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808Ab2EXFhF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 01:37:05 -0400
Received: from [192.168.2.105] (p4FFDBBD1.dip.t-dialin.net [79.253.187.209])
	by india601.server4you.de (Postfix) with ESMTPSA id 60EF02F8058;
	Thu, 24 May 2012 07:37:03 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <7vmx4yzgce.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198353>

Am 24.05.2012 00:24, schrieb Junio C Hamano:
> * rs/maint-grep-F (2012-05-21) 4 commits
>    (merged to 'next' on 2012-05-23 at b24143c)
>   + grep: stop leaking line strings with -f
>   + grep: support newline separated pattern list
>   + grep: factor out do_append_grep_pat()
>   + grep: factor out create_grep_pat()
>
> "git grep -F", unlike the case where it reads from a file, did not tr=
eat
> individual lines in the given pattern argument as separate patterns a=
s it
> should.

This is not specific to -F; grep(1) accepts newline-separated pattern=20
lists with -E etc. as well, as does git grep with the patches above.

Ren=E9
