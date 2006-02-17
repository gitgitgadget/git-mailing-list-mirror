From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: "stg mail" doesn't set Content-Type and such
Date: Fri, 17 Feb 2006 03:42:41 +0100
Message-ID: <20060217024241.GA28114@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 17 03:43:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9vaA-0008Uk-Kl
	for gcvg-git@gmane.org; Fri, 17 Feb 2006 03:42:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbWBQCmq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 16 Feb 2006 21:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbWBQCmq
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Feb 2006 21:42:46 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:21774 "EHLO
	diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S1751304AbWBQCmp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2006 21:42:45 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1F9vZy-0007ZY-00; Fri, 17 Feb 2006 02:42:42 +0000
To: Catalin Marinas <catalin.marinas@arm.com>
Content-Disposition: inline
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16323>

As can be seen in the headers of the stgit patches I've send to this
list recently, "stgit mail" doesn't seem to handle charsets and stuff
when sending mail; from what I can tell, it just sends the raw bytes
without setting Content-Transfer-Encoding, Content-Type, or anything
similar.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
