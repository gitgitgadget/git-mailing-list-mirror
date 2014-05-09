From: Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v1 25/25] contrib: remove 'mw-to-git'
Date: Fri, 09 May 2014 14:30:41 +0200
Message-ID: <536CCA71.8010300@gmail.com>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com> <1399597116-1851-26-git-send-email-felipe.contreras@gmail.com> <vpqr443i600.fsf@anie.imag.fr> <536cb51c3f348_6b2dde7308b1@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Q8OpbGVzdGluIE1hdHRl?= <celestin.matte@ensimag.fr>,
	Benoit Person <benoit.person@ensimag.fr>
To: Felipe Contreras <felipe.contreras@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri May 09 14:30:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wijws-0004Jx-Tb
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 14:30:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754063AbaEIMam (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 08:30:42 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:35259 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606AbaEIMam (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 08:30:42 -0400
Received: by mail-ee0-f46.google.com with SMTP id t10so2582854eei.5
        for <git@vger.kernel.org>; Fri, 09 May 2014 05:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=fdJWeRCYmJLeDdOnZ3GCGJaO7ZlLHZQZl3vR8B0mhcw=;
        b=iydhiFjgC0uxLnr8aH1HCtVZTwmEAgddmhXqdjl9XG2Y0RDpf8mhCgBIHlFVxLXIzQ
         7aQCSpOzBvdlvKNBvdZMJ9qnuzBEUrrzb64C9hx9R5ztTTNGZrsWb9TYDjCRvRXs16b5
         Ag7f1VOmZbLnyQNmeZYRgVwSyK2tUWvsFs4NJWW4jhhPYZ85teLZl5qwBrcB661AkN5N
         Y4ePPdwL2WVDglAO3dkv2R4Dem50eYkcMwembv/jswQNKAytrgoX3DMpvdOG0c3vnNg5
         9HUFTULx1q4HsMFMXWx/WSE5q8wPt5raOZunUmmeRlG4pvX3UjzuxMKQ7vyKwPB7fZyQ
         EZlw==
X-Received: by 10.15.24.201 with SMTP id j49mr12932154eeu.99.1399638640878;
        Fri, 09 May 2014 05:30:40 -0700 (PDT)
Received: from [192.168.1.7] (ip-178-200-168-156.unitymediagroup.de. [178.200.168.156])
        by mx.google.com with ESMTPSA id cj41sm11118115eeb.34.2014.05.09.05.30.39
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 09 May 2014 05:30:40 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <536cb51c3f348_6b2dde7308b1@nysa.notmuch>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248554>

On 09.05.2014 12:59, Felipe Contreras wrote:
> Matthieu Moy wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> No chance of ever graduating.
>>
>> I see no relationship between the chance of graduating and the removal
>> from contrib/.
> 
> Read contrib/README.
> 
>> If you want to remove mw-to-git from contrib, then a good starting point
>> would be to explain why you want to do so in the commit message.
> 
> The purpose of the contrib area is to either a) give visibility to
> otherwise potentially ignored scripts b) serve a staging area for
> features before moving into the core.
> 
> This script doesn't match either of those. It doesn't belong in the
> contrib/ area.
> 

Maybe we could split it a little bit. Similar to the kernel there is a
staging area. Ok there are some features, which are not yet promoted
to mainline, some never will.

But some things like examples/ could be moved out to another directory.
(How about Documentation/historicEncounters/ ?)

Also we could think about renaming contrib to staging then.
However I don't think it's urgent.
