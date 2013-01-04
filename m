From: Adam Baxter <voltagex@voltagex.org>
Subject: Fwd: Git hangs after resolving deltas when using NTLM proxy on Windows
Date: Fri, 4 Jan 2013 11:28:44 +1100
Message-ID: <CAChFQ9TGvNdGZjPnyRM7TUK85VjtNpd=FYiiK_XEbHO6Zu--Xg@mail.gmail.com>
References: <CAChFQ9S7wf8i_UJayRAKYzJo2nnqYGCyuZfzdpdQcq_JvG=a1A@mail.gmail.com>
	<CAChFQ9QYt6ncpD2zwQu+ziD98J+aOd4TWAJR9dLdDs69bskZ2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 04 01:29:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tqv9k-0002pS-Ow
	for gcvg-git-2@plane.gmane.org; Fri, 04 Jan 2013 01:29:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754298Ab3ADA2q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2013 19:28:46 -0500
Received: from mail-qc0-f175.google.com ([209.85.216.175]:41639 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753722Ab3ADA2o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2013 19:28:44 -0500
X-Greylist: delayed 743 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Jan 2013 19:28:44 EST
Received: by mail-qc0-f175.google.com with SMTP id j3so8290963qcs.20
        for <git@vger.kernel.org>; Thu, 03 Jan 2013 16:28:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:x-gm-message-state;
        bh=WhrpQc9lmEPXBJHPC1KFgWJ5oQ/AamffutxAketBDQA=;
        b=GODUN1pxVl2rFH3kl8aCM/eQ8nUhm/e5zU4pxBQT+Lszpz+e96Lz1xhceokayvAHv8
         nCsGjdCzN1buGOwctx1W0Ywp5NrNbYNcFzUfp0Hqth6ldy9EbL3f0YDAx6/x60v/PdC7
         LVoaenBM7XmD3blWvHw+rbm/StZxrK7foGkYjWEqkH3NWP2FFXngLDuXEoVRy96TsP2Q
         YXW0wqZ89XIg6mTLlLi0nhqTvM5luvELVzbyOuhhEEkq6TaMDXoO8kUtogIiswceyr3+
         bNct75b4O04N0AO7MWnb0DwxqWJFbpcBsbH5g4ubjswyCXdGodn7WSenM0b7b/BTgCLD
         gxWA==
Received: by 10.224.223.80 with SMTP id ij16mr28470373qab.8.1357259324089;
 Thu, 03 Jan 2013 16:28:44 -0800 (PST)
Received: by 10.49.87.227 with HTTP; Thu, 3 Jan 2013 16:28:44 -0800 (PST)
In-Reply-To: <CAChFQ9QYt6ncpD2zwQu+ziD98J+aOd4TWAJR9dLdDs69bskZ2g@mail.gmail.com>
X-Gm-Message-State: ALoCoQksF8XF4ob63qvU8k3RHZqnkhL8QpVX3mIGhdx21feI60F2FaCOhODyVCZ5WEoOy7a/i44M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212623>

Hi,
Git is authenticating to my corporate proxy correctly, but is hanging
after "resolving deltas".

This is when cloning via HTTPS.

Apologies for linking to a Gist, but I'm having difficulty getting
this list to accept a log file attachment.
See https://gist.github.com/4448684 for the curl log.

Regards,
Adam
