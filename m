From: Nico Williams <nico@cryptonector.com>
Subject: Re: Rebase safely (Re: cherry picking and merge)
Date: Wed, 6 Aug 2014 15:13:46 -0500
Message-ID: <20140806201340.GF23449@localhost>
References: <51C01AAA-3CFB-4110-BAE9-7D04CA8EE53A@comcast.net>
 <20140801024329.GA28914@vauxhall.crustytoothpaste.net>
 <53DBBFE8.8060607@gmail.com>
 <5AF18A76-DD3B-4B9A-BF70-EFE4BB852C3D@comcast.net>
 <53DBF4C9.2090905@vilain.net>
 <4E372CD5-33CA-4AF5-8647-F6BBC64BABA8@comcast.net>
 <CAK3OfOiG8kzKYRUGZJW90t-DyjWf775MfMDxzin0gw94ATS7nw@mail.gmail.com>
 <96B703A6-58B0-458A-8A2D-699EA8F1941B@comcast.net>
 <20140806194457.GD23449@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Vilain <sam@vilain.net>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git discussion list <git@vger.kernel.org>
To: Mike Stump <mikestump@comcast.net>
X-From: git-owner@vger.kernel.org Wed Aug 06 22:13:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XF7ap-0006OB-SG
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 22:13:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753445AbaHFUNs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 16:13:48 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:58125 "EHLO
	homiemail-a108.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752343AbaHFUNr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Aug 2014 16:13:47 -0400
Received: from homiemail-a108.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a108.g.dreamhost.com (Postfix) with ESMTP id 274122005D82E;
	Wed,  6 Aug 2014 13:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=cryptonector.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=cryptonector.com; bh=FChE1mwJQ+X19n
	cFF7xu1cAfXYw=; b=RmIZD4E/X+ewyZc1RdzeNlgtpoIdVz2J9h3QlLz3ETuTYw
	IKW1IbL6/67Mgdb7fWwHDuUx4grkOLmlhk20/3Q3/8KWC3RvW/vSLXzcEW2idUo/
	OKg7qvimfC/Cguk28Zn4TanROfLopDLyzVFEYYOuiYgq+0RvYyyK68VE/mfLI=
Received: from localhost (108-207-244-174.lightspeed.austtx.sbcglobal.net [108.207.244.174])
	(Authenticated sender: nico@cryptonector.com)
	by homiemail-a108.g.dreamhost.com (Postfix) with ESMTPA id A781C2005D807;
	Wed,  6 Aug 2014 13:13:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140806194457.GD23449@localhost>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254899>

On Wed, Aug 06, 2014 at 02:44:59PM -0500, Nico Williams wrote:
> That means that you have/maintain an intermediate upstream, yes?
> 
> This is a bit trickier since once in a while that intermediate upstream
> and everyone downstream of it has to catch up with the real upstream.
> 
> Here you have two options:
> 
>  - the intermediate diverges from the real upstream, and then you
>    merge/cherry-pick from the upstream as needed
>    
>    The intermediate's maintainer must still merge/rebase/cherry-pick
>    from the intermediate branch and onto a branch of the upstream in
>    order to push to the upstream.

I should add something important here.

Rebasing makes life easier for the intermediate maintainer, and for any
upstream maintainer who has to merge "pull requests" or patches sent in
email.  Rebasing puts the onus for merging on the contributor, exactly
where it belongs!

(Granted, for an e-mail based workflow one's patches might have made for
a fast-forward merge when sent but not when the upstream gets to them.
With long enough latency this gets painful.  Which is why I don't
recommend an e-mail based commit integration workflow.)

Nico
-- 
