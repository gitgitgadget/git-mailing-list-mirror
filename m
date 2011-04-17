From: David Chanters <david.chanters@googlemail.com>
Subject: History for Strbuf and ParseOpts?
Date: Sun, 17 Apr 2011 16:13:45 +0100
Message-ID: <BANLkTimg-a-k8wR-gotEYUQ+C3LcwsBGuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Chanters <david.chanters@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 17:13:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBTfc-0003rO-2q
	for gcvg-git-2@lo.gmane.org; Sun, 17 Apr 2011 17:13:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753832Ab1DQPNr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Apr 2011 11:13:47 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:56551 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752439Ab1DQPNq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2011 11:13:46 -0400
Received: by iyb14 with SMTP id 14so3283656iyb.19
        for <git@vger.kernel.org>; Sun, 17 Apr 2011 08:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to:cc
         :content-type;
        bh=Ptif/0b/d5Mp7klIs3xrTmrPlbvvnr1xSNHpYfQrAT4=;
        b=N8tZU0FsqjIMRNdTaLT+/Uoyd6jeYVtczEeOukx3MJ6YKWtkTyTOTYRhlrd/9IVrgh
         hKK3R4d3a2ObWtjJJRcyT5GLmP3TS2iGkH4SD9MKobz2GHFkezRoLrtnzXurPFqPxPuJ
         21kMQwFs/O0IwMZXeEJAQYDfMi0xcmGkdNLDk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=HC3uc7ukzM6KCJI5dTmCfUerJBnHTzKOa9OPbW2wEMbq9TUKwdXImr7gpgblH6Nldl
         FS7QC9YIwFA59kwE0sHas4CHDxWCzGRkgAsO+FH34gEw64Qw8yCPCk+xJ2AoZcHPVfjb
         dq0cUVAxxR35IMft7wvWLokP5Mbiv/AJVGF1g=
Received: by 10.42.148.9 with SMTP id p9mr5243386icv.19.1303053225826; Sun, 17
 Apr 2011 08:13:45 -0700 (PDT)
Received: by 10.42.178.3 with HTTP; Sun, 17 Apr 2011 08:13:45 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171722>

[ Please CC me on replies.  Thanks! ]i,

Hi,

I shouldn't conflate to two (parseopts and strbuf) but can someone
tell me how these two things came about -- that is, when/why/how?  If
I understand strbuf correctly, it's a transparent and dynamic way of
handling strings?  If so, how useful would it be as a separate
project?

TIA!

David
