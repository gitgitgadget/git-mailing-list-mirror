From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] status&commit: Teach them to show commits of modified submodules.
Date: Sun, 11 Nov 2007 09:27:08 +0100
Message-ID: <8c5c35580711110027y3a17b9a0j16d3db5ffe606554@mail.gmail.com>
References: <1194722863-14741-1-git-send-email-pkufranky@gmail.com>
	 <8c5c35580711101607l7c45d6f5ge0f40ac6e447031a@mail.gmail.com>
	 <46dff0320711102224h7a14329ag27fcfcfcf479823e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Yin Ping" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 09:27:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ir8AF-0003Wx-UA
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 09:27:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752896AbXKKI1L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 03:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756536AbXKKI1L
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 03:27:11 -0500
Received: from wa-out-1112.google.com ([209.85.146.179]:19974 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756146AbXKKI1I (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 03:27:08 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1147773wah
        for <git@vger.kernel.org>; Sun, 11 Nov 2007 00:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=7Q5ErJxdnXkpA17Szunqtqvh9X8xkh3Iq0AtulnY8lY=;
        b=F/ig5AhigtaCwj7638pCQ3WCdw8TXGmX0V+POkmSNNiv7mhf9vNdeCrZVMCjV39Tlpx2HHjxqF2qQt+xyf7fGGre5can3l0EjCY9jqlW22i/sAcRmOQSXHOAXFanwQ+r8NLOs1sSQaQgPrmKlv1ZHzmGuBb8eqz/4XD21bJDM4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KlvG7y/EcmnBGiDWAqFjglkUG1SM/cZ7qVYrExyyqv6UkB21hVW1hedo2vdmiwsdEliGEkguMaqSmqNr2OuA2LnGgjTnY4yTQv540UmO/XWtmnzuyBkhQ1Wtf3iVUC1koi0XwbUai3zpi3KDLThR7C3evp6WNxKWfiB7SX4LzOA=
Received: by 10.115.94.1 with SMTP id w1mr1139044wal.1194769628423;
        Sun, 11 Nov 2007 00:27:08 -0800 (PST)
Received: by 10.114.235.4 with HTTP; Sun, 11 Nov 2007 00:27:08 -0800 (PST)
In-Reply-To: <46dff0320711102224h7a14329ag27fcfcfcf479823e@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64425>

On Nov 11, 2007 7:24 AM, Yin Ping <pkufranky@gmail.com> wrote:
> On Nov 11, 2007 8:07 AM, Lars Hjemli <hjemli@gmail.com> wrote:
> > On Nov 10, 2007 8:27 PM, Ping Yin <pkufranky@gmail.com> wrote:
> > > This commit teaches git status/commit to also show commits of user-cared
> > > modified submodules since HEAD (or HEAD^ if --amend option is on).
> >
> > Some nitpicks:
> > -we'll need a config option to enable/disable this output in git-status
> agree. default off?

That would be nice.

> > -the feature should probably be implemented in git-submodule.sh
> >
> I'll want to see the commits of submodules when editing commit msg.

If git-commit.sh uses git-submodule.sh to get this information, the
feature is still available in git-submodule even if it's disabled for
git-status.

--
larsh
