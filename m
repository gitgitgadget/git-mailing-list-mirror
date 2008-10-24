From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [RFC] Zit: the git-based single file content tracker
Date: Fri, 24 Oct 2008 21:51:29 +0200
Message-ID: <cb7bb73a0810241251w4c2486a0x4684a25b364ebbbb@mail.gmail.com>
References: <gdok16$vh2$1@ger.gmane.org> <4901077A.7050904@gmx.ch>
	 <cb7bb73a0810232355u6de0479cyc260c80227f44e59@mail.gmail.com>
	 <m38wsei8ne.fsf@localhost.localdomain>
	 <7vabct3l1e.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.10.0810241159290.27333@asgard.lang.hm>
	 <cb7bb73a0810241242y7467f6fexcca4b7cd768e7992@mail.gmail.com>
	 <alpine.DEB.1.10.0810241244170.27333@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Jakub Narebski" <jnareb@gmail.com>,
	"Jean-Luc Herren" <jlh@gmx.ch>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Fri Oct 24 21:52:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtSiD-0007wK-8w
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 21:52:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752756AbYJXTvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 15:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752568AbYJXTvb
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 15:51:31 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:61210 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793AbYJXTvb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 15:51:31 -0400
Received: by yx-out-2324.google.com with SMTP id 8so369232yxm.1
        for <git@vger.kernel.org>; Fri, 24 Oct 2008 12:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=RZoWwiYSYLqS6r5TlJ/GdB+IsJDO95IUvT2zKT8rHkg=;
        b=ghtK3YrFzCmLUpRplEzraIaRQJuKEl1G4WpMzpcZLboXK/Nij6SvRKMGNNtxF07B2e
         RmJweSlY/cwQ7ZsW0jMjGRLYt8E1JSN9W6FAVy71NwtRmxzHsBxLy/8OvQowcfTfkwMW
         0ZazuXa/mc+FfDHrnVMnGiL7G9vDDAEcfn4oU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=fCdzrg6EQT1jQjHGdmiXqvmRtR4C2fqf4QJ9kwJnMTz8ZrANJch3eHtDAV5ZZHt9LW
         G8mUjXFGLHqSZCxDIyPLedCW7rhOTRYSkZlEF5HlNajSThtxFEoUTjP5O9Mss3JsJBnj
         KsjS5aP8sma31P2MoWX7QSlnG9vcflWklaCIo=
Received: by 10.150.230.8 with SMTP id c8mr6447797ybh.47.1224877889767;
        Fri, 24 Oct 2008 12:51:29 -0700 (PDT)
Received: by 10.150.145.2 with HTTP; Fri, 24 Oct 2008 12:51:29 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.10.0810241244170.27333@asgard.lang.hm>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99056>

On Fri, Oct 24, 2008 at 9:46 PM,  <david@lang.hm> wrote:
> On Fri, 24 Oct 2008, Giuseppe Bilotta wrote:
>>
>> It seems that tags, hooks, branches and description can be done with.
>
> do you mean 'can be done away with'?

Ahem. Yes. I've got a patch ready for zit that gets rid of them.

(A smarter way would be to create a template, but I'm not smart.)

>> info contains exclude which is rather essential,
>
> is it? by default everything in this file is commented out. And with you
> only adding files explicitly why would it ever need to excluded anything?

Zit does
 		echo "*" > $GIT_DIR/info/exclude
and yes it sucks to use a whole block for a file that only contains
one character. Suggestions welcome.

The reason why we want the exclude is that when you do zit status
somefile you don't want every other file in the directory to come up
as 'not tracked'.

-- 
Giuseppe "Oblomov" Bilotta
