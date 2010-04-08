From: Aghiles <aghilesk@gmail.com>
Subject: git pull with "no common commits" : danger?
Date: Wed, 7 Apr 2010 21:56:56 -0400
Message-ID: <v2t3abd05a91004071856s5811e086q17241996a359e172@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 08 03:57:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nzgzk-000708-57
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 03:57:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758305Ab0DHB5T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Apr 2010 21:57:19 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:65231 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758261Ab0DHB5S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Apr 2010 21:57:18 -0400
Received: by bwz1 with SMTP id 1so1391936bwz.21
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 18:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:received
         :message-id:subject:to:content-type:content-transfer-encoding;
        bh=4zCfoWbaol4xOO6bBlTg7nxthlHxvVvQcpNZSPhNyOM=;
        b=pNDPeEUvsz4DhAO8U7BnRuGrK55wuprIxFlTu9QF0ruOOC01dfTn1jWowpqJxCIgLf
         IfmebwB+3wMYQqbBmbxAuYo0KRVJdpc9yNrKTa608pstW+jJya+mfU/xgResivltrocv
         aJy8ZlY/P+fTYy8ky1xXbaYk3TKcq4JLcX7p4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=FsfLyg5cIww8D4QRonfa65kMd+5XpwKucnvZhneWzrTPuTvdMzHyh37eNxrYxeIyIC
         VFUwMaKT8RCsBvVjlrHGLOcaUu9rqmJ5LBjuOtSIOxIU0gFyn5BPlWXIA/iwALG44M8w
         o5c5jS5jUAbPZ8gpl6wQ74RSUojsdDjam8k6I=
Received: by 10.204.63.196 with HTTP; Wed, 7 Apr 2010 18:56:56 -0700 (PDT)
Received: by 10.204.22.6 with SMTP id l6mr267320bkb.163.1270691836150; Wed, 07 
	Apr 2010 18:57:16 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144302>

Hello,

I mistakenly pulled a project into another project. I had the
"warning: no common commits" but the pull did proceed.
I am wondering if, from a usability point of view, it would be
best to avoid doing so by default.

Thanks,

=A0 -- aghiles
