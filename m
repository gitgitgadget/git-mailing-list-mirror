From: Junio C Hamano <gitster@pobox.com>
Subject: Re: A few "linked checkout" niggles
Date: Fri, 17 Jul 2015 08:19:25 -0700
Message-ID: <xmqqzj2u3j7m.fsf@gitster.dls.corp.google.com>
References: <xmqqoajdui8w.fsf@gitster.dls.corp.google.com>
	<55A8F4B1.9060304@drmicha.warpmail.net>
	<CACsJy8BZEhMJPdw4K_kihA1kTPBVsAt=zW-cemzO7V+xfDih8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 17 17:19:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZG7QC-0002HC-BR
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jul 2015 17:19:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758541AbbGQPT2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 11:19:28 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:36752 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757866AbbGQPT1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 11:19:27 -0400
Received: by pdjr16 with SMTP id r16so64082290pdj.3
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 08:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=bQG+TiKTZxLE1AO2GaIgUmspVNCU54uEVOKpHaRoaf0=;
        b=uZg6r7xH3tyUBCF9PN3QqQqzoGo+P00Ufqsn5oT5XVxLjPjH2amYpJAVvpDotEn/Ng
         Rwcdyc40S4aK+iIqkC0XY0V2ONhtqU2AbSIYbhkguPjR3VENnvOV5ALHZoPotaYaOBt2
         aZtCHZ0YXhZ5P/WBlDyCw6kWq3oqF50G/3gWcQycXEaEPZQSezGtHjtSXYVyP5lwwTvz
         +dW/vLLDTQ21b/OaHfvSoE3gIZQdHzPyjQ2F4ihPbeptE17gegh4dCCSq6jjR2ebNKYM
         PAHfeBtxM6CiHDAKB+OfpifhN/0yfHd/tBSM3L2TM21uQn1YZU+Z+xOynkpovjm08zk5
         3f8g==
X-Received: by 10.68.114.131 with SMTP id jg3mr31088199pbb.54.1437146367443;
        Fri, 17 Jul 2015 08:19:27 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:902a:e9ec:1aae:aea2])
        by smtp.gmail.com with ESMTPSA id ti10sm11616140pab.20.2015.07.17.08.19.26
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 17 Jul 2015 08:19:26 -0700 (PDT)
In-Reply-To: <CACsJy8BZEhMJPdw4K_kihA1kTPBVsAt=zW-cemzO7V+xfDih8Q@mail.gmail.com>
	(Duy Nguyen's message of "Fri, 17 Jul 2015 19:49:57 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274075>

Duy Nguyen <pclouds@gmail.com> writes:

> On Fri, Jul 17, 2015 at 7:27 PM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Two more observations:
>>
>> $ git worktree add /tmp/gitwt
>> Enter /tmp/gitwt (identifier gitwt)
>> Switched to a new branch 'gitwt'
>>
>> Now I'm in /tmp/gitwt at branch gitwt. Right? No. I'm in the original wd
>> at the original branch.
>>
>> So either we cd to the new location or quelch these messages or add a
>> message that we're actually back.
>
> s/Enter/Preparing/ ?

Hmm, do we even need that message?  I assumed it was a leftover
debugging stuff ;-)
