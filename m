From: David Lang <david@lang.hm>
Subject: Re: Pull is Mostly Evil
Date: Fri, 2 May 2014 12:31:27 -0700 (PDT)
Message-ID: <alpine.DEB.2.02.1405021227161.14881@nftneq.ynat.uz>
References: <5363BB9F.40102@xiplink.com> <87k3a4xjzg.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri May 02 21:31:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgJBL-00058G-GS
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 21:31:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701AbaEBTbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 15:31:35 -0400
Received: from mail.lang.hm ([64.81.33.126]:38202 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751788AbaEBTbf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 15:31:35 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id s42JVRmL005213;
	Fri, 2 May 2014 12:31:27 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <87k3a4xjzg.fsf@fencepost.gnu.org>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247959>

On Fri, 2 May 2014, David Kastrup wrote:

> Date: Fri, 02 May 2014 17:45:23 +0200
> From: David Kastrup <dak@gnu.org>
> To: git@vger.kernel.org
> Subject: Re: Pull is Mostly Evil
> 
> Marc Branchaud <marcnarc@xiplink.com> writes:
>
>> To that end, I suggest that pull's default behaviour should be to do
>> *nothing*.  It should just print out a message to the effect that it
>> hasn't been configured, and that the user should run "git help pull"
>> for guidance.
>
> Fetching is uncontentious, and I _think_ that fast-forwards are pretty
> uncontentious as well.

so those people just need to use fetch instead of pull.

This seems fairly straightforward

fetch, get the data but don't integrate it

pull, get the data and ff along it if possible

pull with options, merge/rebase left/right based on options when ff is not 
possible.

Pull was created with one workflow in mind, Changing it to require explcitly 
specifying the option (in a config, with appropriate transition, handholding) is 
not completly unreasonable, and given the confusion this causes, may be very 
reasonable.

But saying that ff isn't always right, so make pull go away altogether (or 
"don't change anything because there isn't 100% agreement on the result" 
paralysis) doesn't seem right.

> It's just when the merge-left/merge-right/rebase-left/rebase-right
> decision kicks in that prescribing one git-pull behavior looks like a
> recipe for trouble.

confusion at least. It's not fatal confusion, people have been using it for 
years after all.

David Lang
