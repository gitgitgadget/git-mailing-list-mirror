From: Wincent Colaiuta <win@wincent.com>
Subject: Re: What's cooking in git.git (topics)
Date: Fri, 2 Nov 2007 11:26:43 +0100
Message-ID: <87F9D7C1-8E4D-4F74-B514-EF128189CB8A@wincent.com>
References: <20071022063222.GS14735@spearce.org> <7vzly84qwf.fsf@gitster.siamese.dyndns.org> <7vmytycykt.fsf@gitster.siamese.dyndns.org> <20071101214131.GF4099@lavos.net>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Fri Nov 02 11:27:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IntkB-0005nZ-4g
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 11:27:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753226AbXKBK1A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Nov 2007 06:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753247AbXKBK1A
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 06:27:00 -0400
Received: from wincent.com ([72.3.236.74]:37008 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753069AbXKBK07 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Nov 2007 06:26:59 -0400
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lA2AQj9Y027936;
	Fri, 2 Nov 2007 05:26:46 -0500
In-Reply-To: <20071101214131.GF4099@lavos.net>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63097>

El 1/11/2007, a las 22:41, Brian Downing escribi=F3:

> On Wed, Oct 31, 2007 at 10:41:06PM -0700, Junio C Hamano wrote:
>> * jc/spht (Tue Oct 2 18:00:27 2007 -0700) 1 commit
>> - git-diff: complain about >=3D8 consecutive spaces in initial inden=
t
>>
>> This is a counterpart of an earlier patch from J. Bruce Fields
>> to change "git-apply --whitespace" to make SP{8,} at the
>> beginning of line a whitespace error.
>>
>> Personally, I am in favor of the stricter check, but I had to
>> reject the "git-apply" patch because there was no way to disable
>> the additional check without disabling the existing check for
>> trailing whitespaces.  We probably would want to revisit that
>> one (perhaps with a new option and/or config to selectively
>> enable different kinds of whitespace check).
>
> Just to throw in my two cents, I would be strongly opposed to this
> going in without some form of configuration to make it work for
> spaces-only-indent projects.

Ditto, I also work on some projects which have a spaces-only policy, =20
and the proposed change would be quite painful when working on those =20
projects, so configurability would be very important to me.

Cheers,
Wincent
