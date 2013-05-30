From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [git-users] Highlevel (but simple to implement) commands provided
 by default for git
Date: Wed, 29 May 2013 22:08:46 -0500
Message-ID: <CAMP44s3807Dk0SOZcBbaOKTLj5k36bW0SA9F5ZBY2MwS1Nnxiw@mail.gmail.com>
References: <f611150e-a12a-47f6-97f0-8aaff3045338@googlegroups.com>
	<CAJri6_tm=tk6L1DT=A_BB25jm7b+2Uniw1uSCGtrY5_8X=t_hw@mail.gmail.com>
	<CAMP44s0Cx-FCZLOFZxcpC86sY+H03HKBi0nKFMgit=B5XCy71g@mail.gmail.com>
	<CALkWK0mBOB1RM+MXH+Nvos29M5vqc2yAtC__zPyowf7imfnz9Q@mail.gmail.com>
	<CAJri6_uScqjovt5eK9f9+Z4ehtsdYQNuiEX1MERiDBEJWueAXg@mail.gmail.com>
	<CALkWK0=5BwterP7ATM1GgFvLUs391w_MW4YrwbnvsbM6Q4_Opg@mail.gmail.com>
	<20130529234335.GE28153@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	=?UTF-8?Q?Br=C3=A1ulio_Bhavamitra?= <brauliobo@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 30 05:08:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhtES-0000Bg-LW
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 05:08:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967365Ab3E3DIt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 May 2013 23:08:49 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:51971 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965989Ab3E3DIr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 May 2013 23:08:47 -0400
Received: by mail-la0-f42.google.com with SMTP id fg20so9432466lab.29
        for <git@vger.kernel.org>; Wed, 29 May 2013 20:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=mdojZkooKMz4iL0kVBVkyFv5BFS20MAVKlC6LLsX6Wg=;
        b=doyyI9P3AoedW5GUbVdYgGtFtvOZzUAg6Hpi7/hqIgn8Ro7DPStAho4Gyix1lbFybO
         0XeOOGEIGCEQnqTAKhExx9r0ipOcagcuh0mr1PV6hMtVTc4SEyDpwYwxacwTOJB6r/QN
         qBTUHcq6H9BofeDkHAB8ojthUdhUsKNR9GhCw7PdvXSJircAktdSF9wByOUioEyq6XGE
         TN0e2l8UKeUKfU+hLMhnpmvBcN9bK/bQ3vOGjzci2aDUcOgD5HOy6NvGgamrx3zHTHnD
         TTZ8Uc2CVpdGYTc2oGjhW/Zm84puZcXH9n3r6gBpUGIpeMLRetv/ZLfcl96GgHtY6DsI
         jozg==
X-Received: by 10.152.27.132 with SMTP id t4mr2509220lag.46.1369883326236;
 Wed, 29 May 2013 20:08:46 -0700 (PDT)
Received: by 10.114.177.164 with HTTP; Wed, 29 May 2013 20:08:46 -0700 (PDT)
In-Reply-To: <20130529234335.GE28153@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225917>

On Wed, May 29, 2013 at 6:43 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Ramkumar Ramachandra wrote:
>> Br=C3=A1ulio Bhavamitra wrote:
>
>>> Agree, these aliased should work as a fallback or as an automatic s=
hort
>>> version
>>
>> Making builtins override'able is also a terrible idea.  It opens doo=
rs
>> to potential bugs we don't want to deal with.  Simple example:
>>
>>    am =3D log -1
>>    log =3D am -3
>
> That's detectable and could be made to error out, so it's not too bad=
=2E
>
> A bigger problem (in my opinion) with allowing arbitrary changes to
> the meaning of existing commands is that scripts, whether placed in
> .sh files or given as commands to run over IRC, stop working
> altogether.  It's nice to have commands like "git log" and "git am"
> mean the same thing no matter what machine I am on.

Except that's not true:

% git config --global format.pretty oneline

Either way, this is a red herring, I don't see anybody pushing for
overriding builtins.

--=20
=46elipe Contreras
