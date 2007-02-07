From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: MinGW binary installer available
Date: Wed, 07 Feb 2007 18:35:06 +0100
Message-ID: <45CA0DCA.3080908@xs4all.nl>
References: <45C9E470.7030609@xs4all.nl> <Pine.LNX.4.63.0702071552470.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45C9EB54.3040406@xs4all.nl> <Pine.LNX.4.63.0702071625341.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45C9F184.1060300@xs4all.nl> <Pine.LNX.4.63.0702071713190.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45CA06E7.3050704@xs4all.nl> <Pine.LNX.4.63.0702071808320.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jan Nieuwenhuizen <janneke@gnu.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 07 18:38:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEqhd-0005Wq-Ab
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 18:35:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965689AbXBGRfK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 12:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965541AbXBGRfK
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 12:35:10 -0500
Received: from smtp-vbr13.xs4all.nl ([194.109.24.33]:1735 "EHLO
	smtp-vbr13.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965691AbXBGRfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 12:35:09 -0500
Received: from [192.168.123.187] (muurbloem.xs4all.nl [213.84.26.127])
	(authenticated bits=0)
	by smtp-vbr13.xs4all.nl (8.13.8/8.13.8) with ESMTP id l17HYtfa089120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 7 Feb 2007 18:34:56 +0100 (CET)
	(envelope-from hanwen@xs4all.nl)
User-Agent: Thunderbird 1.5.0.9 (X11/20070130)
In-Reply-To: <Pine.LNX.4.63.0702071808320.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38948>

Johannes Schindelin escreveu:

> Thank you very much!
> 
> Just out of curiosity: What do you use to convert it? Tailor all branches, 
> then stitch them together? (With tailor, stitching is possible as long as 
> you did not merge branches: the commit objects _will_ be identical, since 
> even the commit timestamps are derived from the source repository.)

A simple linear import of all the patches. Since Darcs
uses patch based storage, I think it's not possible to accurately map a Darcs
repository onto a Git one without creating branch spaghetti. 

I have never grokked how tailor is supposed to work, so I use a home made
script.

-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
