From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] help.c: Pull cmd_version out of this file.
Date: Wed, 1 Sep 2010 13:04:37 +1000
Message-ID: <AANLkTik7P2nC9zMp5+srrRNEAOKLcXnsJA5+_43S9A3=@mail.gmail.com>
References: <2ae543604216146b742253584d8393c5e3179697.1283114573.git.tfransosi@gmail.com>
	<20100830023812.GA4010@burratino>
	<20100830024020.GB4010@burratino>
	<AANLkTimDjRz=JmiVn+ybQ5ewaj=7N5tp48fUArD5vG_H@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 01 05:04:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oqdcx-0005yP-74
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 05:04:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752779Ab0IADEj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 23:04:39 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:52455 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166Ab0IADEi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 23:04:38 -0400
Received: by wyb35 with SMTP id 35so8676309wyb.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 20:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=3AwcXERaJ8vYVRpRGn02SamgswmB9VN7TrXlHBxU/6U=;
        b=T78R1Zkl8ozk0p+Ch4MppiCex9geefPw1H7UBt9e7lM36NbzInUogC9cGmII+8ZikF
         xyTiOzJ/lAyRkhwYl4+3ex8f41UaG4944wPEaT2EYJO2f8/jUlb5lFbaCwozZjI9T4PP
         txhrKbsNNWPwiJ16ecZqSAllYqYh8z3iqcOhU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=VbdgN7vr6i8RbYLRFj69BzdM4j0jT7DP7l7u4ldvV//4I82M+TYGTSG9Aj8QLX78zq
         zzcq2dJol2ZoWu0KiwsTFg75isWwDG7HmoF+2DseY3UzrrNPBhSRuNWGYRhDeB4jVKhi
         eZafFauf4uvbmiBNdQzf17IhFv4q9WinZLKL8=
Received: by 10.216.17.211 with SMTP id j61mr7279555wej.14.1283310277244; Tue,
 31 Aug 2010 20:04:37 -0700 (PDT)
Received: by 10.216.184.17 with HTTP; Tue, 31 Aug 2010 20:04:37 -0700 (PDT)
In-Reply-To: <AANLkTimDjRz=JmiVn+ybQ5ewaj=7N5tp48fUArD5vG_H@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155008>

On Wed, Sep 1, 2010 at 12:38 PM, Thiago Farina <tfransosi@gmail.com> wrote:
> On Sun, Aug 29, 2010 at 11:40 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Jonathan Nieder wrote:
>>> Thiago Farina wrote:
>>>
>>>> Promote cmd_version to a builtin, by moving it to its own file
>>>> in builtin/version.c
>> [...]
>> So for what it's worth,
>>
>> Acked-by: Jonathan Nieder <jrnieder@gmail.com>
>>
>
> Ping Junio.

Not my call, but should you also update .gitignore to ignore git-version?
-- 
Duy
