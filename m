From: =?UTF-8?B?RnLDqWTDqXJpYyBEZWxhbm95?= <frederic.delanoy@gmail.com>
Subject: Configuring diff --color-words using git-config?
Date: Wed, 1 Jun 2011 12:12:18 +0200
Message-ID: <BANLkTikMPDM7ce0mJhx=Hmm4bhLFCREUCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 01 12:12:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRiQ3-0004at-Ar
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 12:12:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933302Ab1FAKMu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Jun 2011 06:12:50 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:54150 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933260Ab1FAKMt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Jun 2011 06:12:49 -0400
Received: by ewy4 with SMTP id 4so1928422ewy.19
        for <git@vger.kernel.org>; Wed, 01 Jun 2011 03:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        bh=Yrrm2ucy23kwZcAcl3MstBHFDeDPEXAGKqTfQ5F32dU=;
        b=bcKmEBmFBxehlm9AGPRExMY7G765Fn+1xEVNhMSk/oTJmU1i7wsZOTHIOOvQjf3XV2
         wKm/htn+I6Nd+1J4HVgoroNeN+OKLkeZfKDSR8XP00d2vu/jo7tnK1Y4AoOJ/pr6C27E
         1HJIQANXUTcsxrL0EsZcWiYyzQKECv8jO381M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=daRxKnp09YJ7ExSHUsqJRjZqROS8qWxoAYq9s13XEb89v3UllZ4ENcU4eA2F53gdMc
         dcUnINC8TXbWidKeyKRwH6FxTQHGun86IQ+HBhw+lTpZvPA/HVxbKHATbjQeLhaffveB
         kXjsB7Bawv6uSDP2vWJZmrRP+plGr9jhrhuwc=
Received: by 10.14.53.136 with SMTP id g8mr2734298eec.239.1306923168351; Wed,
 01 Jun 2011 03:12:48 -0700 (PDT)
Received: by 10.14.100.16 with HTTP; Wed, 1 Jun 2011 03:12:18 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174861>

Hi

Is it possible to use a config option so that "--color-words" is used
as default for diff?

I RTFM'ed git-config but didn't find such an option.

=46r=C3=A9d=C3=A9ric
