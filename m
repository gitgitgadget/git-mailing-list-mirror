From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 1/3] git-bisect: war on "sed"
Date: Thu, 15 Nov 2007 12:18:50 +0100
Message-ID: <861war4uzp.fsf@lola.quinscape.zz>
References: <20071115081807.06fe092b.chriscool@tuxfamily.org>
	<7voddv6fxz.fsf@gitster.siamese.dyndns.org>
	<buozlxfeu0z.fsf@dhapc248.dev.necel.com>
	<995F69D5-4ABC-44E7-BA2B-5E276479EDA1@wincent.com>
	<buotznnesw9.fsf@dhapc248.dev.necel.com>
	<86tznn4y7v.fsf@lola.quinscape.zz>
	<fc339e4a0711150300n64b9d670o1e183553a9de0cba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 15 12:19:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iscl4-0005Wj-RK
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 12:19:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760497AbXKOLTE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 06:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759954AbXKOLTD
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 06:19:03 -0500
Received: from main.gmane.org ([80.91.229.2]:39925 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752087AbXKOLTB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 06:19:01 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IsckK-0001rM-IJ
	for git@vger.kernel.org; Thu, 15 Nov 2007 11:18:56 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Nov 2007 11:18:56 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Nov 2007 11:18:56 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:DYK2EgL8a7N5kd+QK2EvsnfE4jQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65108>

"Miles Bader" <miles@gnu.org> writes:

> On Nov 15, 2007 7:09 PM, David Kastrup <dak@gnu.org> wrote:
>> > Er, I suppose -- if you are acquainted with that particular shell
>> > variable syntax (I suspect knowledge of sed is far more widespread).
>>
>> sed is rather bad with regard to portability.  If you take a look at
>> the respective portability section in the autoconf file, it is almost
>> longer than that of Bourne shells.
>
> I don't think that's really a fair characterization -- almost all of
> the autoconf sed portability caveats concern weird corner cases in the
> dusty corners of the language (and some are "common" issues with other
> tools, i.e., avoiding ^ and $ inside of regexp groups).
>
> For typical straightforward usage, there seems little problem.
>
> [The main portability problems I've actually _noticed_ with sed are
> the "-e" versus ";" issue and what happens with "\n" in various
> contexts...]

What about character classes containing the pattern delimiter, \+, \?,
\|, nested grouping, anchors in groups, * after groups?  That's all
rather straightforward usage.

-- 
David Kastrup
