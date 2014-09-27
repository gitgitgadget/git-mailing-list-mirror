From: Jordan Klassen <forivall@gmail.com>
Subject: Bug Report: 'git add -Np .' does not add new files
Date: Sat, 27 Sep 2014 01:23:55 +0000 (UTC)
Message-ID: <loom.20140927T031739-468@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 27 03:30:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXgpy-0007VL-6Y
	for gcvg-git-2@plane.gmane.org; Sat, 27 Sep 2014 03:30:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbaI0BaI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Sep 2014 21:30:08 -0400
Received: from plane.gmane.org ([80.91.229.3]:48206 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750960AbaI0BaH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2014 21:30:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1XXgpn-0007Ri-VL
	for git@vger.kernel.org; Sat, 27 Sep 2014 03:30:04 +0200
Received: from 184.71.161.34 ([184.71.161.34])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 27 Sep 2014 03:30:03 +0200
Received: from forivall by 184.71.161.34 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 27 Sep 2014 03:30:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 184.71.161.34 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:32.0) Gecko/20100101 Firefox/32.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257556>

I expect that combining the --intent-to-add and --patch command would o=
pen
up the patch interface with all of my current files and untracked files
withing the path specified. However, it seems like the patch command ca=
uses
the intent-to-add to be ignored.

=E2=9D=AF git --version
git version 2.0.0

Thanks!
