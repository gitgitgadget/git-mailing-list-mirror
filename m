From: Jonathon Mah <me@JonathonMah.com>
Subject: Re: What's cooking in git.git (Sep 2011, #04; Mon, 12)
Date: Tue, 13 Sep 2011 19:34:18 -0700
Message-ID: <D3CA81F2-647B-4AD0-A4FC-4C22772FD791@JonathonMah.com>
References: <7v4o0h7byd.fsf@alter.siamese.dyndns.org> <7vipox2wd6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Dan McGee <dpmcgee@gmail.com>, David Aguilar <davvid@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 14 04:34:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3fJC-0005dy-Qj
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 04:34:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754059Ab1INCed (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Sep 2011 22:34:33 -0400
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:11831 "EHLO
	ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753681Ab1INCec convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2011 22:34:32 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApIBAKwQcE5M5FL2/2dsb2JhbAAMNapDAQEEAToxBwcFCwtGVwYTh3e2a4YOYASHbZhKhEg
Received: from adsl-76-228-82-246.dsl.pltn13.sbcglobal.net (HELO [10.0.1.129]) ([76.228.82.246])
  by ipmail06.adl6.internode.on.net with ESMTP; 14 Sep 2011 12:04:23 +0930
In-Reply-To: <7vipox2wd6.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1244.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181334>

On 2011-09-12, at 14:59, Junio C Hamano wrote:

>> [Stalled]
>> 
>> * jm/mergetool-pathspec (2011-06-22) 2 commits
>> - mergetool: Don't assume paths are unmerged
>> - mergetool: Add tests for filename with whitespace
>> 
>> I think this is a good idea, but it probably needs a re-roll.
>> Cf. $gmane/176254, 176255, 166256
> 
> What's the plan for this series? Do we still want to pursue it within the
> timeframe for the next round?
> 
> Is there any mergetool/difftool expert who volunteers to help moving this
> topic forward?


I'd love this to stay alive. As I've mentioned before, my relationship with shell is tenuous. My biggest problem is I don't have a mental model of how quoting works, so I end up writing tests and performing trial-and-error until it works.


On 2011-06-22, at 14:33, Junio C Hamano wrote:

> Why do you need a loop here in the else clause, instead of just a single:
> 
> 	files=$(git ls-files -u -- "$@" |...)

See above (the dumb loop isn't necessary; your suggestion is much better). Should I bother re-submitting with just this change?



Jonathon Mah
me@JonathonMah.com
