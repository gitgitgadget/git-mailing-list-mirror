From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Re: Edit a rerere conflict resolution
Date: Mon, 12 Mar 2012 22:39:32 +0100
Message-ID: <4F5E6D14.2060306@lyx.org>
References: <4F5E4B20.5080709@lyx.org> <7vobs1r3kn.fsf@alter.siamese.dyndns.org> <4F5E5A77.1070605@lyx.org> <7vd38hr22e.fsf@alter.siamese.dyndns.org> <4F5E68C5.5070300@lyx.org> <7vipi9pkpw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 12 22:39:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7Cxw-0007Qk-8X
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 22:39:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753490Ab2CLVjf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 17:39:35 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:43002 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752326Ab2CLVje (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 17:39:34 -0400
Received: by eekc41 with SMTP id c41so1524267eek.19
        for <git@vger.kernel.org>; Mon, 12 Mar 2012 14:39:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=Wu77WwD8eFz/c0xg084bkT4EWFv1lPDqS3MfNiyCwws=;
        b=Hh4RdYeqLEBxVYYG2VewL6bjeI1xO6IRQqCD8smVqjg23ywHT0cuv1QHzUD7ozF6JL
         72TdF6dyeGumW+YX78zhNDpVvu3pXFTg5mzl3/IIuxKjQoQ7bqTGRD4wqWLJZJK2HCy0
         ryzw6TBNs0CMoDyb1fPNB4JlB3lv432/2sucEEMTEIjPYl96B1hdX9QCakp+dco8SZBH
         6Qd/WsFn/8wSVW7DpnOjZ9INQ33DrhC5JNjbO2PxTvTjQqAuavNacezl3yCaUTY1eNap
         ds3N0WblEsUVsy+0aDrNGJgXy5Lj1j2GzhsQ/MwdTQT0LX1D2yU/yIyjWlHr7OEXlZoT
         uRKg==
Received: by 10.213.27.22 with SMTP id g22mr1106945ebc.83.1331588373042;
        Mon, 12 Mar 2012 14:39:33 -0700 (PDT)
Received: from [192.168.1.3] (j175101.upc-j.chello.nl. [24.132.175.101])
        by mx.google.com with ESMTPS id n56sm32400400eeb.4.2012.03.12.14.39.32
        (version=SSLv3 cipher=OTHER);
        Mon, 12 Mar 2012 14:39:32 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <7vipi9pkpw.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQkeLfFrQZOh7yEURdUhygWrKOnip266/cOYOJ9FVfiPPqbM+jcvBlkSRGiNVMsQwwk41d3D
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192952>

Op 12-3-2012 22:34, Junio C Hamano schreef:
> Vincent van Ravesteijn<vfr@lyx.org>  writes:
>
>>> The problem I have with "rerere edit" is it is an offline process,
>>> and to validate that the update is correct, I would have to have the
>>> problematic merge in my working tree once _anyway_.  And at that
>>> point, updating the target file in the working tree and recording
>>> the updated resolution using the usual "git rerere" feels a more
>>> natural way to do so, and more importantly, it is a more convenient
>>> way to do the "update and validate".  On the other hand, "rerere
>>> edit" is a more convenient way to "update but not validate the
>>> result".
>> This last part probably makes the difference indeed. In my case the
>> merge resolution was very very easy (the conflicting hunks have
>> fileformat version numbers), but it is a bit annoying and it requires
>> some 'vim'-skills to redo the merge conflict just to correct a newline
>> somewhere, or a missing ','.
> Now you confused me.  How do you envision your "rerere edit" not to
> require "vim-skills" that is needed to navigate to the problematic
> line to correct a newline or comma?  To put it another way, how much
> more "vim-skills" is needed to fix the conflict in the real file,
> than "rerere edit"?

Well, I often paste lines in the line below the line I wanted to paste 
to, in python files I often get whitespace errors,  when cutting line I 
always have to guess how many lines there are... anyway, I don't feel 
very comfortable.

Editing the postimage by just inserting an enter seems easier.

Vincent
