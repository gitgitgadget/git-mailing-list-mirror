From: Gabriel Filion <lelutin@gmail.com>
Subject: Re: RFD: git-bzr: anyone interested?
Date: Mon, 26 Apr 2010 22:53:58 -0400
Message-ID: <4BD651C6.5050501@gmail.com>
References: <4B7D8358.1080108@gmail.com>	 <fabb9a1e1002181037n58d6942dpa63a57a23f506d9c@mail.gmail.com>	 <4B7E3856.3080609@gmail.com> <20100219135549.GA31796@Knoppix>	 <4B820B4E.7050405@gmail.com> <20100222105133.GA10577@Knoppix>	 <4B834989.50502@gmail.com> <20100223124553.GA19153@Knoppix> <p2ka038bef51004261441x7e4857f1mc3f03a4104f8e018@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 27 04:54:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6aw8-0007y3-DT
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 04:54:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753949Ab0D0CyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Apr 2010 22:54:06 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:64301 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753889Ab0D0CyE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 22:54:04 -0400
Received: by qyk9 with SMTP id 9so18536495qyk.1
        for <git@vger.kernel.org>; Mon, 26 Apr 2010 19:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=EGw8oGtlz19jHdFE9+BbGfbVEnxsKKVb22Pe2P22mvk=;
        b=BCamJ5wC7hmacJfS4cZDZtJ+vNGtZ4eRBfpbUC5V4vv1t0wGpeqF5azYd1bSrV+eVJ
         74Zcv380QZnS04GzuPEm2UFulI+9a1IFLSFU/fUYGSKBwxQlLH5CwPuRqNsoLNoMkj4w
         XJIMPkCmWTXoChfWR4EE/7bZeZypQpDwfrPx0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=Sa6kHSy6FakksZmze9ZB5HgKPUlsFfQyCnyPrJn+9gm1TQdl8H+rX2JllE3dIRq1Lr
         HI/a9A8iOUjT3z4qgrPAJFNo3M4H6W2JBkzMfrgnNezv24Y4YYqwtnAQyTEBTKBULmpM
         LLref62UqviMSiBY96/VYI9ep9j/QK16fXrx4=
Received: by 10.229.192.7 with SMTP id do7mr5887032qcb.71.1272336841746;
        Mon, 26 Apr 2010 19:54:01 -0700 (PDT)
Received: from [192.168.2.204] (dsl-149-34.aei.ca [66.36.149.34])
        by mx.google.com with ESMTPS id 23sm2657767qyk.11.2010.04.26.19.54.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Apr 2010 19:54:00 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.5) Gecko/20100108 Lightning/1.0b1 Icedove/3.0
In-Reply-To: <p2ka038bef51004261441x7e4857f1mc3f03a4104f8e018@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145872>

Hello,

On 2010-04-26 17:41, Chris Packham wrote:
> How far did git-bzr or git-remote-bzr get?
> 

I unfortunately haven't had much time to fiddle with this. Having a full
time job doesn't give me much space for experiences :( And on my free
time, I've been a bit busy with one of my projects..


I've tried simply "plugging in" the bzr-fastimport plugin to do the
communication part. They already implement output similar to what
git-fastimport expects. I was stuck on the part where you have to
specify "marks" files, and about where to place them, so I left it there
for now.

I'll try and work on this pretty soon, but since I'm doing this on spare
time, any help would be welcome. Maybe the good thing to do would be to
put up a page somewhere with a mini-roadmap and the info needed/the info
that was found out?
By using bzr fast-import, the whole thing shouldn't take too long.

> I've tried git-bzr from the repo and I seem to be stumbling on bzr not
> having the fast-export command after I install the fast-import plugin
> as per [1].

> [1] http://github.com/kfish/git-bzr/blob/master/README

This script needs you to install bazaar and the bzr "fast-import"
plugin. Normally the fast-export command is implemented by it. You need
a rather up-to-date version, though.
I've found this script to work mostly for pulling in changes from bzr
into git. Pushing has proven to be from slow to non-functional.


As for the interest in this: mine is in using only one tool to do the
work right and not having to switch from using 3 vcs tools (the current
situation at work is 2 -- git and svn -- but soon bzr will come in). And
for the one tool, I'd like to choose git.
stupid reason? probably. but I've tried bzr and I don't like it.

-- 
Gabriel Filion
