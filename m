From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH] Fix git-instaweb breakage on MacOS X due to the limited sed functionality
Date: Wed, 19 Dec 2007 11:36:17 +0000
Message-ID: <20071219113617.GA26520@hashpling.org>
References: <20071219105752.GA23932@hashpling.org> <23306E3C-24F1-4626-A956-02531644B786@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 12:36:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4xEE-0000yp-8W
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 12:36:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752580AbXLSLgX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 06:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752537AbXLSLgX
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 06:36:23 -0500
Received: from pih-relay06.plus.net ([212.159.14.133]:58016 "EHLO
	pih-relay06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752145AbXLSLgW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 06:36:22 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay06.plus.net with esmtp (Exim) id 1J4xDo-0005w0-H2; Wed, 19 Dec 2007 11:36:20 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id lBJBaI3n026855;
	Wed, 19 Dec 2007 11:36:18 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id lBJBaHxF026854;
	Wed, 19 Dec 2007 11:36:17 GMT
Content-Disposition: inline
In-Reply-To: <23306E3C-24F1-4626-A956-02531644B786@wincent.com>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68888>

On Wed, Dec 19, 2007 at 12:28:04PM +0100, Wincent Colaiuta wrote:
> 
> I think it's a bad idea to hard-code the perl path there; the  
> generated scripts only assume /usr/bin/perl if the user hasn't  
> overridden it at build time:
> 
> 	PERL_PATH=/foo/perl make ...
> 
> Using just this should work fine anyway:
> 
> 	perl -p -e ...
> 

I agree completely, but all the generated scripts output hard coded
paths so it would seem inconsistent not to qualify the path in this
case too.  Would  @@PERL_PATH@@perl -p -e work, do you know?

Charles.
