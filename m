From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCHv5 2/6] Gitweb: add support for minifying gitweb.css
Date: Thu, 15 Apr 2010 01:18:30 +0100
Message-ID: <20100415001830.GA26416@hashpling.org>
References: <4BB430C3.9030000@mailservices.uwaterloo.ca>
 <4BC4D3F0.5020107@hashpling.org>
 <201004140030.47222.jnareb@gmail.com>
 <7viq7tmvsb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, Mark Rada <marada@uwaterloo.ca>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 15 02:18:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2Cn1-0001ZO-Ja
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 02:18:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753030Ab0DOASd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 20:18:33 -0400
Received: from relay.ptn-ipout02.plus.net ([212.159.7.36]:19036 "EHLO
	relay.ptn-ipout02.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751849Ab0DOASc (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Apr 2010 20:18:32 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEANr3xUvUnw4R/2dsb2JhbACbW3G+BIUNBA
Received: from pih-relay04.plus.net ([212.159.14.17])
  by relay.ptn-ipout02.plus.net with ESMTP; 15 Apr 2010 01:18:31 +0100
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay04.plus.net with esmtp (Exim) id 1O2Cmt-0000eZ-36; Thu, 15 Apr 2010 01:18:31 +0100
Received: from charles by hashpling.plus.com with local (Exim 4.69)
	(envelope-from <charles@hashpling.org>)
	id 1O2Cms-0008Hk-RR; Thu, 15 Apr 2010 01:18:30 +0100
Content-Disposition: inline
In-Reply-To: <7viq7tmvsb.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-Plusnet-Relay: 3f513b5200f78ecae88511328c945b64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144927>

On Wed, Apr 14, 2010 at 04:58:12PM -0700, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > On Tue, 13 April 2010, Charles Bailey wrote:
> >> On 01/04/2010 06:36, Mark Rada wrote:
> >> > @@ -84,13 +92,14 @@ endif
> >> >
> >> >   all:: gitweb.cgi
> >> >
> >> > +FILES = gitweb.cgi
> >> >   ifdef JSMIN
> >> > +FILES += gitweb.min.js
> >> > +endif
> >> > +ifdef CSSMIN
> >> > +FILES += gitweb.min.css
> >> > +endif
> >> > +gitweb.cgi: gitweb.perl $(GITWEB_JS) $(GITWEB_CSS)
> >
> > GITWEB_JS and GITWEB_CSS were originally meant to be URI to file with
> > gitweb JavaScript code and default gitweb stylesheet,... but during work
> > on minification of JavaScript code and CSS file it somehow got confused
> > to mean source path.
> 
> I am not touching instaweb part, but this would fix the build/clean side
> of the things, no?
> 

Yes, this certainly fixes make and make clean for me with overridden
GITWEB_JS and GITWEB_CSS paths.

Charles.
