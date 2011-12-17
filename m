From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 1/3] use struct sha1_array in diff_tree_combined()
Date: Sat, 17 Dec 2011 11:27:23 +0100
Message-ID: <4EEC6E8B.8080804@lsrfire.ath.cx>
References: <4EEC6BD4.4040302@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-15?Q?=C6var_Arnfj=F6?= =?ISO-8859-15?Q?r=F0_Bjarmason?= 
	<avarab@gmail.com>, Jens Lehmann <Jens.Lehmann@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 17 11:27:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbrUa-0004ex-Ii
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 11:27:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904Ab1LQK1k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Dec 2011 05:27:40 -0500
Received: from india601.server4you.de ([85.25.151.105]:40076 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792Ab1LQK13 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2011 05:27:29 -0500
Received: from [192.168.2.105] (p579BE8BE.dip.t-dialin.net [87.155.232.190])
	by india601.server4you.de (Postfix) with ESMTPSA id 394802F8038;
	Sat, 17 Dec 2011 11:27:28 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <4EEC6BD4.4040302@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187371>

Am 17.12.2011 11:15, schrieb Ren=E9 Scharfe:
> Maintaining an array of hashes is easier using sha1_array than
> open-coding it.  This patch also fixes a leak of the SHA1 array
> in  diff_tree_combined_merge().
>
> ---

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
