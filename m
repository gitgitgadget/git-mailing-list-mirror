From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: git/gitweb - feature request: Add description to the branches.
Date: Tue, 06 Sep 2005 10:33:49 -0400
Message-ID: <431DA8CD.9060009@gmail.com>
References: <87ll2aib73.fsf@gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kay Sievers <kay.sievers@vrfy.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 06 16:36:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECeWS-0005rJ-0i
	for gcvg-git@gmane.org; Tue, 06 Sep 2005 16:34:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbVIFOd7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 6 Sep 2005 10:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964869AbVIFOd7
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Sep 2005 10:33:59 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:58840 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964865AbVIFOd6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Sep 2005 10:33:58 -0400
Received: by wproxy.gmail.com with SMTP id i35so847714wra
        for <git@vger.kernel.org>; Tue, 06 Sep 2005 07:33:56 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=WjA6dxhjDfY8aRPdQYiYsAfHLGyfi4qarxH5hORfiogNZhPOq97X2F+HQG/dxA6v5BGxgXb+QepZ1PjyF1ZGZFAmcYKtpxmS/76YJaCnZKcIqAySFIvKFiB4XeSoLKXTkUtxHLkQU+LICYiKtpt1I6b5h4qtMNZ5svTOM0P900I=
Received: by 10.54.5.74 with SMTP id 74mr4423944wre;
        Tue, 06 Sep 2005 07:33:56 -0700 (PDT)
Received: from ?10.0.0.6? ( [70.89.97.97])
        by mx.gmail.com with ESMTP id 38sm8967882wrl.2005.09.06.07.33.55;
        Tue, 06 Sep 2005 07:33:56 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: =?ISO-8859-1?Q?Santi_B=E9jar?= <sbejar@gmail.com>
In-Reply-To: <87ll2aib73.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8131>

Santi B=E9jar wrote:
[...]
>=20
>         One thing I'm missing is a way to describe a branch. It can b=
e
>         done in the $GIT_DIR/description, the first line for the whol=
e
>         repository and the rest for the branches. So description file
>         for the git.git repository could be:
>=20
> [description]
> The core git plumbing
> pu: Proposed updates
> rc: Release candidate
> todo: Todo list
> [/description]
>=20
>         And it can be added to the gitweb tool.

Having somewhere to describe the intent of a branch would be a useful=20
convention. But I think the descriptions should be in separate files;=20
one for each branch and one for the repository as a whole.

That way it would be possible to have long, multi-line descriptions of=20
the repository and branches with the tools displaying just the first=20
line unless more information is requested; like gitk and gitkweb do wit=
h=20
commit messages.

An unrelated gitweb feature request: include a timestamp near the top o=
f=20
the projects page so that I don't have to try to remember when I last=20
reloaded the page. TZ=3DUTC preferred.
