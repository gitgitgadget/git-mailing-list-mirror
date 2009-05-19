From: Marc Haber <mh+git@zugschlus.de>
Subject: Re: How to check repository/working tree status from a script
Date: Tue, 19 May 2009 18:00:31 +0200
Message-ID: <20090519160031.GB23505@torres.zugschlus.de>
References: <20090519143537.GA23505@torres.zugschlus.de> <alpine.LSU.2.00.0905191630120.23478@hermes-2.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 19 18:00:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6Rk9-0006P6-BL
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 18:00:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752827AbZESQAb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 12:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752545AbZESQAb
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 12:00:31 -0400
Received: from torres.zugschlus.de ([85.214.68.41]:44141 "EHLO
	torres.zugschlus.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752185AbZESQAa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 12:00:30 -0400
Received: from mh by torres.zugschlus.de with local (Exim 4.69)
	(envelope-from <mh+git@zugschlus.de>)
	id 1M6Rjz-0006nn-MJ
	for git@vger.kernel.org; Tue, 19 May 2009 18:00:31 +0200
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.00.0905191630120.23478@hermes-2.csi.cam.ac.uk>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119540>

Hi Tony,

On Tue, May 19, 2009 at 04:34:47PM +0100, Tony Finch wrote:
> On Tue, 19 May 2009, Marc Haber wrote:
> > I would like to check in a script whether there (a) are uncommitted
> > changes (as in "working tree differs from local repository")
> 
> # check working tree is not different from the index
> git diff --quiet
> # check that the index is not different from the head
> git diff --quiet --cached

$ git diff --quiet; echo $?
0
$ git diff --quiet --cached; echo $?
0
$ touch keks
$ git diff --quiet; echo $?
0
$ git diff --quiet --cached; echo $?
0
$

Am I missing something?

Greetings
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Mannheim, Germany  |  lose things."    Winona Ryder | Fon: *49 621 72739834
Nordisch by Nature |  How to make an American Quilt | Fax: *49 3221 2323190
