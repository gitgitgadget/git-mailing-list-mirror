From: =?UTF-8?B?UMOkci1PbGEgTmlsc3Nvbg==?= <peje@home.se>
Subject: Exporting git tags/branches to svn tags/branches?
Date: Thu, 13 Dec 2007 00:08:32 +0100
Message-ID: <476069F0.6020403@home.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 13 00:56:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2bQx-0003oo-9o
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 00:56:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751615AbXLLXz2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Dec 2007 18:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbXLLXz1
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 18:55:27 -0500
Received: from vrooom.space.umu.se ([130.239.33.102]:58668 "EHLO
	vrooom.umea.irf.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722AbXLLXz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 18:55:27 -0500
X-Greylist: delayed 2801 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Dec 2007 18:55:26 EST
Received: from trolle.homeip.net ([83.219.210.68])
	by vrooom.umea.irf.se with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <peje@home.se>)
	id 1J2ah0-0001lx-MT; Thu, 13 Dec 2007 00:08:42 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.6) Gecko/20071009 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68109>

Hi!

I have svn repository with a standard layout:

branches
tags
    RELEASE1_0
    RELEASE1_1
    ...
trunk

I have cloned this with:
    git-svn clone -s url

Now for the question:

Can I create new tags/branches on the git side and have them appear on=20
the svn side?

=46or example, create a new release, RELEASE2_0,  in git and push this =
to=20
the svn repository as "tags/RELEASE2_0".

P=C3=A4r-Ola Nilsson
