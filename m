From: David Lang <david.lang@digitalinsight.com>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Tue, 13 Feb 2007 15:19:39 -0800 (PST)
Message-ID: <Pine.LNX.4.63.0702131518290.8035@qynat.qvtvafvgr.pbz>
References: <45CFA30C.6030202@verizon.net>  <200702130932.51601.litvinov2004@gmail.com>
  <Pine.LNX.4.63.0702131105240.1300@wbgn013.biozentrum.uni-wuerzburg.de> 
 <Pine.LNX.4.64.0702130845330.8424@woody.linux-foundation.org> 
 <Pine.LNX.4.64.0702130919100.8424@woody.linux-foundation.org> 
 <7v7iumx7hu.fsf@assigned-by-dhcp.cox.net>  <Pine.LNX.4.64.0702131053110.8424@woody.linux-foundation.org>
 <20070213204248.GA21046@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alexander Litvinov <litvinov2004@gmail.com>,
	Mark Levedahl <mlevedahl@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
X-From: git-owner@vger.kernel.org Wed Feb 14 00:35:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH7Au-0008IO-M6
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 00:35:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbXBMXfA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 18:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbXBMXfA
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 18:35:00 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:42194 "HELO
	warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1751454AbXBMXfA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 18:35:00 -0500
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Tue, 13 Feb 2007 15:34:59 -0800
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Tue, 13 Feb 2007 15:34:39 -0800
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <20070213204248.GA21046@uranus.ravnborg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39601>

On Tue, 13 Feb 2007, Sam Ravnborg wrote:

>
> I wonder what we are really trying to address here. Or in other words
> could the original poster maybe tell what Windows IDE's that does
> not handle UNIX files properly?
>
> core git today should not care about CRLF as opposed to LF end-of-line
> as long as the end-of-line is consistent - correct?
>
> So defaulting to autoCRLF in Windows/DOS environments was maybe
> sane 10 years ago but today that seems to be the wrong thing to do.
> For certain project the option could be useful if the tool-set in
> the project *requires* CRLF, but if the toolset like all modern toolset
> supports both CRLF and LF then git better avoid changing end-of-line marker.

I've actually run into grief on this subject with perl scripts within the last 
year (files from windows systems with crlf not working cleanly on a linux system 
with just lf)

this is real, not just historic

David Lang
