From: Max Horn <max@quendi.de>
Subject: Re: [PATCH 2/2] Document rev^! and rev^@ as revision specifiers
Date: Mon, 9 Jul 2012 17:02:19 +0200
Message-ID: <05708C97-7925-4E45-BA16-374FB38F54D1@quendi.de>
References: <7vpq8aqdzb.fsf@alter.siamese.dyndns.org> <1341532890-13829-1-git-send-email-max@quendi.de> <1341532890-13829-2-git-send-email-max@quendi.de> <7vtxxlnyn1.fsf@alter.siamese.dyndns.org> <D8DF0AED-91D3-45C0-B49E-97E07D21350C@quendi.de> <7vliiwog0a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1280)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Mon Jul 09 17:02:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoFTn-0004Ul-Hf
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jul 2012 17:02:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754246Ab2GIPCX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jul 2012 11:02:23 -0400
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:35408 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752523Ab2GIPCW convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 9 Jul 2012 11:02:22 -0400
Received: from 77-22-67-26-dynip.superkabel.de ([77.22.67.26] helo=kaitain-wlan.fritz.box); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1SoFTg-0000SX-LY; Mon, 09 Jul 2012 17:02:20 +0200
In-Reply-To: <7vliiwog0a.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1280)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1341846142;e3e5a862;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201208>

> 
On 06.07.2012, at 21:18, Junio C Hamano wrote:

> Max Horn <max@quendi.de> writes:
> 
>>>> +'<rev>{caret}!', e.g. 'HEAD{caret}!'::
>>>> +  A suffix '{caret}' followed by an exclamation mark
>>>> +  means commit '<rev>' but forces all of its parents to be excluded. For
>>>> +  commands that deal with a single revision, this is the same as '<rev>".
>>> 
>>> Is this sentence correct?  "git commit -C 'HEAD^!'" might be a
>>> command that expects a single revision, but I do not think it is the
>>> same as "git commit -C HEAD".
>> 
>> Ignoring the exact words I used for the moment, what I meant is that these two commands should be functionally equivalent. Aren't they?
> 
> No.  When a single commit is wanted HEAD^! shouldn't be used, and
> they cannot be functionally equivalent.  I haven't tried but I think
> "commit -C HEAD^!"  would give you a syntax error.
> 

Indeed, it says
 fatal: could not lookup commit HEAD^!

I'll iterate over this once more.

Cheers,
Max