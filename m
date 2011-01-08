From: Anders Kaseorg <andersk@MIT.EDU>
Subject: Re: [RFC/PATCH] t9157-*.sh: Add an svn version check
Date: Sat, 08 Jan 2011 02:19:02 -0700
Message-ID: <1294478342.2791.4.camel@fixed-disk>
References: <4D260A03.90903@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	stevenrwalter@gmail.com, normalperson@yhbt.net
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sat Jan 08 10:19:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbUxD-00010r-Bo
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 10:19:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399Ab1AHJTM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jan 2011 04:19:12 -0500
Received: from DMZ-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.34]:46609 "EHLO
	dmz-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751250Ab1AHJTL (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Jan 2011 04:19:11 -0500
X-AuditID: 12074422-b7c3eae000000a70-e1-4d282c0e07f6
Received: from mailhub-auth-3.mit.edu ( [18.9.21.43])
	by dmz-mailsec-scanner-5.mit.edu (Symantec Brightmail Gateway) with SMTP id C1.47.02672.E0C282D4; Sat,  8 Jan 2011 04:19:10 -0500 (EST)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-3.mit.edu (8.13.8/8.9.2) with ESMTP id p089J9TV008162;
	Sat, 8 Jan 2011 04:19:09 -0500
Received: from [192.168.1.108] (c-71-56-216-201.hsd1.co.comcast.net [71.56.216.201])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id p089J329004055
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 8 Jan 2011 04:19:07 -0500 (EST)
In-Reply-To: <4D260A03.90903@ramsay1.demon.co.uk>
X-Mailer: Evolution 2.32.1 
X-Brightmail-Tracker: AAAAARcU4pI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164813>

On Thu, 2011-01-06 at 18:29 +0000, Ramsay Jones wrote:
> +svn_ver="$(svn --version --quiet)"
> +case $svn_ver in
> +[0-1].[0-4].[0-6])

Thanks for the patch.  Can I suggest the more precise

0.* | 1.[0-4].*)

Anders
