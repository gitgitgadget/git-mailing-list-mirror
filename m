From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 2/2] contrib/git-candidate: Add README
Date: Wed, 6 Jan 2016 21:50:14 +0100
Message-ID: <568D7E06.9030100@gmail.com>
References: <1447160198-23296-1-git-send-email-richard.ipsum@codethink.co.uk>
 <1447160198-23296-3-git-send-email-richard.ipsum@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 06 21:50:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGv2f-0004ky-Rx
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jan 2016 21:50:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041AbcAFUuq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2016 15:50:46 -0500
Received: from plane.gmane.org ([80.91.229.3]:43989 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751708AbcAFUup (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2016 15:50:45 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1aGv2P-0004Vn-7W
	for git@vger.kernel.org; Wed, 06 Jan 2016 21:50:33 +0100
Received: from p548d68af.dip0.t-ipconnect.de ([84.141.104.175])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 06 Jan 2016 21:50:33 +0100
Received: from sschuberth by p548d68af.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 06 Jan 2016 21:50:33 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p548d68af.dip0.t-ipconnect.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12)
 Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
In-Reply-To: <1447160198-23296-3-git-send-email-richard.ipsum@codethink.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283453>

On 10.11.2015 13:56, Richard Ipsum wrote:

> +Existing tools such as Github's pull-requests and Gerrit are already
> +in wide use, why bother with something new?
> +
> +We are concerned that whilst git is a distributed version control
> +system the systems used to store comments and reviews for content
> +under version control are usually centralised,

I think it's a bit unjust to unconditionally mention Gerrit in this 
context as you seem to imply that Gerrit does not store *any* review 
data in Git.

Even without Dave's upcoming notedb, Gerrit already stores refs/changes 
in Git, and with the reviewnotes plugin [1] also the outcome of a review 
in refs/notes/review.

[1] 
https://gerrit.googlesource.com/plugins/reviewnotes/+/refs/heads/master/src/main/resources/Documentation/refs-notes-review.md

-- 
Sebastian Schuberth
