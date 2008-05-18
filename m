From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [PATCH] "not uptodate" changed to "has local changes"
Date: Sun, 18 May 2008 13:11:07 +0200
Message-ID: <bd6139dc0805180411k4a2edee3ueef178c141744b35@mail.gmail.com>
References: <1209833972-12256-1-git-send-email-timcharper@gmail.com>
	 <alpine.DEB.1.00.0805161125320.30431@racer>
	 <1ED37CF1-EABD-4881-BA29-ED2CB1CE73FC@sb.org>
	 <b8bf37780805162030m4c961505nabd72e8f5bd08404@mail.gmail.com>
	 <alpine.DEB.1.00.0805171102480.30431@racer>
	 <e06498070805170744l7ad213aeqb779b0c0381e1de4@mail.gmail.com>
	 <bd6139dc0805170912w14b7894fxfebe15c14e4c44ef@mail.gmail.com>
	 <alpine.DEB.1.00.0805171939540.30431@racer>
	 <bd6139dc0805171314i29daf0det47d9ad8f9e7d76a7@mail.gmail.com>
	 <200805181032.m4IAWjE0012832@mi0.bluebottle.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Steven Walter" <stevenrwalter@gmail.com>,
	"=?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?=" <andre.goddard@gmail.com>,
	"Kevin Ballard" <kevin@sb.org>,
	"Mike Ralphson" <mike.ralphson@gmail.com>,
	"Tim Harper" <timcharper@gmail.com>, git@vger.kernel.org
To: "=?ISO-2022-JP?B?GyRCJDckaSQkJDckSiRKJDMbKEI=?=" 
	<nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Sun May 18 13:12:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxgoN-0007c6-2h
	for gcvg-git-2@gmane.org; Sun, 18 May 2008 13:12:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752248AbYERLLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2008 07:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751973AbYERLLK
	(ORCPT <rfc822;git-outgoing>); Sun, 18 May 2008 07:11:10 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:51105 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779AbYERLLJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2008 07:11:09 -0400
Received: by wf-out-1314.google.com with SMTP id 27so926679wfd.4
        for <git@vger.kernel.org>; Sun, 18 May 2008 04:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=rcLcC3VZgdpegmU+otxNrRvknNvZrCt6d+YOazE0y84=;
        b=OcGfG08E2SjBBuR3wpPXDqRu90HiHnGwS2xiNF4XT7OYX9ZXB41O45HIv8MRDTVn+tSzkcy4SFk3hfWWkB62OVKwBzWDxK6pWmeSCk5KXEp/+OQBNHatA9MKMah+AtsCSCMjQjmCaX1xd03NnJ3/9VCeb6oDjZ4FgNp5nbgC5Lw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=w/f5EAUzV31SQWiL1JapmNQsCCpth6dskh5AzvdPerv5PE5O0u70d5oklPZI8dqlIBeRERZtg6uS1R8sRPZi7lhnng6pAbe7c7nioQ+YR655Ck6DHyfePXMY7uyYImSHL5ZqXG2IzU7DKxsLcnF+CxBkJL4rFLZlnDhH1W5nBbc=
Received: by 10.143.3.4 with SMTP id f4mr2341924wfi.256.1211109068039;
        Sun, 18 May 2008 04:11:08 -0700 (PDT)
Received: by 10.143.33.6 with HTTP; Sun, 18 May 2008 04:11:07 -0700 (PDT)
In-Reply-To: <200805181032.m4IAWjE0012832@mi0.bluebottle.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82380>

On Sun, May 18, 2008 at 12:31 PM, しらいしななこ <nanako3@bluebottle.com> wrote:
> What advantage are you bringing to the table for them to be worth bothering to update, other than "if they update then they can get their scripts working again after you break them by rewording messages for no good reason"? Why do you punish the old-timers for using the well established API?

My reason was that (perhaps not as much in this case, but I meant to
speak in general) the message is confusing/not clear enough.

> Did you study Junio's patch before you responded to his message? The point of the suggestion was that he reworded the message given by git-checkout that is a porcelain command without breaking output from read-tree that is a plumbing command. In other words, you can improve output from porcelain commands without making unnecessary changes to plumbing.

I hadn't read his e-mail when I was replying, my Internet has been
playing up lately (same for about half of the Netherlands due to a
problem at one of our biggest ISPs). I did reply to it though:
http://thread.gmane.org/gmane.comp.version-control.git/81100

-- 
Cheers,

Sverre Rabbelier
