From: John Bito <jwbito@gmail.com>
Subject: Egit crashing Eclipse on sparc (Solaris 10)
Date: Thu, 25 Jun 2009 18:54:22 -0700
Message-ID: <3ae83b000906251854h70e5d9cs30bba9d563c3827a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 26 03:54:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MK0eW-0004PS-59
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 03:54:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752567AbZFZByU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Jun 2009 21:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752431AbZFZByU
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 21:54:20 -0400
Received: from mail-yx0-f186.google.com ([209.85.210.186]:37687 "EHLO
	mail-yx0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752342AbZFZByT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Jun 2009 21:54:19 -0400
Received: by yxe16 with SMTP id 16so640621yxe.33
        for <git@vger.kernel.org>; Thu, 25 Jun 2009 18:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=Vo63aCVdaofyap4aOMDKM59owRof1YYy61WPAFoG/70=;
        b=SjDxiibVMU7Vkot/CdmxdI3ThW+ee3rNw30YKKYS517352iWW/juAP3QcaiangIzl0
         PTVwBibFBF+l9h2X6WsOYk3nK5ZcHubFQWbxbhDXip8/WMjJmBSVlDwUUVVp8MSQbyhc
         rvU7iSTRJwA017sWCI1j96+1RFv2ethzrBaXw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=Q/8XEddf3u5cs4gEy0VJ7BRfDVKAct+EtZy9tIzFhA46m+u/pZj6vKas4uUhnsP+Xr
         G+5WUrVZ6CJXDIyVYawdJmjtvsnI81bkMvru2A3UQi7ukvZjqcgvb8rgCf/owgeJK1KL
         JEb3EcNqkH6WU0LEFd0lzzEbzWx31fit4BMsk=
Received: by 10.100.128.18 with SMTP id a18mr4304743and.12.1245981262525; Thu, 
	25 Jun 2009 18:54:22 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122265>

As I noted last month, a commit from April broke on sparc running
Solaris 10.=A0 Since then, I opened an issue here
<http://code.google.com/p/egit/issues/detail?id=3D95>, two with eclipse
<https://bugs.eclipse.org/bugs/show_bug.cgi?id=3D280960 &
https://bugs.eclipse.org/bugs/show_bug.cgi?id=3D279300> and four with
sun (one for each of the 1.6 updates 12, 13 & 14 plus one for the JDK
7 Early Access release - they haven't responded).

The problem is quite repeatable on my environment (I only have one
sparc machine to try it on).  It does not appear at all on WinVista.
(I do have a Solaris x86 machine, but I can't really do anything with
it immediately.)

Robin worked with me as far as identifying the commit that introduced
the problem (2d77d30b5f5eca2b3087f1bab47fa9df2e64cd71 - Rewrite
WindowCache to be easier to follow and maintain). Now I need further
guidance to get this problem resolved.

The current 'Release Build' (0.4.9) cannot clone
git://repo.or.cz/egit.git on sparc Solaris.  I'm very interested in
getting this solved, if only I can get some more input from the folks
who know the code.

~John
