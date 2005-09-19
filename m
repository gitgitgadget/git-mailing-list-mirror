From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] Added -d and -e options to the "git" script.
Date: Mon, 19 Sep 2005 10:14:46 -0400
Message-ID: <432EC7D6.6080105@gmail.com>
References: <Pine.LNX.4.58.0509181114190.26803@g5.osdl.org> <u5tmzm9bbrb.fsf@lysator.liu.se>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 16:16:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHMQ1-0003gH-DQ
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 16:14:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbVISOOu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 19 Sep 2005 10:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932424AbVISOOu
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 10:14:50 -0400
Received: from xproxy.gmail.com ([66.249.82.192]:28935 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932426AbVISOOu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 10:14:50 -0400
Received: by xproxy.gmail.com with SMTP id i27so1599wxd
        for <git@vger.kernel.org>; Mon, 19 Sep 2005 07:14:49 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=HTpYw/0ltBS97uMEC7AmvEATmo7RFarpamQ5RcZWk8SNWAU2HN1fNy2iizfmZNpdmQLfapGO4jjRxgQiJYFiTCZMosryW/wc3mdONzVicS1twQlVcrxRt1q7Tdr/jhnEuAGFnofZK8nCQCHhdMkyeOeCMiHTGIbZFK4nW2a1hZo=
Received: by 10.70.132.19 with SMTP id f19mr1315956wxd;
        Mon, 19 Sep 2005 07:14:49 -0700 (PDT)
Received: from ?10.0.0.6? ( [70.89.97.97])
        by mx.gmail.com with ESMTP id h15sm487032wxd.2005.09.19.07.14.48;
        Mon, 19 Sep 2005 07:14:49 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: =?ISO-8859-1?Q?David_K=E5gedal?= <davidk@lysator.liu.se>
In-Reply-To: <u5tmzm9bbrb.fsf@lysator.liu.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8863>

David K=E5gedal wrote:
> These flags override the GIT_DIR and EDITOR environment variables.
>=20
[Patch snipped]

An option for GIT_DIR maybe since it's a Git environment variable but a=
=20
command line option to change the EDITOR _environment_ variable is NOT=20
appropriate for git.
