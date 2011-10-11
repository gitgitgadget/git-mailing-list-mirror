From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [PATCHv5/RFC 3/6] gitweb: Add manpage for gitweb
Date: Tue, 11 Oct 2011 09:02:15 -0400
Message-ID: <1318338135.22324.33.camel@drew-northup.unet.maine.edu>
References: <1318098723-12813-1-git-send-email-jnareb@gmail.com>
	 <1318098723-12813-4-git-send-email-jnareb@gmail.com>
	 <7vr52kk1jj.fsf@alter.siamese.dyndns.org>
	 <201110110002.24665.jnareb@gmail.com>
	 <20111010221811.GA21367@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 11 15:05:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDc18-0002xG-NF
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 15:05:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752232Ab1JKNFD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Oct 2011 09:05:03 -0400
Received: from basalt.its.maine.edu ([130.111.32.66]:49337 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264Ab1JKNFB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2011 09:05:01 -0400
Received: from [IPv6:2610:48:100:827::97] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827::97])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id p9BD2Jbj016295
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 11 Oct 2011 09:02:24 -0400
In-Reply-To: <20111010221811.GA21367@elie.hsd1.il.comcast.net>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=4
	Fuz1=4 Fuz2=4
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p9BD2Jbj016295
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1318942946.0067@YD9FZ4CwAnUOgMWJfsfdow
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183293>

On Mon, 2011-10-10 at 17:18 -0500, Jonathan Nieder wrote:
> Jakub Narebski wrote:
> 
> > The problem is that catering to old AsciiDoc (but still used by some of
> > long-term-support Linux distributions) requires to have "SYNOPSIS"
> > section... but there is no natural synopsis for non self-hostable web
> > application, is there?
> 
> I personally think something like
> 
> 	SYNOPSIS
> 	--------
> 	/usr/share/gitweb/gitweb.cgi
> 	git instaweb
> 
> or perhaps something like
> 
> 	SYNOPSIS
> 	--------
> 	http://<site>/?p=<project>.git;a=<action>;h=<object>;<parameters>
> 	http://<site>/<project>/<action>/<object>?<parameters>
> 
> would be best.

This would be why I included a synopsis with my original submission. As
this was supposed to be a description of the configuration files of said
application it does not make much sense to put the executable in the
synopsis. Please forgive me for attempting to make sense!

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
