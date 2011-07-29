From: Ferry Huberts <mailings@hupie.com>
Subject: Re: gitignore design
Date: Fri, 29 Jul 2011 14:08:50 +0200
Message-ID: <4E32A2D2.9060007@hupie.com>
References: <1311934832699-6632987.post@n2.nabble.com> <4E329EDB.6040007@hupie.com> <1311940877783-6633274.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: llucianf <llucianf@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 29 14:09:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmlsA-0004cx-7v
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jul 2011 14:08:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755704Ab1G2MIx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jul 2011 08:08:53 -0400
Received: from 82-197-206-98.dsl.cambrium.nl ([82.197.206.98]:53313 "EHLO
	mail.hupie.dyndns.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755619Ab1G2MIw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2011 08:08:52 -0400
Received: from stinkpad.internal.hupie.com (82-197-206-98.dsl.cambrium.nl [82.197.206.98])
	by mail.hupie.dyndns.org (Postfix) with ESMTP id 2DD0858BD75;
	Fri, 29 Jul 2011 14:08:51 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110707 Thunderbird/5.0
In-Reply-To: <1311940877783-6633274.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178140>

On 07/29/2011 02:01 PM, llucianf wrote:
> sorry but this is not always the case. there are plenty of cases (project
> files is most common example) in which i need files in repo but i do not
> need git to track them. so why i cant just simply enumerate those project

this is a contradiction: you want them tracked (they're in the repo) but
you do not want them tracked.

you can't have it both ways.

git works this way.

 git != cvs

-- 
Ferry Huberts
