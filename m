From: Michael Witten <mfwitten@gmail.com>
Subject: Re: git send-email: How to modify subject prefix?
Date: Fri, 24 Apr 2009 10:23:03 -0500
Message-ID: <b4087cc50904240823nea4ef2ep20f2060f48395f74@mail.gmail.com>
References: <85647ef50904240818s41fffc2eh798083a24ab53750@mail.gmail.com>
	 <b4087cc50904240820r567020d7gaa7cecaa0f3b78fa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Constantine Plotnikov <constantine.plotnikov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 17:25:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxNHX-0002ET-Gg
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 17:25:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754728AbZDXPXH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 11:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753825AbZDXPXG
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 11:23:06 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:22896 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755371AbZDXPXF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 11:23:05 -0400
Received: by qw-out-2122.google.com with SMTP id 5so959411qwd.37
        for <git@vger.kernel.org>; Fri, 24 Apr 2009 08:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sql924eJFtU9f7dI7bARbfzbaKT1X8IzvqgrU94YGtg=;
        b=dNdUfIASyOmmxqDptGLVZqVu1NiQ0TPr5mFKNE7GXeh/wFGmCBORnhf15KDYZHzxZy
         0RR8D4UdmXwn4+qRMThxhAzPX4alQHfvBII7Jt5EHV0HblfNtXQ4lqN0BPILjRz1YxGk
         1+5zTwtx/YOx7oU+YW01l8inY5e6q5xvfeeCA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gTUiSqByZJPwPZC0Laix+62NzsMVqfwHR4twctLalNULny5rCzJ8ERzZh4BXHViZ96
         jDyH+fvzICHHVvLsK6UxXkYePSKdEVHY8iPguTARRNvCPjBy/VdS9mGsJTy/2IIBKDI8
         fsmtxqeFLyMny8gJjQZK7iS+q/Xcuiej8DwlI=
Received: by 10.224.67.133 with SMTP id r5mr2872364qai.285.1240586583847; Fri, 
	24 Apr 2009 08:23:03 -0700 (PDT)
In-Reply-To: <b4087cc50904240820r567020d7gaa7cecaa0f3b78fa@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117455>

On Fri, Apr 24, 2009 at 10:20, Michael Witten <mfwitten@gmail.com> wrote:
> On Fri, Apr 24, 2009 at 10:18, Constantine Plotnikov
> <constantine.plotnikov@gmail.com> wrote:
>> I'm interested how to modify subject prefix when sending patches using
>> git send-email. I want it to prefix the subject with [JGIT PATCH]
>> instead of [PATCH] and I have not found any option that allows it.
>
> The option is format-patch's --subject-prefix
>

Looking at the source for send-email, it would appear you can do the
following if you don't want to run format-patch separately:

    git send-email $send_email_args -- $format_patch_args

That should be documented!
