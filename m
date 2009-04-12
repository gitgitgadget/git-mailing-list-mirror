From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH RFC 08/10] send-email: Add --sleep for email throttling
Date: Sat, 11 Apr 2009 22:27:29 -0400
Message-ID: <76718490904111927y683ee4axe512dae9d58e19bb@mail.gmail.com>
References: <1239476908-25944-1-git-send-email-mfwitten@gmail.com>
	 <1239476908-25944-2-git-send-email-mfwitten@gmail.com>
	 <1239476908-25944-3-git-send-email-mfwitten@gmail.com>
	 <1239476908-25944-4-git-send-email-mfwitten@gmail.com>
	 <1239476908-25944-5-git-send-email-mfwitten@gmail.com>
	 <1239476908-25944-6-git-send-email-mfwitten@gmail.com>
	 <1239476908-25944-7-git-send-email-mfwitten@gmail.com>
	 <1239476908-25944-8-git-send-email-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 12 04:35:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LspXc-0002xY-V9
	for gcvg-git-2@gmane.org; Sun, 12 Apr 2009 04:35:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753745AbZDLC1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Apr 2009 22:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752916AbZDLC1b
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 22:27:31 -0400
Received: from mail-gx0-f160.google.com ([209.85.217.160]:36890 "EHLO
	mail-gx0-f160.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752291AbZDLC1b (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2009 22:27:31 -0400
Received: by gxk4 with SMTP id 4so3626349gxk.13
        for <git@vger.kernel.org>; Sat, 11 Apr 2009 19:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=M25xedKdsD5CW+0lWPzWMqshT4iykICTfxtQjDuAPag=;
        b=XEEB1DQmmD3y9y0yJhZ04A9mnVZgujrH8F/WNCnKU78lHC2BH3VSHLiBr7UR8QPYv/
         qaabbjZbW4O6V70dc9LLuMSsPj/hfR5E7phJrMxOu5wUWtUF080fZqmNBLbHDc9KXTYs
         iyjWuQfAq/U1AcIgHJRX8moMgt0luWNW+y5YE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QW2BYlGcIXZkvn4buFIJm2KSNxrjFcUUlza1d0LUyBc4/FuZVqpipgMbvVloY87JvP
         7db/dzlERnR9AkYEhisMHp320s/GB1qxj/aYtnXEMfCxAtWuW8AXIdZttI+uhznU0h/M
         Bdz+Tb1NEIWsTigTd6WXsTrsGxkxJPclEG+fA=
Received: by 10.150.217.14 with SMTP id p14mr9908293ybg.147.1239503249971; 
	Sat, 11 Apr 2009 19:27:29 -0700 (PDT)
In-Reply-To: <1239476908-25944-8-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116363>

On Sat, Apr 11, 2009 at 3:08 PM, Michael Witten <mfwitten@gmail.com> wrote:
> +if (defined $sleep) {{
> +}}

What's the double-brackets about?

j.
