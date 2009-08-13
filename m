From: Ori Avtalion <ori@avtalion.name>
Subject: Re: [PATCH] Change mentions of "git programs" to "git commands"
Date: Thu, 13 Aug 2009 15:02:28 +0300
Message-ID: <4A8400D4.9010600@avtalion.name>
References: <4a7c3971.170d660a.3caa.20b3@mx.google.com>	<20090811125813.6117@nanako3.lavabit.com>	<4A815AAC.2030601@avtalion.name> <20090812075946.6117@nanako3.lavabit.com> <4A81FECE.5040806@avtalion.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 14:03:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbZ1Q-0005Dj-5w
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 14:03:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754181AbZHMMCe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 08:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754121AbZHMMCe
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 08:02:34 -0400
Received: from mail-fx0-f228.google.com ([209.85.220.228]:60395 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753967AbZHMMCd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 08:02:33 -0400
Received: by fxm28 with SMTP id 28so539845fxm.17
        for <git@vger.kernel.org>; Thu, 13 Aug 2009 05:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=at2eP3XZPOXY5Pu/vKvfoaTZ30koDvrBaaaurQgZ7i8=;
        b=wtmI4IzbWGQqEy3EUUJQo+3eJ/JvdN+2WYAH9Woeycz6syIVhMry5PkagwAQ14QJYK
         /z9S+RdHphEXRUJyqbhYevpUGb+ABFnBJJmvUxhQpS4HMYntJeY1I2e0dgZlP1Ct7Vo7
         CyiGNOCv6+hzR/6o5asvrBYT8RW+PAyubJwuw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=e6m/wObjI+Tb6eC9Y01sO1BltQnbhx1KoqpUT3QHXK+1dpqEiHDZCLvLLYmdqcJpTS
         RzcVex2PDx5GoK3ytfVylTv4MrCNj6otalDPGFAeAyAZ2KbUDEU8i2mN9r7lsnumdmd7
         GqZ2RexsVSywML5OdRUx6QdSDgaRvUrlLWXTY=
Received: by 10.103.125.38 with SMTP id c38mr338044mun.119.1250164953728;
        Thu, 13 Aug 2009 05:02:33 -0700 (PDT)
Received: from ?192.168.1.55? (bzq-79-179-35-131.red.bezeqint.net [79.179.35.131])
        by mx.google.com with ESMTPS id 23sm1058480mun.43.2009.08.13.05.02.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 13 Aug 2009 05:02:31 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.1.3pre) Gecko/20090811 Shredder/3.0b4pre
In-Reply-To: <4A81FECE.5040806@avtalion.name>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125807>

On 08/12/2009 02:29 AM, Ori Avtalion wrote:
>>> -git-mailsplit - Simple UNIX mbox splitter program
>>> +git-mailsplit - Simple UNIX mbox splitter
>>>
>>> SYNOPSIS
>>> --------
>>
>
> It's another case where a command is called a "program" when, to the
> user, it's simply a command such as "git mailsplit". Having the word
> "command" in a command description is redundant, so I just dropped the
> word.
>
> And here's another command with a similar description that I missed before:
> "git-merge-one-file - The standard helper *program* to use with
> git-merge-index"

Should I create a new patch for these two? Or is the change not welcome?
