From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: How to send a warning message from git hosting server?
Date: Wed, 15 Apr 2015 15:58:52 +0530
Message-ID: <552E3D64.8090501@gmail.com>
References: <CAFT+Tg-Gwr9EemFv88+=Ao21dGYe73D-CDiT4mXU4kuP-niOSw@mail.gmail.com>	<alpine.LSU.2.00.1504081206420.10193@hermes-1.csi.cam.ac.uk> <CAFT+Tg9La03dkteQT0YOPPKdR78w89385VfOGN2B9kLGPo7Kcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: semtlenori@gmail.com, Tony Finch <dot@dotat.at>
X-From: git-owner@vger.kernel.org Wed Apr 15 12:29:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiKZB-00072b-5r
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 12:29:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756132AbbDOK27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2015 06:28:59 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36585 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754870AbbDOK24 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2015 06:28:56 -0400
Received: by pabsx10 with SMTP id sx10so46214313pab.3
        for <git@vger.kernel.org>; Wed, 15 Apr 2015 03:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=EykfEBwy7DytggGwwQFRU1ph8RNxbmeoCOMIKlp2KiM=;
        b=QKK1gezEy/53pobibZrTfkPWzeVGElA6lu7FKwzykX3zDgEjmB6EZDto4rkMfEjC0N
         n9oh4bGoRMpHg1zCBbG6KOUr9jtG427IXIWNps8k7QfAb9UItnRfhG/0DycF33UqWdgI
         MqmetUCyWL0yOqziKeb04sFKFaFoA3nd8PzP1gKqpyrjigR2XrfPXfj4X8MEC6do3VYP
         hZBG1+95KERhoTcaEoY+5PQe+dvmz4BudjSY8AZDNV0YRaGlnNuN8QD7g4AaDECSv3ua
         +gFzrP+/AZ+P1zptsPPZgRztrCW2xxiW+GayIKJPIXfWKfnBHRT914UzL3nn2kDTCh1D
         jzaA==
X-Received: by 10.70.32.164 with SMTP id k4mr45388118pdi.138.1429093735619;
        Wed, 15 Apr 2015 03:28:55 -0700 (PDT)
Received: from sita-lt.atc.tcs.com (atcmail.atc.tcs.com. [203.200.212.145])
        by mx.google.com with ESMTPSA id bs4sm3720147pdb.21.2015.04.15.03.28.53
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Apr 2015 03:28:55 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <CAFT+Tg9La03dkteQT0YOPPKdR78w89385VfOGN2B9kLGPo7Kcg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267195>

On 04/12/2015 04:55 PM, Yi, EungJun wrote:
> On Wed, Apr 8, 2015 at 8:08 PM, Tony Finch <dot@dotat.at> wrote:
>> Yi, EungJun <semtlenori@gmail.com> wrote:
>>>
>>> I want a way to response a remote message when a client send any kind
>>> of request. Is it possible?
>>
>> Yes, though you need a wrapper around git. Recent versions of gitolite
>> have a "motd" message of the day feature.
> 
> It sounds nice. Is the wrapper for git client or git server?

Gitolite is -- in this context -- a wrapper on the git server.

It's main purpose is access control; the motd feature is just an extra that just happened to be easy once there was a wrapper anyway.
