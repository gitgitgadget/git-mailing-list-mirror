From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Tree with leading '0' modes in 1.7.0.3
Date: Sat, 27 Mar 2010 15:44:29 -0400
Message-ID: <4BAE601D.6010205@gmail.com>
References: <32541b131003261656h430d77a8q753c6141297e8f86@mail.gmail.com> <4BAD4A82.5070703@gmail.com> <20100327012211.GD10910@spearce.org> <alpine.LFD.2.00.1003262125120.694@xanadu.home> <20100327013443.GE10910@spearce.org> <alpine.LFD.2.00.1003262142121.694@xanadu.home> <d411cc4a1003270544l43f2f93dq5006efb737aa7bbc@mail.gmail.com> <alpine.LFD.2.00.1003270959110.694@xanadu.home> <20100327191405.GF10910@spearce.org> <4BAE5CB9.6020905@gmail.com> <20100327193222.GI10910@spearce.org> <4BAE5EEC.5090804@gmail.com>
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
X-From: git-owner@vger.kernel.org Sat Mar 27 20:44:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nvbvy-0004NH-NG
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 20:44:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753889Ab0C0Toe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Mar 2010 15:44:34 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:55418 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753864Ab0C0Tod (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Mar 2010 15:44:33 -0400
Received: by gwaa18 with SMTP id a18so3278750gwa.19
        for <git@vger.kernel.org>; Sat, 27 Mar 2010 12:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=3O65QZpx2mLGKZ0Cljth42xA0frZhJrjriv/MKYSV6U=;
        b=AhJl4aD4JFOpLe4Lq2GHlvD73MadAi4hxFgcr2bZTCA/yPzTlozempPAPYINwB6Eha
         QtLcDTdyM0ooD252vuGa7kuLK/yixLvwIftVA7NFayiEr7mwUmmuBRqRKsBnP4dZBGP0
         bZDvdgI3UZYS4Xs7+mxo2BeRjZ0eOkvAM06oQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=SgcwKol5rIzo5g/VRCgaGF1Rl7d5LKA0IhA/uMT1/PXK9C9sOlTlY7S77TgbPZMBGd
         qKFICS1u3YmCIVyJ109xYjPVF3U5lVvfiHfvNcM+5LjPA6VVyxosW1MzuFOTh46c25us
         Er98SsSzZRHUePSe/opvbT1rvmjxVXHhQkxTQ=
Received: by 10.151.125.13 with SMTP id c13mr3093145ybn.279.1269719072443;
        Sat, 27 Mar 2010 12:44:32 -0700 (PDT)
Received: from [10.0.0.6] (c-71-199-240-201.hsd1.fl.comcast.net [71.199.240.201])
        by mx.google.com with ESMTPS id j42sm1986211ibr.13.2010.03.27.12.44.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Mar 2010 12:44:31 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <4BAE5EEC.5090804@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143351>

A Large Angry SCM wrote:
> Shawn O. Pearce wrote:
>> A Large Angry SCM <gitzilla@gmail.com> wrote:
>>> Shawn O. Pearce wrote:
>>>> IMHO, this leading '0' thing is a similar breakage.  We shouldn't
>>>> relax CGit or JGit to accept it just because the Ruby implementation
>>>> of Git got the tree encoding wrong.  If anything, we should teach
>>>> these implementations to catch these sorts of problems earlier.
>>> Just add an additional data point, it looks like up to 16 of these 
>>> trees  with zero-padded file modes are reachable from Linus' kernel 
>>> master ref.
>>
>> Frell.
>>
>> We can't ask Linus to rewrite his history to repair this breakage.
>> The fact that its made it into the kernel history means we have
>> to accept this.  The kernel project is simply too large and move
>> too fast for us to ask them to fix their repository history.
>> Smaller projects of 1-2 people, we could have gotten away with
>> asking them to fix their history.
>>
>> I guess that answers the questions then.  CGit permits this with
>> a warning, and must always continue to do that.  And JGit needs to
>> fix itself to do the same.
>>
> 
> Wait a minute, something strange is going on here.
> 
> My combined kernel repository has 16 of these things according to 
> git-fsck. And when I do 'git-fsck torvalds/linux-2.6/master' I get the 
> same 16 BUT when I 'git-rev-list --objects torvalds/linux-2.6/master' 
> they do not appear in the output.
> 

Ignore my noise until some more checking is done!

My combined repository also includes Scott's progit book and examples 
repositories. I'm guessing that git-fsck did not limit itself to just 
the object reachable from the torvalds/linux-2.6/master ref.
