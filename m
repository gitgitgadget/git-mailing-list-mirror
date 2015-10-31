From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: Re: [PATCH] checkout: refactor of --progress option
Date: Sat, 31 Oct 2015 12:45:49 -0600
Message-ID: <CAOc6etah_GFgQNKLKRtWDLzUd0UV2SDTCjq6t3y5B8hGJb1eoQ@mail.gmail.com>
References: <1446310669-9790-1-git-send-email-eantoranz@gmail.com>
	<CAOc6etasvk6f0XhJumwXtYiC7h_ufQUAyN1BktQ=qdd4_f0hSQ@mail.gmail.com>
	<CAOc6etb+Fom9t=2R=opR-fKYDkR1X6FFA=OGyQqo8HWycgqUVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 31 19:45:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsbA2-0005tt-Mx
	for gcvg-git-2@plane.gmane.org; Sat, 31 Oct 2015 19:45:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbbJaSpu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Oct 2015 14:45:50 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35911 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920AbbJaSpt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Oct 2015 14:45:49 -0400
Received: by pacfv9 with SMTP id fv9so109584939pac.3
        for <git@vger.kernel.org>; Sat, 31 Oct 2015 11:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=EpgSWvsD2IncQB0BIYpQ3rtyjfR0mXEXPmH2bCP/x0E=;
        b=QKxYaXOTe/OGP/7EOz6SP/pEmNV2Dt9Cx2E9G4Vik2ZbShEUpsZektSLTKKuxiOvB+
         mqwpBM5no9RmGilTYLYX5APwkna78k/DQzFE8f+mWs+7cxy25koIKAhg6mYS97jiDmCt
         b2tLFRKXIiNzdYDAIkyaaax+tMSFnBSiINzE21fUSZxR1u24u58zCCMJfOuXjhH0AC6J
         RRr+XMnL6Id5G4z7/+HA4zs411j7XCGYajvkNWpxpoDnFv+LrDFwMWflwSOscfXGHAbf
         MuoDGW9rpDGnab2cQfT7gozoy62ovcV/Z0VqH0PlTBe4zfN8pirvoX3wIO6oeP+EHAPa
         Bgiw==
X-Received: by 10.68.134.232 with SMTP id pn8mr16277298pbb.47.1446317149215;
 Sat, 31 Oct 2015 11:45:49 -0700 (PDT)
Received: by 10.66.149.4 with HTTP; Sat, 31 Oct 2015 11:45:49 -0700 (PDT)
In-Reply-To: <CAOc6etb+Fom9t=2R=opR-fKYDkR1X6FFA=OGyQqo8HWycgqUVw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280597>

Disregard this patch.
