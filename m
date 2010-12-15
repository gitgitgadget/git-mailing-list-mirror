From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: When I merge, a binary file conflict,how can I select between
 2 versions?
Date: Wed, 15 Dec 2010 10:33:01 +0200
Message-ID: <20101215083301.GA6946@LK-Perkele-V2.elisa-laajakaista.fi>
References: <loom.20101215T084919-573@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Chunlin Zhang <zhangchunlin@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 15 09:32:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSmn8-0004hW-Ut
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 09:32:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854Ab0LOIck (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Dec 2010 03:32:40 -0500
Received: from emh05.mail.saunalahti.fi ([62.142.5.111]:34430 "EHLO
	emh05.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795Ab0LOIcj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Dec 2010 03:32:39 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh05-2.mail.saunalahti.fi (Postfix) with SMTP id B06068C550;
	Wed, 15 Dec 2010 10:32:36 +0200 (EET)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A0210BA91BB; Wed, 15 Dec 2010 10:32:36 +0200
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh04.mail.saunalahti.fi (Postfix) with ESMTP id E4CC741BE5;
	Wed, 15 Dec 2010 10:32:33 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <loom.20101215T084919-573@post.gmane.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163743>

On Wed, Dec 15, 2010 at 08:00:08AM +0000, Chunlin Zhang wrote:
> The only way now I know is to replace the file with the version file I want in
> working copy,and then git add and git commit.I think it is inconvenient.
> 
> Then I think if there is some command to select local or remote version file to
> add more easier,because it is obviously git keep 2 version file.
 
IIRC,

git checkout --theirs -- <file>
git add <file>


-Ilari
