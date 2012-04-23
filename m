From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/10] i18n: help: mark strings for translation
Date: Mon, 23 Apr 2012 11:18:22 -0700
Message-ID: <xmqqaa22jor5.fsf@junio.mtv.corp.google.com>
References: <1335184230-8870-1-git-send-email-pclouds@gmail.com>
	<1335184230-8870-5-git-send-email-pclouds@gmail.com>
	<20120423163032.GF4832@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 23 20:18:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMNqH-0002bl-94
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 20:18:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753254Ab2DWSSY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Apr 2012 14:18:24 -0400
Received: from mail-gy0-f202.google.com ([209.85.160.202]:62911 "EHLO
	mail-gy0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751638Ab2DWSSY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Apr 2012 14:18:24 -0400
Received: by ghbz15 with SMTP id z15so1361498ghb.1
        for <git@vger.kernel.org>; Mon, 23 Apr 2012 11:18:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=USFtM1xYF9fvt11nArmIiVvneUv7HJOITMVFl4JLCHc=;
        b=Tu9G5xiuQG6cE49AvwbkYeSE41/2u9blvmoZdWl1RPHLhm8jbVireVD5Z5VDLeEO8Y
         mA9Oy0EXsGITiEEjjW8k7Tchel5SaxobktG5eUSOOi936wJCiSfCoVwas4Sj+KtcjkoV
         UrcE/4OyUvOLtiZye2nFetFjzwv9vQS02NHPwtEynrIr7m2FCllc7VH94o0IqoSqDj4d
         FV2MCOtIG5/3yPDPS0FsNcrmFat7JaxW67Iuaqo9omAr5gVjzX/7O3+hJ2cqkMb4w43Y
         Gb0ITE46zIjJZBkyjocjumM5npWi9j7oyt6Vv+vb77B9+pOwdHGxQHUJgCK3jxbAyuQh
         KkHA==
Received: by 10.236.118.37 with SMTP id k25mr20794029yhh.3.1335205103580;
        Mon, 23 Apr 2012 11:18:23 -0700 (PDT)
Received: by 10.236.118.37 with SMTP id k25mr20794009yhh.3.1335205103519;
        Mon, 23 Apr 2012 11:18:23 -0700 (PDT)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id z48si15592498yhn.7.2012.04.23.11.18.23
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Mon, 23 Apr 2012 11:18:23 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id 69BC71E004D;
	Mon, 23 Apr 2012 11:18:23 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 13527E120A; Mon, 23 Apr 2012 11:18:23 -0700 (PDT)
In-Reply-To: <20120423163032.GF4832@burratino> (Jonathan Nieder's message of
	"Mon, 23 Apr 2012 11:30:32 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQnlE1ulprDKJ1lWcCGyKaro1Fi4SZFPE4Tt4gO3bLPZQlnWt4F4SeYF5kkas16NyPGCk004Qg4diFQ66j8TIe27zIgsluz22Tx5Ua1BroypPkFp0bf1JkYymuxA4smOs8PDQw5lmNuE1TryAK7u+5xQQjL5F7v8gpPgTQqRX6exssxSKuU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196154>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> --- a/help.c
>> +++ b/help.c
>> @@ -217,8 +217,9 @@ void list_commands(const char *title, struct cmd=
names *main_cmds,
>> =20
>>  	if (main_cmds->cnt) {
>>  		const char *exec_path =3D git_exec_path();
>> -		printf("available %s in '%s'\n", title, exec_path);
>> -		printf("----------------");
>> +		printf_ln(_("available %s in '%s'"), title, exec_path);
>> +		/* TRANSLATORS: this must align with "available %s in '%s'" */
>> +		printf(_("----------------"));
>>  		mput_char('-', strlen(title) + strlen(exec_path));
>
> Yuck. :)

Yuck indeed.  Do we even care these pseudo-underline?  Wouldn't a simpl=
e
and clean "blank line" look better?
