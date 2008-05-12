From: "Govind Salinas" <govind@sophiasuchtig.com>
Subject: Re: Why repository grows after "git gc"? / Purpose of *.keep files?
Date: Mon, 12 May 2008 16:07:56 -0500
Message-ID: <5d46db230805121407pdb3f6fdnd41898d3dde6862b@mail.gmail.com>
References: <20080512122900.GA13050@mithlond.arda.local>
	 <20080512155243.GA3592@mithlond.arda.local>
	 <alpine.DEB.1.00.0805121810501.30431@racer>
	 <20080512184334.GB5160@mithlond.arda.local>
	 <alpine.LFD.1.10.0805121453250.23581@xanadu.home>
	 <20080512190946.GC5160@mithlond.arda.local>
	 <alpine.LFD.1.10.0805121527550.23581@xanadu.home>
	 <5d46db230805121310q5a0c6037p769ea091c26284d0@mail.gmail.com>
	 <alpine.LFD.1.10.0805121704140.23581@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Teemu Likonen" <tlikonen@iki.fi>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon May 12 23:09:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvfGT-0002c0-9N
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 23:08:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756037AbYELVIH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 17:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755920AbYELVIG
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 17:08:06 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:53415 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755631AbYELVIE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 17:08:04 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1402311ywe.1
        for <git@vger.kernel.org>; Mon, 12 May 2008 14:07:56 -0700 (PDT)
Received: by 10.150.92.12 with SMTP id p12mr8782460ybb.238.1210626476629;
        Mon, 12 May 2008 14:07:56 -0700 (PDT)
Received: by 10.150.181.17 with HTTP; Mon, 12 May 2008 14:07:56 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0805121704140.23581@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81952>

On Mon, May 12, 2008 at 4:06 PM, Nicolas Pitre <nico@cam.org> wrote:
> On Mon, 12 May 2008, Govind Salinas wrote:
>
>  > On Mon, May 12, 2008 at 2:36 PM, Nicolas Pitre <nico@cam.org> wrote:
>
> > >  Sure.  But to decide to track only one branch and exclude the others
>  > >  require some higher level of git knowledge already.  At that point if
>  > >  you really care about top packing performances you certainly can deal
>  > >  with the .keep file as well.
>  >
>  > I have had some similar problems with .keep files.  I cloned a repo I
>  > created that had a branch that I wasn't interested in.  I deleted the
>  > branch and then I could never get rid of the (large) number of objects
>  > in that pack until I deleted the .keep and repacked.
>
>  But as soon as you just "git pull" you'll get the deleted branch back.
>
>
If you read the rest of my mail, you will see where I removed it from the
hosted server as well.  But with difficulty.

Thanks,
Govind.
