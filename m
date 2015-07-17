From: Christian Weiske <cweiske@cweiske.de>
Subject: git clone --recursive and URL overrides
Date: Fri, 17 Jul 2015 10:48:48 +0200
Message-ID: <20150717104848.31ab4c3f@csystems>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 17 10:56:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZG1Rn-0001Qa-9R
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jul 2015 10:56:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946123AbbGQI4l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Jul 2015 04:56:41 -0400
Received: from cweiske.de ([5.35.241.22]:43402 "EHLO mail.cweiske.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946018AbbGQI4j convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jul 2015 04:56:39 -0400
X-Greylist: delayed 467 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Jul 2015 04:56:38 EDT
Received: by mail.cweiske.de (Postfix, from userid 65534)
	id 9F3F92E530B; Fri, 17 Jul 2015 10:48:49 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on ahso2
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.2
Received: from csystems (proxy.lpz.netresearch.de [85.232.25.153])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	by mail.cweiske.de (Postfix) with ESMTPSA id 6D6762E52EB
	for <git@vger.kernel.org>; Fri, 17 Jul 2015 10:48:49 +0200 (CEST)
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.27; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274061>

Hi,


I'm setting some URL overrides via
> -c foo.insteadof=3Dbar
to "git clone --recursive", but they are not used in the subsequent
submodule requests on git 1.9.1.

Is this expected behavior, or a bug?

--=20
Regards/Mit freundlichen Gr=C3=BC=C3=9Fen
Christian Weiske

-=3D Geeking around in the name of science since 1982 =3D-
