From: Frans Pop <elendil@planet.nl>
Subject: Re: Testing if a certain commit is in the current branch
Date: Wed, 27 Jan 2010 14:26:05 +0100
Message-ID: <201001271426.06844.elendil@planet.nl>
References: <201001270819.39819.elendil@planet.nl> <201001270936.14935.elendil@planet.nl> <20100127101943.GA4470@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 14:26:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Na7uR-0007Hq-Ko
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 14:26:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754680Ab0A0N0K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 08:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754679Ab0A0N0J
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 08:26:09 -0500
Received: from Cpsmtpm-eml107.kpnxchange.com ([195.121.3.11]:61010 "EHLO
	CPSMTPM-EML107.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751746Ab0A0N0I (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jan 2010 08:26:08 -0500
Received: from aragorn.fjphome.nl ([77.166.180.99]) by CPSMTPM-EML107.kpnxchange.com with Microsoft SMTPSVC(7.0.6001.18000);
	 Wed, 27 Jan 2010 14:26:06 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <20100127101943.GA4470@progeny.tock>
Content-Disposition: inline
X-OriginalArrivalTime: 27 Jan 2010 13:26:06.0782 (UTC) FILETIME=[4804BDE0:01CA9F54]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138157>

On Wednesday 27 January 2010, Jonathan Nieder wrote:
> Frans Pop wrote:
> > The use case is a wrapper script for kernel builds in which some
> > variation are needed (due to changes in the build system) when
> > building older kernels, e.g. during bisections or when building older
> > stable updates. So I test for the presence of commits that introduced
> > relevant changes.
>
> Neat idea.  How about this (untested)?
>
>  git rev-list ^HEAD --no-walk commit1 commit2 ...

Does not seem to work. But I'd be interested if you find a variant that 
does as it's very fast.

Thanks,
FJP
