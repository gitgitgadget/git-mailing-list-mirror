Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9023C1F428
	for <e@80x24.org>; Fri,  7 Sep 2018 22:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbeIHDVL (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 23:21:11 -0400
Received: from mail-eopbgr10107.outbound.protection.outlook.com ([40.107.1.107]:34523
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726486AbeIHDVK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 23:21:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qtcompany.onmicrosoft.com; s=selector1-qt-io;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZpNxykm5jQr0jPX6Z7nJTWEuLGDWpI5loknAbv8znM=;
 b=iL9MGqb7gxb+mjTaSKsSA346xRKDTMVqUfJELk6n4Iq2cMIeknZH4YIptCD7dNfp2fCVu7fDAgd86MqWLH5iDTVBhZ9LpNDJWBHQ28bqu5vcXTmgk3mvuFdZjp1GKjESKd+hWPktt8Ogja6YFfpimJ7PTShCRsOMcO474kg6/qk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Allan.Jensen@qt.io; 
Received: from twilight.localnet (2003:ef:2bc6:f822:e8cb:bafd:34b2:3f16) by
 VI1PR0202MB3390.eurprd02.prod.outlook.com (2603:10a6:803:20::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.16; Fri, 7 Sep
 2018 22:33:28 +0000
From:   Allan Sandfeld Jensen <allan.jensen@qt.io>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: Old submodules broken in 2.19rc1 and 2.19rc2
Date:   Sat, 08 Sep 2018 00:33:25 +0200
Message-ID: <1612976.VLH7GnMWUR@twilight>
Organization: The Qt Company
In-Reply-To: <CAGZ79kaVQ0T=acpviOoD+8XVxYsefNkO7c5d+d0Wc0iCbr2Evw@mail.gmail.com>
References: <2659750.rG6xLiZASK@twilight> <CAGZ79kaVQ0T=acpviOoD+8XVxYsefNkO7c5d+d0Wc0iCbr2Evw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart7542107.NyiUUSuA9g"
Content-Transfer-Encoding: 7Bit
X-Originating-IP: [2003:ef:2bc6:f822:e8cb:bafd:34b2:3f16]
X-ClientProxiedBy: AM6PR03CA0002.eurprd03.prod.outlook.com (2603:10a6:20b::15)
 To VI1PR0202MB3390.eurprd02.prod.outlook.com (2603:10a6:803:20::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 271f205c-fe92-4a03-eace-08d61511ef07
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:VI1PR0202MB3390;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB3390;3:+YwG2S6/ResLKLuNcyhc33mhYDPDJbmb8/RkJ34ov8zeuPUELp2yuiAdlu+qiyQyX9e8C9kqi6D4P6LxHXNyXy9FOVQBiE6A0ciruciIbPgNA4UC+/Fmme3FRAFEgZERUMBw4J0bSzSyZFCBDi/nt2nxRVKw1nmCny6gIgXo38lCOw1ilKlPzb50/SUbu1VPWm8But+asPYBdv1Zl+Q7DN0CBqCKyan5f/FA0MgBGWXUzf0PyDmtgdCkqqGVHjEy;25:VyA091ZSk/3fM2kZxH6VAyMITVRNjz5hY1I87CYBtlNpgDQOwaQWesZMnHKY8GaqbjVolLgdKuTOF9F5i+6yrYElvnWg06jaCCONRPzqRewW+nI2hG/JEikNSo6TNe2MP2+WqkgGABXmMNLRbHcLvzT8jxMmHkg6zkjuengHjTS2PZt7v7wxcGNcrCxgOLTtWZalb/QrtHZMHhpGBOytgTpAWXUzDLqVBCxWRDlN9aAPyMc4mrNo1lRIZ9caaknEaIKbew/EK8CIlQ9oET/5/3PPoxJcVUmx5Nc5h7rmuf5uvZ+el5EUcfnLgJVVRd8m3W+rrFSnfKwmfCuiKzhO+A==;31:NpER3CUNkvIyLREUdeJGFvnzccsMwmgArwF8x2V4MwAuhoaXL/8bJU3Uxevo0gVvYQn+EnP9YjowFx6p5Q7j3ubitZ34LmwbV3ZSl4rHXyNcEvF8YKkmQcU6besuHC1KnCneuEs1iSqRvjmeDrPCqyweHvdO+1bj03nERSlt7G/PUMg2WR40aMOPvXlwO7KRC0WYj2NNwbsu5gAc0dV8b3B4fljNR48r5HlCPktO6g8=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB3390:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB3390;20:w8Dm0oVjEwF9TmVRpt9f5uJmHrKtId4gZA9+obKjMgyi6sCQSRqCDZqey3G3tHQ0zvviyqk7F5D1mzurzMdcBkj0EpTWB8W/klx9EEa5aoo+UOVPHSrmFQeYVP1y8OBl0u/yKj6uoedaGNnSsJJII6BsbHNFd1Iuw9ivVBcv9sNc6SPAKNIvEIumb3R6LiZe/JiNajnjKa/xDZGpnb9npWHxaKy+MjmB5jiV9ZQklbFpVDiOZYnPm2qvTlv1h/biBT+pSZq6LDwf2CRYLplsJSe9+ut5XuHHLtK7KvcFlVTsowU/TrX4UUfiAygITvSsN6kPKHJC90eM4Mqef5ru82Fnt7xmM9da0SlNhgBoTqoykhCftXqytSpwN/ZD4Kx5GiH4ccQP5p6TxRul9tBxYoM88My7DYkPsZNYTmaSgsmo6R3z75tLSQDqUOSNOgELDFdWU5d7Z+wzlGOJp6KIXqf8BjhEy079AF2JNoL2ViuwhN9sOpu8Lfj7NMhpIwlM;4:Vjeg9NaJwxDZM8+YcTQou7B2zrq14xZWeNEmZLw2/RagYirrzARb3azCTjas6UamBiFdn/pXSjuZo/+20svl72tPdM1io3ee5C+tBob4ODhp0P5cdMt4esTxnkOwigwzGod6Z83zN2lH8m1hJDKkKqekxzrp2zQSDHUanmvpf4nG4DJgmNL+v8qg4QD6U9z5Hivr5dHDv0t1GGKeZkRBa5M94keHuSQTceUKqdSt5DkQ2qh/5lp+93ZMDmZR32cXWaC3O8gJ3kooF0PMjgcTrUipijx4lhCc7ZiC73WKs5HdyemcnxWc8n2Zpq1oHGON
X-Microsoft-Antispam-PRVS: <VI1PR0202MB3390C19BBA48A84CB8C6A8A78E000@VI1PR0202MB3390.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(102415395)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699050);SRVR:VI1PR0202MB3390;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB3390;
X-Forefront-PRVS: 07880C4932
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39850400004)(366004)(346002)(376002)(136003)(199004)(189003)(966005)(478600001)(33716001)(316002)(72206003)(8676002)(4610100001)(4326008)(6486002)(25786009)(6246003)(230700001)(260700001)(6306002)(6512007)(9686003)(229853002)(53936002)(106356001)(16200700003)(53946003)(97736004)(305945005)(53546011)(6116002)(186003)(84326002)(74482002)(5660300001)(6916009)(6666003)(2476003)(105586002)(16526019)(21480400003)(270700001)(68736007)(446003)(86362001)(46003)(11346002)(81156014)(81166006)(33964004)(76176011)(486006)(36916002)(386003)(6506007)(52396003)(2906002)(7736002)(14444005)(52116002)(33896004)(8936002)(476003)(39026011)(569006);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB3390;H:twilight.localnet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: qt.io does not designate permitted
 sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB3390;23:Ahg3pKUiZEHfu7oBa8lYs5TVlqQxNBR0XfqVSrk?=
 =?us-ascii?Q?khBUh608FZAm8QRqTlZ8xGI0cVFc8Udwe/3nrMkldelOC5w9bjYlMHcOHLNI?=
 =?us-ascii?Q?H5Rfqkf4KXwvUe26L5qv81shkwJFt1ULKkO6eMyDTuMKXkUD/6XxbrcHcwhL?=
 =?us-ascii?Q?CjrkdIvwvLGsadx9eSVb1ruhq3PRaKng/0gZ4l8gA2hL4pwvs8OOdh22u5Oy?=
 =?us-ascii?Q?cKWKjYrg8MQopkWAv8Iri96JQ7RKjWBkQR+Ru30oispmjIezwtsX8BP/fhZ8?=
 =?us-ascii?Q?W8JChllwjieK7Py+i+7TRr8cyPDg3ovON8pSXlZ6FjYDncEMRLcrvz8i5Rjc?=
 =?us-ascii?Q?bEWHSyHDwnR6x36svuCiD/2MpcRosMkDLXd6gYcVZ6UZll5tvxeRmZa8AQIA?=
 =?us-ascii?Q?/FjIJOGGyifsXF//yN0uWJFSEyu4Itnmged5S718j8CLo82cOhSbyL//ZlSd?=
 =?us-ascii?Q?BKoTSQlTVHZX+YglySkAO4iMKI8aXCsTbUEDsqSjMHTHeRGjhMA7UOeCi6Nc?=
 =?us-ascii?Q?MOnBylWjWcfiPbbj+tcIgyuSCsTuDcBNJZVMaVJQHqCYHDBSdjtHOLwyUXcZ?=
 =?us-ascii?Q?/CDkKixtpemK9Di2eCwabjn49Kne5naDMiHzIT61HpcN4kxEOpRmW7fHl7Yj?=
 =?us-ascii?Q?Dfg+gob9UP6WJ0U4YUm0YCbQrvIeEVNQZCciPR+nRiTgBjzj5AZA1rwQu5vf?=
 =?us-ascii?Q?GfLCeNcK5b5kcaqf/x2dyftqFcUcRCV6rTIEX3mrCtHh/XTx3vhdT7RoBfym?=
 =?us-ascii?Q?0b1PfRXdTjlSEw4THasEeRGN8FdfybkttJm6z6QwFqTaKqj5+pJyYHsnwURT?=
 =?us-ascii?Q?T5v/52r1Z9gP4qpiyus7tHxGTx/bQR/paMOZkM7HpZ69kFdfL4lyWdXcOicZ?=
 =?us-ascii?Q?HKdTf0U3BIuqARnSBUJ9YKCJfUMFPo8FJ16Ov+BOiK6PKLFJt5oUeMQS8OSH?=
 =?us-ascii?Q?W1LAK7bDEC7Lggd2KsH7dHEpeU8YF+on50pj1T+2F7j7gc9s4zg8z49bfwFm?=
 =?us-ascii?Q?AOr7pTetUfpQQEgt65N8dgCQCXHlWaRCjZylA+z76q/LlqHsdzWwAZ0TlEGO?=
 =?us-ascii?Q?xG95TH6VNIG+jdlXNQlDw0VrLZkSKCBsTZAbsKcD48IA/1Yd3hu3lwMKPifX?=
 =?us-ascii?Q?6H8h9Dacjn1JkQtm/vrd7Aj1RW3eANAnkFEEcdIFzIGYkfUdwmH8fUw9T1QC?=
 =?us-ascii?Q?pABCRn9JtlOzBVBMCY91+0H+Ukidp6S6zpYHyH1itGeaahkyWhB65SgrQZ9j?=
 =?us-ascii?Q?fAyeZmqEjBFAVpw7lJHHV44kSsDVMretbOV6xEngdn01q5XbkhpJbrCzjel4?=
 =?us-ascii?Q?8obu5bmdvfHWSi+cSh8SBzrK3wfJfwQYbtjFUVaBBF+pEEZY7o1kREu3Rh/B?=
 =?us-ascii?Q?pANR1T3cX4kR23HcfT//uvRNS+UGl7JrzOXSz+LgqlnAjri1R3dewEhASDxP?=
 =?us-ascii?Q?XuccJQE/DZthla7eyMkKwqKyUwWgmPzdFqAG91/NFoXUQTDN3Nf9c/ZEzpNW?=
 =?us-ascii?Q?r5WVBv/iD7wgQrw=3D=3D?=
X-Microsoft-Antispam-Message-Info: 17VGRmEbeVc6NxCJS+K++rRAFAAgJHV16Ol/O46wLIhfz/ar4lWxFO2nMwT5LYkpKOUAOAyjeF5Ht43Xhcv+U+DdwX/5z89P8fl0J4aeljUVDF0R8Ry4w4t1Jt+233kne55zUokCcnzFSp0bS9QZMpWG/r9HRDby59wu1Gc+ELex32So3KF9oe5MxSyDKpBPkO7SI25WMTl3LqhfjJyuzNw5fTO6xVUE0mnou544GhATqzlVOm1ULmquJNZnc3D4ciukx3fJXms/hpKBmAYKupN+pPcf4u7NxmHGKG/zkwviX5oH3oeL//bkYdBxEWdXhftoBWLN2QpL34ESMeZtIUt1SmncRMJRuBy5c3WhvSY=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB3390;6:ZRSxD9oYsdOvYpow2AJ19cappAZk7a6fiV285l6JPZqTts85tUvz0Um76erjAgZ4yXLsJrCpEFQqLthH/0WT7vCImWckQ/dqFhj30Tu5FvNQocNVo3ePl9yPCTcSOaajC4nHrwqv23FKTlpNBX/bN1QL0Skrlc3KHddZvAiZgQdIjZUxeDIvck+/7kMSQ5Y6x9l82UgHVVD11QAaNnQNNolr9cDpTfHYFCL99W44ugeYCwRhzPrUTMC5ZfwIr2U4RqgXoXOLAufDjc+jHPSwl1avrQ3Z7Lvy8gvl6SxAg/WUvEdkG4CeZssslJ0Su19CMP7dkF/umol3kp3f6qA3tS0HWz6rQxlzhWRZHPK3t8PSoklSHZLVJSyCouW4zvWvQLyTbZ5Nba64tfroSUrK/dL07WL+AkETPxRrfTwImQEpdeKT8O9Ns1837BwKJuSOOyyXpHqL36z0+PJ78yxUvQ==;5:13v2tC9b9KUQCfEwzXuHpW9IZjxUhSfxZh/H2hkE/stUKmZi1o/FChmccXpe7HB0BuHWZq8eZDgY5yOkZ2/hCzxaEPN5IelAtyOshb7XFAOQMMQeiftBuglV89RvfRUAlL09ZRPsqYj5UdbKA3yGCwqvaUjg19V05SYRmqcMVVk=;7:AKe3RSslwlyKx3NO/xvJG/eQYxK+m3Cxhk3AS2WROOvTcZN0SdRS55WZ9VYHEB92OsExcUlKiS3lhNnHW7GnsIqS+3LzDGfzj3+lXmn5WBuSqAvp4SsYk5mXgRo3B6bkaVS8feTGKeOxUKy5PXmnIHq/D7OgrrTmVoVUSGmHbzx8JobPw2yxxler17IYK+fDSUT3Vorp9cF4hYC2F0NWdAI3rxE97w9gpm9/wG864oc5XvBk/pdBeEYYocJSlzxb
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: qt.io
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2018 22:33:28.5748 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 271f205c-fe92-4a03-eace-08d61511ef07
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 20d0b167-794d-448a-9d01-aaeccc1124ac
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB3390
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--nextPart7542107.NyiUUSuA9g
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Freitag, 7. September 2018 19:08:43 CEST Stefan Beller wrote:
> On Fri, Sep 7, 2018 at 2:53 AM Allan Sandfeld Jensen <allan.jensen@qt.io> 
wrote:
> > Submodules checked out with older versions of git not longer works in the
> > latest 2.19 releases. A "git submodule update --recursive" command wil
> > fail
> > for each submodule with a line saying "fatal: could not open
> > '<submodule>/.git' for writing> Is a directory.
> 
> Can you run the update again with
> 
>     GIT_TRACE=1 git submodule update ....
> 
> and post the output?
> 
> I have the suspicion that e98317508c0 (submodule:
> ensure core.worktree is set after update, 2018-06-18)
> might be the offender.
> 
> Could you try reverting that commit and check as well?
> 
>     git clone https://github.com/git/git && cd git
>     git revert e98317508c0
>     make install # installs to you home dir at ~/bin
> 
> and then try again, as well?
> (though bisection may be more fruitful if this doesn't pan out)

Okay. I had the issue on my workstation at work which I won't be back to until 
friday next week, but I managed to reproduce the exact same issue on separate 
machine running Ubuntu, and a freshly built git from git master, on another 
roughly one year old checkout of qt5.git with submodules



--nextPart7542107.NyiUUSuA9g
Content-Disposition: inline; filename="git-trace.txt"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"; name="git-trace.txt"

[127] carewolf@twilight% GIT_TRACE=1 ~src/git/git submodule update --recursive                                               [5.11.2] ~qt5
00:28:32.234453 git.c:659               trace: exec: git-submodule update --recursive
00:28:32.234491 run-command.c:637       trace: run_command: git-submodule update --recursive
00:28:32.240792 git.c:415               trace: built-in: git rev-parse --git-dir
00:28:32.241981 git.c:415               trace: built-in: git rev-parse --git-path objects
00:28:32.242905 git.c:415               trace: built-in: git rev-parse -q --git-dir
00:28:32.244794 git.c:415               trace: built-in: git rev-parse --show-prefix
00:28:32.245699 git.c:415               trace: built-in: git rev-parse --show-toplevel
00:28:32.247181 git.c:415               trace: built-in: git submodule--helper update-clone
00:28:32.247463 run-command.c:1553      run_processes_parallel: preparing to run up to 1 tasks
00:28:32.247764 run-command.c:1585      run_processes_parallel: done
00:28:32.248626 git.c:415               trace: built-in: git submodule--helper name qt3d
00:28:32.249751 git.c:415               trace: built-in: git config submodule.qt3d.update
00:28:32.250608 git.c:415               trace: built-in: git submodule--helper relative-path qt3d 
00:28:32.251399 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.252120 git.c:415               trace: built-in: git rev-parse --verify HEAD
00:28:32.253096 git.c:415               trace: built-in: git rev-parse --git-common-dir
00:28:32.253982 git.c:415               trace: built-in: git config -f .git/modules/qt3d/config core.worktree
00:28:32.254771 git.c:415               trace: built-in: git submodule--helper connect-gitdir-workingtree qt3d qt3d
fatal: could not open 'qt3d/.git' for writing: Is a directory
00:28:32.255930 git.c:415               trace: built-in: git submodule--helper relative-path qt3d/ 
00:28:32.256712 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.257878 git.c:415               trace: built-in: git submodule--helper update-clone --recursive-prefix qt3d/
00:28:32.258510 run-command.c:1553      run_processes_parallel: preparing to run up to 1 tasks
00:28:32.258544 run-command.c:1585      run_processes_parallel: done
00:28:32.260356 git.c:415               trace: built-in: git submodule--helper name qtactiveqt
00:28:32.261475 git.c:415               trace: built-in: git config submodule.qtactiveqt.update
00:28:32.262321 git.c:415               trace: built-in: git submodule--helper relative-path qtactiveqt 
00:28:32.263259 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.263987 git.c:415               trace: built-in: git rev-parse --verify HEAD
00:28:32.264929 git.c:415               trace: built-in: git rev-parse --git-common-dir
00:28:32.265775 git.c:415               trace: built-in: git config -f .git/modules/qtactiveqt/config core.worktree
00:28:32.266563 git.c:415               trace: built-in: git submodule--helper connect-gitdir-workingtree qtactiveqt qtactiveqt
fatal: could not open 'qtactiveqt/.git' for writing: Is a directory
00:28:32.267595 git.c:415               trace: built-in: git submodule--helper relative-path qtactiveqt/ 
00:28:32.268310 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.269481 git.c:415               trace: built-in: git submodule--helper update-clone --recursive-prefix qtactiveqt/
00:28:32.269626 run-command.c:1553      run_processes_parallel: preparing to run up to 1 tasks
00:28:32.269652 run-command.c:1585      run_processes_parallel: done
00:28:32.270893 git.c:415               trace: built-in: git submodule--helper name qtandroidextras
00:28:32.272151 git.c:415               trace: built-in: git config submodule.qtandroidextras.update
00:28:32.273213 git.c:415               trace: built-in: git submodule--helper relative-path qtandroidextras 
00:28:32.274162 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.274856 git.c:415               trace: built-in: git rev-parse --verify HEAD
00:28:32.275879 git.c:415               trace: built-in: git rev-parse --git-common-dir
00:28:32.276995 git.c:415               trace: built-in: git config -f .git/modules/qtandroidextras/config core.worktree
00:28:32.277883 git.c:415               trace: built-in: git submodule--helper connect-gitdir-workingtree qtandroidextras qtandroidextras
fatal: could not open 'qtandroidextras/.git' for writing: Is a directory
00:28:32.278974 git.c:415               trace: built-in: git submodule--helper relative-path qtandroidextras/ 
00:28:32.279721 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.280735 git.c:415               trace: built-in: git submodule--helper update-clone --recursive-prefix qtandroidextras/
00:28:32.280854 run-command.c:1553      run_processes_parallel: preparing to run up to 1 tasks
00:28:32.280881 run-command.c:1585      run_processes_parallel: done
00:28:32.281938 git.c:415               trace: built-in: git submodule--helper name qtbase
00:28:32.283009 git.c:415               trace: built-in: git config submodule.qtbase.update
00:28:32.283947 git.c:415               trace: built-in: git submodule--helper relative-path qtbase 
00:28:32.284835 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.285594 git.c:415               trace: built-in: git rev-parse --verify HEAD
00:28:32.286639 git.c:415               trace: built-in: git rev-parse --git-common-dir
00:28:32.287548 git.c:415               trace: built-in: git config -f .git/modules/qtbase/config core.worktree
00:28:32.288399 git.c:415               trace: built-in: git submodule--helper connect-gitdir-workingtree qtbase qtbase
fatal: could not open 'qtbase/.git' for writing: Is a directory
00:28:32.289379 git.c:415               trace: built-in: git submodule--helper relative-path qtbase/ 
00:28:32.290073 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.291003 git.c:415               trace: built-in: git submodule--helper update-clone --recursive-prefix qtbase/
00:28:32.293437 run-command.c:1553      run_processes_parallel: preparing to run up to 1 tasks
00:28:32.293450 run-command.c:1585      run_processes_parallel: done
00:28:32.294761 git.c:415               trace: built-in: git submodule--helper name qtcanvas3d
00:28:32.295955 git.c:415               trace: built-in: git config submodule.qtcanvas3d.update
00:28:32.296830 git.c:415               trace: built-in: git submodule--helper relative-path qtcanvas3d 
00:28:32.297737 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.298323 git.c:415               trace: built-in: git rev-parse --verify HEAD
00:28:32.299308 git.c:415               trace: built-in: git rev-parse --git-common-dir
00:28:32.300424 git.c:415               trace: built-in: git config -f .git/modules/qtcanvas3d/config core.worktree
00:28:32.301219 git.c:415               trace: built-in: git submodule--helper connect-gitdir-workingtree qtcanvas3d qtcanvas3d
fatal: could not open 'qtcanvas3d/.git' for writing: Is a directory
00:28:32.302298 git.c:415               trace: built-in: git submodule--helper relative-path qtcanvas3d/ 
00:28:32.303135 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.304144 git.c:415               trace: built-in: git submodule--helper update-clone --recursive-prefix qtcanvas3d/
00:28:32.304305 run-command.c:1553      run_processes_parallel: preparing to run up to 1 tasks
00:28:32.304312 run-command.c:1585      run_processes_parallel: done
00:28:32.305436 git.c:415               trace: built-in: git submodule--helper name qtcharts
00:28:32.306623 git.c:415               trace: built-in: git config submodule.qtcharts.update
00:28:32.307733 git.c:415               trace: built-in: git submodule--helper relative-path qtcharts 
00:28:32.309132 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.309953 git.c:415               trace: built-in: git rev-parse --verify HEAD
00:28:32.310872 git.c:415               trace: built-in: git rev-parse --git-common-dir
00:28:32.311715 git.c:415               trace: built-in: git config -f .git/modules/qtcharts/config core.worktree
00:28:32.312694 git.c:415               trace: built-in: git submodule--helper connect-gitdir-workingtree qtcharts qtcharts
fatal: could not open 'qtcharts/.git' for writing: Is a directory
00:28:32.313739 git.c:415               trace: built-in: git submodule--helper relative-path qtcharts/ 
00:28:32.314476 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.315474 git.c:415               trace: built-in: git submodule--helper update-clone --recursive-prefix qtcharts/
00:28:32.315706 run-command.c:1553      run_processes_parallel: preparing to run up to 1 tasks
00:28:32.315714 run-command.c:1585      run_processes_parallel: done
00:28:32.317048 git.c:415               trace: built-in: git submodule--helper name qtconnectivity
00:28:32.318220 git.c:415               trace: built-in: git config submodule.qtconnectivity.update
00:28:32.319278 git.c:415               trace: built-in: git submodule--helper relative-path qtconnectivity 
00:28:32.320454 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.321200 git.c:415               trace: built-in: git rev-parse --verify HEAD
00:28:32.322107 git.c:415               trace: built-in: git rev-parse --git-common-dir
00:28:32.323086 git.c:415               trace: built-in: git config -f .git/modules/qtconnectivity/config core.worktree
00:28:32.323983 git.c:415               trace: built-in: git submodule--helper connect-gitdir-workingtree qtconnectivity qtconnectivity
fatal: could not open 'qtconnectivity/.git' for writing: Is a directory
00:28:32.325043 git.c:415               trace: built-in: git submodule--helper relative-path qtconnectivity/ 
00:28:32.325810 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.326789 git.c:415               trace: built-in: git submodule--helper update-clone --recursive-prefix qtconnectivity/
00:28:32.326978 run-command.c:1553      run_processes_parallel: preparing to run up to 1 tasks
00:28:32.326987 run-command.c:1585      run_processes_parallel: done
00:28:32.328155 git.c:415               trace: built-in: git submodule--helper name qtdatavis3d
00:28:32.329275 git.c:415               trace: built-in: git config submodule.qtdatavis3d.update
00:28:32.330125 git.c:415               trace: built-in: git submodule--helper relative-path qtdatavis3d 
00:28:32.331069 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.331678 git.c:415               trace: built-in: git rev-parse --verify HEAD
00:28:32.332616 git.c:415               trace: built-in: git rev-parse --git-common-dir
00:28:32.333516 git.c:415               trace: built-in: git config -f .git/modules/qtdatavis3d/config core.worktree
00:28:32.334445 git.c:415               trace: built-in: git submodule--helper connect-gitdir-workingtree qtdatavis3d qtdatavis3d
fatal: could not open 'qtdatavis3d/.git' for writing: Is a directory
00:28:32.335636 git.c:415               trace: built-in: git submodule--helper relative-path qtdatavis3d/ 
00:28:32.336442 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.337468 git.c:415               trace: built-in: git submodule--helper update-clone --recursive-prefix qtdatavis3d/
00:28:32.337696 run-command.c:1553      run_processes_parallel: preparing to run up to 1 tasks
00:28:32.337724 run-command.c:1585      run_processes_parallel: done
00:28:32.338780 git.c:415               trace: built-in: git submodule--helper name qtdeclarative
00:28:32.339940 git.c:415               trace: built-in: git config submodule.qtdeclarative.update
00:28:32.340751 git.c:415               trace: built-in: git submodule--helper relative-path qtdeclarative 
00:28:32.341537 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.342183 git.c:415               trace: built-in: git rev-parse --verify HEAD
00:28:32.343111 git.c:415               trace: built-in: git rev-parse --git-common-dir
00:28:32.343997 git.c:415               trace: built-in: git config -f .git/modules/qtdeclarative/config core.worktree
00:28:32.344743 git.c:415               trace: built-in: git submodule--helper connect-gitdir-workingtree qtdeclarative qtdeclarative
fatal: could not open 'qtdeclarative/.git' for writing: Is a directory
00:28:32.345732 git.c:415               trace: built-in: git submodule--helper relative-path qtdeclarative/ 
00:28:32.346490 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.347495 git.c:415               trace: built-in: git submodule--helper update-clone --recursive-prefix qtdeclarative/
00:28:32.348619 run-command.c:1553      run_processes_parallel: preparing to run up to 1 tasks
00:28:32.348690 run-command.c:1585      run_processes_parallel: done
00:28:32.349524 git.c:415               trace: built-in: git submodule--helper name tests/auto/qml/ecmascripttests/test262
00:28:32.351213 git.c:415               trace: built-in: git config submodule.tests/auto/qml/ecmascripttests/test262.update
00:28:32.352106 git.c:415               trace: built-in: git submodule--helper relative-path qtdeclarative/tests/auto/qml/ecmascripttests/test262 
00:28:32.352996 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.353646 git.c:415               trace: built-in: git rev-parse --verify HEAD
00:28:32.354640 git.c:415               trace: built-in: git rev-parse --git-common-dir
00:28:32.355437 git.c:415               trace: built-in: git config -f .git/modules/tests/auto/qml/ecmascripttests/test262/config core.worktree
00:28:32.356344 git.c:415               trace: built-in: git submodule--helper connect-gitdir-workingtree tests/auto/qml/ecmascripttests/test262 tests/auto/qml/ecmascripttests/test262
00:28:32.357659 git.c:415               trace: built-in: git submodule--helper relative-path qtdeclarative/tests/auto/qml/ecmascripttests/test262/ 
00:28:32.358693 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.360070 git.c:415               trace: built-in: git submodule--helper update-clone --recursive-prefix qtdeclarative/tests/auto/qml/ecmascripttests/test262/
00:28:32.361641 run-command.c:1553      run_processes_parallel: preparing to run up to 1 tasks
00:28:32.361673 run-command.c:1585      run_processes_parallel: done
00:28:32.363347 git.c:415               trace: built-in: git submodule--helper name qtdoc
00:28:32.364557 git.c:415               trace: built-in: git config submodule.qtdoc.update
00:28:32.365526 git.c:415               trace: built-in: git submodule--helper relative-path qtdoc 
00:28:32.366413 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.367022 git.c:415               trace: built-in: git rev-parse --verify HEAD
00:28:32.368012 git.c:415               trace: built-in: git rev-parse --git-common-dir
00:28:32.368810 git.c:415               trace: built-in: git config -f .git/modules/qtdoc/config core.worktree
00:28:32.369720 git.c:415               trace: built-in: git submodule--helper connect-gitdir-workingtree qtdoc qtdoc
fatal: could not open 'qtdoc/.git' for writing: Is a directory
00:28:32.370824 git.c:415               trace: built-in: git submodule--helper relative-path qtdoc/ 
00:28:32.371573 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.372563 git.c:415               trace: built-in: git submodule--helper update-clone --recursive-prefix qtdoc/
00:28:32.372766 run-command.c:1553      run_processes_parallel: preparing to run up to 1 tasks
00:28:32.372775 run-command.c:1585      run_processes_parallel: done
00:28:32.373799 git.c:415               trace: built-in: git submodule--helper name qtdocgallery
00:28:32.374757 git.c:415               trace: built-in: git config submodule.qtdocgallery.update
00:28:32.375489 git.c:415               trace: built-in: git submodule--helper relative-path qtdocgallery 
00:28:32.376272 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.376930 git.c:415               trace: built-in: git rev-parse --verify HEAD
00:28:32.377819 git.c:415               trace: built-in: git rev-parse --git-common-dir
00:28:32.378643 git.c:415               trace: built-in: git config -f .git/modules/qtdocgallery/config core.worktree
00:28:32.379545 git.c:415               trace: built-in: git submodule--helper connect-gitdir-workingtree qtdocgallery qtdocgallery
00:28:32.380811 git.c:415               trace: built-in: git submodule--helper relative-path qtdocgallery/ 
00:28:32.381563 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.382596 git.c:415               trace: built-in: git submodule--helper update-clone --recursive-prefix qtdocgallery/
00:28:32.382712 run-command.c:1553      run_processes_parallel: preparing to run up to 1 tasks
00:28:32.382738 run-command.c:1585      run_processes_parallel: done
00:28:32.383858 git.c:415               trace: built-in: git submodule--helper name qtfeedback
00:28:32.384939 git.c:415               trace: built-in: git config submodule.qtfeedback.update
00:28:32.385747 git.c:415               trace: built-in: git submodule--helper relative-path qtfeedback 
00:28:32.386554 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.387206 git.c:415               trace: built-in: git rev-parse --verify HEAD
00:28:32.388173 git.c:415               trace: built-in: git rev-parse --git-common-dir
00:28:32.388989 git.c:415               trace: built-in: git config -f .git/modules/qtfeedback/config core.worktree
00:28:32.389997 git.c:415               trace: built-in: git submodule--helper connect-gitdir-workingtree qtfeedback qtfeedback
00:28:32.391155 git.c:415               trace: built-in: git submodule--helper relative-path qtfeedback/ 
00:28:32.391946 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.392937 git.c:415               trace: built-in: git submodule--helper update-clone --recursive-prefix qtfeedback/
00:28:32.393042 run-command.c:1553      run_processes_parallel: preparing to run up to 1 tasks
00:28:32.393053 run-command.c:1585      run_processes_parallel: done
00:28:32.394070 git.c:415               trace: built-in: git submodule--helper name qtgamepad
00:28:32.395037 git.c:415               trace: built-in: git config submodule.qtgamepad.update
00:28:32.395778 git.c:415               trace: built-in: git submodule--helper relative-path qtgamepad 
00:28:32.396736 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.397423 git.c:415               trace: built-in: git rev-parse --verify HEAD
00:28:32.398334 git.c:415               trace: built-in: git rev-parse --git-common-dir
00:28:32.399191 git.c:415               trace: built-in: git config -f .git/modules/qtgamepad/config core.worktree
00:28:32.400069 git.c:415               trace: built-in: git submodule--helper connect-gitdir-workingtree qtgamepad qtgamepad
fatal: could not open 'qtgamepad/.git' for writing: Is a directory
00:28:32.401080 git.c:415               trace: built-in: git submodule--helper relative-path qtgamepad/ 
00:28:32.401843 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.402868 git.c:415               trace: built-in: git submodule--helper update-clone --recursive-prefix qtgamepad/
00:28:32.402976 run-command.c:1553      run_processes_parallel: preparing to run up to 1 tasks
00:28:32.402988 run-command.c:1585      run_processes_parallel: done
00:28:32.404108 git.c:415               trace: built-in: git submodule--helper name qtgraphicaleffects
00:28:32.405122 git.c:415               trace: built-in: git config submodule.qtgraphicaleffects.update
00:28:32.406006 git.c:415               trace: built-in: git submodule--helper relative-path qtgraphicaleffects 
00:28:32.407290 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.408276 git.c:415               trace: built-in: git rev-parse --verify HEAD
00:28:32.409773 git.c:415               trace: built-in: git rev-parse --git-common-dir
00:28:32.410889 git.c:415               trace: built-in: git config -f .git/modules/qtgraphicaleffects/config core.worktree
00:28:32.411702 git.c:415               trace: built-in: git submodule--helper connect-gitdir-workingtree qtgraphicaleffects qtgraphicaleffects
fatal: could not open 'qtgraphicaleffects/.git' for writing: Is a directory
00:28:32.412798 git.c:415               trace: built-in: git submodule--helper relative-path qtgraphicaleffects/ 
00:28:32.413551 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.414577 git.c:415               trace: built-in: git submodule--helper update-clone --recursive-prefix qtgraphicaleffects/
00:28:32.414724 run-command.c:1553      run_processes_parallel: preparing to run up to 1 tasks
00:28:32.414732 run-command.c:1585      run_processes_parallel: done
00:28:32.416013 git.c:415               trace: built-in: git submodule--helper name qtimageformats
00:28:32.417100 git.c:415               trace: built-in: git config submodule.qtimageformats.update
00:28:32.418063 git.c:415               trace: built-in: git submodule--helper relative-path qtimageformats 
00:28:32.419038 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.419763 git.c:415               trace: built-in: git rev-parse --verify HEAD
00:28:32.420765 git.c:415               trace: built-in: git rev-parse --git-common-dir
00:28:32.421611 git.c:415               trace: built-in: git config -f .git/modules/qtimageformats/config core.worktree
00:28:32.422395 git.c:415               trace: built-in: git submodule--helper connect-gitdir-workingtree qtimageformats qtimageformats
fatal: could not open 'qtimageformats/.git' for writing: Is a directory
00:28:32.423463 git.c:415               trace: built-in: git submodule--helper relative-path qtimageformats/ 
00:28:32.424255 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.425276 git.c:415               trace: built-in: git submodule--helper update-clone --recursive-prefix qtimageformats/
00:28:32.425454 run-command.c:1553      run_processes_parallel: preparing to run up to 1 tasks
00:28:32.425462 run-command.c:1585      run_processes_parallel: done
00:28:32.426548 git.c:415               trace: built-in: git submodule--helper name qtlocation
00:28:32.427653 git.c:415               trace: built-in: git config submodule.qtlocation.update
00:28:32.428520 git.c:415               trace: built-in: git submodule--helper relative-path qtlocation 
00:28:32.429392 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.430081 git.c:415               trace: built-in: git rev-parse --verify HEAD
00:28:32.430948 git.c:415               trace: built-in: git rev-parse --git-common-dir
00:28:32.431883 git.c:415               trace: built-in: git config -f .git/modules/qtlocation/config core.worktree
00:28:32.432644 git.c:415               trace: built-in: git submodule--helper connect-gitdir-workingtree qtlocation qtlocation
fatal: could not open 'qtlocation/.git' for writing: Is a directory
00:28:32.433659 git.c:415               trace: built-in: git submodule--helper relative-path qtlocation/ 
00:28:32.434425 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.435419 git.c:415               trace: built-in: git submodule--helper update-clone --recursive-prefix qtlocation/
00:28:32.435658 run-command.c:1553      run_processes_parallel: preparing to run up to 1 tasks
00:28:32.435689 run-command.c:1585      run_processes_parallel: done
00:28:32.436536 git.c:415               trace: built-in: git submodule--helper name src/3rdparty/mapbox-gl-native
00:28:32.437460 git.c:415               trace: built-in: git config submodule.src/3rdparty/mapbox-gl-native.update
00:28:32.438238 git.c:415               trace: built-in: git submodule--helper relative-path qtlocation/src/3rdparty/mapbox-gl-native 
00:28:32.439093 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.439705 git.c:415               trace: built-in: git rev-parse --verify HEAD
00:28:32.440802 git.c:415               trace: built-in: git rev-parse --git-common-dir
00:28:32.441577 git.c:415               trace: built-in: git config -f .git/modules/src/3rdparty/mapbox-gl-native/config core.worktree
00:28:32.442548 git.c:415               trace: built-in: git submodule--helper connect-gitdir-workingtree src/3rdparty/mapbox-gl-native src/3rdparty/mapbox-gl-native
00:28:32.443595 git.c:415               trace: built-in: git submodule--helper relative-path qtlocation/src/3rdparty/mapbox-gl-native/ 
00:28:32.444333 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.445350 git.c:415               trace: built-in: git submodule--helper update-clone --recursive-prefix qtlocation/src/3rdparty/mapbox-gl-native/
00:28:32.445928 run-command.c:1553      run_processes_parallel: preparing to run up to 1 tasks
00:28:32.445938 run-command.c:1585      run_processes_parallel: done
00:28:32.447234 git.c:415               trace: built-in: git submodule--helper name qtmacextras
00:28:32.448286 git.c:415               trace: built-in: git config submodule.qtmacextras.update
00:28:32.449142 git.c:415               trace: built-in: git submodule--helper relative-path qtmacextras 
00:28:32.450001 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.450815 git.c:415               trace: built-in: git rev-parse --verify HEAD
00:28:32.451994 git.c:415               trace: built-in: git rev-parse --git-common-dir
00:28:32.452936 git.c:415               trace: built-in: git config -f .git/modules/qtmacextras/config core.worktree
00:28:32.453738 git.c:415               trace: built-in: git submodule--helper connect-gitdir-workingtree qtmacextras qtmacextras
fatal: could not open 'qtmacextras/.git' for writing: Is a directory
00:28:32.454821 git.c:415               trace: built-in: git submodule--helper relative-path qtmacextras/ 
00:28:32.455618 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.456636 git.c:415               trace: built-in: git submodule--helper update-clone --recursive-prefix qtmacextras/
00:28:32.456803 run-command.c:1553      run_processes_parallel: preparing to run up to 1 tasks
00:28:32.456812 run-command.c:1585      run_processes_parallel: done
00:28:32.458217 git.c:415               trace: built-in: git submodule--helper name qtmultimedia
00:28:32.459897 git.c:415               trace: built-in: git config submodule.qtmultimedia.update
00:28:32.460908 git.c:415               trace: built-in: git submodule--helper relative-path qtmultimedia 
00:28:32.461787 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.462588 git.c:415               trace: built-in: git rev-parse --verify HEAD
00:28:32.463611 git.c:415               trace: built-in: git rev-parse --git-common-dir
00:28:32.464496 git.c:415               trace: built-in: git config -f .git/modules/qtmultimedia/config core.worktree
00:28:32.465265 git.c:415               trace: built-in: git submodule--helper connect-gitdir-workingtree qtmultimedia qtmultimedia
fatal: could not open 'qtmultimedia/.git' for writing: Is a directory
00:28:32.466329 git.c:415               trace: built-in: git submodule--helper relative-path qtmultimedia/ 
00:28:32.467121 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.468129 git.c:415               trace: built-in: git submodule--helper update-clone --recursive-prefix qtmultimedia/
00:28:32.468431 run-command.c:1553      run_processes_parallel: preparing to run up to 1 tasks
00:28:32.468441 run-command.c:1585      run_processes_parallel: done
00:28:32.469470 git.c:415               trace: built-in: git submodule--helper name qtnetworkauth
00:28:32.470535 git.c:415               trace: built-in: git config submodule.qtnetworkauth.update
00:28:32.471371 git.c:415               trace: built-in: git submodule--helper relative-path qtnetworkauth 
00:28:32.472263 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.472913 git.c:415               trace: built-in: git rev-parse --verify HEAD
00:28:32.473816 git.c:415               trace: built-in: git rev-parse --git-common-dir
00:28:32.474659 git.c:415               trace: built-in: git config -f .git/modules/qtnetworkauth/config core.worktree
00:28:32.475434 git.c:415               trace: built-in: git submodule--helper connect-gitdir-workingtree qtnetworkauth qtnetworkauth
fatal: could not open 'qtnetworkauth/.git' for writing: Is a directory
00:28:32.476461 git.c:415               trace: built-in: git submodule--helper relative-path qtnetworkauth/ 
00:28:32.477322 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.478451 git.c:415               trace: built-in: git submodule--helper update-clone --recursive-prefix qtnetworkauth/
00:28:32.478570 run-command.c:1553      run_processes_parallel: preparing to run up to 1 tasks
00:28:32.478597 run-command.c:1585      run_processes_parallel: done
00:28:32.479732 git.c:415               trace: built-in: git submodule--helper name qtpim
00:28:32.480914 git.c:415               trace: built-in: git config submodule.qtpim.update
00:28:32.481850 git.c:415               trace: built-in: git submodule--helper relative-path qtpim 
00:28:32.482689 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.483373 git.c:415               trace: built-in: git rev-parse --verify HEAD
00:28:32.484330 git.c:415               trace: built-in: git rev-parse --git-common-dir
00:28:32.485198 git.c:415               trace: built-in: git config -f .git/modules/qtpim/config core.worktree
00:28:32.486164 git.c:415               trace: built-in: git submodule--helper connect-gitdir-workingtree qtpim qtpim
00:28:32.487302 git.c:415               trace: built-in: git submodule--helper relative-path qtpim/ 
00:28:32.488150 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.489140 git.c:415               trace: built-in: git submodule--helper update-clone --recursive-prefix qtpim/
00:28:32.489344 run-command.c:1553      run_processes_parallel: preparing to run up to 1 tasks
00:28:32.489352 run-command.c:1585      run_processes_parallel: done
00:28:32.490484 git.c:415               trace: built-in: git submodule--helper name qtpurchasing
00:28:32.491559 git.c:415               trace: built-in: git config submodule.qtpurchasing.update
00:28:32.492429 git.c:415               trace: built-in: git submodule--helper relative-path qtpurchasing 
00:28:32.493215 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.493847 git.c:415               trace: built-in: git rev-parse --verify HEAD
00:28:32.495112 git.c:415               trace: built-in: git rev-parse --git-common-dir
00:28:32.496041 git.c:415               trace: built-in: git config -f .git/modules/qtpurchasing/config core.worktree
00:28:32.496843 git.c:415               trace: built-in: git submodule--helper connect-gitdir-workingtree qtpurchasing qtpurchasing
fatal: could not open 'qtpurchasing/.git' for writing: Is a directory
00:28:32.497956 git.c:415               trace: built-in: git submodule--helper relative-path qtpurchasing/ 
00:28:32.498768 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.499883 git.c:415               trace: built-in: git submodule--helper update-clone --recursive-prefix qtpurchasing/
00:28:32.500003 run-command.c:1553      run_processes_parallel: preparing to run up to 1 tasks
00:28:32.500011 run-command.c:1585      run_processes_parallel: done
00:28:32.501056 git.c:415               trace: built-in: git submodule--helper name qtqa
00:28:32.502126 git.c:415               trace: built-in: git config submodule.qtqa.update
00:28:32.502974 git.c:415               trace: built-in: git submodule--helper relative-path qtqa 
00:28:32.503773 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.504591 git.c:415               trace: built-in: git rev-parse --verify HEAD
00:28:32.505645 git.c:415               trace: built-in: git rev-parse --git-common-dir
00:28:32.506732 git.c:415               trace: built-in: git config -f .git/modules/qtqa/config core.worktree
00:28:32.507875 git.c:415               trace: built-in: git submodule--helper connect-gitdir-workingtree qtqa qtqa
fatal: could not open 'qtqa/.git' for writing: Is a directory
00:28:32.509175 git.c:415               trace: built-in: git submodule--helper relative-path qtqa/ 
00:28:32.509985 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.510882 git.c:415               trace: built-in: git submodule--helper update-clone --recursive-prefix qtqa/
00:28:32.511002 run-command.c:1553      run_processes_parallel: preparing to run up to 1 tasks
00:28:32.511010 run-command.c:1585      run_processes_parallel: done
00:28:32.512184 git.c:415               trace: built-in: git submodule--helper name qtquickcontrols
00:28:32.513251 git.c:415               trace: built-in: git config submodule.qtquickcontrols.update
00:28:32.514082 git.c:415               trace: built-in: git submodule--helper relative-path qtquickcontrols 
00:28:32.514961 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.515611 git.c:415               trace: built-in: git rev-parse --verify HEAD
00:28:32.516612 git.c:415               trace: built-in: git rev-parse --git-common-dir
00:28:32.517380 git.c:415               trace: built-in: git config -f .git/modules/qtquickcontrols/config core.worktree
00:28:32.518168 git.c:415               trace: built-in: git submodule--helper connect-gitdir-workingtree qtquickcontrols qtquickcontrols
fatal: could not open 'qtquickcontrols/.git' for writing: Is a directory
00:28:32.519164 git.c:415               trace: built-in: git submodule--helper relative-path qtquickcontrols/ 
00:28:32.519987 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.521262 git.c:415               trace: built-in: git submodule--helper update-clone --recursive-prefix qtquickcontrols/
00:28:32.521463 run-command.c:1553      run_processes_parallel: preparing to run up to 1 tasks
00:28:32.521472 run-command.c:1585      run_processes_parallel: done
00:28:32.522591 git.c:415               trace: built-in: git submodule--helper name qtquickcontrols2
00:28:32.523636 git.c:415               trace: built-in: git config submodule.qtquickcontrols2.update
00:28:32.524524 git.c:415               trace: built-in: git submodule--helper relative-path qtquickcontrols2 
00:28:32.525398 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.526081 git.c:415               trace: built-in: git rev-parse --verify HEAD
00:28:32.527044 git.c:415               trace: built-in: git rev-parse --git-common-dir
00:28:32.527925 git.c:415               trace: built-in: git config -f .git/modules/qtquickcontrols2/config core.worktree
00:28:32.528793 git.c:415               trace: built-in: git submodule--helper connect-gitdir-workingtree qtquickcontrols2 qtquickcontrols2
fatal: could not open 'qtquickcontrols2/.git' for writing: Is a directory
00:28:32.529877 git.c:415               trace: built-in: git submodule--helper relative-path qtquickcontrols2/ 
00:28:32.530626 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.531571 git.c:415               trace: built-in: git submodule--helper update-clone --recursive-prefix qtquickcontrols2/
00:28:32.532079 run-command.c:1553      run_processes_parallel: preparing to run up to 1 tasks
00:28:32.532090 run-command.c:1585      run_processes_parallel: done
00:28:32.533173 git.c:415               trace: built-in: git submodule--helper name qtremoteobjects
00:28:32.534263 git.c:415               trace: built-in: git config submodule.qtremoteobjects.update
00:28:32.535105 git.c:415               trace: built-in: git submodule--helper relative-path qtremoteobjects 
00:28:32.536033 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.536725 git.c:415               trace: built-in: git rev-parse --verify HEAD
00:28:32.537674 git.c:415               trace: built-in: git rev-parse --git-common-dir
00:28:32.538553 git.c:415               trace: built-in: git config -f .git/modules/qtremoteobjects/config core.worktree
00:28:32.539863 git.c:415               trace: built-in: git submodule--helper connect-gitdir-workingtree qtremoteobjects qtremoteobjects
00:28:32.541153 git.c:415               trace: built-in: git submodule--helper relative-path qtremoteobjects/ 
00:28:32.541930 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.543141 git.c:415               trace: built-in: git submodule--helper update-clone --recursive-prefix qtremoteobjects/
00:28:32.543315 run-command.c:1553      run_processes_parallel: preparing to run up to 1 tasks
00:28:32.543323 run-command.c:1585      run_processes_parallel: done
00:28:32.544545 git.c:415               trace: built-in: git submodule--helper name qtrepotools
00:28:32.545673 git.c:415               trace: built-in: git config submodule.qtrepotools.update
00:28:32.546525 git.c:415               trace: built-in: git submodule--helper relative-path qtrepotools 
00:28:32.547372 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.548026 git.c:415               trace: built-in: git rev-parse --verify HEAD
00:28:32.548941 git.c:415               trace: built-in: git rev-parse --git-common-dir
00:28:32.550163 git.c:415               trace: built-in: git config -f .git/modules/qtrepotools/config core.worktree
00:28:32.551057 git.c:415               trace: built-in: git submodule--helper connect-gitdir-workingtree qtrepotools qtrepotools
fatal: could not open 'qtrepotools/.git' for writing: Is a directory
00:28:32.552245 git.c:415               trace: built-in: git submodule--helper relative-path qtrepotools/ 
00:28:32.552994 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.553990 git.c:415               trace: built-in: git submodule--helper update-clone --recursive-prefix qtrepotools/
00:28:32.554068 run-command.c:1553      run_processes_parallel: preparing to run up to 1 tasks
00:28:32.554078 run-command.c:1585      run_processes_parallel: done
00:28:32.555115 git.c:415               trace: built-in: git submodule--helper name qtscript
00:28:32.556249 git.c:415               trace: built-in: git config submodule.qtscript.update
00:28:32.557242 git.c:415               trace: built-in: git submodule--helper relative-path qtscript 
00:28:32.558261 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.559396 git.c:415               trace: built-in: git rev-parse --verify HEAD
00:28:32.560545 git.c:415               trace: built-in: git rev-parse --git-common-dir
00:28:32.561380 git.c:415               trace: built-in: git config -f .git/modules/qtscript/config core.worktree
00:28:32.562155 git.c:415               trace: built-in: git submodule--helper connect-gitdir-workingtree qtscript qtscript
fatal: could not open 'qtscript/.git' for writing: Is a directory
00:28:32.563124 git.c:415               trace: built-in: git submodule--helper relative-path qtscript/ 
00:28:32.563927 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.564905 git.c:415               trace: built-in: git submodule--helper update-clone --recursive-prefix qtscript/
00:28:32.565221 run-command.c:1553      run_processes_parallel: preparing to run up to 1 tasks
00:28:32.565231 run-command.c:1585      run_processes_parallel: done
00:28:32.566411 git.c:415               trace: built-in: git submodule--helper name qtscxml
00:28:32.567548 git.c:415               trace: built-in: git config submodule.qtscxml.update
00:28:32.568436 git.c:415               trace: built-in: git submodule--helper relative-path qtscxml 
00:28:32.569265 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.569916 git.c:415               trace: built-in: git rev-parse --verify HEAD
00:28:32.570831 git.c:415               trace: built-in: git rev-parse --git-common-dir
00:28:32.571669 git.c:415               trace: built-in: git config -f .git/modules/qtscxml/config core.worktree
00:28:32.572460 git.c:415               trace: built-in: git submodule--helper connect-gitdir-workingtree qtscxml qtscxml
fatal: could not open 'qtscxml/.git' for writing: Is a directory
00:28:32.573413 git.c:415               trace: built-in: git submodule--helper relative-path qtscxml/ 
00:28:32.574148 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.575136 git.c:415               trace: built-in: git submodule--helper update-clone --recursive-prefix qtscxml/
00:28:32.575381 run-command.c:1553      run_processes_parallel: preparing to run up to 1 tasks
00:28:32.575389 run-command.c:1585      run_processes_parallel: done
00:28:32.576437 git.c:415               trace: built-in: git submodule--helper name qtsensors
00:28:32.577525 git.c:415               trace: built-in: git config submodule.qtsensors.update
00:28:32.578342 git.c:415               trace: built-in: git submodule--helper relative-path qtsensors 
00:28:32.579090 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.579769 git.c:415               trace: built-in: git rev-parse --verify HEAD
00:28:32.580707 git.c:415               trace: built-in: git rev-parse --git-common-dir
00:28:32.581594 git.c:415               trace: built-in: git config -f .git/modules/qtsensors/config core.worktree
00:28:32.582376 git.c:415               trace: built-in: git submodule--helper connect-gitdir-workingtree qtsensors qtsensors
fatal: could not open 'qtsensors/.git' for writing: Is a directory
00:28:32.583481 git.c:415               trace: built-in: git submodule--helper relative-path qtsensors/ 
00:28:32.584231 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.585326 git.c:415               trace: built-in: git submodule--helper update-clone --recursive-prefix qtsensors/
00:28:32.585508 run-command.c:1553      run_processes_parallel: preparing to run up to 1 tasks
00:28:32.585534 run-command.c:1585      run_processes_parallel: done
00:28:32.586897 git.c:415               trace: built-in: git submodule--helper name qtserialbus
00:28:32.588337 git.c:415               trace: built-in: git config submodule.qtserialbus.update
00:28:32.589209 git.c:415               trace: built-in: git submodule--helper relative-path qtserialbus 
00:28:32.590098 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.590756 git.c:415               trace: built-in: git rev-parse --verify HEAD
00:28:32.591667 git.c:415               trace: built-in: git rev-parse --git-common-dir
00:28:32.592607 git.c:415               trace: built-in: git config -f .git/modules/qtserialbus/config core.worktree
00:28:32.593610 git.c:415               trace: built-in: git submodule--helper connect-gitdir-workingtree qtserialbus qtserialbus
fatal: could not open 'qtserialbus/.git' for writing: Is a directory
00:28:32.594737 git.c:415               trace: built-in: git submodule--helper relative-path qtserialbus/ 
00:28:32.595530 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.596573 git.c:415               trace: built-in: git submodule--helper update-clone --recursive-prefix qtserialbus/
00:28:32.596704 run-command.c:1553      run_processes_parallel: preparing to run up to 1 tasks
00:28:32.596713 run-command.c:1585      run_processes_parallel: done
00:28:32.597783 git.c:415               trace: built-in: git submodule--helper name qtserialport
00:28:32.598892 git.c:415               trace: built-in: git config submodule.qtserialport.update
00:28:32.599733 git.c:415               trace: built-in: git submodule--helper relative-path qtserialport 
00:28:32.600596 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.601270 git.c:415               trace: built-in: git rev-parse --verify HEAD
00:28:32.602151 git.c:415               trace: built-in: git rev-parse --git-common-dir
00:28:32.603026 git.c:415               trace: built-in: git config -f .git/modules/qtserialport/config core.worktree
00:28:32.603836 git.c:415               trace: built-in: git submodule--helper connect-gitdir-workingtree qtserialport qtserialport
fatal: could not open 'qtserialport/.git' for writing: Is a directory
00:28:32.604865 git.c:415               trace: built-in: git submodule--helper relative-path qtserialport/ 
00:28:32.605611 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.606636 git.c:415               trace: built-in: git submodule--helper update-clone --recursive-prefix qtserialport/
00:28:32.606810 run-command.c:1553      run_processes_parallel: preparing to run up to 1 tasks
00:28:32.606839 run-command.c:1585      run_processes_parallel: done
00:28:32.608349 git.c:415               trace: built-in: git submodule--helper name qtspeech
00:28:32.609706 git.c:415               trace: built-in: git config submodule.qtspeech.update
00:28:32.610607 git.c:415               trace: built-in: git submodule--helper relative-path qtspeech 
00:28:32.611487 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.612204 git.c:415               trace: built-in: git rev-parse --verify HEAD
00:28:32.613232 git.c:415               trace: built-in: git rev-parse --git-common-dir
00:28:32.614108 git.c:415               trace: built-in: git config -f .git/modules/qtspeech/config core.worktree
00:28:32.614933 git.c:415               trace: built-in: git submodule--helper connect-gitdir-workingtree qtspeech qtspeech
fatal: could not open 'qtspeech/.git' for writing: Is a directory
00:28:32.616036 git.c:415               trace: built-in: git submodule--helper relative-path qtspeech/ 
00:28:32.616776 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.617739 git.c:415               trace: built-in: git submodule--helper update-clone --recursive-prefix qtspeech/
00:28:32.617837 run-command.c:1553      run_processes_parallel: preparing to run up to 1 tasks
00:28:32.617848 run-command.c:1585      run_processes_parallel: done
00:28:32.619008 git.c:415               trace: built-in: git submodule--helper name qtsvg
00:28:32.620270 git.c:415               trace: built-in: git config submodule.qtsvg.update
00:28:32.621128 git.c:415               trace: built-in: git submodule--helper relative-path qtsvg 
00:28:32.622013 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.622629 git.c:415               trace: built-in: git rev-parse --verify HEAD
00:28:32.623561 git.c:415               trace: built-in: git rev-parse --git-common-dir
00:28:32.624515 git.c:415               trace: built-in: git config -f .git/modules/qtsvg/config core.worktree
00:28:32.625298 git.c:415               trace: built-in: git submodule--helper connect-gitdir-workingtree qtsvg qtsvg
fatal: could not open 'qtsvg/.git' for writing: Is a directory
00:28:32.626287 git.c:415               trace: built-in: git submodule--helper relative-path qtsvg/ 
00:28:32.627145 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.628338 git.c:415               trace: built-in: git submodule--helper update-clone --recursive-prefix qtsvg/
00:28:32.628495 run-command.c:1553      run_processes_parallel: preparing to run up to 1 tasks
00:28:32.628506 run-command.c:1585      run_processes_parallel: done
00:28:32.629807 git.c:415               trace: built-in: git submodule--helper name qtsystems
00:28:32.631235 git.c:415               trace: built-in: git config submodule.qtsystems.update
00:28:32.632216 git.c:415               trace: built-in: git submodule--helper relative-path qtsystems 
00:28:32.633090 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.633793 git.c:415               trace: built-in: git rev-parse --verify HEAD
00:28:32.634746 git.c:415               trace: built-in: git rev-parse --git-common-dir
00:28:32.635733 git.c:415               trace: built-in: git config -f .git/modules/qtsystems/config core.worktree
00:28:32.636868 git.c:415               trace: built-in: git submodule--helper connect-gitdir-workingtree qtsystems qtsystems
00:28:32.638098 git.c:415               trace: built-in: git submodule--helper relative-path qtsystems/ 
00:28:32.638884 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.640013 git.c:415               trace: built-in: git submodule--helper update-clone --recursive-prefix qtsystems/
00:28:32.640214 run-command.c:1553      run_processes_parallel: preparing to run up to 1 tasks
00:28:32.640223 run-command.c:1585      run_processes_parallel: done
00:28:32.641300 git.c:415               trace: built-in: git submodule--helper name qttools
00:28:32.642395 git.c:415               trace: built-in: git config submodule.qttools.update
00:28:32.643236 git.c:415               trace: built-in: git submodule--helper relative-path qttools 
00:28:32.644077 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.644769 git.c:415               trace: built-in: git rev-parse --verify HEAD
00:28:32.645713 git.c:415               trace: built-in: git rev-parse --git-common-dir
00:28:32.646548 git.c:415               trace: built-in: git config -f .git/modules/qttools/config core.worktree
00:28:32.647334 git.c:415               trace: built-in: git submodule--helper connect-gitdir-workingtree qttools qttools
fatal: could not open 'qttools/.git' for writing: Is a directory
00:28:32.648349 git.c:415               trace: built-in: git submodule--helper relative-path qttools/ 
00:28:32.649095 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.650073 git.c:415               trace: built-in: git submodule--helper update-clone --recursive-prefix qttools/
00:28:32.650421 run-command.c:1553      run_processes_parallel: preparing to run up to 1 tasks
00:28:32.650430 run-command.c:1585      run_processes_parallel: done
00:28:32.651506 git.c:415               trace: built-in: git submodule--helper name qttranslations
00:28:32.652684 git.c:415               trace: built-in: git config submodule.qttranslations.update
00:28:32.653475 git.c:415               trace: built-in: git submodule--helper relative-path qttranslations 
00:28:32.654350 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.654959 git.c:415               trace: built-in: git rev-parse --verify HEAD
00:28:32.656013 git.c:415               trace: built-in: git rev-parse --git-common-dir
00:28:32.656890 git.c:415               trace: built-in: git config -f .git/modules/qttranslations/config core.worktree
00:28:32.657870 git.c:415               trace: built-in: git submodule--helper connect-gitdir-workingtree qttranslations qttranslations
fatal: could not open 'qttranslations/.git' for writing: Is a directory
00:28:32.659252 git.c:415               trace: built-in: git submodule--helper relative-path qttranslations/ 
00:28:32.660213 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.661187 git.c:415               trace: built-in: git submodule--helper update-clone --recursive-prefix qttranslations/
00:28:32.661332 run-command.c:1553      run_processes_parallel: preparing to run up to 1 tasks
00:28:32.661361 run-command.c:1585      run_processes_parallel: done
00:28:32.662521 git.c:415               trace: built-in: git submodule--helper name qtvirtualkeyboard
00:28:32.663699 git.c:415               trace: built-in: git config submodule.qtvirtualkeyboard.update
00:28:32.664602 git.c:415               trace: built-in: git submodule--helper relative-path qtvirtualkeyboard 
00:28:32.665572 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.666259 git.c:415               trace: built-in: git rev-parse --verify HEAD
00:28:32.667181 git.c:415               trace: built-in: git rev-parse --git-common-dir
00:28:32.668119 git.c:415               trace: built-in: git config -f .git/modules/qtvirtualkeyboard/config core.worktree
00:28:32.669040 git.c:415               trace: built-in: git submodule--helper connect-gitdir-workingtree qtvirtualkeyboard qtvirtualkeyboard
fatal: could not open 'qtvirtualkeyboard/.git' for writing: Is a directory
00:28:32.670111 git.c:415               trace: built-in: git submodule--helper relative-path qtvirtualkeyboard/ 
00:28:32.671037 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.672260 git.c:415               trace: built-in: git submodule--helper update-clone --recursive-prefix qtvirtualkeyboard/
00:28:32.672510 run-command.c:1553      run_processes_parallel: preparing to run up to 1 tasks
00:28:32.672522 run-command.c:1585      run_processes_parallel: done
00:28:32.673824 git.c:415               trace: built-in: git submodule--helper name qtwayland
00:28:32.675254 git.c:415               trace: built-in: git config submodule.qtwayland.update
00:28:32.676254 git.c:415               trace: built-in: git submodule--helper relative-path qtwayland 
00:28:32.677149 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.677815 git.c:415               trace: built-in: git rev-parse --verify HEAD
00:28:32.678705 git.c:415               trace: built-in: git rev-parse --git-common-dir
00:28:32.679515 git.c:415               trace: built-in: git config -f .git/modules/qtwayland/config core.worktree
00:28:32.680378 git.c:415               trace: built-in: git submodule--helper connect-gitdir-workingtree qtwayland qtwayland
fatal: could not open 'qtwayland/.git' for writing: Is a directory
00:28:32.681349 git.c:415               trace: built-in: git submodule--helper relative-path qtwayland/ 
00:28:32.682068 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.683020 git.c:415               trace: built-in: git submodule--helper update-clone --recursive-prefix qtwayland/
00:28:32.683211 run-command.c:1553      run_processes_parallel: preparing to run up to 1 tasks
00:28:32.683220 run-command.c:1585      run_processes_parallel: done
00:28:32.684288 git.c:415               trace: built-in: git submodule--helper name qtwebchannel
00:28:32.685365 git.c:415               trace: built-in: git config submodule.qtwebchannel.update
00:28:32.686197 git.c:415               trace: built-in: git submodule--helper relative-path qtwebchannel 
00:28:32.687250 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.688053 git.c:415               trace: built-in: git rev-parse --verify HEAD
00:28:32.689027 git.c:415               trace: built-in: git rev-parse --git-common-dir
00:28:32.689828 git.c:415               trace: built-in: git config -f .git/modules/qtwebchannel/config core.worktree
00:28:32.690649 git.c:415               trace: built-in: git submodule--helper connect-gitdir-workingtree qtwebchannel qtwebchannel
fatal: could not open 'qtwebchannel/.git' for writing: Is a directory
00:28:32.691673 git.c:415               trace: built-in: git submodule--helper relative-path qtwebchannel/ 
00:28:32.692395 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.693337 git.c:415               trace: built-in: git submodule--helper update-clone --recursive-prefix qtwebchannel/
00:28:32.693440 run-command.c:1553      run_processes_parallel: preparing to run up to 1 tasks
00:28:32.693450 run-command.c:1585      run_processes_parallel: done
00:28:32.694513 git.c:415               trace: built-in: git submodule--helper name qtwebengine
00:28:32.695558 git.c:415               trace: built-in: git config submodule.qtwebengine.update
00:28:32.696394 git.c:415               trace: built-in: git submodule--helper relative-path qtwebengine 
00:28:32.697128 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.697813 git.c:415               trace: built-in: git rev-parse --verify HEAD
00:28:32.698713 git.c:415               trace: built-in: git rev-parse --git-common-dir
00:28:32.699550 git.c:415               trace: built-in: git config -f .git/modules/qtwebengine/config core.worktree
00:28:32.700365 git.c:415               trace: built-in: git submodule--helper connect-gitdir-workingtree qtwebengine qtwebengine
fatal: could not open 'qtwebengine/.git' for writing: Is a directory
00:28:32.701368 git.c:415               trace: built-in: git submodule--helper relative-path qtwebengine/ 
00:28:32.702128 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.703122 git.c:415               trace: built-in: git submodule--helper update-clone --recursive-prefix qtwebengine/
00:28:32.703383 run-command.c:1553      run_processes_parallel: preparing to run up to 1 tasks
00:28:32.703414 run-command.c:1585      run_processes_parallel: done
00:28:32.704307 git.c:415               trace: built-in: git submodule--helper name src/3rdparty
00:28:32.705228 git.c:415               trace: built-in: git config submodule.src/3rdparty.update
00:28:32.706067 git.c:415               trace: built-in: git submodule--helper relative-path qtwebengine/src/3rdparty 
00:28:32.707040 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.707919 git.c:415               trace: built-in: git rev-parse --verify HEAD
00:28:32.709130 git.c:415               trace: built-in: git rev-parse --git-common-dir
00:28:32.709996 git.c:415               trace: built-in: git config -f .git/modules/src/3rdparty/config core.worktree
00:28:32.710800 git.c:415               trace: built-in: git submodule--helper connect-gitdir-workingtree src/3rdparty src/3rdparty
fatal: could not open 'src/3rdparty/.git' for writing: Is a directory
00:28:32.711881 git.c:415               trace: built-in: git submodule--helper relative-path qtwebengine/src/3rdparty/ 
00:28:32.712760 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.713700 git.c:415               trace: built-in: git submodule--helper update-clone --recursive-prefix qtwebengine/src/3rdparty/
00:28:32.725343 run-command.c:1553      run_processes_parallel: preparing to run up to 1 tasks
00:28:32.725361 run-command.c:1585      run_processes_parallel: done
00:28:32.727259 git.c:415               trace: built-in: git submodule--helper name qtwebglplugin
00:28:32.728403 git.c:415               trace: built-in: git config submodule.qtwebglplugin.update
00:28:32.729247 git.c:415               trace: built-in: git submodule--helper relative-path qtwebglplugin 
00:28:32.730030 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.730647 git.c:415               trace: built-in: git rev-parse --verify HEAD
00:28:32.731663 git.c:415               trace: built-in: git rev-parse --git-common-dir
00:28:32.732627 git.c:415               trace: built-in: git config -f .git/modules/qtwebglplugin/config core.worktree
00:28:32.733597 git.c:415               trace: built-in: git submodule--helper connect-gitdir-workingtree qtwebglplugin qtwebglplugin
00:28:32.734749 git.c:415               trace: built-in: git submodule--helper relative-path qtwebglplugin/ 
00:28:32.735528 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.736522 git.c:415               trace: built-in: git submodule--helper update-clone --recursive-prefix qtwebglplugin/
00:28:32.736647 run-command.c:1553      run_processes_parallel: preparing to run up to 1 tasks
00:28:32.736675 run-command.c:1585      run_processes_parallel: done
00:28:32.737777 git.c:415               trace: built-in: git submodule--helper name qtwebsockets
00:28:32.738846 git.c:415               trace: built-in: git config submodule.qtwebsockets.update
00:28:32.739635 git.c:415               trace: built-in: git submodule--helper relative-path qtwebsockets 
00:28:32.740495 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.741177 git.c:415               trace: built-in: git rev-parse --verify HEAD
00:28:32.742182 git.c:415               trace: built-in: git rev-parse --git-common-dir
00:28:32.742995 git.c:415               trace: built-in: git config -f .git/modules/qtwebsockets/config core.worktree
00:28:32.743886 git.c:415               trace: built-in: git submodule--helper connect-gitdir-workingtree qtwebsockets qtwebsockets
fatal: could not open 'qtwebsockets/.git' for writing: Is a directory
00:28:32.744957 git.c:415               trace: built-in: git submodule--helper relative-path qtwebsockets/ 
00:28:32.745717 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.746692 git.c:415               trace: built-in: git submodule--helper update-clone --recursive-prefix qtwebsockets/
00:28:32.746840 run-command.c:1553      run_processes_parallel: preparing to run up to 1 tasks
00:28:32.746866 run-command.c:1585      run_processes_parallel: done
00:28:32.748007 git.c:415               trace: built-in: git submodule--helper name qtwebview
00:28:32.749097 git.c:415               trace: built-in: git config submodule.qtwebview.update
00:28:32.749954 git.c:415               trace: built-in: git submodule--helper relative-path qtwebview 
00:28:32.750826 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.751483 git.c:415               trace: built-in: git rev-parse --verify HEAD
00:28:32.752413 git.c:415               trace: built-in: git rev-parse --git-common-dir
00:28:32.753361 git.c:415               trace: built-in: git config -f .git/modules/qtwebview/config core.worktree
00:28:32.754127 git.c:415               trace: built-in: git submodule--helper connect-gitdir-workingtree qtwebview qtwebview
fatal: could not open 'qtwebview/.git' for writing: Is a directory
00:28:32.755139 git.c:415               trace: built-in: git submodule--helper relative-path qtwebview/ 
00:28:32.755984 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.757138 git.c:415               trace: built-in: git submodule--helper update-clone --recursive-prefix qtwebview/
00:28:32.757282 run-command.c:1553      run_processes_parallel: preparing to run up to 1 tasks
00:28:32.757296 run-command.c:1585      run_processes_parallel: done
00:28:32.758804 git.c:415               trace: built-in: git submodule--helper name qtwinextras
00:28:32.760424 git.c:415               trace: built-in: git config submodule.qtwinextras.update
00:28:32.761271 git.c:415               trace: built-in: git submodule--helper relative-path qtwinextras 
00:28:32.762207 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.762894 git.c:415               trace: built-in: git rev-parse --verify HEAD
00:28:32.763791 git.c:415               trace: built-in: git rev-parse --git-common-dir
00:28:32.764976 git.c:415               trace: built-in: git config -f .git/modules/qtwinextras/config core.worktree
00:28:32.765725 git.c:415               trace: built-in: git submodule--helper connect-gitdir-workingtree qtwinextras qtwinextras
fatal: could not open 'qtwinextras/.git' for writing: Is a directory
00:28:32.766885 git.c:415               trace: built-in: git submodule--helper relative-path qtwinextras/ 
00:28:32.767774 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.768941 git.c:415               trace: built-in: git submodule--helper update-clone --recursive-prefix qtwinextras/
00:28:32.769102 run-command.c:1553      run_processes_parallel: preparing to run up to 1 tasks
00:28:32.769131 run-command.c:1585      run_processes_parallel: done
00:28:32.770438 git.c:415               trace: built-in: git submodule--helper name qtx11extras
00:28:32.771952 git.c:415               trace: built-in: git config submodule.qtx11extras.update
00:28:32.772819 git.c:415               trace: built-in: git submodule--helper relative-path qtx11extras 
00:28:32.773589 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.774251 git.c:415               trace: built-in: git rev-parse --verify HEAD
00:28:32.775162 git.c:415               trace: built-in: git rev-parse --git-common-dir
00:28:32.776071 git.c:415               trace: built-in: git config -f .git/modules/qtx11extras/config core.worktree
00:28:32.776842 git.c:415               trace: built-in: git submodule--helper connect-gitdir-workingtree qtx11extras qtx11extras
fatal: could not open 'qtx11extras/.git' for writing: Is a directory
00:28:32.777843 git.c:415               trace: built-in: git submodule--helper relative-path qtx11extras/ 
00:28:32.778635 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.779692 git.c:415               trace: built-in: git submodule--helper update-clone --recursive-prefix qtx11extras/
00:28:32.779869 run-command.c:1553      run_processes_parallel: preparing to run up to 1 tasks
00:28:32.779879 run-command.c:1585      run_processes_parallel: done
00:28:32.780894 git.c:415               trace: built-in: git submodule--helper name qtxmlpatterns
00:28:32.781947 git.c:415               trace: built-in: git config submodule.qtxmlpatterns.update
00:28:32.782800 git.c:415               trace: built-in: git submodule--helper relative-path qtxmlpatterns
00:28:32.784034 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.784739 git.c:415               trace: built-in: git rev-parse --verify HEAD
00:28:32.785617 git.c:415               trace: built-in: git rev-parse --git-common-dir
00:28:32.786458 git.c:415               trace: built-in: git config -f .git/modules/qtxmlpatterns/config core.worktree
00:28:32.787263 git.c:415               trace: built-in: git submodule--helper connect-gitdir-workingtree qtxmlpatterns qtxmlpatterns
fatal: could not open 'qtxmlpatterns/.git' for writing: Is a directory
00:28:32.788317 git.c:415               trace: built-in: git submodule--helper relative-path qtxmlpatterns/
00:28:32.789011 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.789985 git.c:415               trace: built-in: git submodule--helper update-clone --recursive-prefix qtxmlpatterns/
00:28:32.790227 run-command.c:1553      run_processes_parallel: preparing to run up to 1 tasks
00:28:32.790256 run-command.c:1585      run_processes_parallel: done
00:28:32.791071 git.c:415               trace: built-in: git submodule--helper name tests/auto/3rdparty/testsuites
00:28:32.792081 git.c:415               trace: built-in: git config submodule.testsuites.update
00:28:32.792875 git.c:415               trace: built-in: git submodule--helper relative-path qtxmlpatterns/tests/auto/3rdparty/testsuites
00:28:32.793713 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.794363 git.c:415               trace: built-in: git rev-parse --verify HEAD
00:28:32.795249 git.c:415               trace: built-in: git rev-parse --git-common-dir
00:28:32.796074 git.c:415               trace: built-in: git config -f .git/modules/testsuites/config core.worktree
00:28:32.796861 git.c:415               trace: built-in: git submodule--helper connect-gitdir-workingtree testsuites tests/auto/3rdparty/testsuites
fatal: could not open 'tests/auto/3rdparty/testsuites/.git' for writing: Is a directory
00:28:32.798041 git.c:415               trace: built-in: git submodule--helper relative-path qtxmlpatterns/tests/auto/3rdparty/testsuites/
00:28:32.798785 git.c:415               trace: built-in: git rev-parse --local-env-vars
00:28:32.799766 git.c:415               trace: built-in: git submodule--helper update-clone --recursive-prefix qtxmlpatterns/tests/auto/3rdparty/testsuites/
00:28:32.805569 run-command.c:1553      run_processes_parallel: preparing to run up to 1 tasks
00:28:32.805586 run-command.c:1585      run_processes_parallel: done

--nextPart7542107.NyiUUSuA9g--
