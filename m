From: Wincent Colaiuta <win@wincent.com>
Subject: Re: RFC: git diff colorization idea
Date: Fri, 23 Jan 2009 07:16:50 +0100
Message-ID: <5034E8A9-2B17-4368-8EDF-5FEE61BB2BAD@wincent.com>
References: <53497057-1ADE-4300-9F35-B218959606FE@wincent.com> <7vhc3q6evi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 07:23:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQFRB-0002O1-6T
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 07:22:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762674AbZAWGU5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Jan 2009 01:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762665AbZAWGU4
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 01:20:56 -0500
Received: from wincent1.inetu.net ([209.235.192.161]:42643 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762656AbZAWGUz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Jan 2009 01:20:55 -0500
Received: from cuzco.lan (139.pool85-53-3.dynamic.orange.es [85.53.3.139])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id n0N6GoZn019140
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 23 Jan 2009 01:16:52 -0500
In-Reply-To: <7vhc3q6evi.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106841>

El 23/1/2009, a las 1:32, Junio C Hamano escribi=F3:

> Wincent Colaiuta <win@wincent.com> writes:
>
>> I'm also thinking that perhaps a per-character approach might be
>> useful here instead of a per-word one (it would make that last hunk
>> look better in the mock-up screenshot that I posted); if I go the =20
>> per-
>> character route then that suggests that "--color-chars" might be the
>> right option name, and the color slots would then be
>> color.diff.new.char and color.diff.old.char.
>>
>> Any feedback or suggestions before I get in too deep?
>
> I personally find your "prposal" picture too loud to my eye.

Yes, mine too. I wouldn't actually use those colors in practice. =20
(Doubly so because the "removed" color looks like the "whitespace =20
error" color.)

I'll whip something up with non-garish defaults.

Cheers,
Wincent
