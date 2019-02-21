Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C2BD1F453
	for <e@80x24.org>; Thu, 21 Feb 2019 09:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfBUJyd convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 21 Feb 2019 04:54:33 -0500
Received: from cisrsmtp.univ-lyon1.fr ([134.214.188.146]:41705 "EHLO
        cisrsmtp.univ-lyon1.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfBUJyc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 04:54:32 -0500
Received: from localhost (localhost [127.0.0.1])
        by cisrsmtp.univ-lyon1.fr (Postfix) with ESMTP id 0A0FBA0360;
        Thu, 21 Feb 2019 10:54:29 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at cisrsmtp.univ-lyon1.fr
Received: from cisrsmtp.univ-lyon1.fr ([127.0.0.1])
        by localhost (cisrsmtp.univ-lyon1.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0LOlL6iYbct4; Thu, 21 Feb 2019 10:54:28 +0100 (CET)
Received: from BPMBX2013-01.univ-lyon1.fr (bpmbx2013-01.univ-lyon1.fr [134.214.201.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by cisrsmtp.univ-lyon1.fr (Postfix) with ESMTPS id 07AAAA0369;
        Thu, 21 Feb 2019 10:54:28 +0100 (CET)
Received: from BEMBX2013-01.univ-lyon1.fr (134.214.201.247) by
 BPMBX2013-01.univ-lyon1.fr (134.214.201.243) with Microsoft SMTP Server (TLS)
 id 15.0.1263.5; Thu, 21 Feb 2019 10:54:27 +0100
Received: from BEMBX2013-01.univ-lyon1.fr ([fe80::b1ea:14ef:61b9:d4cd]) by
 BEMBX2013-01.univ-lyon1.fr ([fe80::b1ea:14ef:61b9:d4cd%15]) with mapi id
 15.00.1263.000; Thu, 21 Feb 2019 10:54:27 +0100
From:   BOMPARD CORENTIN p1603631 <corentin.bompard@etu.univ-lyon1.fr>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        BERBEZIER NATHAN p1601409 <nathan.berbezier@etu.univ-lyon1.fr>,
        CHABANNE PABLO p1602176 <pablo.chabanne@etu.univ-lyon1.fr>,
        MOY MATTHIEU <matthieu.moy@univ-lyon1.fr>
Subject: RE: [PATCH] doc: format pathnames and URLs as monospace
Thread-Topic: [PATCH] doc: format pathnames and URLs as monospace
Thread-Index: AQHUxILFjUrpXHpQoE6nRC4eaCEQ4qXfwxZYgApKc3w=
Date:   Thu, 21 Feb 2019 09:54:27 +0000
Message-ID: <1550742866944.14637@etu.univ-lyon1.fr>
References: <20190214163043.7103-1-corentin.bompard@etu.univ-lyon1.fr>,<xmqq4l9685ia.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq4l9685ia.fsf@gitster-ct.c.googlers.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [134.214.126.172]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr> writes:
>>
>> diff --git a/Documentation/config/checkout.txt b/Documentation/config/checkout.txt
>> index c4118fa19..8ba92f274 100644
>> --- a/Documentation/config/checkout.txt
>> +++ b/Documentation/config/checkout.txt
>> @@ -1,7 +1,7 @@
>>  checkout.defaultRemote::
>>  	When you run 'git checkout <something>' and only have one
>>  	remote, it may implicitly fall back on checking out and
>> -	tracking e.g. 'origin/<something>'. This stops working as soon
>> +	tracking e.g. `origin/<something>`. This stops working as soon
>
>Are you doing only pathnames and URLs, or are you also doing refnames?
>
>I am not sure if "this is a pathname, or a URL or a refname, so it
>must be typeset with monospace" is the direction we'd want to go in
>in the first place.  One rule we tried to follow (but with minor
>inconsistencies everywhere, apparently we are not doing a very good
>job at) is "this is a string the user would literally type or see
>when following this description, so it must be typeset with
>monospace".
>
>From that point of view, we'd want the `git checkout <something>` we
>see in the introductory sentence of this paragraph also typeset in
>mono.  In order to match (i.e. to make it clear that the <something>
>part came from what the user typed), the change in this hunk your
>patch makes does make sense.
>
>> diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
>> index f98b7c6ed..6643bc39f 100644
>> --- a/Documentation/git-cvsserver.txt
>> +++ b/Documentation/git-cvsserver.txt
>> @@ -140,7 +140,7 @@ CVS_SERVER directly in CVSROOT like
>>  ------
>>  cvs -d ":ext;CVS_SERVER=git cvsserver:user@server/path/repo.git" co <HEAD_name>
>>  ------
>> -This has the advantage that it will be saved in your 'CVS/Root' files and
>> +This has the advantage that it will be saved in your `CVS/Root` files and
>>  you don't need to worry about always setting the correct environment
>>  variable.  SSH users restricted to 'git-shell' don't need to override the default
>>  with CVS_SERVER (and shouldn't) as 'git-shell' understands `cvs` to mean
>
>I am using this hunk as just an example, but "this is what the user
>literally sees or types" point-of-view, `CVS/Root` and `CVS_SERVER`
>in the hunk fall into the same category.  They are both literals in
>the sense that you cannot say "I do not like the words Root or
>SERVER, so in my CVS repository I am using CVS/Leaf and CVS_HELPER
>instead".
>
>> @@ -179,7 +179,7 @@ allowing access over SSH.
>>  ------
>>  --
>>  3. If you didn't specify the CVSROOT/CVS_SERVER directly in the checkout command,
>> -   automatically saving it in your 'CVS/Root' files, then you need to set them
>> +   automatically saving it in your `CVS/Root` files, then you need to set them
>>     explicitly in your environment.  CVSROOT should be set as per normal, but the
>>     directory should point at the appropriate Git repo.  As above, for SSH clients
>>     _not_ restricted to 'git-shell', CVS_SERVER should be set to 'git-cvsserver'.
>
>Even if you are doing only pathnames and URLs, `git-shell` and
>`git-cvsserver` would be candidates to be in monospace, as they are
>names in $GIT_EXEC_PATH/.
>
>> diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
>> index 7a2375a55..bbc984235 100644
>> --- a/Documentation/technical/pack-protocol.txt
>> +++ b/Documentation/technical/pack-protocol.txt
>> @@ -107,7 +107,7 @@ Initiating the upload-pack or receive-pack processes over SSH is
>>  executing the binary on the server via SSH remote execution.
>>  It is basically equivalent to running this:
>>  
>> -   $ ssh git.example.com "git-upload-pack '/project.git'"
>> +   $ ssh git.example.com "git-upload-pack `/project.git`"
>>  
>>  For a server to support Git pushing and pulling for a given user over
>>  SSH, that user needs to be able to execute one or both of those
>
>I agree with Eric's comment.  If the user types `/project.git`, it
>would give a funny result ;-).

Hello thanks for your reply we will soon use your answer to rework our patch.
Corentin BOMPARD, Nathan BERBEZIER, Pablo CHABANNE
