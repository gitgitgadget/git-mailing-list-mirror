From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: building git on Solaris
Date: Fri, 10 Sep 2010 22:00:03 +0200
Message-ID: <4C8A8E43.1030708@dbservice.com>
References: <4C86A86B.1030107@bio.umass.edu> <AANLkTikvy-wUB-RFLegp7KJa_srqh97nLC03bdZDmru=@mail.gmail.com> <4C87A1DF.1020706@bio.umass.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	git mailing list <git@vger.kernel.org>
To: Chris Hoogendyk <hoogendyk@bio.umass.edu>
X-From: git-owner@vger.kernel.org Fri Sep 10 22:16:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OuA1e-0003yT-Jl
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 22:16:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755198Ab0IJUQj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Sep 2010 16:16:39 -0400
Received: from office.neopsis.com ([78.46.209.98]:40532 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752938Ab0IJUQj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Sep 2010 16:16:39 -0400
X-Spam-Status: No, hits=0.0 required=5.0
	tests=BAYES_00: -1.665,TOTAL_SCORE: -1.665,autolearn=ham
X-Spam-Level: 
Received: from calvin.caurea.org ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Fri, 10 Sep 2010 22:16:34 +0200
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <4C87A1DF.1020706@bio.umass.edu>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155968>

On 9/8/10 4:46 PM, Chris Hoogendyk wrote:
> Anyway, now I'm in the normal build debugging mode. Got all the way
> through to building the Documentation, at which stage I now need to get
> asciidoc and python. I don't really like bloating my minimal server
> systems with python, but it seems I'm finally stuck, since I have
> faculty who really want to use git.

Git doesn't *need* python nor asciidoc, it works just fine without.
Except, of course, that tools which require python don't work (but there
aren't many of those, most is C, shell and perl).

tom
