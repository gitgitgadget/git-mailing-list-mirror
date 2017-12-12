Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F1071F406
	for <e@80x24.org>; Tue, 12 Dec 2017 14:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752848AbdLLOLA (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 09:11:00 -0500
Received: from mx0a-00099f01.pphosted.com ([67.231.149.228]:35972 "EHLO
        mx0b-00099f01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752003AbdLLOKy (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2017 09:10:54 -0500
Received: from pps.filterd (m0074061.ppops.net [127.0.0.1])
        by mx0a-00099f01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vBCEAcqL003457
        for <git@vger.kernel.org>; Tue, 12 Dec 2017 08:10:54 -0600
Received: from crexpp04.us.aegon.com (email2.aegonusa.com [162.123.17.223])
        by mx0a-00099f01.pphosted.com with ESMTP id 2et405at7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Tue, 12 Dec 2017 08:10:53 -0600
Received: from pps.filterd (crexpp04.us.aegon.com [127.0.0.1])
        by crexpp04.us.aegon.com (8.16.0.21/8.16.0.21) with SMTP id vBCE2tdf004110
        for <git@vger.kernel.org>; Tue, 12 Dec 2017 08:10:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Aegon.onmicrosoft.com;
 s=selector1-transamerica-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=MjJFRnAfBO2MxsDTYCW3btNJTDcYZ1i2ZJm1MTg2p60=;
 b=RUZaiQyfE8mlddG18z6BgH8nNOOdDtHeo/PazmUCABiDkIWo98Y14Mk8XNVlAiIokXZOQtSkA+LgF3O+0NsTYlNbY/yJ4pQfUoL5yl/fINIWlOkmTvxBcamm3k56GQwwtKuMJie+ovxihZoFs3KoHKLWiTZgJ2OGK/OHHYBZBI4=
From:   "Bennett, Brian" <Brian.Bennett@Transamerica.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git svn dcommit error: Cannot accept non-LF line endings in 'svn:log'
 property
Thread-Topic: git svn dcommit error: Cannot accept non-LF line endings in
 'svn:log' property
Thread-Index: AdNzUv68qggNYxDjQ0CejzikxXyuYQ==
Date:   Tue, 12 Dec 2017 14:10:43 +0000
Message-ID: <BL2PR05MB2179DEBF7123ACD090E60F2685340@BL2PR05MB2179.namprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [162.123.17.85]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL2PR05MB2179;20:E4fSuCZkXeSGZnWg+7PSEww9QjHZ6iZBqO/u343GN/vtPAeuz5JWQvH/Sd4tp303Hc4VfR2qIIJdind+MQTu0KqpZIMavInWQJS4pcuq1ep4Wz/E+U25QVZV042vQKI5p2g6CSw74tJYL0k7Fl0JNgsTUhWtlqZH8skazO2ERgINH6H2Cu8UmPcTMRhETqbj7Nxn+cpbEyG410TihysAkLhoQLItR1qiSorcodOcVChX+HeZNgfePwKH/n0BgHXo7YZbpH4ORWJ06KUIic+eYh+gpooaNdhpxDm5uGbB4xadBYKGYh6V06CdVcnZClFLRtJdmdFw9dEFOKAAw4tPjthMGdbcCZR3s1FB+uHZHRHaTIT2wtJhTRrsVCCV98FmMJTeHK1PYddIvDofSfWDuMUXr4crI4zk8I7UabWczrd+mg7YzYki/Xoab1BMqpwT0rpC4y5aQGlqmt32FEFJLwycuVfgX7Leq9ila2bMViftnarr/VqByli1NVP/pqlu
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: d851a1b2-d01b-415f-02f3-08d5416a21e9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(5600026)(4604075)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603307);SRVR:BL2PR05MB2179;
x-ms-traffictypediagnostic: BL2PR05MB2179:
x-microsoft-antispam-prvs: <BL2PR05MB2179836F7EA914B060E071B785340@BL2PR05MB2179.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(83074219007389)(190756311086443)(158342451672863)(166708455590820)(116415991822766)(81227570615382);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231023)(6041248)(20161123564025)(20161123558100)(20161123562025)(20161123555025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(6072148)(201708071742011);SRVR:BL2PR05MB2179;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:BL2PR05MB2179;
x-forefront-prvs: 051900244E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(376002)(346002)(199004)(189003)(8936002)(81156014)(68736007)(15974865002)(86362001)(575784001)(106356001)(2351001)(105586002)(7696005)(1730700003)(6116002)(3846002)(99286004)(8676002)(9686003)(81166006)(2501003)(316002)(55016002)(97736004)(6306002)(102836003)(53936002)(5640700003)(25786009)(45080400002)(478600001)(2906002)(14454004)(305945005)(7736002)(66066001)(72206003)(59450400001)(6916009)(3660700001)(74316002)(2900100001)(33656002)(5250100002)(3280700002)(6436002)(6506006)(5660300001)(460985005)(134885004)(19627235001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL2PR05MB2179;H:BL2PR05MB2179.namprd05.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
received-spf: None (protection.outlook.com: Transamerica.com does not
 designate permitted sender hosts)
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d851a1b2-d01b-415f-02f3-08d5416a21e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2017 14:10:43.2644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46e16835-c804-41de-be3c-55835d14dee4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR05MB2179
X-EXCLAIMER-MD-CONFIG: 7562670a-beab-4c6e-8ed2-ab3b5287c042
X-OriginatorOrg: transamerica.com
x-crexppdlp-TriggeredRule: module.access.rule.forcepoint_dlp_reroute
x-crexppdlp-TriggeredRule: module.access.rule.mcafee_dlp_reroute
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-12-12_09:,,
 signatures=0
X-RCIS-Action: ALLOW
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-12-12_09:,,
 signatures=0
X-VPM-MSG-ID: 4c1daa04-e129-4edc-9c95-b588051b57a4
X-VPM-HOST: crexzx02.inet.nogea.local
X-VPM-GROUP-ID: f0802a61-3a70-4450-a931-b24de5747c25
X-VPM-ENC-REGIME: Plaintext
X-VPM-IS-HYBRID: 0
x-crexpp01-TriggeredRule: module.access.rule.Strip_Receive_HeadersV2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-12-12_09:,,
 signatures=0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-12-12_09:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Environment:

Desktop: Windows 7 Enterprise 64-bit
svn client (if applicable): 1.8.8 from Apache
git (https://git-for-windows.github.io/): git version 2.10.1.windows.1
GitTfs (https://github.com/git-tfs/git-tfs): git-tfs version 0.27.0.0 (TFS =
client library 14.0.0.0 (MS)) (32-bit)
Team Foundation Server: 2010
Visual Studio installation: 2010 and 2015

All processing is being done on my desktop described above. My goal is to m=
igrate Team Foundation Server source into git and then from git into a loca=
l SVN repository. The specific source from Team Foundation Server has only =
2 changesets made against it and neither have a commit message associated w=
ith them.

Steps I'm taking:

1. Open a Windows (cmd.exe) command shell and put git-tfs into Path:
Set Path=3DC:\Users\brbennett\Downloads\GitTfs-0.27.0;%Path%

2. Create empty folder C:\TEMP\gitclone\Project_Elevation_Request and make =
this the working folder.

3. git-tfs clone -d "http://tfs:8080/tfs/collection" $/Folder1/Production/E=
levation_Request
I can see the only 2 TFS changesets being cloned into the local git reposit=
ory.
C423 =3D 6dfefb6160b53da7f580f24f2ce41af04f508b8a
C424 =3D e8d6573b5a6e29db78fd420f843ca7ad7480eda2

4. Move working folder to C:\TEMP\gitclone\Project_Elevation_Request\Elevat=
ion_Request

5. Create empty folder C:\TEMP\SVN\repos and create empty SVN repository:
svnadmin --compatible-version 1.8 create C:\TEMP\SVN\repos\Elevation_Reques=
t

6. Start up local SVN server in a different shell:
svnserve -d -r C:\TEMP\SVN\repos

7. Create trunk in local=20
svn mkdir --parents svn:///C:/TEMP/SVN/repos/Elevation_Request/trunk -m "Im=
porting git repo"
Committed revision 1.

8. git svn init svn:///C:/TEMP/SVN/repos/%PROJNAME% -s

9. git svn fetch
R1 for the trunk created earlier is retrieved
r1 =3D 5efc0da5f5af4cd62fde660a4402e3a751c2b003 (refs/remotes/origin/trunk)

10. git rebase origin/trunk
First, rewinding head to replay your work on top of it...
Applying:
Applying:

11. git svn dcommit
Committing to svn:///C:/TEMP/SVN/repos/Source_elevation_tool/trunk ...
        A       Source_elevation_tool.sln
        A       Source_elevation_tool/Form1.Designer.cs
        A       Source_elevation_tool/Form1.cs
        A       Source_elevation_tool/Form1.resx

ERROR from SVN:
Wrong or unexpected property value: Cannot accept non-LF line endings in 's=
vn:log' property
W: 40ff09d157bcbbf1e6deefd2222e38ed499ec8ac and refs/remotes/origin/trunk d=
iffer, using rebase -v:
:100644 000000 8222efb4e5a055b3b0b41ab91972f07dd71e4b10 0000000000000000000=
000000000000000000000 D      Source_elevation_tool.sln
:100644 000000 794f014c920a6aee2f21ee348e30f38a458e9c7d 0000000000000000000=
000000000000000000000 D      Source_elevation_tool.vssscc
:040000 000000 0acaa94fa910fe974019ae4c2dcbf9a620437758 0000000000000000000=
000000000000000000000 D      Source_elevation_tool
Current branch master is up to date.
ERROR: Not all changes have been committed into SVN, however the committed
ones (if any) seem to be successfully integrated into the working tree.
Please see the above messages for details.

I've researched enough to believe that the commit message being used by git=
 svn contains a carriage return character (x'0D') and that has not been all=
owed in Subversion since version 1.6 (I can replicate this specific error m=
essage using an SVN dump file that contains x'0D' characters in the log mes=
sages.). However, I cannot find where I have any control over the log messa=
ge that git svn is trying to use nor can I observe it. Note that I've also =
used the '-v' switch with the 'git svn dcommit', but do not receive anythin=
g other than what I am showing above.

Brian Bennett | Supv System Admin & Support, TA TECH Change Mgmt/Production=
 Support
o: 319-355-7602 | c: 319-533-1094
e: brian.bennett@transamerica.com | w: www.transamerica.com

Transamerica
6400 C St. SW, Cedar Rapids, IA 52404 MS-2410
Facebook | LinkedIn


