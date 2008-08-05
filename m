From: Brian Foster <brian.foster@innova-card.com>
Subject: [Q] Finding the commit that removed a symbol?
Date: Tue, 5 Aug 2008 13:43:07 +0200
Message-ID: <200808051343.07370.brian.foster@innova-card.com>
Reply-To: Brian Foster <brian.foster@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 05 13:44:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQKxo-0007QC-K1
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 13:44:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755106AbYHELnZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Aug 2008 07:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756792AbYHELnZ
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 07:43:25 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:45846 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755106AbYHELnY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Aug 2008 07:43:24 -0400
Received: by an-out-0708.google.com with SMTP id d40so406066and.103
        for <git@vger.kernel.org>; Tue, 05 Aug 2008 04:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:reply-to:to:subject:date
         :user-agent:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id:sender;
        bh=W/8P7eIh00QyVUY0kN/tUstcNswnlE/JQvZJnUEo7KU=;
        b=uywYba8/5KNQdSHFvH2axkcS5aQXszh5lk3r6V0QrJjsoaqW30fh4JUkt0aG6Dd8eN
         fRU3vOwZK1KD3VeDEB1Qnnt/AYeWF7nSqMPJT21wMm29FF0vteVTsMv1h7S673U3MYup
         aBFQYpoYfvFLciBij+R+Aa3ONk5q9E7Gm8uHw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:reply-to:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id:sender;
        b=ShtY40n24dcGfq//f/pG6bGq/6H3tt/ZCR9FbWMCJfrDMDYMk3GGd0LuTb20bdkiAB
         9RyPQyafDzQYEBNw6YhVPptfRTzPLiosV2N0CbGAuYus64Lp9e0E/bd+VfmHhnMIGoCM
         L/0IXwv+FlAlnP0pmEl8/8FTz3p/zUSgv1n3Q=
Received: by 10.100.227.6 with SMTP id z6mr1174017ang.133.1217936602122;
        Tue, 05 Aug 2008 04:43:22 -0700 (PDT)
Received: from innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTPS id d24sm11887280and.24.2008.08.05.04.43.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 05 Aug 2008 04:43:20 -0700 (PDT)
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91436>


  I'm a bit puzzled as to how to do find a commit which
 removed a symbol.  This is not a =E2=80=98bisect=E2=80=99 per se (or a=
t
 least I don't think it is ?); I know exactly what I am
 looking for, but am not quite sure how to find it.

  I know that between tags A (older) and B (younger)
 a certain symbol S, defined in file F, vanished.
 A:F has S; B:F does not.  (There are many commits
 affecting F between A and B, albeit most don't involve
 S per se.)  S isn't mentioned in any commit comments,
 else I could search the output of:   git log A..B -- F

  Actually, using gitk(1) =E2=80=94 gitk A..B -- F =E2=80=94 I've found
 what I'm looking for, so I guess what I'm now wondering
 is if there's a better/easier/faster(/non-GUI ?) way of
 doing this?   (My git-newbie-ness may be showing here!)

cheers!
	-blf-

--=20
=E2=80=9CHow many surrealists does it take to   | Brian Foster
 change a lightbulb? Three. One calms   | somewhere in south of France
 the warthog, and two fill the bathtub  |   Stop E$$o (ExxonMobil)!
 with brightly-coloured machine tools.=E2=80=9D |      http://www.stope=
sso.com
