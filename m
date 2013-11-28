From: =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
Subject: Re: How to resume broke clone ?
Date: Thu, 28 Nov 2013 14:39:47 +0700
Message-ID: <5296F343.6050506@gmail.com>
References: <AAA12788-A242-41B8-B47D-1A0A52F33FC1@ancientrocklab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: zhifeng hu <zf@ancientrocklab.com>
X-From: git-owner@vger.kernel.org Thu Nov 28 08:39:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlwCa-0003X7-VV
	for gcvg-git-2@plane.gmane.org; Thu, 28 Nov 2013 08:39:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948Ab3K1Hjx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Nov 2013 02:39:53 -0500
Received: from mail-pb0-f45.google.com ([209.85.160.45]:58707 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813Ab3K1Hjw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Nov 2013 02:39:52 -0500
Received: by mail-pb0-f45.google.com with SMTP id rp16so12040590pbb.4
        for <git@vger.kernel.org>; Wed, 27 Nov 2013 23:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=CMeY3yjjrKsd7gHNJWeEs0tyxLL0HmjzF058hxRzyrE=;
        b=nOmI95GQUh/hqu0634hERLjkPafcLvOPCxzcdaHXqP5RDV3S2nYvCaDBRk3G2mmyPZ
         0yI4fiW2KfT1iP7oMchOMwpCANyPllniAuqcnAkqm7cU2S+HZNCbOvmonoxKAKUfKaUy
         4W15WYYFRualxw8yjtggYHIv4MvNsR+X9GOLWIsyRPv8WAcF2hPlPFFdVw33RkwPTGmW
         eufaewDnbDPL61tNSk9nwAjwVhcBtVGJDaqfxo+zVmjj9R6u8tu3JzploA07qsZT1uIR
         NYOhondLhFCzbjBmA2yjrksl7cfR5t42lEBB7FbSFPgYesH5QzY+mu2deEOLeQhu00gE
         ORyw==
X-Received: by 10.66.230.233 with SMTP id tb9mr46218107pac.38.1385624391854;
        Wed, 27 Nov 2013 23:39:51 -0800 (PST)
Received: from vnwildman.myftp.org ([113.186.93.56])
        by mx.google.com with ESMTPSA id xe9sm105382454pab.0.2013.11.27.23.39.49
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 27 Nov 2013 23:39:51 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <AAA12788-A242-41B8-B47D-1A0A52F33FC1@ancientrocklab.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238474>

On 28/11/2013 10:13, zhifeng hu wrote:
> Hello all:
> Today i want to clone the Linux Kernel git repository.
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>
> I am in china. our bandwidth is very limitation. Less than 50Kb/s.
This repo is really too big.
You may consider using --depth option if you don't want full history, o=
r
clone from somewhere have better bandwidth
$ git clone --depth=3D1
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
you may chose other mirror (github.com) for example
see git-clone(1)

--=20
Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n.
