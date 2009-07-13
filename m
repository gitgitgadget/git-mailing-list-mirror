From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: default aliases (ci, di, st, co)
Date: Mon, 13 Jul 2009 11:15:12 +0200
Message-ID: <4A5AFB20.6010403@gnu.org>
References: <85b5c3130907081649s37f726f7id1a64f2fdbe609f@mail.gmail.com> <m3my7evhky.fsf@localhost.localdomain> <7vskh53iyt.fsf@alter.siamese.dyndns.org> <4A56786B.7040904@gnu.org> <20090713064027.GA10300@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Ondrej Certik <ondrej@certik.cz>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 13 11:15:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQHdb-0008GZ-5z
	for gcvg-git-2@gmane.org; Mon, 13 Jul 2009 11:15:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755147AbZGMJPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jul 2009 05:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754899AbZGMJPU
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jul 2009 05:15:20 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:58679 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755130AbZGMJPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jul 2009 05:15:16 -0400
Received: by fxm18 with SMTP id 18so2049659fxm.37
        for <git@vger.kernel.org>; Mon, 13 Jul 2009 02:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:newsgroups:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=lDXDX+f0lcDtS9YE1ufxJp4IS0TP0MA8Oscu0h/gWEY=;
        b=OVAxi+L/YjLtB8qVFJLO9+EDsxUMt+SB1bgaWOCgeVU02RrdXCcyzRLiCKM4S7tp/i
         WwOfGomn3VAQTmuqP+ATOLCXoW6Ta1h8UORwjythJW0CL3KIM3rrby0cLqIQCkJGtKab
         Fbx5NBxS13bx2kCEcW4rk5V5DG4rBuqu3/H/k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:newsgroups:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=TlOKZYo32wd2SqohRJIwD9P6U2QTKMhcz6EsbrEJE1lqC7NVcg8F2/h1qByKBHZq6T
         3fNBYgpaa/+P4aUzTcI7lK4grN/MDMYrlm6tWVyE2Q1x9Xq/VMcRPvhYcpLHiTt9W4R5
         p+g2ryhcUOuK7BDEQRQqCINSKBdSBAgHdiD30=
Received: by 10.204.100.70 with SMTP id x6mr4958126bkn.140.1247476514718;
        Mon, 13 Jul 2009 02:15:14 -0700 (PDT)
Received: from yakj.usersys.redhat.com ([85.93.118.17])
        by mx.google.com with ESMTPS id 12sm6772164fks.51.2009.07.13.02.15.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 13 Jul 2009 02:15:13 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090513 Fedora/3.0-2.3.beta2.fc11 Lightning/1.0pre Thunderbird/3.0b2
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <20090713064027.GA10300@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123179>

On 07/13/2009 08:40 AM, Jeff King wrote:
> On Fri, Jul 10, 2009 at 01:08:27AM +0200, Paolo Bonzini wrote:
>
>> Yes, it's in the wiki and in my .gitconfig:
>>
>>          whatis = "!sh -c 'git show -s --pretty=\"format:%h (%s, %ai\"
>> \"$@\" | sed -e \"s/ [012][0-9]:[0-5][0-9]:[0-5][0-9]
>> [-+][0-9][0-9][0-9][0-9]$/)\\n/\"' -"
>
> Is there a reason not to simply use:
>
>    whatis = "show -s --pretty='format:%h (%s, %ad)' --date=short"
>
> these days?

With s/format/tformat, which I just learnt about, no, there is no reason.

Thanks!

Paolo
