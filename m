From: Parag Kalra <paragkalra@gmail.com>
Subject: Listing files in order they are changed
Date: Thu, 23 Sep 2010 11:51:56 -0700
Message-ID: <AANLkTimHrCujEggj9KbAWWivY+WxnL0YqsXs+idhymBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 23 20:52:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oyqu9-00085H-Co
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 20:52:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755316Ab0IWSwT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Sep 2010 14:52:19 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:51776 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754339Ab0IWSwT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Sep 2010 14:52:19 -0400
Received: by qyk33 with SMTP id 33so2738479qyk.19
        for <git@vger.kernel.org>; Thu, 23 Sep 2010 11:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type:content-transfer-encoding;
        bh=kaPl5VHi7yMKY0AKfqeB6hoxLlRDBPZUy63raCxDBMc=;
        b=In075gtNwUACpN/TCE+uRb1H6ILMW7SF2LZL6ZpOKzFLXJdp9ltckUh3Gb7fptBMUc
         +XhDgejqxRWtQmLvvspFCoE5Pb5zOoqOxxY1CMhbYoTGF6wCv1T8AesQQ27UV/lO5Udk
         GNItApprYwHLV1096/8ZylU1oNfHyquKF3wHQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=hkk0SpFWzwkPTcMlxzNcGoHcEZFahJuUH2P6yW5HuVTgSfNlCX2HISpcEMyS8VyDD3
         eRGDIXqU12sTJj6Zn+HW0dWeerP+3U4u7DHFchW/hrof2AhVY2YrBoHnItmAa9zsaZcV
         7dGhBqXAzizKenfohEkl4qh0oJlQW3I03yHeY=
Received: by 10.224.80.133 with SMTP id t5mr1589897qak.341.1285267938194; Thu,
 23 Sep 2010 11:52:18 -0700 (PDT)
Received: by 10.229.187.205 with HTTP; Thu, 23 Sep 2010 11:51:56 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156896>

Hi All,

Is there a way I can make Git list all the tracked=C2=A0files in the
working directory=C2=A0in order they are changed (modified, added or
deleted)

Something like displayed by: git ls-files

Cheers,
Parag
