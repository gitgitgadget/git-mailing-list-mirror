From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: Call Me Gitless
Date: Thu, 21 Aug 2008 16:15:49 +0200
Message-ID: <48AD7895.5010707@gnu.org>
References: <4b6f054f0808171702q10d89dfey98afa65634d26e91@mail.gmail.com>	 <alpine.LNX.1.00.0808181512160.19665@iabervon.org>	 <7vfxp2m5w8.fsf@gitster.siamese.dyndns.org>	 <905315640808181624w58918a0ao939a3f0462f9dc9e@mail.gmail.com>	 <48AA7BE9.4040108@sneakemail.com>	 <7vk5edfn6g.fsf@gitster.siamese.dyndns.org>	 <ee521d6f0808190157s6a676a75t2ba3ef095f608431@mail.gmail.com>	 <vpqk5edid2y.fsf@bauges.imag.fr> <ee521d6f0808190309n7f0114a6q2e8113238cb2142b@mail.gmail.com> <48AAAE17.1070800@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Alexander E Genaud <alex@genaud.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?TGlzdHMgUGV0ZXIgVmFsZGVtYXI=?= =?UTF-8?B?IE3DuHJjaA==?= 
	<4ux6as402@sneakemail.com>, git@vger.kernel.org
To: pascal@obry.net
X-From: git-owner@vger.kernel.org Thu Aug 21 16:18:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWAyL-0000UA-Ot
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 16:17:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752971AbYHUOP7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 10:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752674AbYHUOP7
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 10:15:59 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:20683 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710AbYHUOP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 10:15:58 -0400
Received: by yx-out-2324.google.com with SMTP id 8so5517yxm.1
        for <git@vger.kernel.org>; Thu, 21 Aug 2008 07:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding:sender;
        bh=HWsfF2Lu3qbEKzEtw44X+hRXEeIzxS7FhdcMdv6hKR8=;
        b=AK8oRL64/Y5EQ9SV0Ek2qvTcfTxQMJN4y+snzGuV/NmjDX9PWL7WAGiDG2fPSrnGvc
         chgJOH6KMTIuU0ReUX5+wLCWJnZMsb8QMFeUFtPzJIBPnUrZZ2T+CN6QPWA1N3Sq9xF0
         5e7Lq6VrN8WcULCfpIDg8a2OC/2t+zBFQhYrc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :sender;
        b=hHn8lTkf52SBJmlcVVUzfL9qKgR9vzRX13q7yboRiegHmzex4U6kmNI2IvENBq4g04
         5eVq/w5Djgo6KJVo9Ae+lZk6o1q1PYFbHiBUoXr+ZmIeyeeB7dN4uxGV5gF0Z5J7W+FZ
         SDdrgvqHUyEFe7TOw9QJxaqAZoFWyEhgHQfBE=
Received: by 10.102.253.13 with SMTP id a13mr991226mui.74.1219328156572;
        Thu, 21 Aug 2008 07:15:56 -0700 (PDT)
Received: from scientist-2.local ( [195.176.178.209])
        by mx.google.com with ESMTPS id j9sm6541160mue.3.2008.08.21.07.15.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Aug 2008 07:15:55 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Macintosh/20080707)
In-Reply-To: <48AAAE17.1070800@obry.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93153>

Pascal Obry wrote:
> 
> For what it's worth, I have added this since I've been working with Git 
> on my aliases:
> 
> [alias]
>  staged = diff --cached
> 
> Since then I'm always running:
> 
>    $ git staged
> 
> This looks more intuitive to me and faster than typing:
> 
>    $ git diff --cached

You're probably right, but it means that basically you cannot have other 
"diff" aliases without having an exploding number of combinations.  For 
example I have

[alias]
         changes=diff --name-status -r

and I don't want to have staged-changes too. :-)

I used to think that the proposal I saw in another git frontend, which is:

	git diff --cached -->	git diff --staged
	git diff -->		git diff --unstaged
	git diff HEAD -->	git diff

was a good one, but it is actually not when you start thinking about 
what to do during a large merge with few conflicts.  In fact, even 
though I use the index almost exclusively when merging (*), I don't mind 
the few extra keystrokes.

(*) When not merging, I use "git commit -a" preceded by "git changes" 
(see above).  In all situations where I might get confused between what 
is in the index and what is not (for example when adding new files) I 
use "git citool".

Paolo
