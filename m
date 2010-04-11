From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [ANNOUNCE] Git 1.7.1.rc1
Date: Sun, 11 Apr 2010 16:08:27 +0000
Message-ID: <y2i51dd1af81004110908mcf6ce8cahf04225d7c261a85b@mail.gmail.com>
References: <7vmxxar5h7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 11 18:08:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0zi7-0006gF-IF
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 18:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150Ab0DKQI3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Apr 2010 12:08:29 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:32908 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752137Ab0DKQI2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Apr 2010 12:08:28 -0400
Received: by bwz19 with SMTP id 19so46687bwz.21
        for <git@vger.kernel.org>; Sun, 11 Apr 2010 09:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=aC5NqMvVYcJbG5TJaZZEJMX3SB60gUUmYLsLugW2ce0=;
        b=pjRUAMSViQD+T7BoRK61ChMChjk4B+txWCWY7AHCyu4aFB73cxrqjNuNr7SmjYIWWL
         a50DqHgdyAlJyYsLbey4a2NCcU/Me1WnyQJAlloenDQwpKw6MzEQHLw9KDwNe74X76DN
         66sV4SFjVDmSFFbOtE+89H6Ct+cEZ5p/BzA8I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=nxVpWS+xUtG5GQDH1TYC/87jxrus7TsVkoUv68DD+LvZ1zbaAS1fZefJX3hVWmB6BH
         w++hXXOvsH93gpjBXIg5KGu2aw3XIsm1hDkBbC9j/7rleM5FqX7Xnv0pcue+XfG03eJt
         wbJ0qXXIdAeOIe3t1Q03Uu4krdGcYvupYQXZk=
Received: by 10.204.121.195 with HTTP; Sun, 11 Apr 2010 09:08:27 -0700 (PDT)
In-Reply-To: <7vmxxar5h7.fsf@alter.siamese.dyndns.org>
Received: by 10.204.9.6 with SMTP id j6mr3390523bkj.37.1271002107538; Sun, 11 
	Apr 2010 09:08:27 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144655>

On Sun, Apr 11, 2010 at 04:13, Junio C Hamano <gitster@pobox.com> wrote=
:
> A release candidate Git 1.7.1.rc1 is available at the usual places
> for testing:

This is a minor nit but when I generate the info docs from master I
get this at the top of user-manual.texi:

    @menu
    * : id2860714.
    * Repositories and Branches::
    * Exploring git history::
    * Developing with git::

I can't find what produces that token but here are all occurrences of i=
t:

  4 matches for "id2860714" in buffer: user-manual.texi
     10:@node Top, id2860714, , (dir)
     15:* : id2860714.
    130:@node id2860714, Repositories and Branches, Top, Top
    171:@node Repositories and Branches, Exploring git history, id28607=
14, Top

This bug results in an empty list item when viewing the Git User=E2=80=99=
s
Manual with info.
