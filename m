From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Mon, 31 Oct 2011 15:51:52 -0700
Message-ID: <4EAF2688.9000508@zytor.com>
References: <1319969101.5215.20.camel@dabdike> <CA+55aFx1NGWfNJAKDTvZfsHDDKiEtS4t4RydSgHurBeyGPyhXg@mail.gmail.com> <1320049150.8283.19.camel@dabdike> <CA+55aFz3=cbciRfTYodNhdEetXYxTARGTfpP9GL9RZK222XmKQ@mail.gmail.com> <7vy5w1ow90.fsf@alter.siamese.dyndns.org> <CA+55aFwL_s=DcT46dprcYVWEAm_=WkuTV6K9dAn3wc_bDQU8vA@mail.gmail.com> <4EAF1F40.3030907@zytor.com> <CA+55aFxprv9JR4gtt_UDXheHR5G8PrUA3-Mj0CPsU6E5EzNYeg@mail.gmail.com> <4EAF2245.90308@zytor.com> <7vzkggok6u.fsf@alter.siamese.dyndns.org> <20111031224905.GQ16825@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Ted Ts'o" <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership
X-From: linux-ide-owner@vger.kernel.org Mon Oct 31 23:52:10 2011
Return-path: <linux-ide-owner@vger.kernel.org>
Envelope-to: lnx-linux-ide@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-ide-owner@vger.kernel.org>)
	id 1RL0i9-0002K4-So
	for lnx-linux-ide@lo.gmane.org; Mon, 31 Oct 2011 23:52:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934716Ab1JaWwI (ORCPT <rfc822;lnx-linux-ide@m.gmane.org>);
	Mon, 31 Oct 2011 18:52:08 -0400
Received: from terminus.zytor.com ([198.137.202.10]:40810 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934711Ab1JaWwH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 31 Oct 2011 18:52:07 -0400
Received: from anacreon.sc.intel.com (fmdmzpr03-ext.fm.intel.com [192.55.54.38])
	(authenticated bits=0)
	by mail.zytor.com (8.14.5/8.14.5) with ESMTP id p9VMpvaS005929
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Mon, 31 Oct 2011 15:51:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0) Gecko/20110927 Thunderbird/7.0
In-Reply-To: <20111031224905.GQ16825@thunk.org>
X-Enigmail-Version: 1.3.2
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184538>

On 10/31/2011 03:49 PM, Ted Ts'o wrote:
> On Mon, Oct 31, 2011 at 03:44:25PM -0700, Junio C Hamano wrote:
>> So nobody is worried about this (quoting from my earlier message)?
>>
>>    On the other hand, the consumers of "Linus kernel" may want to say that
>>    they trust your tree and your tags because they can verify them with your
>>    GPG signature, but also they can independently verify the lieutenants'
>>    trees you pulled from are genuine.
>>
>> A signed emphemeral tag is usable as means to verify authenticity in a
>> hop-by-hop fashion, but that does not leave a permanent trail that can be
>> used for auditing.
> 
> Oh, there are definitely people who worry about this.  They tend to be
> security poeple, though, so the goal is how do we leave the permanent
> trail in a way that doesn't generate too much noise or otherwise makes
> life difficult for developers who don't care.
> 

Could we introduce a tag namespace that doesn't show up in gitweb by
default, and perhaps doesn't resolve in abbreviated form?

This is basically what Linus suggested, as far as I understand:
something like refs/pulls/hpa/tip-123-456 which is otherwise a normal
tag object?

	-hpa


