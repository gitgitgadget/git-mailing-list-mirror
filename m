From: =?UTF-8?Q?Ville_Skytt=C3=A4?= <ville.skytta@iki.fi>
Subject: Re: [PATCH 1/2] git-prompt.sh: Don't error on null
 ${ZSH,BASH}_VERSION, $short_sha
Date: Mon, 6 Jun 2016 19:33:12 +0300
Message-ID: <CABr9L5A1i9Qiood7RnBiSOKAGOPLd+-Nh2b0B73RuFwVJygbKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 18:33:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9xTI-0002Jk-FT
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 18:33:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753075AbcFFQdf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jun 2016 12:33:35 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33490 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582AbcFFQdd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2016 12:33:33 -0400
Received: by mail-wm0-f66.google.com with SMTP id c74so9606775wme.0
        for <git@vger.kernel.org>; Mon, 06 Jun 2016 09:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=57LsX6J2SceubQOzJ6YJYDFbaVt9BnDOgVLEhjPwinU=;
        b=OJwKsHbZnqgaoAZzkonhyKJuxZawc7OqBTYHdp2+TCXoPe6qrbGNOgnzKt0Uv/UiKl
         olpIXU743KKkoksmWfhnO2Dscvf0C6QcShV38FMoJKz1/wVQgiRYpwC/deHk7YycXyZQ
         VLmm+vuXy9BL7jhrwdCVWe8tWeIptwhMFWYm9p2WU4ke6oZJU9mrDXIGSm6/RjEcoB54
         D9IjM/8dwoCVf/BMToAJJ9CtDMzewpQWdg5T1DN8kVjceXKbIAumTAjKpUs1FtlIV1e8
         +EBKS9M6uBrMIYk1Ge8XEcCvhZN8r1phJWnGsJExPZ5Hde30X34F+b+6cDBcHtw0bsYx
         NMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=57LsX6J2SceubQOzJ6YJYDFbaVt9BnDOgVLEhjPwinU=;
        b=mDhH3WCH45JjBi4oyr6ScdpdSw0+J1eXjd7FsV3LVPTTcbCoLRlW8KVcc05u6xJASO
         0EmMihdn444OzbCMDn+FHgnieCwl8oEUZr37INa28EqWPdA+Gi5eQJ2dBH1vrcUuAwPu
         khG5w72/w8uv6uurLQtZc6TnoIxLjwKAZv9sG7ZkBlY9jJozV8iN+nz0AU68dqid5l2O
         xZuks9GT1gMzkhIW+OAsOyF2zSdkmfG9mm2TCY+JRFsg3sUF07pnws3jYRgYgffiPA3r
         RJyqKxM/TtE8wUUuI+5ZxnWaxs+TGVDQHH8A9tMtfxoalqFpX6KcHTXmlsFBCeR6iIEC
         XmuQ==
X-Gm-Message-State: ALyK8tIEODnnyaMJVZqTBsHEmdtDS4ZyDPU4DQu2o7qABdREInZY6/leyFQ2tib8V6q/RZLZ7PuB1UROWe83Hw==
X-Received: by 10.194.79.69 with SMTP id h5mr17944539wjx.129.1465230811841;
 Mon, 06 Jun 2016 09:33:31 -0700 (PDT)
Received: by 10.194.9.195 with HTTP; Mon, 6 Jun 2016 09:33:12 -0700 (PDT)
X-Google-Sender-Auth: 6ywzPpn9T5CJGOCvw9GqeoKplRQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296531>

On Mon, Jun 6, 2016 at 7:29 PM, Ville Skytt=C3=A4 <ville.skytta@iki.fi>=
 wrote:
> When the shell is in "nounset" or "set -u" mode, referencing unset or
> null variables results in an error. Protect $ZSH_VERSION and
> $BASH_VERSION against that, and initialize $short_sha before use.

No part 2/2 will be coming, 1/2 is all there is to this change, sorry
about the confusion.
