From: Matthew Persico <matthew.persico@gmail.com>
Subject: GIT_CONFIG - what's the point?
Date: Thu, 31 Mar 2016 20:54:26 -0400
Message-ID: <CAL20dLDQsti1qW7CrrEifPAhPp1snq9r5MgJL+mDwhLqhe6fyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 01 02:54:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alnMQ-0006cJ-O2
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 02:54:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757617AbcDAAyq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 20:54:46 -0400
Received: from mail-yw0-f171.google.com ([209.85.161.171]:34247 "EHLO
	mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752210AbcDAAyq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 20:54:46 -0400
Received: by mail-yw0-f171.google.com with SMTP id h129so124346512ywb.1
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 17:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=4ylKYxMKGWZTSQePRKUpqF6xvBXFs2HoCV1u9RI9UYA=;
        b=WUsTmX+2XZFToVcaQqRZctlRf54Kbz2qwT5KDLDM5khIRvV2akkbSm8BeOX86/AcOh
         +ILVsp1M2ez5CZ9gwwHetrfvZnaHnD44m3hobqrtgkotWc82Y6ctIzIsMWoWI6ezZsHp
         rX/dcqo2TwfZuY0H/AlPiCIhy610bjgx4fwG0vBSyUWQkQgRyCPcZBBphHMiEuTtDhkO
         /gGKdjMm9G2oy53qvwOPXnCO7zJZqACpGlBdQ235oI1/UfUPFr7GFPsMhUUvbBbeQ6uk
         cIl632jSfdUwUUuN6Jd6o+v4iu537IpV7HUcxdZi7SD8CDtSApjW6FqnQNcoMpMTvgl5
         crZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=4ylKYxMKGWZTSQePRKUpqF6xvBXFs2HoCV1u9RI9UYA=;
        b=WDNev0BKPJEciLxmB9aNHhdpjvdvyYlkCslA9Ea+6ptEeYXaXBc2BbbVxUgQfglhNu
         acm3MW0o//CyS+Cr8xmuZ6NXX7HVuhQGoaRWUG/kaqU888XMOvYyhQRhu4ebln8OjmWK
         th8wTgkQ4YXAsCI1KpbdygVn3AD8TAvPfmgCePlHk0j+JJOUxN1i2zSAjiAlAWccMeW/
         YK5O3P9nqa6Wxqs+1U027jl7nEqOLkcbRzJo6DgfkF1ZXIwJYW24gT/uCay0bBrKf4U0
         fHIuwfSmfm3UFeiPltz/fqsVad7FxlYAIYQlgkZd14SR03pOd/A/5B/osIVURDFyoh54
         GEDw==
X-Gm-Message-State: AD7BkJIUxYLUQJhCKvW/LDr74zaG/Z8rC6xcUltKH1+A3ZnpHTdGZiVDx1kQI9AbupWB8WjgNjnbT2L0ybFnRA==
X-Received: by 10.176.0.246 with SMTP id 109mr830993uaj.33.1459472085623; Thu,
 31 Mar 2016 17:54:45 -0700 (PDT)
Received: by 10.159.54.228 with HTTP; Thu, 31 Mar 2016 17:54:26 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290503>

Greetings.

Given the GIT_CONFIG environment variable can change 'git config'
behaves, it stands to reason that if GIT_CONFIG is defined, then ALL
git commands obey the value of GIT_CONFIG and use that file for config
info.

As a test, exported GIT_CONFIG=/tmp/ohm, copied ~/.gitconfig to
/tmp/ohm, moved ~/.gitconfig to ~/.gitconfig.hold and then tried git
st, where 'st' is an alias for status in my config file.

No dice. git st was unrecognized.

So, what's the point of GIT_CONFIG if only git-config uses it? Or did
I miss a step?

Thanks

-- 
Matthew O. Persico
