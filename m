From: Pete Harlan <pgit@pcharlan.com>
Subject: Re: Archiving tags/branches?
Date: Sun, 19 Oct 2008 23:36:10 -0700
Message-ID: <48FC26DA.10508@pcharlan.com>
References: <48F93F52.4070506@pcharlan.com> <200810181315.49265.johan@herland.net> <20081018130204.GB3749@neumann> <200810181532.59883.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Oct 20 15:27:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KroON-000353-J5
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 08:37:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbYJTGgM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 02:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbYJTGgM
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 02:36:12 -0400
Received: from lax-green-bigip-5.dreamhost.com ([208.113.200.5]:47919 "EHLO
	swarthymail-a6.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750878AbYJTGgM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Oct 2008 02:36:12 -0400
Received: from [192.168.0.2] (031.132-78-65.ftth.swbr.surewest.net [65.78.132.31])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by swarthymail-a6.g.dreamhost.com (Postfix) with ESMTP id 5677A106271;
	Sun, 19 Oct 2008 23:36:11 -0700 (PDT)
User-Agent: Mozilla-Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <200810181532.59883.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98667>

Johan Herland wrote:
> BTW, the best way IMHO to archive old refs is to clone your repo (with all 
> tags/branches) to a backup disk, and then regularly push (git push --all && 
> git push --tags) your new tags/branches to this backup. You are now free to 
> delete these tags/branches from your work repo (they will not be deleted 
> from the backup unless you use "git push --mirror"). And if you ever need 
> to retrieve an old tag/branch, it's just a matter of pulling it from the 
> backup repo. Nice, clean, flexible, and requires no changes to git.
> 
> 
> Have fun! :)
> 
> ...Johan

Hi,

Thank you; that indeed seems to work and solves the problem of managing
refs/archived-tags manually.

Using a secondary repo solely to overcome a flat tag/branch namespace
feels hackish.  Perhaps git will benefit someday from work in this area,
but until I come up with a patch your suggestion should work fine.  Just
knowing I didn't overlook an existing feature helps a lot.

--Pete
