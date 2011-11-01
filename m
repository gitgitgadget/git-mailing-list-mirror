From: Hong-Ming Su <halleyinvent@gmail.com>
Subject: how to undo a merge
Date: Tue, 1 Nov 2011 15:27:43 +0800
Message-ID: <CANiMyiEoaxAO3XxJMWEXP-L7C_xkxU0_nyDaor+TsJr-Ch7ARw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 01 08:27:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RL8lC-0007mJ-2h
	for gcvg-git-2@lo.gmane.org; Tue, 01 Nov 2011 08:27:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954Ab1KAH1p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Nov 2011 03:27:45 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:51203 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585Ab1KAH1p convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Nov 2011 03:27:45 -0400
Received: by eye27 with SMTP id 27so5995346eye.19
        for <git@vger.kernel.org>; Tue, 01 Nov 2011 00:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=oDe4lRAiLW98CViJWlo6AY7KLwaQ97pfKc+i9+ThoP4=;
        b=aA0fdWtm0CsSAoBt9jetL0o7jAx8JOZF1T/iTQfXISpl8tIs2QgmBucQe+WFKLOkdO
         zMC7cqxxfC668o/OgzeBJ1id5I9ZV4AM59bZ7ESrCtgqWYZ3HPMsmxxyB+uu1UbNE4RA
         SW53sirVwXZ091dpeYwUFJGKtBoY11fbb1Z40=
Received: by 10.14.5.148 with SMTP id 20mr1547167eel.105.1320132463973; Tue,
 01 Nov 2011 00:27:43 -0700 (PDT)
Received: by 10.14.127.4 with HTTP; Tue, 1 Nov 2011 00:27:43 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184559>

The commit graph before merging is:
A--B <-master
=A0\=A0 \
=A0 \=A0 \
C--D--E--F <- dev

git checkout master
git merge dev

The commit graph after merging is:
A--B
=A0\=A0 \
=A0 \=A0 \
C--D--E--F <- dev <-master

master fast-forward to commit F.
I want to "undo" the merge. What shall I do?

Thank you!

Best regards,
Hong-Ming
