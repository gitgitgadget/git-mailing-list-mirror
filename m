From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 2/3] pass struct commit to diff_tree_combined_merge()
Date: Sat, 17 Dec 2011 11:27:26 +0100
Message-ID: <4EEC6E8E.6090703@lsrfire.ath.cx>
References: <4EEC6BD4.4040302@lsrfire.ath.cx> <4EEC6CD7.2030408@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sat Dec 17 11:27:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbrUb-0004ex-2n
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 11:27:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924Ab1LQK1l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Dec 2011 05:27:41 -0500
Received: from india601.server4you.de ([85.25.151.105]:40080 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746Ab1LQK1d (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2011 05:27:33 -0500
Received: from [192.168.2.105] (p579BE8BE.dip.t-dialin.net [87.155.232.190])
	by india601.server4you.de (Postfix) with ESMTPSA id C48C92F8038;
	Sat, 17 Dec 2011 11:27:31 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <4EEC6CD7.2030408@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187372>

Am 17.12.2011 11:20, schrieb Ren=E9 Scharfe:
> Instead of passing the hash of a commit and then searching that
> same commit in the single caller, simply pass the commit directly.
>
> ---

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

Ugh.  Forgetting it twice is stupid..
