From: Michael Witten <mfwitten@gmail.com>
Subject: Re: git send-email: How to modify subject prefix?
Date: Fri, 24 Apr 2009 10:34:55 -0500
Message-ID: <b4087cc50904240834q34200ee1qd9081b8c4480c83a@mail.gmail.com>
References: <85647ef50904240818s41fffc2eh798083a24ab53750@mail.gmail.com>
	 <b4087cc50904240820r567020d7gaa7cecaa0f3b78fa@mail.gmail.com>
	 <85647ef50904240828i76cf5f0en14a9fd2dc496a89d@mail.gmail.com>
	 <b4087cc50904240832u6d0a17b2gaad406a0176da883@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Constantine Plotnikov <constantine.plotnikov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 17:37:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxNSJ-0006gB-8a
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 17:36:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756428AbZDXPfA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 11:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755977AbZDXPe6
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 11:34:58 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:58895 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755941AbZDXPe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 11:34:58 -0400
Received: by qyk16 with SMTP id 16so2325398qyk.33
        for <git@vger.kernel.org>; Fri, 24 Apr 2009 08:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=VgVfEP76vJwljSArKXVx8lD1PptGioTzuE3zabelLks=;
        b=cNoy7ggukuEXNU/otVXYsQK/1vi1AL990OAb8pj4Sfzo5waqxH3yZwbYsfnkq6UVXP
         bHzgypEox5eM2Y0OV4oFhvsFFaNEMQadm/zgLR6NvObZTBtb2p3E6UYWVZ/dkytyfZ+3
         APPBy2BxH/XsAmt5SvOEbNQBiXI0RgwOZZ6zY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TTdBC9TI1vVQ1tLMwbpeV7pUlwyqEHBqWVZFp6iq6SFhk0clH/Bz13jbNuuF+Rtvw/
         UDFLI/2clUifsZ3rJQcXudpbqhmwcuxVD0+U/z+dsqCiZWXO6jqpXp9k/vx4Xqr03RwL
         f+ewD37D3sGvAtEBPtfnffuRXGkfPqWbz/9Sc=
Received: by 10.224.32.146 with SMTP id c18mr2954217qad.58.1240587295580; Fri, 
	24 Apr 2009 08:34:55 -0700 (PDT)
In-Reply-To: <b4087cc50904240832u6d0a17b2gaad406a0176da883@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117460>

On Fri, Apr 24, 2009 at 10:32, Michael Witten <mfwitten@gmail.com> wrote:
> The option --subject-prefix is documented in format-patch's man page
> (it is an option of format-patch, after all :-D).
>
> However, using '--' with send-email to pass along arguments to a call
> to format-patch is not documented in send-email's man page, and it
> should be.

I should add that I don't really like it though; it seems that it
makes the relationship to format-patch a little to close and implicit.
I would think that --format-patch-args would be better.
