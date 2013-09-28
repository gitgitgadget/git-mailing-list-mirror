From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] RelNotes/1.8.5: direct script writers to "git status
 --porcelain"
Date: Fri, 27 Sep 2013 17:08:53 -0700
Message-ID: <20130928000853.GQ9464@google.com>
References: <1380201815-14140-1-git-send-email-Matthieu.Moy@imag.fr>
 <loom.20130926T201754-563@post.gmane.org>
 <87y56jl3bz.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Keshav Kini <keshav.kini@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 28 02:09:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPi61-0001FV-47
	for gcvg-git-2@plane.gmane.org; Sat, 28 Sep 2013 02:09:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754213Ab3I1AI7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Sep 2013 20:08:59 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:42867 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753786Ab3I1AI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Sep 2013 20:08:58 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz1so3397931pad.30
        for <git@vger.kernel.org>; Fri, 27 Sep 2013 17:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=nVOcYG4CeyLfBllsYAvJJceURsdAuTssBTS9+cmGYD4=;
        b=vAfWXxAUOFT5pBAylT+wdqw7UAcr1TKXPqgaLul+L/f2JaQgN/2UKyJm03o57lxcno
         jL6S9+rU5at2r8oPBn7UWv6Ja5utRNkjvtq8bfVZXL5/Ewp9AySe0S/HwpRyVCWxwW8c
         vclwrzt7Azkf1C/rEb3WPZ+UveI6+sZgqOKOjzN4GgAV5bxfkB3o2cvolHc46891qxmQ
         F9LL2B+VGv2SVxAmFmhG4MIs8wtjugkJfz/EQdpBgCQjXtk6y7E+lRTq+KO2vSGuGbTt
         UuwerZ/fq4RMoig60j2o2vIhhAF8Kc0nUHNYj3SwbjD96R2SUFzn4cGOxcnDR/UXJdeG
         mDTw==
X-Received: by 10.66.141.144 with SMTP id ro16mr16765pab.173.1380326937540;
        Fri, 27 Sep 2013 17:08:57 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id py4sm11281972pbb.33.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 27 Sep 2013 17:08:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87y56jl3bz.fsf@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235481>

Keshav Kini wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>> Matthieu Moy <Matthieu.Moy@imag.fr> writes:

>>>   * "git status" now omits the prefix to make its output a comment in a
>>>     commit log editor, which is not necessary for human consumption.
>>> +   Scripts that parse the output of "git status" are advised to use
>>> +   "git status --porcelain", which is both easier to parse and stable,
>>> +   instead.
>>
>> Good addition.
[...]
>                   rewording it to the following is much better, IMHO:
> '... are advised to use "git status --porcelain" instead, as it is both
> stable and easier to parse.'

Thanks, all.
