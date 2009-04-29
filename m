From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 3/9] Do not sleep after the last patch sent by e-mail
Date: Wed, 29 Apr 2009 08:13:38 +0200
Message-ID: <20090429061338.GC18483@diana.vm.bytemark.co.uk>
References: <20090428150742.27261.19620.stgit@pc1117.cambridge.arm.com> <20090428150952.27261.5637.stgit@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 08:13:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lz33C-0005tv-K5
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 08:13:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752325AbZD2GNj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Apr 2009 02:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752082AbZD2GNj
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 02:13:39 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:48702 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751918AbZD2GNj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 02:13:39 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Lz334-0004rV-00; Wed, 29 Apr 2009 07:13:38 +0100
Content-Disposition: inline
In-Reply-To: <20090428150952.27261.5637.stgit@pc1117.cambridge.arm.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117850>

This is an improvement.

An somewhat related improvement would be to decouple the mail sending
and interactive editing of cover letter and patch mails -- we don't
really need to wait five seconds before letting the user edit the next
patch! (In fact, we should probably let her edit everything first, and
then ask "Send? Y/N" at the end. Or something. Maybe a menu with
options to edit cover letter, edit patches, send, save to mbox, read
from mbox, and discard. But now we're getting into UI land. And most
of this isn't StGit-specific anyway.)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
