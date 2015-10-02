From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [RFC/PATCH v1] Add Travis CI support
Date: Fri, 2 Oct 2015 18:40:11 +0200
Message-ID: <560EB36B.9020608@gmail.com>
References: <1443131004-39284-1-git-send-email-larsxschneider@gmail.com>
 <xmqqeghnuy8t.fsf@gitster.mtv.corp.google.com>
 <1443150875.3042.3.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	Junio C Hamano <gitster@pobox.com>, larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Fri Oct 02 18:40:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zi3No-0001z0-QQ
	for gcvg-git-2@plane.gmane.org; Fri, 02 Oct 2015 18:40:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752633AbbJBQk2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2015 12:40:28 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:32974 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919AbbJBQk2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2015 12:40:28 -0400
Received: by wiclk2 with SMTP id lk2so41829749wic.0
        for <git@vger.kernel.org>; Fri, 02 Oct 2015 09:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=mpeUkDEHRRMnuNjGIkE2tBSRZgKT5c249kdI8nOzAAg=;
        b=UEvuDXu0FqbLFX6NnOCcBk9wcpFqi7ThNVK0iPC939yz0Vw4Yw1iGe7GgwYOcPPRws
         nNb9uST2C5DBWvOzYXuqBxUIUwpPMDg7l9l59D7970QJ3KgmzTD55UdgdEGpxK49nFQJ
         Z98jT1hPu9dZFAC2wYBl9orNIQqRHDrcIZpIMK0sEzO5cSjE3pH4dSELIyTIcp+wIb8E
         k8fW/SZXJ7ooZMLtjU9LK6be0vuNlraov7SdZJlcY+lboIXHeX5lcEecKT3PqF9bEtTv
         TiKy2wLJG02fw8j/C3bvlhBBniGZOooVbfS2pKJ0ezFprDdzadPvXSjIVj2VqTiOoPDD
         k8Bw==
X-Received: by 10.180.8.232 with SMTP id u8mr5851864wia.10.1443804027005;
        Fri, 02 Oct 2015 09:40:27 -0700 (PDT)
Received: from [192.168.188.20] (p548D6E9C.dip0.t-ipconnect.de. [84.141.110.156])
        by smtp.googlemail.com with ESMTPSA id p1sm9204727wif.7.2015.10.02.09.40.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 02 Oct 2015 09:40:26 -0700 (PDT)
Newsgroups: gmane.comp.version-control.git
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12)
 Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
In-Reply-To: <1443150875.3042.3.camel@kaarsemaker.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278925>

On 25.09.2015 05:14, Dennis Kaarsemaker wrote:

>>> My idea is that the owner of "https://github.com/git/git" enables this account
>>> for Travis (it's free!). Then we would automatically get the test state for all
>>> official branches.
>>
>> The last time I heard about this "it's free" thing, I thought I
>> heard that it wants write access to the repository.
>
> It does not need write access to the git data, only to auxiliary GitHub
> data: commit status and deployment status (where it can put "this
> commit failed tests"), repository hooks (to set up build triggers),
> team membership (ro) and email addresses (ro).

Also, as Roberto explained at [1], "If you set up the webhook yourself, 
you don't need to grant the [repository hooks] permissions".

BTW, there's already an attempt at creating a .travis.yml file at [2].

[1] https://github.com/rtyley/submitgit/issues/16#issuecomment-120119634
[2] https://github.com/git/git/pull/154

-- 
Sebastian Schuberth
