From: Frans Pop <elendil@planet.nl>
Subject: Re: Feature request: option to not fetch tags for 'git remote' branches
Date: Wed, 24 Mar 2010 22:46:15 +0100
Message-ID: <201003242246.16286.elendil@planet.nl>
References: <201003242154.29245.elendil@planet.nl> <4BAA7F5B.2040400@feurix.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: John Feuerstein <john@feurix.com>
X-From: git-owner@vger.kernel.org Wed Mar 24 22:46:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuYP9-0007fw-Ep
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 22:46:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752574Ab0CXVqS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 17:46:18 -0400
Received: from Cpsmtpm-eml107.kpnxchange.com ([195.121.3.11]:58735 "EHLO
	CPSMTPM-EML107.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751258Ab0CXVqR (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Mar 2010 17:46:17 -0400
Received: from aragorn.fjphome.nl ([77.166.180.99]) by CPSMTPM-EML107.kpnxchange.com with Microsoft SMTPSVC(7.0.6001.18000);
	 Wed, 24 Mar 2010 22:46:16 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <4BAA7F5B.2040400@feurix.com>
Content-Disposition: inline
X-OriginalArrivalTime: 24 Mar 2010 21:46:16.0710 (UTC) FILETIME=[6E765A60:01CACB9B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143133>

On Wednesday 24 March 2010, John Feuerstein wrote:
> > It would be great to be able to tell 'git remote' to skip tags and
> > only fetch the requested branch. A --no-tags option maybe?
> >
> > AFAIK this is currently not possible, although I'd happy to be proven
> > wrong.
>
> have a look at -n, --no-tags provided by git-fetch, ie.
>
> $ git remote add ... foo ...
> $ git fetch -n foo

Thanks John. I'll need to test if that's persistent, or that I'll have
to remember to specify it with each fetch. I guess the option is also 
recognized by 'git remote update'?

Ahh. I've just found 'remote.<name>.tagopt' in 'man git-config'.
I still think it would be nice if that could be set with an option for
'git remote add'. That would make life so much simpler :-)

Cheers,
FJP
