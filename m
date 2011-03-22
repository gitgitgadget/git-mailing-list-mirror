From: Nicolas Morey-Chaisemartin <devel-git@morey-chaisemartin.com>
Subject: Re: [PATCH] git-submodule: Remove duplicate entries during merge
 with conflict
Date: Tue, 22 Mar 2011 07:28:04 +0100
Message-ID: <4D884174.6070700@morey-chaisemartin.com>
References: <4D81C1AA.5010008@morey-chaisemartin.com> <7v1v254ma7.fsf@alter.siamese.dyndns.org> <7vhbb1320t.fsf@alter.siamese.dyndns.org> <4D87B51A.4060609@web.de> <4D87C467.3090907@morey-chaisemartin.com> <4D87CAC4.2010001@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Mar 22 07:28:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1v5G-0003dt-2R
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 07:28:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754426Ab1CVG2k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 02:28:40 -0400
Received: from 63.mail-out.ovh.net ([91.121.185.56]:34159 "HELO
	63.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754298Ab1CVG2i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 02:28:38 -0400
Received: (qmail 11282 invoked by uid 503); 22 Mar 2011 07:15:32 -0000
Received: from b9.ovh.net (HELO mail189.ha.ovh.net) (213.186.33.59)
  by 63.mail-out.ovh.net with SMTP; 22 Mar 2011 07:15:32 -0000
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 22 Mar 2011 08:28:36 +0200
Received: from mut38-4-82-233-116-185.fbx.proxad.net (HELO ?10.0.2.12?) (nicolas@morey-chaisemartin.com@82.233.116.185)
  by ns0.ovh.net with SMTP; 22 Mar 2011 08:28:35 +0200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.15) Gecko/20110303 Lightning/1.0b2 Thunderbird/3.1.9
In-Reply-To: <4D87CAC4.2010001@web.de>
X-Ovh-Tracer-Id: 4725120434678194103
X-Ovh-Remote: 82.233.116.185 (mut38-4-82-233-116-185.fbx.proxad.net)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-Spam-Check: DONE|U 0.5/N
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169701>

On 21/03/2011 23:01, Jens Lehmann wrote:
> Hmm, I'm not sure if I fully understand your use case. Maybe being able
> to tell pull to run a "git merge <sha1-from-upstream>" in submodules
> where the superproject's merge produced conflicts would help you?
> 

In short yes. And if it could be recursive (if a conflicting submodules has conflicting submodules) that would be great !
And yes git-merge is probably a better place to do something like that than git submodule update.

> That is a good argument against '*'. I don't have strong feelings about
> that, I just came up with '*' because "git submodule status" already uses
> '-' and '+' in it's output. But anyways, 'U' is fine for me too.
> 

OK. I'll integrate that with the patch Junio proposed then.

Nicolas
