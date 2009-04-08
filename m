From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: "git status <file>" in the middle of a merge
Date: Thu, 9 Apr 2009 01:47:59 +0200
Message-ID: <200904090147.59603.markus.heidelberg@web.de>
References: <10804.1239234026@relay.known.net>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: layer <layer@known.net>
X-From: git-owner@vger.kernel.org Thu Apr 09 01:49:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrhW6-0007us-FY
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 01:49:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756030AbZDHXrl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 19:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755617AbZDHXrl
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 19:47:41 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:58730 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755269AbZDHXrk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 19:47:40 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id A7C26FA2B438;
	Thu,  9 Apr 2009 01:47:36 +0200 (CEST)
Received: from [89.59.73.185] (helo=.)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LrhUW-0001XG-00; Thu, 09 Apr 2009 01:47:36 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <10804.1239234026@relay.known.net>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+QezRE1J1TAf4e1vIA5MBcStI6FT5osqjdGnt8
	v5pZmHZEV9oasUYkFOIdK0mmvOM+ymD1ph+HToklZ+u/iVz03E
	Sd0K5JWUx+YATVqhP0/g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116133>

layer, 09.04.2009:
> $ git status ChangeLog

This does not what you expect, see git-status doc:

    The command takes the same set of options as git-commit; it shows
    what would be committed if the same options are given to git-commit.

Markus
