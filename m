From: Kevin Green <Kevin.T.Green@morganstanley.com>
Subject: Re: [PATCH] git-p4: Work around race between p4_edit and p4_change
Date: Fri, 11 Apr 2008 12:27:59 -0400
Message-ID: <20080411162759.GO22542@morganstanley.com>
References: <20080401222856.GA22542@morganstanley.com> <200804032032.39860.simon@lst.de> <20080403184537.GH22542@morganstanley.com> <20080403195135.GI22542@morganstanley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Simon Hausmann <simon@lst.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 11 18:29:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkM7p-0004bN-VY
	for gcvg-git-2@gmane.org; Fri, 11 Apr 2008 18:29:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761481AbYDKQ2F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2008 12:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761292AbYDKQ2F
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 12:28:05 -0400
Received: from pimtabh1.ms.com ([199.89.64.101]:50424 "EHLO pimtabh1.ms.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761481AbYDKQ2E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2008 12:28:04 -0400
Received: from pimtabh1 (localhost.ms.com [127.0.0.1])
	by pimtabh1.ms.com (output Postfix) with ESMTP id B7A2948C6E;
	Fri, 11 Apr 2008 12:27:59 -0400 (EDT)
Received: from ny0019as01 (unknown [144.203.194.205])
	by pimtabh1.ms.com (internal Postfix) with ESMTP id 9E9EDA94019;
	Fri, 11 Apr 2008 12:27:59 -0400 (EDT)
Received: from hn314c1n12 (localhost [127.0.0.1])
	by ny0019as01 (msa-out Postfix) with ESMTP id 907F4104448F;
	Fri, 11 Apr 2008 12:27:59 -0400 (EDT)
Received: from menevado.ms.com (unknown [144.203.222.190])
	by ny0019as01 (msa-in Postfix) with ESMTP id 71F6A88066;
	Fri, 11 Apr 2008 12:27:59 -0400 (EDT)
Received: (kgreen@localhost) by menevado.ms.com (8.12.11.20060308/sendmail.cf.client v1.05) id m3BGRxKV024580; Fri, 11 Apr 2008 12:27:59 -0400
X-Authentication-Warning: menevado.ms.com: kgreen set sender to Kevin.T.Green@morganstanley.com using -f
Mail-Followup-To: Simon Hausmann <simon@lst.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20080403195135.GI22542@morganstanley.com>
User-Agent: Mutt/1.5.6i
X-Anti-Virus: Kaspersky Anti-Virus for MailServers 5.5.15/RELEASE, bases: 11042008 #626342, status: clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79279>

On 04/03/08 15:51:35, Kevin Green wrote:
> On 04/03/08 14:45:38, Kevin Green wrote:
> > On 04/03/08 14:32:32, Simon Hausmann wrote:
> > > 
> > > Last but not least we could of course also generate the entire Files: section 
> > > ourselves, using 'p4 change -o' just to get the rest of the template right.
> > > 
> > > I almost prefer the last approach, since we know the base depot path and the 
> > > relative paths of all edited/added files.
> > > 
> > > What do you think?
> > > 
> > 
> > Thank you...  That's the right approach.  Stop as soon as we get to the Files:
> > section and then just add in the depot + filepath string for each change...
> > 
> 
> And here's the patch that does what we just described...
> 

Haven't heard comment back on this patch.  Am wondering if it will be applied
to git, or if I need to start thinking about maintaining it myself on my end,
or if it's not appropriate and I should re-submit something else.


Thanks

--Kevin
