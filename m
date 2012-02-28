From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2] Perform cheaper connectivity check when pack is used
 as medium
Date: Tue, 28 Feb 2012 16:40:58 +0100
Message-ID: <4F4CF58A.9090502@viscovery.net>
References: <7vmx849ma8.fsf@alter.siamese.dyndns.org> <1330435109-4437-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 28 16:41:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2PAt-0006l0-UW
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 16:41:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965489Ab2B1PlG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Feb 2012 10:41:06 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:6205 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753468Ab2B1PlF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Feb 2012 10:41:05 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1S2PAh-0000at-5z; Tue, 28 Feb 2012 16:40:59 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id E05DF1660F;
	Tue, 28 Feb 2012 16:40:58 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <1330435109-4437-1-git-send-email-pclouds@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191740>

Am 2/28/2012 14:18, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy:
> Without the patch:
> $ time git fetch file:///home/pclouds/w/git/.git
> remote: Counting objects: 125638, done.
> remote: Compressing objects: 100% (33201/33201), done.
=2E..
> With the patch:
> $ time git fetch file:///home/pclouds/w/git/.git
> remote: Counting objects: 125647, done.
> remote: Compressing objects: 100% (33209/33209), done.

It is a bit irritating that the number are different when they should b=
e
identical...

-- Hannes
