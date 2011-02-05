From: "Mike Gant" <mike@gantsfort.com>
Subject: Re: [idea] separate .git dir and the working tree
Date: Fri, 4 Feb 2011 20:23:39 -0700
Message-ID: <20110205032339.GA15303@mg1>
References: <AANLkTik4MjnpOzPdGy7ZDiH0in4e1DpjrhQFOHjUiEEE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 05 04:33:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlYtY-0005kV-G5
	for gcvg-git-2@lo.gmane.org; Sat, 05 Feb 2011 04:33:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753068Ab1BEDcp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Feb 2011 22:32:45 -0500
Received: from gantsfort.com ([64.66.245.199]:54109 "EHLO mail.gantsfort.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753034Ab1BEDcp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Feb 2011 22:32:45 -0500
X-Greylist: delayed 544 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Feb 2011 22:32:45 EST
Received: from mg1 (mg1.gantsfort.com [192.168.0.10])
	by mail.gantsfort.com (Postfix) with SMTP id C46D917E0C
	for <git@vger.kernel.org>; Fri,  4 Feb 2011 20:23:39 -0700 (MST)
Received: by mg1 (sSMTP sendmail emulation); Fri, 04 Feb 2011 20:23:39 -0700
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <AANLkTik4MjnpOzPdGy7ZDiH0in4e1DpjrhQFOHjUiEEE@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166073>

On Sat, Feb 05, 2011 at 10:53:58AM +0800, redstun wrote:
> First please shout if this is a known feature :-)
> 
> I think separating the .git directory from its working tree could
> increase the safety of the data to one more level higher.
> 
> We might have a git variable set to specify (a shared place) where to
> put the .git directories (or the data inside it), then use
> "/path/to/working/tree" as (or the seed to calculate) a hash key to
> map from the (.git directory in the) shared place to the working tree
> directory.
> 
> Or we may have just a few data (that can be re-created) stored in the
> .git directory along with the working tree, and most of the revision
> history stored in the shared place.

GIT_DIR and GIT_WORK_TREE might be what you are looking for. Explanation
of usage in 'man git'

HTH
Mike

> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
