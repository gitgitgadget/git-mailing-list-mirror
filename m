From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 7/7] make "git fetch" update all fetch repositories
Date: Tue, 29 Apr 2008 08:50:15 +0200
Message-ID: <4816C527.4000406@gnu.org>
References: <cover.1209391614.git.bonzini@gnu.org> <55a4068681841e6c3579f4183b469fc7aa4de266.1209391615.git.bonzini@gnu.org> <20080428181012.GB6710@steel.home> <48161544.90500@gnu.org> <20080428213339.GC10600@steel.home> <4816A989.2010204@gnu.org> <20080429053814.GA3332@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, spearce@spearce.org, gitster@pobox.com,
	peff@peff.net, johannes.schindelin@gmx.de, srb@cuci.nl
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 08:51:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqjgB-0001n0-T4
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 08:51:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754996AbYD2GuT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 02:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbYD2GuT
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 02:50:19 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:21462 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754966AbYD2GuR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 02:50:17 -0400
Received: by fg-out-1718.google.com with SMTP id l27so5108146fgb.17
        for <git@vger.kernel.org>; Mon, 28 Apr 2008 23:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=CM0D8npJlvC+s0759v9Pn87fkdTCKb/DGz5Q6tY3A2Y=;
        b=FM7g3yGRLq2Hq8HgY8OFXvdU0t9VunfhTAGPi/q9RS7WVGrdaXIzL+oFJZySYe0lREGTx1pKE3Ar8BAXXOm8QlVT8hFFfQTerxeKHGGXinTUhRMuuJDkIuTyoZaayLjVFjbIQlixMO8LKjhmeQLfJ8QWZmaimDQQs6Gv3dcIf7U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        b=M6pUzjE3Qof7q9N6JKFEl7wzlek+axKAnVJW7GF1AdOcbYSZZ1+UP+qVh2VeiCBD3ThnLsFTkEi+d8vX7taTfq4xMawMROAefQ74R+fbPFX/+GPo70UVkEzW/gbciqYDZch5RwD88TCub/AZePZluQVJCjiXC9z1olw834aXIME=
Received: by 10.86.59.18 with SMTP id h18mr8498150fga.67.1209451813860;
        Mon, 28 Apr 2008 23:50:13 -0700 (PDT)
Received: from scientist-2.local ( [195.176.178.209])
        by mx.google.com with ESMTPS id e9sm28137085muf.0.2008.04.28.23.50.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 28 Apr 2008 23:50:13 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
In-Reply-To: <20080429053814.GA3332@steel.home>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80654>

Alex Riesen wrote:
> Paolo Bonzini, Tue, Apr 29, 2008 06:52:25 +0200:
>> Alex Riesen wrote:
>>> Paolo Bonzini, Mon, Apr 28, 2008 20:19:48 +0200:
>>>>> my v4l2
>>>>> repo (which is a pretty collection of all kinds of remotes)
>>>> I can add a global boolean configuration to change the default value 
>>>> of  skipDefaultRemote.
>>>>
>>> With the default NOT so that current behaviour stays?
>> No, absolutely.  In fact if I were you I would set skipDefaultUpdate  
>> *now* on the remotes of that repo.
> 
> And all the others, who don't read this discussion, are just expected
> to adapt?

Man, that's what release notes are for.  You are expected to read those.

Paolo
