From: =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
Subject: Re: problems with git --git-dir on windows 7
Date: Fri, 06 Dec 2013 08:35:17 +0700
Message-ID: <52A129D5.3050109@gmail.com>
References: <EF40980AA2C4C4449E2D87B419007B7F18E0FACA@SPMWB01L.luinternal.fortis.bank> <EF40980AA2C4C4449E2D87B419007B7F18E0FACB@SPMWB01L.luinternal.fortis.bank> <CACsJy8DBYOwTOapOdLf=hTTWQB1U5U74FKSbUmqwXBAG++C=kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: SCHILZ MANFRED <manfred.schilz@bgl.lu>
X-From: git-owner@vger.kernel.org Fri Dec 06 02:35:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VokKT-0004FW-FJ
	for gcvg-git-2@plane.gmane.org; Fri, 06 Dec 2013 02:35:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624Ab3LFBfh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Dec 2013 20:35:37 -0500
Received: from mail-pb0-f54.google.com ([209.85.160.54]:48480 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150Ab3LFBfg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 20:35:36 -0500
Received: by mail-pb0-f54.google.com with SMTP id un15so75333pbc.27
        for <git@vger.kernel.org>; Thu, 05 Dec 2013 17:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=m5ZRUwInndP9azADbtV3/kUUKl879sr8TvM8MPG3uuQ=;
        b=xGmSv58x1QYuV4JaCydCUgHogUf3Dh7l6QVec1ifgKqJIGyTGx4eaPQNlvrsgfi6m1
         dMGNw/hFGCx3dgBbuCc6xzf0Y/nLE/Ld5FDEsSP/xsi5myeZYdpf4SJDil/uzxFI1b84
         DntxK3WQGGzKcJJ9MvPCUaZcEUkTtVbT1QkGyIiIEUAS4j9X2MZKvX1tPAgcY8JnIPnn
         fZksstGxITN3Oo+KixvJxebsVqA5G/7OR+sgvHMOe0vfooMM6BgBvtP0Xq7ZMmh67nTR
         RRJ7TcddM/klYFBixucLQ5qT5C8TwfhqYAv8lOfT7rs2zgIKqaV/It+ZSpY+rW9tBzfy
         JPIQ==
X-Received: by 10.66.7.68 with SMTP id h4mr888304paa.0.1386293736274;
        Thu, 05 Dec 2013 17:35:36 -0800 (PST)
Received: from vnwildman.myftp.org ([113.168.12.254])
        by mx.google.com with ESMTPSA id qv8sm25689623pbc.31.2013.12.05.17.35.34
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Dec 2013 17:35:35 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
In-Reply-To: <CACsJy8DBYOwTOapOdLf=hTTWQB1U5U74FKSbUmqwXBAG++C=kg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238922>

On 06/12/2013 08:07, Duy Nguyen wrote:
> On Wed, Dec 4, 2013 at 11:11 PM, SCHILZ MANFRED <manfred.schilz@bgl.l=
u> wrote:
>> Hello,
>> We are using git on windows7(git-version 1.8.1; see below) and we ge=
t the following problem in using the command 'git --git-dir=3D'
>>
>>
>> C:\UserTemp\git\appli3>git  --git-dir=3DC:\UserTemp\git\appli3 tag
>> fatal: Not a git repository: 'C:\UserTemp\git\appli3'
>>
>>
>> but the repository is well defined,as we can run the following comma=
nd:
>>
>> C:\UserTemp\git\appli3>git log -1 --oneline
>> 37cdbe0 Merge branch 'master' of L:/_ApplicationData/FBLU_IT-FLIT/se=
-DevelopSupp
> I have no clue. The --git-dir calls
> is_git_directory("C:\\UserTemp\\git\\appli3") while the "git log"
> calls is_git_directory("."). The former fails and the latter suceeds.=
=2E
> Copying msysgit@ maybe they know something. Btw what if you try
>
> git --git-dir=3D. tag
in linux:
$ git --git-dir=3D. tag
fatal: Not a git repository: '.'

>
> ?
You have to specify git dir instead of the dir contain .git
This option use when your are not in git repo or git dir isn't .git as
by default
$ git --git-dir=3D.git tag
$ git --git-dir=3D/mnt/E/MyProjects/git/.git tag
$ git --version
git version 1.8.5-rc1

>
>> When running the equivalent command on Linux, we don't have any prob=
lems:
>> On Linux:
>>> git --git-dir=3D"/tmp/GITPOC/appli3" tag
>> V1.0
>> V1.1
>> V2.0
>> V3.0
>>
>> Could you help me please ?
>>
>> Best regards
>>
>> Manfred Schilz
>>
>> --------------------------------------------------------------------=
-------------------
>> C:\UserTemp\git\appli3>git --version
>> git version 1.8.1.msysgit.1
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> Internet communications are not secure and therefore BGL BNP Paribas=
 does not accept legal responsibility for the contents of this message.=
 The information contained in this e-mail is confidential and may be le=
gally privileged. It is intended solely for the addressee. If you are n=
ot the intended recipient, any disclosure, copying, distribution or any=
 action taken or omitted to be taken in reliance on it, is prohibited a=
nd may be unlawful. Nothing in the message is capable or intended to cr=
eate any legally binding obligations on either party and it is not inte=
nded to provide legal advice.
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>


--=20
Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n.
