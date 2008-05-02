From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH] Make words boundary for --color-words configurable
Date: Fri, 2 May 2008 11:14:08 +0300
Message-ID: <20080502081408.GA11420@mithlond.arda.local>
References: <1209699564-2800-1-git-send-email-pkufranky@gmail.com> <alpine.DEB.1.00.0805020839200.2691@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ping Yin <pkufranky@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 02 10:15:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrqQ9-0000Eq-EP
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 10:15:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756823AbYEBIOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 04:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755937AbYEBIOU
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 04:14:20 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:54198 "EHLO
	kirsi1.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756760AbYEBIOT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 04:14:19 -0400
Received: from mithlond.arda.local (80.220.180.181) by kirsi1.rokki.sonera.fi (8.0.013.9)
        id 481786910026C95D; Fri, 2 May 2008 11:14:16 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1JrqPA-00035J-W0; Fri, 02 May 2008 11:14:08 +0300
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0805020839200.2691@eeepc-johanness>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80968>

Johannes Schindelin wrote (2008-05-02 08:45 +0100):

> On Fri, 2 May 2008, Ping Yin wrote:
> 
> > Previously --color-words only allow spaces as words boundary.
> > However, just space is not enough. For example, when i rename
> > a function from foo to bar, following example doesn't show as
> > expected when using --color-words.
> 
> Thanks for starting this.
> 
> However, as Junio pointed out, it is easier to specify
> word-characters, rather than non-word characters (think TAB), and...

Just a quick note from someone who is not so much a programmer but who
uses Git to track text/LaTex/etc. files with human languages: Please
don't make this kind of things too Ascii-specific and too much
byte-is-interpreted-as-character type thing. 

In general, my opinion is that with international text it's better to
define word boundary characters than trying to maintain a _huge_ list of
characters used within words in different human languages.
