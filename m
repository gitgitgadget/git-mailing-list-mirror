From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] commit: Append commit_list prefix in two function names.
Date: Sat, 27 Nov 2010 02:29:33 -0600
Message-ID: <20101127082933.GA24840@burratino>
References: <0b9cde68dcdfddc13a91a63f9deb3384576164de.1289768501.git.tfransosi@gmail.com>
 <20101114211905.GB10150@burratino>
 <AANLkTi=V7e-KFhKVDLjH4TvoT6U3xmFieo5uqigPhqKF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 27 09:29:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMGAI-0006eu-0X
	for gcvg-git-2@lo.gmane.org; Sat, 27 Nov 2010 09:29:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818Ab0K0I3l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Nov 2010 03:29:41 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:32875 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290Ab0K0I3k (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Nov 2010 03:29:40 -0500
Received: by gyb11 with SMTP id 11so1263555gyb.19
        for <git@vger.kernel.org>; Sat, 27 Nov 2010 00:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=NVxKGcqE/zSe6qsmzcyS4Pb+ZQZvL2o+bKEGUufU+1Y=;
        b=Dv9XJLUMi5L3v6b2Y/G6O56H22JiFZuvb9FJpPgwGcAd5CmFRjeS6OIjC1Xp3y3NL2
         JMcYRirYSyGcL5gVS0wB6JTud9M7tZzdMkyQULznfX80aZf710qc4Kq2yC8SWbSpRfXx
         eLOJOJkmwTJcfWdus+XxiwQpxGQZ8nKXD1faE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=uByHwpu4AZ7yxZHlq2/dpMjruzidIsTN89pTJiO9A5DfwoL36AFiWOWpAXCKYOoYme
         th1/9c4EMI9RURetW5gs6ly6KOqCcLDuParcIM/ICC1Fi6NY/qXqJVsRAMqUnZ+40p2F
         lUSJgBHW2OJXXNPHW2rAo+aZ6rkPCF/hOyaDU=
Received: by 10.100.172.15 with SMTP id u15mr2328957ane.51.1290846579808;
        Sat, 27 Nov 2010 00:29:39 -0800 (PST)
Received: from burratino (adsl-68-255-101-216.dsl.chcgil.ameritech.net [68.255.101.216])
        by mx.google.com with ESMTPS id i10sm3073733anh.12.2010.11.27.00.29.38
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 27 Nov 2010 00:29:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=V7e-KFhKVDLjH4TvoT6U3xmFieo5uqigPhqKF@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162304>

Thiago Farina wrote:
> On Sun, Nov 14, 2010 at 7:19 PM, Jonathan Nieder <jrnieder@gmail.com>=
 wrote:

>> This gives the oft-used insert_by_name() function a fairly long name=
:
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0commit_list_insert_by_name
>>
>> The proposed name is long enough to be unwieldly. =C2=A0It might hav=
e
>> the virtue of fitting better with some of the commit_list lib:
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0commit_list_count
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0commit_list_insert
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0free_commit_list
>>
>> Compare:
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0sort_by_date
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0pop_most_recent_commit
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0sort_in_topological_order
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0pop_commit
>>
>
> I don't understand what you are arguing here. Is about the size of
> "commit_list_insert_by_name"? I don't care about it's size,

=46or code clarity, length of function names can matter...

> I just
> want to make it consistent by adding commit_list in the functions tha=
t
> are part of the commit_list API.

=2E.. though this consideration is probably more important.

>> Perhaps this change would work better if some of the others were
>> renamed at the same time?
>
> I don't think so, this would increasing the size of the change and
> make it less readable.

Even if split up into multiple patches?  I don't think it makes much
sense to say "functions in the commit_list API all start with
commit_list_" while at the same time leaving half of the functions in
the commit_list API without that suffix.

By the way, how did this come up?  Presumably some particular code
was confusing?  If so, that information could be useful as an example
in the log message.

Regards,
Jonathan
