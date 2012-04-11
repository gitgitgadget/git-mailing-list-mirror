From: Hadmut Danisch <hadmut@danisch.de>
Subject: Why can't git open empty branches ?
Date: Wed, 11 Apr 2012 12:35:23 +0200
Message-ID: <4F855E6B.4010504@danisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 11 12:45:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHv3D-0004ke-VG
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 12:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753092Ab2DKKpR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Apr 2012 06:45:17 -0400
Received: from mail.rackland.de ([212.86.200.188]:50264 "EHLO mail.rackland.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750910Ab2DKKpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 06:45:16 -0400
X-Greylist: delayed 592 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Apr 2012 06:45:16 EDT
Received: from [192.168.160.116] (178-26-58-165-dynip.superkabel.de [178.26.58.165])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by mail.rackland.de (Postfix) with ESMTPSA id 2F8B62C04B
	for <git@vger.kernel.org>; Wed, 11 Apr 2012 12:35:21 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120329 Thunderbird/11.0.1
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195161>

Hi,

when creating a new branch in git, it is by default filled with the
contents of the current branch.

Sometimes a new but empty branch is needed. There are plenty of
instructions in the web to achieve this with =E2=80=9Edirty tricks=E2=80=
=9D, i.e. fiddle
around with git's internals. Which is poor design.



Why doesn't git's branch command support opening empty branches in a
clean an natural way?



regards
Hadmut
