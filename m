From: Geoff Russell <geoffrey.russell@gmail.com>
Subject: check-ref-format question
Date: Wed, 13 May 2009 09:39:28 +0930
Message-ID: <93c3eada0905121709k73a47bddu60def6b5fbc1b15e@mail.gmail.com>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 02:09:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M422Q-00038C-3g
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 02:09:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757922AbZEMAJb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 20:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758248AbZEMAJ3
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 20:09:29 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:7443 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758257AbZEMAJ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 20:09:28 -0400
Received: by qw-out-2122.google.com with SMTP id 5so249483qwd.37
        for <git@vger.kernel.org>; Tue, 12 May 2009 17:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:date:message-id
         :subject:from:to:content-type:content-transfer-encoding;
        bh=LUiv7PJm/LJpP5SDK4/lUpwpp3eMRjMUHEekC5MA8po=;
        b=GthcllC0gAJ5GijpIYD7I4vNZd/gU8SwClBc6H0JOnmn7+k6Nwy15vmxlcgEul4Wgs
         Dv435BoNVxchNyMtzwQl3uS6tIzTDbykt1pNBAsWTY0Xt5WWS15k7deQdBnJ/NXSsQEJ
         rOlFlX04+aUIjWDb1AbpaoV7lylc2lNPKzofA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=LfsGwbBnzqE/RR1+3Hn1rqOQ3kirSvfEsMTJHhRGckJfhesmCCo64h787S4O/wXGA0
         wPql4mnjShG78hb7xf4fcjw7zAuaTOpfiaQzOu5gnfMxBgOlpOs3GM5wOY58qw7wIaHI
         QI3P0Op6BG6yoKKQKKbAeZeD1gC4eELpJcrKQ=
Received: by 10.220.80.195 with SMTP id u3mr570534vck.81.1242173368549; Tue, 
	12 May 2009 17:09:28 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118974>

1 $ git --version
git version 1.6.2.3
2 $ git check-ref-format xxxx && echo OK
3 $ git-check-ref-format --branch xxxx && echo OK
xxxx
OK
4 $ git check-ref-format --branch xxxx && echo OK
usage: git check-ref-format refname


2 seems wrong,
I tried 3 after looking at  builtin-check-ref-format.c
I couldn't find any test cases in the git/t directory

>From the documenation, I expect "git check-ref-format xxx" to return 0 if xxx is
a valid branch or ref name.  git version 1.6.3 gives the same results.

Cheers,
Geoff.
