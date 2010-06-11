From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH v2] Group the default git help message by topic
Date: Fri, 11 Jun 2010 18:00:47 -0400
Message-ID: <4C12B20F.3080709@gmail.com>
References: <AANLkTiloErvcWS1hW80cIV9SiWu_7CBdNSx_iAppcGOd@mail.gmail.com> <422F3619-25EC-4509-8EE3-78B6C765AB2A@wincent.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Scott Chacon <schacon@gmail.com>, git list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sat Jun 12 00:09:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONCPN-00059O-TY
	for gcvg-git-2@lo.gmane.org; Sat, 12 Jun 2010 00:09:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760644Ab0FKWI4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jun 2010 18:08:56 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49729 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760526Ab0FKWIz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jun 2010 18:08:55 -0400
Received: by gye5 with SMTP id 5so1136763gye.19
        for <git@vger.kernel.org>; Fri, 11 Jun 2010 15:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=uUdwH9TsSng92xtDmlOWcpJpLHXAQ6p82A17mXPudog=;
        b=oQbdKKyijQkBnWsSlcVutjb/qCB35PgePty15DemMgOYhZ2y96v06gDUxcWEG1PZ1c
         KYwLmgZjsqm1RGW+pSysgAbg0CFCkPitGtwtKUQ9TMfq6kUM6Z16euUkvejlo85EhswP
         L+HLxFsGTf9xcJDnwwaaJJ43wgPyZ4O9V4UFo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=oAJMSUAYqyeBJ/Y7+1BKaL8twlzDZSf1ZreXQ1Qx9zZTteKjt+Q7pQZpQLshjaDBY2
         MRR3MNT8n8MbcztvQykVU7f71oCiA8lZT4xa+0nQ11brAEdyxuhzBD+u5mTu1h8TMJty
         BJEUho8qHqTSe9dfdQy/w2mOzp1VABurGBH0U=
Received: by 10.151.18.17 with SMTP id v17mr4290275ybi.6.1276293649733;
        Fri, 11 Jun 2010 15:00:49 -0700 (PDT)
Received: from [10.0.0.6] (c-24-129-111-166.hsd1.fl.comcast.net [24.129.111.166])
        by mx.google.com with ESMTPS id j3sm13042756ybe.19.2010.06.11.15.00.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 11 Jun 2010 15:00:48 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <422F3619-25EC-4509-8EE3-78B6C765AB2A@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148974>

Wincent Colaiuta wrote:
> El 11/06/2010, a las 18:03, Scott Chacon escribi=F3:
>=20
>> +	puts("The most commonly used git commands are:\n");
>> +
>> +	puts("Basic Commands:");
>> +	print_command("init");
>> +	print_command("clone");
>> +	print_command("add");
>> +	print_command("status");
>> +	print_command("commit");
>> +	puts("");
>> +
>> +	puts("Branch Commands:");
>> +	print_command("branch");
>> +	print_command("checkout");
>> +	print_command("merge");
>> +	print_command("tag");
>> +	puts("");
>> +
>> +	puts("History Commands:");
>> +	print_command("log");
>> +	print_command("diff");
>> +	print_command("reset");
>> +	print_command("show");
>> +	puts("");
>> +
>> +	puts("Remote Commands:");
>> +	print_command("remote");
>> +	print_command("fetch");
>> +	print_command("pull");
>> +	print_command("push");
>=20
> Nice. I'm sure the output will be a bit less intimidating, but I am n=
ot sure about some of the grouping choices you've made here.
>=20
> "git checkout" is almost certainly a "Basic" command, even though it'=
s used for creating and switching branches.
>=20
> "git tag" doesn't really seem to be a "Branch" command, as it's for t=
agging objects (usually commits), and not branches.
>=20
> "git reset" is the odd one out in the "History" commands group. The o=
ther three commands are about _inspecting_ history, whereas "git reset"=
 is about changing the current HEAD. I actually think "git reset" fits =
better with the "Branch" commands.
>=20
> I think I'd be inclined to use more descriptive headings and group th=
e commands like this:
>=20
>   Basic operation:
>     init
>     add
>     status
>     commit
>     checkout
>=20
>   Inspecting repository state and history:
>     log
>     diff
>     show
>=20
>   Working with branches:
>     branch
>     merge
>     reset
>=20
>   Interacting with other repositories:
>     clone
>     fetch
>     pull
>     push
>     remote
>=20
> ...</end of my 2 cents>

Can a command be listed twice? Some of these commands _really_ belong i=
n=20
more than one category.
