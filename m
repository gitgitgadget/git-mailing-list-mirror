From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] [RFD] Using gitrevisions :/search style with other
 operators
Date: Fri, 10 Dec 2010 15:36:22 -0800
Message-ID: <7v7hfhb3pl.fsf@alter.siamese.dyndns.org>
References: <1291820319-12455-1-git-send-email-pclouds@gmail.com>
 <201012082051.09730.jnareb@gmail.com>
 <AANLkTimU6Bhx-2XsZ45_7BmT9fo9MpK8TJWB3zZ=j-i7@mail.gmail.com>
 <201012090254.24999.jnareb@gmail.com> <20101209015926.GA31119@burratino>
 <7vsjy7h3db.fsf@alter.siamese.dyndns.org>
 <AANLkTimg4Cy83gjzgC3fwg+t=B57b6gzOE98p-=2AR+K@mail.gmail.com>
 <20101210190332.GA6210@burratino>
 <66D6F30D-4707-4057-BB46-57B2DF01F479@sb.org>
 <7vipz1b4zm.fsf@alter.siamese.dyndns.org>
 <64905EED-F368-4D3F-9D2D-C08D9B460D67@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Yann Dirson <dirson@bertin.fr>, Jeff King <peff@peff.net>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Sat Dec 11 00:36:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRCW5-0002TH-GV
	for gcvg-git-2@lo.gmane.org; Sat, 11 Dec 2010 00:36:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756125Ab0LJXgm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 18:36:42 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41222 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755819Ab0LJXgm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 18:36:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CDB323B86;
	Fri, 10 Dec 2010 18:37:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PR+C2cRzoAx2DlAekKSgIiJ5CKQ=; b=DFNVp3
	YMap7J02JK1d53N7V69xj6P1UJ3AZ+JfvGfQqk6wVAciQU6TvAsehA3jBYKwTZzj
	9WY8WhNp7zhmpgHRX2qohrrEvB9Oz36W+3jw37DRVYnu7htYIPYPU5lJ8w5AF3eG
	l6/Qy2O0RAxFtglnPkDXKvNjYDwFHcq0JcNfw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=A3/YLcwPSIbfyVo5/NDX0DgVaOnh/E0r
	3JUavygaPX1rIDpXL+eky8jZbiXQs/1bgFV+ehMktqZXUUrUV54/YnP3MznW6uJM
	HltIBPOXVCXSwYuu6723jiCgcJ9vdWP+ooawmnhIfTHlLT8utnS1nuN1X4SQ1Uc0
	0WssckgV8x8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 55E8C3B82;
	Fri, 10 Dec 2010 18:36:58 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4F7603B81; Fri, 10 Dec 2010
 18:36:49 -0500 (EST)
In-Reply-To: <64905EED-F368-4D3F-9D2D-C08D9B460D67@sb.org> (Kevin Ballard's
 message of "Fri\, 10 Dec 2010 15\:11\:56 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 613E07F8-04B6-11E0-A421-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163450>

Kevin Ballard <kevin@sb.org> writes:

> On Dec 10, 2010, at 3:08 PM, Junio C Hamano wrote:
> ...
>>  d414638 Merge branch 'rj/msvc-fix' into pu
>>  ...
>>  1b2ea00 Merge branch 'mg/cvsimport' into pu
>>  c6d41f4 Merge branch 'nd/maint-relative' into pu
>>  81f395e Merge branch 'ab/i18n' into pu
>>  9f5471f Merge branch 'nd/setup' into pu
>>  06f74a4 Merge branch 'yd/dir-rename' into pu
>>  d8a2ec8 Merge branch 'en/object-list-with-pathspec' into pu
>> 
>> After looking at this output, do you really want to say ":nth(2)/nd/"
>> instead of 9f5471f?
>
> Yep. Doing the latter either requires me to swap over to my mouse, copy the sha1,
> and paste in, or requires me to peer at the sha1 and re-type enough characters.
> It's a lot easier to just glance at that list, realize the 2nd one is the one I
> want, and type `git merge :^{nth(2)/nd/}`. It may not necessarily be faster than
> retyping the sha1, but it's a lot less prone to transcription errors.

What you said heavily depends on the way in which I give names to the
branches, and also on the fact that "nd/" happens to be not very common
prefix at this moment.  If the branches were named without nd/ part and
still be unique, you would not be arguing for nth(2) at all to begin with.

So it is dubious that your argument is convincing.
