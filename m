From: Brian Gesiak <modocache@gmail.com>
Subject: [l10n] date: Note for translators not included in .po files
Date: Thu, 17 Apr 2014 07:51:57 +0900
Message-ID: <CAN7MxmV5tzvGTTG+aOL73fLhbXc7YeOWvYwLkMyad0=mvffMHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 17 00:52:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaYgU-0001Cn-Hx
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 00:52:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756931AbaDPWv6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 18:51:58 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:60214 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748AbaDPWv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2014 18:51:57 -0400
Received: by mail-ie0-f181.google.com with SMTP id tp5so10570861ieb.26
        for <git@vger.kernel.org>; Wed, 16 Apr 2014 15:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=jwR8RlS4mDeGSAdZ7XMaXyt+mdOXejru9aya+x2mlA8=;
        b=oNIAyqQbt5B5bTlImKfXxG/UnwmxzC1XBoOXATfTMwcKT1lKCJ3o2vZvEhzIlbSbY0
         Bongj+mtegnABKvTLy4BU5MB6ofFNm0fU/d7JpITU5PhMb+kgtjCIXVMVZjIY0X5RGwx
         j/2BeBb2DSbC0zf663z8WhIGyC8Ci8YkVUPOQMOCfCrvo1UnRim1ppjFL0gR6NFRudpD
         x7aqLm8WFud4aIJuGEQaT3J7/0G89b6weRRVtt7dde/Tmy581YRNPDQvweQQUxbrN15a
         eQT1CXyMuzLMjaW904i2CW0sJhHbcRnbncDotKe+9mv+J4rgZ1IcNGwLEUy2Fd/r/FF4
         IDVw==
X-Received: by 10.50.138.132 with SMTP id qq4mr13057469igb.8.1397688717313;
 Wed, 16 Apr 2014 15:51:57 -0700 (PDT)
Received: by 10.64.55.161 with HTTP; Wed, 16 Apr 2014 15:51:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246390>

A note for translators in date.c is not included in git.pot.
Namely, the following note from date.c:147 is not included
(https://github.com/git/git/blob/v1.9.2/date.c#L147):

/* TRANSLATORS: "%s" is "<n> years" */

This is a very useful note for translators (in fact, I think
the zh_CN translation for date.c:149 might be a little off
because this note was not included. My Mandarin is rusty,
but I believe "<n> years, <m> months ago" should be expressed
without a comma).

According to po/README, the l10n coordinator is responsible
for updating the git.pot file. Would it be possible to update it based
on v1.9.2 and include the above comment?

By the way, I am trying to organize contributors to produce a Japanese
localization for Core Git. Currently we have plenty of interest but
only two contributors. If you or anyone you know would like to contribute
please visit the repository here: https://github.com/modocache/git-po-ja

Thanks!

- Brian Gesiak
