From: Stefan Tauner <stefan.tauner@alumni.tuwien.ac.at>
Subject: pre-push hook does not get input on non-fast-forward pushes
Date: Mon, 28 Mar 2016 22:56:52 +0200
Message-ID: <201603282056.u2SKuqDf031459@mail2.student.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 28 23:05:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akeLi-0001x5-HZ
	for gcvg-git-2@plane.gmane.org; Mon, 28 Mar 2016 23:05:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754700AbcC1VFS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Mar 2016 17:05:18 -0400
Received: from mail2.student.tuwien.ac.at ([193.170.74.22]:42452 "EHLO
	mail2.student.tuwien.ac.at" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752252AbcC1VFR convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2016 17:05:17 -0400
X-Greylist: delayed 501 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Mar 2016 17:05:16 EDT
Received: from misery (chello080109083031.10.15.vie.surfer.at [80.109.83.31])
	(authenticated bits=0)
	by mail2.student.tuwien.ac.at (8.13.8/8.13.8) with ESMTP id u2SKuqDf031459
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Mon, 28 Mar 2016 22:56:53 +0200
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290064>

Hi,

I noticed that without an additional --force the pre-push hook does not
get any input on stdin if a push would result in non-fast-forward
uploads. This is not a problem per se (although I don't get the
rationale) but it is undocumented and the latter left me puzzled.

(Please keep me in CC since I am not subscribed, thanks)

--=20
Kind regards/Mit freundlichen Gr=C3=BC=C3=9Fen, Stefan Tauner
