From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/3] imap-send.c: Clean up coding style to better match the rest of the git codebase.
Date: Sat, 12 Jul 2008 14:38:34 +0200
Message-ID: <200807121438.34543.jnareb@gmail.com>
References: <1096648c0807070105s2b4ea1d9t2ab1eb17e891e3e8@mail.gmail.com> <m3zloteukz.fsf@localhost.localdomain> <1096648c0807081621x669a9bc4ie484fd004674918d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Rob Shearman" <robertshearman@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 12 14:39:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHeO7-0007Ta-MG
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 14:39:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753068AbYGLMiq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2008 08:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753050AbYGLMiq
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 08:38:46 -0400
Received: from gv-out-0910.google.com ([216.239.58.190]:19302 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752973AbYGLMip (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2008 08:38:45 -0400
Received: by gv-out-0910.google.com with SMTP id e6so772710gvc.37
        for <git@vger.kernel.org>; Sat, 12 Jul 2008 05:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=xRl5Eq2P5SvHDLKIQ7tN4rLqkbcaadDd9+dOLHYQa10=;
        b=YxUDFEJnRh9mcFFT3YbWT61x0fYKpxhUlgouBGI4nWF66YD6j0bQyFbJse1X61i21y
         hKHjW/0ybFBkz70TEzKb80cpTdBXgbBFM1UtWYlvOrU74L6ywije/dv1E1cqXvpVxrIQ
         nPlSWzepE04EAgc3z8a7FqYGeDUXs+4EsDiwM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=P/gOAVNDXwKpMAYGEXnzffE2ZQBMPYjIcwLFGkmgodnP5PG2Tz8nv4vUVNHZEPM7ZY
         clOC0QH2yt6QZpeLpLHmm7vdeCopY65rZ+5uEdJ3GT58dchshmFQKLxhGl1+htDY3GNE
         +DWGE1C8LlP41Jy0zK5toplFxG7M08W2BJmzo=
Received: by 10.103.114.14 with SMTP id r14mr6229941mum.120.1215866323927;
        Sat, 12 Jul 2008 05:38:43 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.204.111])
        by mx.google.com with ESMTPS id u9sm9128676muf.12.2008.07.12.05.38.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 12 Jul 2008 05:38:42 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1096648c0807081621x669a9bc4ie484fd004674918d@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88239>

On Wed, 9 July 2008, Rob Shearman wrote:
> 2008/7/7 Jakub Narebski <jnareb@gmail.com>:

> > or use either git-send-email
> > (I think you can send patches also via Gmail) or git-imap-send,
> 
> Ok, but git-imap-send only puts the emails into your Drafts folder so
> that you can send them with your normal email client (which is what
> does the linewrapping).

Errr... if you are using normal email client, then it should be
possible to turn off line wrapping in the client, isn't it?
 
[...]
> > then preferred solution is to have patch inline.
> >
> > If it is not possible, then attach the patch, but preferrably
> >  1) with text/plain mimetype (.txt extension instead of .patch or
> >    .diff could be required for that)
> >
> >  2) 8bit (preferred) or quoted-printable (if 8bit is not possible)
> >    transfer encoding (base64 is terrible waste of space); text/plain
> >    should chose quoted-printable at worst
> >
> >  3) use "inline" attachement (select 'suggest to display attachement'
> >    or something like that), so it is possible to select attachement
> >    and hit reply.
> 
> I think this was the case with the patches originally sent, but I used
> "git format-patch --attach --stdout ... | git imap-send" so if the
> mails didn't meet one of those points then it should be fixed in
> git-format-patch.

"git format-patch --inline --stdout", perhaps?

-- 
Jakub Narebski
Poland
