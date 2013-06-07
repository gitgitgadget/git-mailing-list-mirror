From: Robert Martin <rdmartin3@gmail.com>
Subject: Is there a library for monitoring a git repository for any changes?
Date: Thu, 6 Jun 2013 23:16:53 -0400
Message-ID: <CABaQ0JgJaCY-LXHjXMq_7NTgHf2GqN4Ond7rm61jfLAV-gEgRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 07 05:17:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UknB0-0000hY-8B
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 05:17:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751625Ab3FGDRO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 23:17:14 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:52566 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162Ab3FGDRN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 23:17:13 -0400
Received: by mail-ie0-f177.google.com with SMTP id u16so8795112iet.8
        for <git@vger.kernel.org>; Thu, 06 Jun 2013 20:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=3ecZMUlAk+grPIPrhpbbkVOU7IAvD9GIL0tkO5SIjnE=;
        b=GtG9KB0Fmn9xYFOtvcWLGlAhPFud0h/wT52/pfQN1OTXpgzWyD0pF3Z5sAA3Nlbx7m
         qF69sjXcpLns2Os1qdi7pXLRXoW9yy6Ax8qqppmOqFNs5k6tO5mbpY530ge1ICr1vvdS
         WMZAZW3viu5OKtOCIGn9Sw0QV76ZEHOnr/iQYfl7akd/7cTnni6DjoAw4auotMOeEhIU
         MnzHqn2BEbywu5o9MRunge/4qaHFDNbF9JUm9KLOtiIcidREaoRZtj2zZBP7kllR0EVb
         LVXGpMzmUneeAGdAnGHWDpX9dmefYM/DNctDhCB6bfdDlB8OM+NYqPWyKmmeknItFQXt
         CWSg==
X-Received: by 10.50.6.107 with SMTP id z11mr477271igz.17.1370575033462; Thu,
 06 Jun 2013 20:17:13 -0700 (PDT)
Received: by 10.64.76.49 with HTTP; Thu, 6 Jun 2013 20:16:53 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226581>

Hi git,

I want to work on a visualization program for git. I was hoping there
was a library that would allow me to monitor a git repo for changes.
Consider it like inotify, but for a git repository (in fact, I think
it would probably have inotify under the hood).

This hypothetical library would trigger an event any time the
repository was modified, i.e. any time the graph that represents
history was changed.

Is there such a library? If not, is there a better way to monitor the
repository so that I wouldn't need to write it myself? Would anyone
else be interested if I wrote it myself?

Cheers,


Robert
