From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] GIT-VERSION-GEN: Do not require tags to be annotated
Date: Fri, 06 Sep 2013 19:37:32 -0500
Message-ID: <522a754cee731_382e8cde804656@nysa.mail>
References: <522A36AA.3050701@gmail.com>
 <xmqqeh91wrvq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 07 02:47:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VI6gH-00071w-26
	for gcvg-git-2@plane.gmane.org; Sat, 07 Sep 2013 02:47:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897Ab3IGArB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 20:47:01 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:55081 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890Ab3IGAqv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 20:46:51 -0400
Received: by mail-ob0-f174.google.com with SMTP id wd6so4171676obb.33
        for <git@vger.kernel.org>; Fri, 06 Sep 2013 17:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=kBFLCBvTqFL7kX+F8QznwsL9xmi+tMAm7MpzeAPD/BA=;
        b=pd6yviPzA1VR7GQ8gEXHj9eV70IhNO5f0FQ4NqVkp36h6vsi70Jb36+S3KpCy0UrQO
         IkDBzrejU1DwhPf/wMahVtEGENAGcgnnE7MA5VpZTXA9xlaRTnPL5m5QgTKnowWokI+z
         OesluQEvwTY9B5Eag5bdTJQgeWUdHZxGWMpi16wj/0egLslWFNNhkl8pnEtVr3RY5/2p
         mdhzV60l7RHI9tj4FU42Yy9nFWSyUw4H8GaolH4fG2jR42qHU3a88554+XexkRQ2x/X+
         9nlN38wx6+VGqODZPvP0ViutiP8gpJBeXZ9iYEh9cy2orQEgn/ppJOxWs/Rh0LqPsU6s
         t+IQ==
X-Received: by 10.182.237.44 with SMTP id uz12mr3904372obc.11.1378514810385;
        Fri, 06 Sep 2013 17:46:50 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id nw5sm576352obc.9.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 06 Sep 2013 17:46:49 -0700 (PDT)
In-Reply-To: <xmqqeh91wrvq.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234110>

Junio C Hamano wrote:
> Sebastian Schuberth <sschuberth@gmail.com> writes:
> 
> > For custom builds of Git it sometimes is inconvenient to annotate tags
> > because there simply is nothing to say, so do not require an annotation.
> >
> > Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
> > ---
> 
> Hmmmm, personally I'd actually want this to stay the way it is, or
> even require a valid signed tag, in order to make sure I won't
> mistakenly creating a lightweight tag.

So the only user Git should care about is you? If Git can make _you_ more
confortable not making certain mistakes, then that's the way it should be?

What's the point of lightweight tags anyway? 'git describe' doesn't use them,
GIT-VERSION-GEN neither, just remove them already.

For the vast majority of the people out there, a tag is a tag. Period.

-- 
Felipe Contreras
