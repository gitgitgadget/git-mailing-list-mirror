From: Frans Pop <elendil@planet.nl>
Subject: Re: Feature request: option to not fetch tags for 'git remote' branches
Date: Tue, 30 Mar 2010 10:09:28 +0200
Message-ID: <201003301009.29412.elendil@planet.nl>
References: <201003242154.29245.elendil@planet.nl> <201003242246.16286.elendil@planet.nl> <2010-03-27-20-10-25+trackit+sam@rfc1149.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: John Feuerstein <john@feurix.com>, git@vger.kernel.org
To: Samuel Tardieu <sam@rfc1149.net>
X-From: git-owner@vger.kernel.org Tue Mar 30 10:10:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwWWj-0001yI-5m
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 10:10:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755455Ab0C3IKN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 04:10:13 -0400
Received: from Cpsmtpm-eml108.kpnxchange.com ([195.121.3.12]:60091 "EHLO
	CPSMTPM-EML108.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755832Ab0C3IJe (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Mar 2010 04:09:34 -0400
Received: from aragorn.fjphome.nl ([77.166.180.99]) by CPSMTPM-EML108.kpnxchange.com with Microsoft SMTPSVC(7.0.6001.18000);
	 Tue, 30 Mar 2010 10:09:29 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <2010-03-27-20-10-25+trackit+sam@rfc1149.net>
Content-Disposition: inline
X-OriginalArrivalTime: 30 Mar 2010 08:09:29.0890 (UTC) FILETIME=[52999020:01CACFE0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143553>

On Saturday 27 March 2010, Samuel Tardieu wrote:
> Add a '--no-tags' option to 'git remote add' which adds a
> 'remote.REMOTE.tagopt = --no-tags' to the configuration file.
>
> 'git add -f -n REMOTE' will create a new remote and fetch from it
> without importing the tags. Subsequent 'git fetch REMOTE' will also
> not import the tags.

Not tested, but looks as if it will do exactly what I had in mind. Thanks!
