From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Thu, 17 Jan 2008 01:08:15 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801170106390.17650@racer.site>
References: <478E1FED.5010801@web.de> <m33asxn2gt.fsf@roke.D-201> <65026F2B-5CE8-4238-A9AB-D3545D336B41@sb.org> <200801162251.54219.jnareb@gmail.com> <1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org> <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org>
 <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org> <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org> <BA518A23-FBF8-49BB-BEFB-D9A6BA1E302C@simplicidade.org> <alpine.LFD.1.00.0801161615330.2806@woody.linux-foundation.org>
 <E8E76634-FFEC-426B-B04D-3C2CD3790D5E@simplicidade.org> <85zlv5nvge.fsf@lola.goethe.zz> <B2E52451-5153-4EFD-ADBE-AACDCEF6169E@simplicidade.org> <D32FF2AF-EA90-4737-8320-836B52AF4612@wincent.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811741-1646330582-1200532096=:17650"
Cc: Pedro Melo <melo@simplicidade.org>, David Kastrup <dak@gnu.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kevin Ballard <kevin@sb.org>,
	Jakub Narebski <jnareb@gmail.com>, Mark Junker <mjscod@web.de>,
	git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 02:08:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFJFR-0006ko-07
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 02:08:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbYAQBIV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 20:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbYAQBIU
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 20:08:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:50096 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750917AbYAQBIU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 20:08:20 -0500
Received: (qmail invoked by alias); 17 Jan 2008 01:08:17 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp019) with SMTP; 17 Jan 2008 02:08:17 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18WTY4HFHEWxVu6aPJM+KPXqqXVRzDRlbgQdaiSIz
	VgfN+vHgrgYpkk
X-X-Sender: gene099@racer.site
In-Reply-To: <D32FF2AF-EA90-4737-8320-836B52AF4612@wincent.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70796>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811741-1646330582-1200532096=:17650
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 17 Jan 2008, Wincent Colaiuta wrote:

> El 17/1/2008, a las 1:40, Pedro Melo escribió:
> 
> > That's the point I'm making. The fact that I need to set LANG across 
> > all users of a project is insane...

FWIW if you use another filesystem, such as reiserfs or ext[2-4], the 
filenames will be _unaffected_ by your particular setting of LANG.  They 
will be stored byte-wise exactly like asked for.  That's why I call them 
"sane".

Hth,
Dscho
---1463811741-1646330582-1200532096=:17650--
