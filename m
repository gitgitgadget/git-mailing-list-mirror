From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Thu, 17 Jan 2008 22:09:40 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801172209080.5731@racer.site>
References: <478E1FED.5010801@web.de> <m33asxn2gt.fsf@roke.D-201> <65026F2B-5CE8-4238-A9AB-D3545D336B41@sb.org> <200801162251.54219.jnareb@gmail.com> <1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org> <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org>
 <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org> <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org> <B45968C6-3029-48B6-BED2-E7D5A88747F7@sb.org> <alpine.LFD.1.00.0801161707150.2806@woody.linux-foundation.org> <8AC4CC86-A711-483D-9F9C-5F8497006A1D@sb.org>
 <alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org> <B719D4A2-0D05-4C55-95FC-AB880D58E1AC@wincent.com> <alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org> <87odbkyuvq.fsf@adler.orangeandbronze.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Wincent Colaiuta <win@wincent.com>,
	Kevin Ballard <kevin@sb.org>,
	Jakub Narebski <jnareb@gmail.com>, Mark Junker <mjscod@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: JM Ibanez <jm@orangeandbronze.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 23:10:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFcwD-0003fR-Hg
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 23:10:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754605AbYAQWJs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 17:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754441AbYAQWJs
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 17:09:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:56517 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754149AbYAQWJr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 17:09:47 -0500
Received: (qmail invoked by alias); 17 Jan 2008 22:09:45 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp025) with SMTP; 17 Jan 2008 23:09:45 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18O3Lhv3NoO/H62Q4VftvVbQ+SunEBstaPIECerGd
	b5FFsU5A63PBBV
X-X-Sender: gene099@racer.site
In-Reply-To: <87odbkyuvq.fsf@adler.orangeandbronze.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70933>

Hi,

On Fri, 18 Jan 2008, JM Ibanez wrote:

> If you check the standard, two Unicode codepoints (i.e. the numeric 
> value that gets stored on disk) *can* map to the same character, hence 
> they are the same.

As Linus _already_ pointed out, you are confusing characters with glyphs.

Hth,
Dscho
