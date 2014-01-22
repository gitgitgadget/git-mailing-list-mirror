From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] gitk: Replace "next" and "prev" buttons with down and up arrows.
Date: Wed, 22 Jan 2014 12:18:27 -0800
Message-ID: <xmqqa9enydm4.fsf@gitster.dls.corp.google.com>
References: <20131008193618.GE9464@google.com>
	<1387382653-8385-1-git-send-email-marcnarc@xiplink.com>
	<52DE932E.7090008@xiplink.com>
	<20140122110448.GB7306@iris.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	"Lucas Sandery \[three am design\]" <lucas@threeamdesign.com.au>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Jan 22 21:18:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W64Fw-0007A7-5t
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 21:18:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755459AbaAVUSc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 15:18:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49020 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752798AbaAVUSb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 15:18:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4361F64B5F;
	Wed, 22 Jan 2014 15:18:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=drLcXc2J1fjwJ9fWJiPhJSb6/Os=; b=WK0262
	sWoSaF4ly/an49tlR0f3Xv3SiA/uwM9KC4JeFHI9K8V0SKVPQ3DkHz4CkzR/pz/R
	+n5g/51dkBAltYdz66b26majQXk6CKlMgS+V7g6GQKsBsCXyxTJg657+8LmC7mA8
	dg+wwmF9dLDPXzjdNk4Kv/WJ0u4O8ESAb1mEI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u10lix38cTJRmrnGma2QBJ9fhU9yUkxx
	uMtDGbdUGUCBJCKFk8fQ0PvAeW5sJE0ueZZ0wfNW3HgzZ+kfrjx02HWMC2kT5mTI
	1lP21bWfMRcsfhw19RifZifo0T5jZxpTnpF00wUhgC7H0newdvhsuv/fvAWQoWLp
	khulNnWR3SQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 33AD364B5E;
	Wed, 22 Jan 2014 15:18:31 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 25E6A64B5C;
	Wed, 22 Jan 2014 15:18:29 -0500 (EST)
In-Reply-To: <20140122110448.GB7306@iris.ozlabs.ibm.com> (Paul Mackerras's
	message of "Wed, 22 Jan 2014 22:04:48 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5BF036C2-83A2-11E3-A0E4-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240852>

Paul Mackerras <paulus@samba.org> writes:

> On Tue, Jan 21, 2014 at 10:33:02AM -0500, Marc Branchaud wrote:
>> On 13-12-18 11:04 AM, Marc Branchaud wrote:
>> > Users often find that "next" and "prev" do the opposite of what they
>> > expect.  For example, "next" moves to the next match down the list, but
>> > that is almost always backwards in time.  Replacing the text with arrows
>> > makes it clear where the buttons will take the user.
>> 
>> Any opinions on this, either way?
>> 
>> I've grown fond of the down/up arrows.  I find them much clearer than the
>> current next/prev buttons.
>> 
>> My only niggle about this patch is that the buttons are much smaller,
>> requiring a bit more precision clicking.  But the smaller buttons allow more
>> room for other widgets.
>
> I showed it to a few colleagues who use gitk a lot.  One was
> indifferent, the others liked it, so I have applied it.
>
> Thanks,
> Paul.

Is this a good time for me to pull from you?  I see these on your
'master' branch.

    8f86339 gitk: Comply with XDG base directory specification
    786f15c gitk: Replace "next" and "prev" buttons with down and up arrows
    c61f3a9 gitk: chmod +x po2msg.sh
    6c626a0 gitk: Update copyright dates
    45f884c gitk: Add Bulgarian translation (304t)
    1f3c872 gitk: Fix mistype

Thanks.
