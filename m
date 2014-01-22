From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v2 1/4] Consistently use the term "builtin" instead of
 "internal command"
Date: Wed, 22 Jan 2014 22:08:45 +0100
Message-ID: <52E0335D.3090408@gmail.com>
References: <52C58FD7.6010608@gmail.com>	<52C590B0.1020702@gmail.com>	<20140102203132.GQ20443@google.com> <CAHGBnuO+MT4pZHD8AiQ5mFU8bDwoFSgaCyxUzL572YVstCerqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 22 22:09:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W652j-0000q7-6c
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 22:09:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756018AbaAVVI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 16:08:57 -0500
Received: from mail-bk0-f47.google.com ([209.85.214.47]:34104 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753648AbaAVVI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 16:08:56 -0500
Received: by mail-bk0-f47.google.com with SMTP id d7so65876bkh.20
        for <git@vger.kernel.org>; Wed, 22 Jan 2014 13:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=okVIOqkvvI4qeoCgx9MDb3Mq6vsRTCuOuIYHmGg+wXs=;
        b=jxdH4QVyejxI+gI31Ag0MfWW5t60pWpUVe0GMvy9m8mzqU6e4lxtYjw7ZazYVqCUky
         iUCVb8Rv9oRjFEsFa4HeLRVRz7EJpodL4RXvUZ8oAUPzuk9/Lq4RDrCqmuT6l0QTwhXn
         +6Z4hh4wahcFrUdDF584qU09eGrBhP30Nw/Uk6bJ71mtsOx56iSVYbAm0zEnR0+e8WKo
         Lio0ZW0EkppHbBwFGgKiI3X2d3QqXVDYi/F+fxCK3RJs6t5vMDk/8L3fe7cPOp7nB+nM
         oSZpzzWVl1sSvEk4NDjupUzE4zaj4d2AS8rnhhNbdcT6egMdRfbvh/CO1TMVI/C4w3uw
         9y2Q==
X-Received: by 10.205.16.137 with SMTP id py9mr327552bkb.63.1390424934740;
        Wed, 22 Jan 2014 13:08:54 -0800 (PST)
Received: from [192.168.188.20] (p4FC96989.dip0.t-ipconnect.de. [79.201.105.137])
        by mx.google.com with ESMTPSA id jv7sm7194838bkb.6.2014.01.22.13.08.53
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 22 Jan 2014 13:08:53 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <CAHGBnuO+MT4pZHD8AiQ5mFU8bDwoFSgaCyxUzL572YVstCerqA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240859>

On 02.01.2014 22:05, Sebastian Schuberth wrote:

>> would just leave me wondering "I never claimed it was built-in; what's
>> going on?"  I think it would be simplest to keep it as
>>
>>          $ git whatever
>>          fatal: cannot handle "whatever" internally
>>
>> which at least makes it clear that this is a low-level error.
>
> Right, I'll change this in a re-roll (using single-quotes for the command name).

Sorry for not coming up with the re-roll until now, and now it's too 
late to fixup the commit as it's already on master (3f784a4). Since this 
is just a minor wording issue I'll not follow this up anymore.

-- 
Sebastian Schuberth
