From: Marc Haber <mh+git@zugschlus.de>
Subject: Re: How to check repository/working tree status from a script
Date: Thu, 21 May 2009 15:24:57 +0200
Message-ID: <20090521132457.GB5625@torres.zugschlus.de>
References: <20090519143537.GA23505@torres.zugschlus.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 21 15:25:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M78Ge-0001fe-2h
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 15:25:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753442AbZEUNY6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2009 09:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753392AbZEUNY5
	(ORCPT <rfc822;git-outgoing>); Thu, 21 May 2009 09:24:57 -0400
Received: from torres.zugschlus.de ([85.214.68.41]:35293 "EHLO
	torres.zugschlus.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751629AbZEUNY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2009 09:24:56 -0400
Received: from mh by torres.zugschlus.de with local (Exim 4.69)
	(envelope-from <mh+git@zugschlus.de>)
	id 1M78GX-0001To-Ng
	for git@vger.kernel.org; Thu, 21 May 2009 15:24:57 +0200
Content-Disposition: inline
In-Reply-To: <20090519143537.GA23505@torres.zugschlus.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119678>

Hi,

On Tue, May 19, 2009 at 04:35:37PM +0200, Marc Haber wrote:
> I would like to check in a script whether there (a) are uncommitted
> changes (as in "working tree differs from local repository") and/or
> whether there (b) are unpulled changes in the "remote origin"
> repository.

(a) has been solved, thanks for helping.

I am now looking for a solution for (b). I tried 

git log -n1 --pretty=oneline master..origin/master

but that seems to always give empty output even if a later issued git
pull will actually pull in changes.

Greetings
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Mannheim, Germany  |  lose things."    Winona Ryder | Fon: *49 621 72739834
Nordisch by Nature |  How to make an American Quilt | Fax: *49 3221 2323190
