From: Johannes Sixt <j6t@kdbg.org>
Subject: =?utf-8?Q?Re=3A_=5BPATCH=5D_Support_working_directory_located?=
 =?utf-8?Q?_at_root?=
Date: Tue, 09 Feb 2010 08:16:52 +0100 (CET)
Message-ID: <mtranet.20100209081652.392409790@telekom.at>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?utf-8?Q?Jo=C3=A3o_Carlos_Mendes_Lu=C3=ADs?= <jonny@jonny.eng.br>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 08:17:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NekLK-0004jy-9O
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 08:17:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752601Ab0BIHQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 02:16:59 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:17013 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750836Ab0BIHQ6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Feb 2010 02:16:58 -0500
Received: from telekom.at (lbmbmn02.lix.bon.at [172.18.12.147])
	by bsmtp.bon.at (Postfix) with SMTP id 978251002A;
	Tue,  9 Feb 2010 08:16:52 +0100 (CET)
Content-ID: <mtranet.1265699812.554676034@telekom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139377>

Nguyen Thai Ngoc Duy schrieb:
> But I suspect my change in this code is not enough and caused
> the problem (on msys?) for Hannes.

My test was on Linux, btw, roughly:

cd /
git init
cd etc
git add resolv.conf

-- Hannes
