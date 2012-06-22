From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: [RFE] option for find branches in a remote repo which contain
 a certain commit
Date: Fri, 22 Jun 2012 13:52:10 -0500
Message-ID: <4FE4BEDA.20608@gmail.com>
References: <CAKkAvazNqZWk=QRmSFsFL33M6z+nZZ_yyxxbxwAh=fQk5DVt-Q@mail.gmail.com> <CAKkAvazRfb0kTphLKoRQxSEBZwHfVZeaM0xEbcxEw7Mt5RMg8A@mail.gmail.com> <CACBZZX6nbWCFWWy5NTMSAPOf4RHUAbC9TuffPPy=2Ehn7KSnaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: ryenus <ryenus@gmail.com>, git@vger.kernel.org
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 22 20:52:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Si8xt-0005JH-4Z
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jun 2012 20:52:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758432Ab2FVSwN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Jun 2012 14:52:13 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:64634 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756128Ab2FVSwM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2012 14:52:12 -0400
Received: by obbuo13 with SMTP id uo13so2309154obb.19
        for <git@vger.kernel.org>; Fri, 22 Jun 2012 11:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=h6spyDyy83xb203PEBIZnrGWbVAvwxEJeWB4bCy/9Ps=;
        b=f8iIq4Ti5Qb9lpC1+O84D375GetMO0mMJ+bGu8qvhnJNdMPbxLyxOKkeeTz2TPiNkt
         eJRJsSYoTgayjQjcDzF98XB9zLib3TPvym/Y4Oy4NiH+cILsa6NUeA+9EATCTybXgGJM
         DPCeYiGhflBEQu3f72vFXY0o0McJG+G0jhEDLVht4xZqaq8umvwy3kI6itQxDmlyKpml
         0Tv8Nr8i8Oi6WpKGZMRQEdgEb/KwMgSYChE4fpkQKkSUMSXImYIzKMNMSaaNs+9uWNQN
         /QJBUqe5sGqYpqZdgr3yw9GnDABWzChFHeyczFUo6HFbmA3yRT6UoiT3os1IrC8GNehA
         hyMw==
Received: by 10.182.167.39 with SMTP id zl7mr3045496obb.10.1340391131930;
        Fri, 22 Jun 2012 11:52:11 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id th10sm684121obb.15.2012.06.22.11.52.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 22 Jun 2012 11:52:11 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <CACBZZX6nbWCFWWy5NTMSAPOf4RHUAbC9TuffPPy=2Ehn7KSnaA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200458>

On 6/22/2012 10:24 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Fri, Jun 22, 2012 at 4:58 PM, ryenus <ryenus@gmail.com> wrote:
>> Given a certain commit, I want there's a command/option for git to
>> make it search the remote repo (e.g. origin) and tell me the
>> branches there which contain that commit.
>
> git branch --contains <commit>
> git branch -a --contains <commit>
> git tag --contains <commit>
>

 >> ...The reason I need this is that there are hundreds of...
 >> branches, but I just need a few of them, and don't want to fetch al=
l
 >> other branches...

You could have a 'query repo' that is a local clone of the remote repo.
  Fetch all branches to the local query repo and then use AEvar's
suggested commands.  Once you find the branches you want then you can=20
git remote add -t them.

v/r,
neal
