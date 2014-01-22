From: John McIntyre <joh98.mac@gmail.com>
Subject: Re: Conceptual Question for git usage ...
Date: Wed, 22 Jan 2014 15:23:32 +0000
Message-ID: <CABQ4iYjVSh_yG0jzc104LJ2hr9GhNnKrCZNw9337t+s4CiWryg@mail.gmail.com>
References: <CABQ4iYjfa1X0KkMm=VtoRt2j65E1cce7TyY_PU8WFr8DPQEtjw@mail.gmail.com>
	<CCFA1C8D-F0E3-43D9-87FD-B62807DB7EA8@kellerfarm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Andrew Keller <andrew@kellerfarm.com>
X-From: git-owner@vger.kernel.org Wed Jan 22 16:23:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5zeU-0005FZ-7l
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 16:23:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756024AbaAVPXe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Jan 2014 10:23:34 -0500
Received: from mail-wi0-f177.google.com ([209.85.212.177]:59830 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755223AbaAVPXd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jan 2014 10:23:33 -0500
Received: by mail-wi0-f177.google.com with SMTP id m19so703212wiv.16
        for <git@vger.kernel.org>; Wed, 22 Jan 2014 07:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=5yAnWtmENvnkwwcxBXkHHqFDZZgWzRucBjzSfOWTeoY=;
        b=NtzeSJulIyenjpvxgOIIrt0SaQ5bTjZM0ZWtBSEFCl3vzwN/xdMYKKRA9CJe37Zt2c
         7AFIaJ+ZpMJ7EVL+u6nlGh6J5dBbF+DNllXt6nEuCnfBGRvO0PS/n8QM8oWF2jBaulOY
         Ljo/KdOdX4NUtQR45IogOjHIX/WNVqV0GtXv1Z787jMy9OUo5n9HrENOkr3RGul7J6WS
         cWt8w4UjoJsBv2/Z1Y4E8eaZ1vUwEI4cbDQgJgqRuIS6KWul/YWn1gpN1ATKoG4T65rU
         zlCnGfUYGS/r53Wf7TeyvgSKQCGnUEsv/u8D0vccifY5QXl8qLMkLIIDQ1Fa4LssxIrB
         TIrg==
X-Received: by 10.180.97.71 with SMTP id dy7mr8803610wib.35.1390404212731;
 Wed, 22 Jan 2014 07:23:32 -0800 (PST)
Received: by 10.180.24.198 with HTTP; Wed, 22 Jan 2014 07:23:32 -0800 (PST)
In-Reply-To: <CCFA1C8D-F0E3-43D9-87FD-B62807DB7EA8@kellerfarm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240830>

Thank you for that, Andrew.

I'm going to follow your advice and just set up a test repository,
which won't be a disaster, if it gets damaged or erased.

I backup my /Users/john/Documents from my Mac to /home/john/Documents
on the Linux server.  Except for my mail directory, which comes from
$HOME/Library/Mail and lives on $HOME/.mac.mail.backup on the server.

2014/1/22 Andrew Keller <andrew@kellerfarm.com>:
> On Jan 22, 2014, at 9:20 AM, John McIntyre <joh98.mac@gmail.com> wrot=
e:
>
>> =85
>>
>> So basically, what I'd like to do is this.  I want to write code,
>> write blg posts, write essays for university, whatever.  And I want =
to
>> use git to maintain revisions, but where do I store them?  Do I make
>> the Mac my hub?  I have a git client on there.  Do I make the server
>> my 'hub'?  If I make the server the 'hub', then won't rsync back-ups
>> from the Mac to the server wipe them out?
>>
>> =85
>
> Git's degree of flexibility in what is considered "the server" is val=
uable here.  I advise that you simply try a configuration, and see how =
it works.  It's easy to change where origin points later.
>
> With that said, like you, I have a small ad-hoc setup of automated rs=
ync backups between my various computers and servers, and I have found =
some characteristics useful:
>
> * I have rsync saving backups into dedicated backup folders on the re=
mote machines.  This eliminates ambiguity of what to back up (server A =
won't blow away server B's Documents folder, for example).
>
> * Using a publicly accessible server has been useful.  I set up port =
forwarding to the machine, and set up a domain name pointing to the ser=
ver.  In general, when I have Internet access, I can access the server =
that contains my repositories.  I always use the same domain name, even=
 if I'm in the same room as the server.
>
> Hope that helps,
> Andrew
>
