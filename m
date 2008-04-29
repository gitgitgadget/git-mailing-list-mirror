From: "Geoffrey Irving" <irving@naml.us>
Subject: Re: About git and the use of SHA-1
Date: Tue, 29 Apr 2008 14:39:46 -0700
Message-ID: <7f9d599f0804291439m6f5dd242jb31b84e1a0205cdc@mail.gmail.com>
References: <20080429124152.GB6160@dpotapov.dyndns.org>
	 <alpine.LFD.1.10.0804291132060.23581@xanadu.home>
	 <7f9d599f0804290859y6a579302m5db9f7f827b320a4@mail.gmail.com>
	 <alpine.LFD.1.10.0804291232130.23581@xanadu.home>
	 <7f9d599f0804291048n2c706f3amdf159ffe86bdbc8@mail.gmail.com>
	 <alpine.LFD.1.10.0804291352120.23581@xanadu.home>
	 <7f9d599f0804291102j4a30c344h18d12d03a6d5953b@mail.gmail.com>
	 <alpine.LNX.1.00.0804291410340.19665@iabervon.org>
	 <7f9d599f0804291331v2f44bee1y29c1580d68a3107a@mail.gmail.com>
	 <20080429205031.GA14547@frsk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Daniel Barkalow" <barkalow@iabervon.org>,
	"Nicolas Pitre" <nico@cam.org>, "Andreas Ericsson" <ae@op5.se>,
	"Dmitry Potapov" <dpotapov@gmail.com>,
	"Henrik Austad" <henrikau@orakel.ntnu.no>, git@vger.kernel.org
To: "Fredrik Skolmli" <fredrik@frsk.net>
X-From: git-owner@vger.kernel.org Tue Apr 29 23:40:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqxYx-00034f-KL
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 23:40:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752916AbYD2Vju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 17:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbYD2Vjt
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 17:39:49 -0400
Received: from po-out-1718.google.com ([72.14.252.157]:11268 "EHLO
	po-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752791AbYD2Vjs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 17:39:48 -0400
Received: by po-out-1718.google.com with SMTP id b23so78368poe.1
        for <git@vger.kernel.org>; Tue, 29 Apr 2008 14:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=OSbM/rB4nw84zos6PxBS+XD8KzuACJ1wovMky1nCNIA=;
        b=RRJ296O/BtPu7PeY7Gc90uDR8CXwT1tinpKCN/AcWPFKWuEl+qtXqRdblNFTDI5HcNEdcLvMeUZlhBiJ3tSvmgC0kgm8DHJKsJqkg1msMPxoqKozJ8foXuJMr6Nk441sd0ooOrkZ5HOQtye36eUypbyHpI5JKGZtYYJyVfj7KQs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=FOCkFM5UBzzemeOfxeMovmh3ExI+ANwAy6tPwrVNB7aNvMDv5obOa7fkNIX8qbQfPRPLtZ4MLkGGLrRZ3/WbM4iRCsHfqoh6/fynoSV0GHHNxISfsEFNC0LcBJDo6WmI9t7rkhPuiVrcOkOU0HmdT6WyQ0NNSDh7SaIdqJMPtao=
Received: by 10.140.165.21 with SMTP id n21mr3422792rve.45.1209505186939;
        Tue, 29 Apr 2008 14:39:46 -0700 (PDT)
Received: by 10.140.178.16 with HTTP; Tue, 29 Apr 2008 14:39:46 -0700 (PDT)
In-Reply-To: <20080429205031.GA14547@frsk.net>
Content-Disposition: inline
X-Google-Sender-Auth: e500f8f6d050d465
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80745>

On Tue, Apr 29, 2008 at 1:50 PM, Fredrik Skolmli <fredrik@frsk.net> wrote:
> On Tue, Apr 29, 2008 at 01:31:51PM -0700, Geoffrey Irving wrote:
>
>  > I sincerely hope that pdf/postscript don't allow the internal
>  > rendering code to branch based on the current date.  That would be an
>  > absurd security hole, and would indeed make you entirely correct.  If
>  > you actually know that it is possible to write that in postscript, I
>  > would very much want to see an example.
>
>  Have a look at
>
>  * http://th.informatik.uni-mannheim.de/People/Lucks/HashCollisions/letter_of_rec.ps
>  vs
>  * http://th.informatik.uni-mannheim.de/People/Lucks/HashCollisions/order.ps
>
>  both found on a website[1] already mentioned[2] in this thread. :-)
>
>  [1]: http://th.informatik.uni-mannheim.de/People/Lucks/HashCollisions/
>  [2]: http://marc.info/?l=git&m=120949349923584&w=2

This is an example of a hash collision, not conditional rendering
based on the current date.  I.e., you didn't actually read my email or
the email I was replying to. :)

Geoffrey
