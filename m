From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: Patchbombing or not, that is the question
Date: Sat, 27 Nov 2010 19:13:36 +0100
Message-ID: <AANLkTik2WXj3kN2859_iSLQWarkR9ugJQiL2TwiNj109@mail.gmail.com>
References: <AANLkTi=C4opog2SfU9R_=dSOGY_5+0WYtFL8BNqcOwUw@mail.gmail.com>
 <20101127172757.GA1858@burratino> <AANLkTimKdwrsYQHGL=KaoQEmv3FLJzS+M=5xdQi+A5Ny@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 27 19:14:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMPHe-0001q0-UL
	for gcvg-git-2@lo.gmane.org; Sat, 27 Nov 2010 19:14:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753162Ab0K0SN5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Nov 2010 13:13:57 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60550 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753107Ab0K0SN5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Nov 2010 13:13:57 -0500
Received: by iwn5 with SMTP id 5so125306iwn.19
        for <git@vger.kernel.org>; Sat, 27 Nov 2010 10:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=wO+8oLgmpNG5pfiTu3Xwu4YcPOFNiX44yGJHbjbxtkA=;
        b=S0tIJiH7pzkAqc6E7d6t23eK2Y3RlwUwOuJPwrOHTH2FX2z4wF6S4g+TbJnrjqBgUG
         fFRkzKkYBNfnsP0OEaT2l7f8+EBlZMXMct9Wr6d9Y9xi9IdeCKuOsocvfy8qyo7jkPHu
         Aa7ctmfK5416R0NdfOMwOrgixykZrK+yQFjIU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=v9dfhVRePHIKt4RvAq39StVVvyPcUeJVksPTP+kJUs809rg/HYuHZqfV16WyCr5Wys
         5JWr6R8KLgcsyb7VTBjJgArIUwMiuvMjnNkPo97FkgbUW+5aOywVlIsmKfoe+zttnDXX
         5DBRNyVpPWzuqybrYjXXLZEz2p76KhhzRX8gk=
Received: by 10.231.13.138 with SMTP id c10mr3231691iba.57.1290881636452; Sat,
 27 Nov 2010 10:13:56 -0800 (PST)
Received: by 10.231.17.135 with HTTP; Sat, 27 Nov 2010 10:13:36 -0800 (PST)
In-Reply-To: <AANLkTimKdwrsYQHGL=KaoQEmv3FLJzS+M=5xdQi+A5Ny@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162320>

On Sat, Nov 27, 2010 at 6:40 PM, Thiago Farina <tfransosi@gmail.com> wr=
ote:
> On Sat, Nov 27, 2010 at 3:27 PM, Jonathan Nieder <jrnieder@gmail.com>=
 wrote:
>> Giuseppe Bilotta wrote:
>>
>>> I prepared a bunch of patches to add support to some other browsers=
 to
>>> git-web--browse (opera, seamonkey, elinks). Currently I did one pat=
ch
>>> per browser. Should I squash them all together?
>>
>> Yeah, I'd squash them. =A0(But I think either way would be fine.)
>>
>> Could you support
>>
>> =A0 =A0 =A0 =A0[browser "chromium-browser"]
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cmd=3Dchromium-browser
>>
> Yeah, that would be great!

Actually I think that in this case the 'chromimu' configuration should
look for chromium-browser if chromium is not found.

--=20
Giuseppe "Oblomov" Bilotta
