From: Johan Herland <johan@herland.net>
Subject: Re: list all the untrack files in a git respo
Date: Wed, 4 Jun 2008 16:20:54 +0200
Message-ID: <200806041620.54890.johan@herland.net>
References: <75b57c110806040705mc324d9dx9ce099593ce967dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Gerb Stralko" <gerb.stralko@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 16:22:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3tsG-000488-De
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 16:22:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753410AbYFDOVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 10:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753101AbYFDOVH
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 10:21:07 -0400
Received: from sam.opera.com ([213.236.208.81]:44751 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753395AbYFDOVG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 10:21:06 -0400
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id m54EKtRw003710
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 4 Jun 2008 14:21:00 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <75b57c110806040705mc324d9dx9ce099593ce967dd@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83783>

On Wednesday 04 June 2008, Gerb Stralko wrote:
> Is there a way to list only the untracked files in git? git status
> works, but i need to do some parsing in order to get a list of
> untracked files.  Something like git status --show-only-untracked?

Is
	git ls-files -o
what you want?

(Depending on your use case, you might also find the --exclude-standard 
and --directory options useful as well. See the git-ls-files manual 
page for details)


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
