From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Tree with leading '0' modes in 1.7.0.3
Date: Sat, 27 Mar 2010 15:57:37 -0400
Message-ID: <4BAE6331.9020000@gmail.com>
References: <32541b131003261656h430d77a8q753c6141297e8f86@mail.gmail.com> <4BAD4A82.5070703@gmail.com> <20100327012211.GD10910@spearce.org> <alpine.LFD.2.00.1003262125120.694@xanadu.home> <20100327013443.GE10910@spearce.org> <alpine.LFD.2.00.1003262142121.694@xanadu.home> <d411cc4a1003270544l43f2f93dq5006efb737aa7bbc@mail.gmail.com> <alpine.LFD.2.00.1003270959110.694@xanadu.home> <20100327191405.GF10910@spearce.org> <4BAE5CB9.6020905@gmail.com> <20100327193222.GI10910@spearce.org> <4BAE5EEC.5090804@gmail.com> <4BAE601D.6010205@gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@fluxnic.net>,
	Scott Chacon <schacon@gmail.com>,
	"Mike.lifeguard" <mike.lifeguard@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: gitzilla@gmail.com
X-From: git-owner@vger.kernel.org Sat Mar 27 20:57:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nvc8r-00024R-8u
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 20:57:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753898Ab0C0T5m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Mar 2010 15:57:42 -0400
Received: from mail-yx0-f191.google.com ([209.85.210.191]:60779 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753864Ab0C0T5l (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Mar 2010 15:57:41 -0400
Received: by yxe29 with SMTP id 29so1324988yxe.4
        for <git@vger.kernel.org>; Sat, 27 Mar 2010 12:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=KUZKYRqNJHYfWzukSyKFPPG3ST5EuSkJHmjHYKL6yZ0=;
        b=CLrnlbthBv8jtxnCAZbpemMvsSmrAdL5Y9c7ABAs2PtSzfdVTYFIid7DQ4VSl2qsS5
         8s+73IsEDZjXsADMfa7kjayRseCW8h6ei5Z2QcA4n1XFBPVZHAdZg0of4BcFzvn3Rol7
         w/pSBtfjk3DMe/36+14iNRZsHdRiFpIrrQV14=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=pVGPVhLTBr/8dYTX1x+3Lh/5TGEXG4ZMD6RDHjc1cuZaDU37FrIUV6jf28SLPg5LqJ
         g2vJjezzFjmcTAIQlZpXCLar5WBLI5TjUIX0izi+i9tHvfg1Ed3UkwNNMzMtAvE2LfKu
         0Ie/uQH0iZVegkAMpI7VBtHeHn6/ThhZnIX+Y=
Received: by 10.151.88.2 with SMTP id q2mr3021734ybl.75.1269719861190;
        Sat, 27 Mar 2010 12:57:41 -0700 (PDT)
Received: from [10.0.0.6] (c-71-199-240-201.hsd1.fl.comcast.net [71.199.240.201])
        by mx.google.com with ESMTPS id co35sm2002321ibb.8.2010.03.27.12.57.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Mar 2010 12:57:40 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <4BAE601D.6010205@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143352>

A Large Angry SCM wrote:
> A Large Angry SCM wrote:
>> Shawn O. Pearce wrote:
>>> A Large Angry SCM <gitzilla@gmail.com> wrote:
>>>> Shawn O. Pearce wrote:
>>>>> IMHO, this leading '0' thing is a similar breakage.  We shouldn't
>>>>> relax CGit or JGit to accept it just because the Ruby implementation
>>>>> of Git got the tree encoding wrong.  If anything, we should teach
>>>>> these implementations to catch these sorts of problems earlier.
>>>> Just add an additional data point, it looks like up to 16 of these 
>>>> trees  with zero-padded file modes are reachable from Linus' kernel 
>>>> master ref.
>>>
>>> Frell.
>>>
>>> We can't ask Linus to rewrite his history to repair this breakage.
>>> The fact that its made it into the kernel history means we have
>>> to accept this.  The kernel project is simply too large and move
>>> too fast for us to ask them to fix their repository history.
>>> Smaller projects of 1-2 people, we could have gotten away with
>>> asking them to fix their history.
>>>
>>> I guess that answers the questions then.  CGit permits this with
>>> a warning, and must always continue to do that.  And JGit needs to
>>> fix itself to do the same.
>>>
>>
>> Wait a minute, something strange is going on here.
>>
>> My combined kernel repository has 16 of these things according to 
>> git-fsck. And when I do 'git-fsck torvalds/linux-2.6/master' I get the 
>> same 16 BUT when I 'git-rev-list --objects torvalds/linux-2.6/master' 
>> they do not appear in the output.
>>
> 
> Ignore my noise until some more checking is done!
> 
> My combined repository also includes Scott's progit book and examples 
> repositories. I'm guessing that git-fsck did not limit itself to just 
> the object reachable from the torvalds/linux-2.6/master ref.
> 

The 16 offending trees are all git-rev-list reachable from Scott's 
progit book master ref and _NOT_ from Linus' Linux master ref.

Sorry about the confusion!!!
