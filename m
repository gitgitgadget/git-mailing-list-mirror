From: =?utf-8?q?Pawe=C5=82_Sikora?= <pawel.sikora@agmk.net>
Subject: support gnupg-2.x in git.
Date: Tue, 29 Nov 2011 19:37:34 +0100
Message-ID: <201111291937.34324.pawel.sikora@agmk.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 29 20:01:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVSvp-0005nv-Jg
	for gcvg-git-2@lo.gmane.org; Tue, 29 Nov 2011 20:01:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755259Ab1K2TBZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Nov 2011 14:01:25 -0500
Received: from esme.agmk.net ([217.73.31.59]:38932 "EHLO esme.agmk.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754443Ab1K2TBY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Nov 2011 14:01:24 -0500
X-Greylist: delayed 1420 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Nov 2011 14:01:24 EST
Received: from mail.agmk.net ([91.192.224.71]:50816 ident=postfix)
	by esme.agmk.net with esmtp (Exim 4.72)
	(envelope-from <pawel.sikora@agmk.net>)
	id 1RVS6W-0006az-4D
	for git@vger.kernel.org; Tue, 29 Nov 2011 19:08:28 +0100
Received: from localhost (unknown [91.192.224.71])
	by mail.agmk.net (Postfix) with ESMTP id 852B220300BD
	for <git@vger.kernel.org>; Tue, 29 Nov 2011 19:37:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at agmk.net
Received: from mail.agmk.net ([91.192.224.71])
	by localhost (agmk.net [91.192.224.71]) (amavisd-new, port 10024)
	with ESMTP id i5NMMwB0WVIQ for <git@vger.kernel.org>;
	Tue, 29 Nov 2011 19:37:37 +0100 (CET)
Received: from vmx.localnet (unknown [89.79.206.92])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.agmk.net (Postfix) with ESMTPSA id A038520300BC
	for <git@vger.kernel.org>; Tue, 29 Nov 2011 19:37:37 +0100 (CET)
User-Agent: KMail/1.13.7 (Linux/3.1.3; KDE/4.7.3; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186072>

Hi,

i'm using a gnupg-2.0.18 and currently i'm not able to use git tag/veri=
fy
due to hadcoded "gpg" literals in builtin/{tag,verifiy-tag}.c.
could you please improve git to use global config key with specified pa=
th
to gpg{,2} executable?

BR,
Pawe=C5=82.

please CC me on reply.
