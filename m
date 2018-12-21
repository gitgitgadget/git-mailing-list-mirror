Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A0CD1F405
	for <e@80x24.org>; Fri, 21 Dec 2018 00:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390341AbeLUAPw (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 19:15:52 -0500
Received: from out1102.nz.smxemail.com ([203.84.134.33]:17897 "EHLO
        out1102.nz.smxemail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733019AbeLUAPv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 19:15:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; d=nz.smxemail.com; s=alpha; c=relaxed/relaxed;
        q=dns/txt; i=@nz.smxemail.com; t=1545351348;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC;
        bh=4ndZgZv4R8nljHicmakUpGTU5mihvtJbTRstsagTX0M=;
        b=D6tixpDsIXlO9SWdP5Su6OBFcGpE9EgjuVQEdwzuyUI3yXX0UZuwOYqcF0jS5iGb
        KvwR9nn8e1cmr31EfFdTU5cJlNH5nUu2yzY5BJaLxvC85h0ZsYZ0yor1b71A9HD/
        onr5DP91YEzUYSEVAdkwM1hHE1r8AKRATz2zS67fEUI=;
Received: from AUS01-ME1-obe.outbound.protection.outlook.com ([104.47.116.58])
        by shared.nz.smxemail.com with ESMTP (using TLSv1.2
        with cipher AES256-SHA256 (256/256 bits))
        id 5C1C30B3-A5B116C6@mta1105.omr;
        Fri, 21 Dec 2018 00:15:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=terabytenz.onmicrosoft.com; s=selector1-terabyte-co-nz;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ndZgZv4R8nljHicmakUpGTU5mihvtJbTRstsagTX0M=;
 b=qq9bqn/iU5GH8Q2WjYllZ1EQXAnPkFf/YpaPDC9sO3NILd8IvomJGylRmMWQ70mLIgRR0mZAK3Bq0h4msNow6GrMeogkKlALsJLgOa3Y5z/sjvFg/Q5fgBvYtVg4/WpoUMWZ3OApZ5grn0gVIYejNl4U3g9FsQrI7YvqY+Gad1Y=
Received: from ME1PR01MB1121.ausprd01.prod.outlook.com (10.171.4.7) by
 ME1PR01MB0962.ausprd01.prod.outlook.com (10.169.166.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Fri, 21 Dec 2018 00:15:43 +0000
Received: from ME1PR01MB1121.ausprd01.prod.outlook.com
 ([fe80::8c52:3018:4fad:2580]) by ME1PR01MB1121.ausprd01.prod.outlook.com
 ([fe80::8c52:3018:4fad:2580%2]) with mapi id 15.20.1446.022; Fri, 21 Dec 2018
 00:15:43 +0000
From:   Andrew Shearer <andrew@terabyte.co.nz>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Eric Wong <e@80x24.org>
Subject: RE: error: Use of uninitialized value $hash in chomp
Thread-Topic: error: Use of uninitialized value $hash in chomp
Thread-Index: AdSXRIAwQLCkx8aZREeNeTGRosl9oQAiJbGAAD066gA=
Date:   Fri, 21 Dec 2018 00:15:43 +0000
Message-ID: <ME1PR01MB11218D4953017CFE06A2B16AE1B80@ME1PR01MB1121.ausprd01.prod.outlook.com>
References: <ME1PR01MB11218735004432E3E26C66FFE1BE0@ME1PR01MB1121.ausprd01.prod.outlook.com>
 <874lb9fika.fsf@evledraar.gmail.com>
In-Reply-To: <874lb9fika.fsf@evledraar.gmail.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrew@terabyte.co.nz; 
x-originating-ip: [115.188.212.65]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;ME1PR01MB0962;6:nzGSR4OteYtxdleohFLkvc3TbqXF5LTaO4pR8USfngMKTvlhETqPl0uEDwFTQYsjSLhXnzPHsXZv1l+EOjZ1u1cUJL9B4s1RpS/XzZeeLV3/0Hsk0Gd9YVYF3sqKqcFn/MQPy/yKVgMcljEuGDRQ5Bg03gFvO1xdisdPxD/4zFrBCHp1rX1U8OlTGw7F7UrAL2c2O0edWHuU+EMzgDKPSqdUwoB0/kULnHqY/vlFcQlGDdPL7mJT5Z84FUXdmSGtpHaUPdLKA+JQM6qJgAZ/ru6J2EeS/+6hrV+l25SpUcg+TGUyCNTBVG0r7YyDwoH1UEZ7ZoD23F9EaXjORxwb2tIaodWcSksyYQA90BmFpJxezUQQkoCZMZG8MAQyoRhoUytENsVCme7qGFJR/+TgS3VPJKaJZPEOwXa2brRtXCFI6xputsa8gEhC0qUxPI7viy5vxb7Z1lfhKoQYNtnZWg==;5:2id24uDlLq/mlui2ZbyICPnAC1BTQg31ncLsql95BG7XyCLhoY5T4YNRFxMRJmsHgStCZ8IzXugyaXMwOsDJpRv6lopX5DJx9dQDODWklmKZxte4gE4O5D+EZMwYoPu4E06g4PLf5dMB96Lax0kJ3uy5uuztIuXUF2bpK3m0aLQ=;7:9/VKXHkjACEocACpE/q1EM7sAbfsxh821DKPy+2AzyL8bqFQBwDzbExTg0jGW4mWlvIf2hyEc/pAITXjJe7w1aFKF6P21xLecr36VdXS1jReDGyO3jgMR8vmXGfsiWzLn5M6rRyzVndYbXkBTXFvqQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b59b09e2-066a-4d42-a6ed-08d666d972bf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(7168020)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:ME1PR01MB0962;
x-ms-traffictypediagnostic: ME1PR01MB0962:
x-microsoft-antispam-prvs: <ME1PR01MB0962F313742EA823761EF582E1B80@ME1PR01MB0962.ausprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(3231475)(944501520)(52105112)(10201501046)(93006095)(93001095)(3002001)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:ME1PR01MB0962;BCL:0;PCL:0;RULEID:;SRVR:ME1PR01MB0962;
x-forefront-prvs: 0893636978
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(39830400003)(136003)(346002)(13464003)(199004)(189003)(11346002)(476003)(4326008)(6436002)(446003)(14454004)(6916009)(25786009)(1411001)(229853002)(105586002)(71190400001)(53936002)(71200400001)(97736004)(6246003)(106356001)(39060400002)(66574012)(7736002)(186003)(26005)(256004)(14444005)(305945005)(7696005)(3846002)(86362001)(6116002)(74316002)(486006)(316002)(53546011)(55236004)(55016002)(5660300001)(9686003)(99286004)(54906003)(102836004)(33656002)(6506007)(76176011)(74482002)(19627235002)(66066001)(2906002)(508600001)(68736007)(81156014)(8676002)(81166006)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:ME1PR01MB0962;H:ME1PR01MB1121.ausprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: terabyte.co.nz does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: LXqdEa1EGMz38waTiCYNp1/Q8T1tsBJDNA95JzCo3quYzTHYqyW8aUifAjLF1XoOCxaoEGzy65LQ2/VPRGux1aVnnrrDQt5Y7LnTx6CmsgKAerquD7Y6YQt35mhxK9cW4FDJA9JQCR8CdkDh/ajXK0ysC2JJGF4FGKQ/CQ3sSZgfg+1nXCF8so8jXCG7A3prxghgn4/x8VvJA0EcCqR+zh05utj0RES6tozDswO/96NkkVfJyZDNZ+iMPKZZscQlnDgJsi/4a5bBocOAdsNO9gc6CvkWaDxpUBlGMdd8cXUbwnjQ5Tz/8ymtKjpuaahX
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: terabyte.co.nz
X-MS-Exchange-CrossTenant-Network-Message-Id: b59b09e2-066a-4d42-a6ed-08d666d972bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2018 00:15:43.7351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ea17f86c-29aa-405c-bbb3-b55968f53184
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME1PR01MB0962
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi=20
Thanks for reply, but sorry I don't know how to do that - I don't have the =
git source code or know how to debug it.
Is there another way I can capture logging/debugging information while runn=
ing "git svn clone" and send it to you?
Thanks

Andrew Shearer / Web Developer
DDI 021 469 888 / andrew@terabyte.co.nz

/TERABYTE

-----Original Message-----
From: =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com>=20
Sent: Thursday, 20 December 2018 8:00 AM
To: Andrew Shearer <andrew@terabyte.co.nz>
Cc: git@vger.kernel.org; Eric Wong <e@80x24.org>
Subject: Re: error: Use of uninitialized value $hash in chomp


On Wed, Dec 19 2018, Andrew Shearer wrote:

> Hello
>
> I am using a "git svn clone" command to extract our project history from =
svn into git.
> About 30m into the process it fails with:
>
> r50739 =3D 2a1491de1353b1e3cce50d8f9d383407218a44f1=20
> (refs/remotes/git-svn)
> fatal: Cannot open '.git/Git_svn_delta_33316_0_UkxiJV': Permission=20
> denied Use of uninitialized value $hash in chomp at C:/Program Files/Git/=
mingw64/share/perl5/Git.pm line 929, <GEN11> line 36311.
> hash-object -w --stdin-paths --no-filters: command returned error: 128
>
> error closing pipe: Bad file descriptor at C:/Program Files/Git/mingw64/l=
ibexec/git-core\git-svn line 0.
> error closing pipe: Bad file descriptor at C:/Program Files/Git/mingw64/l=
ibexec/git-core\git-svn line 0.
>         (in cleanup)  at /usr/share/perl5/vendor_perl/Error.pm line 198 d=
uring global destruction.
>
> I tried updating to the latest build, 2.20.1.windows, but it still fails.
>
> There is nothing particularly special about svn changeset 50739 that I ca=
n see compared to any other.
> Anyone know why this might be failing or how I could resolve it?

That "Permission denied" looks scary. Don't know how git-svn gets into this=
, but try with this patch on top:

    diff --git a/perl/Git.pm b/perl/Git.pm
    index d856930b2e..f5d15895d3 100644
    --- a/perl/Git.pm
    +++ b/perl/Git.pm
    @@ -926,7 +926,13 @@ sub hash_and_insert_object {
                    throw Error::Simple("out pipe went bad");
            }

    -       chomp(my $hash =3D <$in>);
    +       my $hash =3D <$in>;
    +       unless (defined $hash) {
    +           sub noes { die "blah" }
    +           noes();
    +       } else {
    +           chomp($hash);
    +       }
            unless (defined($hash)) {
                    $self->_close_hash_and_insert_object();
                    throw Error::Simple("in pipe went bad");

Then run:

    perl -d $(git --exec-path)/git-svn

Set a breakpoint at that "noes" with:

  DB<1> b Git::noes

Continue:

  DB<2> c

Then when it stops there get a backtrace with "T":

      DB<2> T
    @ =3D DB::DB called from file 'perl/Git.pm' line 931
    . =3D Git::noes() called from file 'perl/Git.pm' line 932
    . =3D Git::hash_and_insert_object(ref(Git), 'Makefile') called from -e =
line 1

And see if you can get any other relevant info out of the debugger. See "pe=
rldoc perldebug".
