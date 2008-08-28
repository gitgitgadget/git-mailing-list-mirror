From: Mike Hommey <mh@glandium.org>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Thu, 28 Aug 2008 07:43:52 +0200
Organization: glandium.org
Message-ID: <20080828054352.GB6791@glandium.org>
References: <1f6632e50808260904t6bea0be5kc69342917e3db97@mail.gmail.com> <20080826162513.GR10544@machine.or.cz> <20080826164526.GM26610@one.firstfloor.org> <20080826171012.GO10360@machine.or.cz> <20080826171255.GI26523@spearce.org> <20080826171623.GE5318@coredump.intra.peff.net> <20080826210631.GC3812@1wt.eu> <48B5B7F3.4080803@pobox.com> <20080827202707.GA25233@coredump.intra.peff.net> <48B5BB35.8090606@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Willy Tarreau <w@1wt.eu>,
	Kristian H??gsberg <krh@redhat.com>,
	Matthias Kestenholz <mk@spinlock.ch>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	users@kernel.org, Andi Kleen <andi@firstfloor.org>,
	Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff Garzik <jgarzik@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 07:47:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYaLV-0000Et-1e
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 07:47:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbYH1Fp3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 01:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbYH1Fp3
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 01:45:29 -0400
Received: from vuizook.err.no ([194.24.252.247]:48513 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751127AbYH1Fp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 01:45:28 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1KYaIT-0004N8-Qf; Thu, 28 Aug 2008 07:44:00 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1KYaIS-00027Y-I9; Thu, 28 Aug 2008 07:43:52 +0200
Content-Disposition: inline
In-Reply-To: <48B5BB35.8090606@pobox.com>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 27, 2008 at 04:38:13PM -0400, Jeff Garzik wrote:
> Jeff King wrote:
>> On Wed, Aug 27, 2008 at 04:24:19PM -0400, Jeff Garzik wrote:
>>
>>> Indeed.
>>>
>>> Also, I type "git-diff-tree" quite a lot.
>>>
>>> My fingers find that
>>>
>>> 	git SPACE diff DASH tree
>>>
>>> is slower and less consistent than
>>>
>>> 	git DASH diff DASH tree
>>>
>>> The same with git-format-patch...  We are going from "all dashes" to 
>>> "a  mix of space and dashes" which is increasing inconsistency.
>>
>> I have also found the SPACE-DASH slightly harder to type. However, I'm
>> curious: what are you doing frequently from the commandline with
>> git-diff-tree that is not just as easily done with git-diff?
>
> I use it to spit out a patch for a specific commit:
>
> 	git-diff-tree -p $COMMIT
>
> Though probably someone will now come along and tell me I'm am  
> old-timer, and there is a shorter command that accomplishes the same  
> thing :)

Other than why you use git diff-tree so much, why don't you set 2
letters aliases for your most commonly used commands ?
[alias]
        st = status
        co = checkout
        fp = format-patch
        dt = diff-tree
etc.

Mike
