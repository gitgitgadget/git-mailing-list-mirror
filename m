Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F5AF211B4
	for <e@80x24.org>; Tue,  8 Jan 2019 19:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732289AbfAHTpI (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 14:45:08 -0500
Received: from out1101.nz.smxemail.com ([203.84.134.32]:47049 "EHLO
        out1101.nz.smxemail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731665AbfAHTpH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 14:45:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; d=nz.smxemail.com; s=alpha; c=relaxed/relaxed;
        q=dns/txt; i=@nz.smxemail.com; t=1546976703;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC;
        bh=bUfT3H/eUa0bumUQdy560231oLbd5Vi918PPGBQebdo=;
        b=foIaLOtTSQ8Yv8ql70o7IJYXIWraljhUReGA3B57EeeLfNJejyZ35qiLzOBbKr/m
        2cJMTWLok38DEweJ+wQhNYKjchGFZla3TXBWo8m8Rk83dYDmlmOb1TZMrmWLkrsz
        /+iVFVKYD5GLOlK0t9HFdVipGrYK5p3W7FGIldp/paU=;
Received: from AUS01-SY3-obe.outbound.protection.outlook.com ([104.47.117.56])
        by shared.nz.smxemail.com with ESMTP (using TLSv1.2
        with cipher AES256-SHA256 (256/256 bits))
        id 5C34FDBF-4A66299B@mta1108.omr;
        Tue, 08 Jan 2019 19:45:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=terabytenz.onmicrosoft.com; s=selector1-terabyte-co-nz;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUfT3H/eUa0bumUQdy560231oLbd5Vi918PPGBQebdo=;
 b=T+iOIfje7Iv4x0U/nRjiE2J2wdelFOYOKuo+BZfDzmESh+65y0D27zxuab5whaopMCZQ0Lhwj4HbSn8VjksxHjJsAUyyB8nBrCYjF0Ju+LrUQ8ZckOHjzwrfRD1bMdx100W7iiJvMflsvjIkObllLWmUz36Sd7fh3RRP0auUjQQ=
Received: from SYXPR01MB1024.ausprd01.prod.outlook.com (10.169.174.146) by
 SYXPR01MB1567.ausprd01.prod.outlook.com (10.171.39.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.9; Tue, 8 Jan 2019 19:44:59 +0000
Received: from SYXPR01MB1024.ausprd01.prod.outlook.com
 ([fe80::579:141a:99a8:2d56]) by SYXPR01MB1024.ausprd01.prod.outlook.com
 ([fe80::579:141a:99a8:2d56%10]) with mapi id 15.20.1495.011; Tue, 8 Jan 2019
 19:44:59 +0000
From:   Andrew Shearer <andrew@terabyte.co.nz>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Eric Wong <e@80x24.org>
Subject: RE: error: Use of uninitialized value $hash in chomp
Thread-Topic: error: Use of uninitialized value $hash in chomp
Thread-Index: AdSXRIAwQLCkx8aZREeNeTGRosl9oQAiJbGAAD066gADsidHQA==
Date:   Tue, 8 Jan 2019 19:44:59 +0000
Message-ID: <SYXPR01MB102421E5DB0DC254B9058624E18A0@SYXPR01MB1024.ausprd01.prod.outlook.com>
References: <ME1PR01MB11218735004432E3E26C66FFE1BE0@ME1PR01MB1121.ausprd01.prod.outlook.com>
 <874lb9fika.fsf@evledraar.gmail.com>
 <ME1PR01MB11218D4953017CFE06A2B16AE1B80@ME1PR01MB1121.ausprd01.prod.outlook.com>
In-Reply-To: <ME1PR01MB11218D4953017CFE06A2B16AE1B80@ME1PR01MB1121.ausprd01.prod.outlook.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrew@terabyte.co.nz; 
x-originating-ip: [210.48.100.210]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SYXPR01MB1567;6:J9wnDsfTp4DQOBS45PauGY23JRIm5txJKmMwWXiKBdQbLv7WqOagVae3tS1VsPQtwWj8CPKN0b6m0UXRwx6PtIKb8cicLb+Nyc5VHQaC6bnn6QS+GtFDyNvFmHCvuzgGqrxODkS8Vp+pS1GK3gOmyj9h7fQT4WKkAgz5xddVl6a0dpz/+Y1NphELBi4iDDUPELQ8jjB9KzQU81MLUs9xhqJVrrWcRt4OjNQdeGwp4p0ZFI6YJNugPpa+S83LdbvJhBSsf86gkU7OnP8hml83G/aA6ZYTHMdApTL5Nq1GrxcgRDWbPOmi8IsqSmaCEEOckgpoakMYvTH6H97Zxc22ZirYYsaQ/VxjSKRFQ5bSuzEg30eNuLsR9BqsTAkBl+Si7cyy9N8Gris42eAjF69ActNHwhKsMk0+NsgYRAj1AOU8RqSIVkK4+OkgZ5YNRRyOn/ax3LDjCbzYPFtiWrCruQ==;5:vl1GN+43YtFw5dUkf0l+O/eHXiTG1lP5fp64nH2Vypa6H0qC+2ILTb1uZZ2b1/PX+VmKRpG3aC5LzN2k3+MliVs52M07IwP0HzP54jNLlbPtRC41bu9tm7mfcq3YYrD+irTrmgKy5VhBN9iU1+pEfDreQNA+dgx+SlVbqLvIWMfuAAiE9ideEG3achBcL0iFR44yq5I+2VwA5ga84UnJ3Q==;7:5wT+u0sXE0nWxiBMtqO9Xwd6IVj73tKKSo74cU/44m+TcmqDS40audSn2Tuuut/PyB0TGs0NEMVIqO52H7qo3Yu7QiV8ksD6PvoMa7BJpaUUP+hffI73aeWMRSvVDB7bDuAS1kbhuj4wEJuN0E+yRw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 2d3a1b5a-7c5e-4936-1b96-08d675a1c642
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:SYXPR01MB1567;
x-ms-traffictypediagnostic: SYXPR01MB1567:
x-microsoft-antispam-prvs: <SYXPR01MB156798F69A526DEABDF8FDD0E18A0@SYXPR01MB1567.ausprd01.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3002001)(93006095)(93001095)(3231475)(944501520)(52105112)(10201501046)(6041310)(20161123560045)(2016111802025)(20161123558120)(20161123564045)(20161123562045)(6043046)(201708071742011)(7699051)(76991095);SRVR:SYXPR01MB1567;BCL:0;PCL:0;RULEID:;SRVR:SYXPR01MB1567;
x-forefront-prvs: 0911D5CE78
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39830400003)(376002)(136003)(346002)(366004)(13464003)(189003)(199004)(4326008)(3846002)(6116002)(11346002)(446003)(476003)(8936002)(25786009)(74482002)(74316002)(86362001)(7696005)(186003)(256004)(66066001)(102836004)(6506007)(53546011)(26005)(76176011)(19627235002)(9686003)(14444005)(39060400002)(6246003)(81166006)(81156014)(7736002)(305945005)(68736007)(8676002)(2906002)(229853002)(71190400001)(71200400001)(106356001)(33656002)(53936002)(14454004)(508600001)(105586002)(99286004)(5660300001)(54906003)(6436002)(1411001)(55016002)(6916009)(97736004)(486006)(66574012)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:SYXPR01MB1567;H:SYXPR01MB1024.ausprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: terabyte.co.nz does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GweEZWFmSiP6zvktfGcAasw9fkV9SSHMYbmcbESdeaM/h1rXG/OOYbAu+N2LMVm7wvnbafX/G0O+ApQzdQlJ7YzpAWaiyUfaXRl3NArj79CC2gYU4bBMLHLR4zkzMlWHXLh9hcW1cH14pZVYG6UFXP2dRQz/WUTYNtr8ip5s2MbojNeM0ek+c084RXMsZ8XY/Z2RWQv+HAjm0jicSrJoZpOxbaqX+eMYshJt+oYGH3dtV3EdPU0Smb47MTA2de+/BR167BCWqHEOwZcJQyuq4Eo3Pq1TRAnSiYq2F1+tKeqiDccU5oLoMEGkkZihnfa2
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: terabyte.co.nz
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d3a1b5a-7c5e-4936-1b96-08d675a1c642
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 19:44:59.5284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ea17f86c-29aa-405c-bbb3-b55968f53184
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYXPR01MB1567
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
