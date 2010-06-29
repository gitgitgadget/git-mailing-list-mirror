From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [PATCH/RFC] Documentation/git-gc.txt: add reference to githooks
Date: Tue, 29 Jun 2010 11:16:41 -0700
Message-ID: <4C2A3889.90407@gmail.com>
References: <AANLkTikjbu_q6QToVUeNAAL0Fls9eQ5BZkzZ1-8L93zh@mail.gmail.com> <1277744834-7546-1-git-send-email-judge.packham@gmail.com> <7vfx05by9t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: spearce@spearce.org, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 29 20:19:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTfOp-0004Tl-ML
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 20:19:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754547Ab0F2STE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jun 2010 14:19:04 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:59555 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753202Ab0F2STB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jun 2010 14:19:01 -0400
Received: by pxi8 with SMTP id 8so2453519pxi.19
        for <git@vger.kernel.org>; Tue, 29 Jun 2010 11:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=JmGyWhScuxzT1RHy/AcBzHG7wgG0upRa8Gb0j+wlb+U=;
        b=TGGoqk+97DXwqpDlWuxfoauZDyb5BXpaiLYQeu//AfO8L/LRbSqQUrlMBI1J1z03n3
         qvlg/XbT1X0AWivRrjBWlXVw345KttNNrc85e0Hzk3XaxkEvfS5W/ph4fxhUkO7Lfg2b
         8RQB6qiopUbgzMxYdz7svLThEF1p/y8siyUcU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=onftqvoEUvxdgmP9Zrj/7OQRou3VOCWgUREw04lSirwwQJh/Mto9cGEiri+zpIb1Yw
         rrckyJsfHR7mAs3JeNCRJViEASiNECH/jRi/3krXRbnIra9509oRMZLGDkFiNctrn5FJ
         kuOj3Qb7bx3dOxaq63R4IOQ98ZwHekwoYDi6s=
Received: by 10.114.248.9 with SMTP id v9mr8032068wah.164.1277835539822;
        Tue, 29 Jun 2010 11:18:59 -0700 (PDT)
Received: from [10.4.9.128] (209-234-175-66.static.twtelecom.net [209.234.175.66])
        by mx.google.com with ESMTPS id n32sm60078246wag.7.2010.06.29.11.18.58
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 29 Jun 2010 11:18:58 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.1.9) Gecko/20100317 SUSE/3.0.4-1.1.1 Thunderbird/3.0.4
In-Reply-To: <7vfx05by9t.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149924>

On 29/06/10 09:26, Junio C Hamano wrote:
> Chris Packham <judge.packham@gmail.com> writes:
>   
>> +HOOKS
>> +-----
>> +This command can run `pre-auto-gc` hook.  See linkgit:githooks[5] for more
>> +information.
>>     
> Hmm.  "git gc --auto" does, but "git gc" doesn't, and saying "can run"
> only adds to the sense of incompleteness of the description here without
> giving useful information to the reader (iow, the user will have to check
> the referred-to page anyway).  We would need to either remove the first
> sentence (leaving only "See ... for information") or clarify the first
> sentence a bit better, I think.
>   
How about

The `git gc --auto` command will run the `pre-auto-gc` hook, if
enabled.  See linkgit:githooks[5] for more information.
