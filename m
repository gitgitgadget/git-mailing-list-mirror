Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0A011F516
	for <e@80x24.org>; Mon,  2 Jul 2018 12:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752213AbeGBMNo convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 2 Jul 2018 08:13:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34376 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752156AbeGBMNn (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 2 Jul 2018 08:13:43 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w62C9ZVf124713
        for <git@vger.kernel.org>; Mon, 2 Jul 2018 08:13:42 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.114])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jyksar8ud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Mon, 02 Jul 2018 08:13:42 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <git@vger.kernel.org> from <GROEGES@uk.ibm.com>;
        Mon, 2 Jul 2018 12:13:40 -0000
Received: from us1b3-smtp01.a3dr.sjc01.isc4sb.com (10.122.7.174)
        by smtp.notes.na.collabserv.com (10.122.47.58) with smtp.notes.na.collabserv.com ESMTP;
        Mon, 2 Jul 2018 12:13:35 -0000
Received: from us1b3-mail97.a3dr.sjc01.isc4sb.com ([10.122.105.210])
          by us1b3-smtp01.a3dr.sjc01.isc4sb.com
          with ESMTP id 2018070212133525-436405 ;
          Mon, 2 Jul 2018 12:13:35 +0000 
X-Disclaimed: 1
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
In-Reply-To: <4E8CDDC9-2957-401F-9BBE-93276C026848@gmail.com>
References: <4E8CDDC9-2957-401F-9BBE-93276C026848@gmail.com>,
        <OF5D40FE06.C18CD7CD-ON002582B9.002B7A02-002582B9.002B7A07@notes.na.collabserv.com> <20180628024446.GD644867@genre.crustytoothpaste.net> <20180628143405.GA16657@sigill.intra.peff.net>
Subject: Re: Use of new .gitattributes working-tree-encoding attribute across
 different platform types
From:   Steve Groeger <GROEGES@uk.ibm.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Date:   Mon, 2 Jul 2018 12:13:35 +0000
X-Mailer: IBM iNotes ($HaikuForm 1011.1) | IBM Domino Build SCN1812108_20180501T0841
 May 01, 2018 at 08:41
X-KeepSent: AD36A6D5:F36D27E7-002582BE:0043296C;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-TNEFEvaluated: 1
X-LLNXfer: False
x-cbid: 18070212-9695-0000-0000-0000037D2B72
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.399202; ST=0; TS=0; UL=0; ISC=; MB=0.033139
X-IBM-SpamModules-Versions: BY=3.00009294; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01055450; UDB=6.00541338; IPR=6.00833372;
 BA=6.00006032; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00021960; XFM=3.00000015;
 UTC=2018-07-02 12:13:39
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2018-07-02 05:36:27 - 6.00008647
x-cbparentid: 18070212-9696-0000-0000-0000E6CE2BA0
Message-Id: <OFAD36A6D5.F36D27E7-ON002582BE.0043296C-002582BE.0043297F@notes.na.collabserv.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-02_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars, 

I think this proposed solution may resolve my issue.
 
 
  
 
Thanks
 Steve Groeger
 Java Runtimes Development
 IBM Hursley
 IBM United Kingdom Ltd
 Tel: (44) 1962 816911 Mobex: 279990 Mobile: 07718 517 129
 Fax (44) 1962 816800
 Lotus Notes: Steve Groeger/UK/IBM
 Internet: groeges@uk.ibm.com  
   
 
Unless stated otherwise above:
 IBM United Kingdom Limited - Registered in England and Wales with number 741598.
 Registered office: PO Box 41, North Harbour, Portsmouth, Hampshire PO6 3AU      

-----Lars Schneider <larsxschneider@gmail.com> wrote: -----
To: Jeff King <peff@peff.net>
From: Lars Schneider <larsxschneider@gmail.com>
Date: 06/28/2018 18:21
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, Steve Groeger <GROEGES@uk.ibm.com>, git@vger.kernel.org
Subject: Re: Use of new .gitattributes working-tree-encoding attribute across different platform types


> On Jun 28, 2018, at 4:34 PM, Jeff King <peff@peff.net> wrote:
> 
> On Thu, Jun 28, 2018 at 02:44:47AM +0000, brian m. carlson wrote:
> 
>> On Wed, Jun 27, 2018 at 07:54:52AM +0000, Steve Groeger wrote:
>>> We have common code that is supposed to be usable across different platforms and hence different file encodings. With the full support of the working-tree-encoding in the latest version of git on all platforms, how do we have files converted to different encodings on different platforms?
>>> I could not find anything that would allow us to say 'if platform = z/OS then encoding=EBCDIC else encoding=ASCII'.   Is there a way this can be done?
>> 
>> I don't believe there is such functionality.  Git doesn't have
>> attributes that are conditional on the platform in that sort of way.
>> You could use a smudge/clean filter and adjust the filter for the
>> platform you're on, which might meet your needs.
> 
> We do have prior art in the line-ending code, though. There the
> attributes say either that a file needs a specific line-ending type
> (which is relatively rare), or that it should follow the system type,
> which is then set separately in the config.
> 
> I have the impression that the working-tree-encoding stuff was made to
> handle the first case, but not the second. It doesn't seem like an
> outrageous thing to eventually add.
> 
> (Though I agree that clean/smudge filters would work, and can even
> implement the existing working-tree-encoding feature, albeit less
> efficiently and conveniently).

Thanks for the suggestion Peff! 
How about this:

1) We allow users to set the encoding "auto". Example:

	*.txt working-tree-encoding=auto

2) We define a new variable `core.autoencoding`. By default the value is 
UTF-8 (== no re-encoding) but user can set to any value in their Git config. 
Example:

    git config --global core.autoencoding UTF-16

All files marked with the value "auto" will use the encoding defined in
`core.autoencoding`.

Would that work?

@steve: Would that fix your problem?

- Lars
Unless stated otherwise above:
IBM United Kingdom Limited - Registered in England and Wales with number 741598. 
Registered office: PO Box 41, North Harbour, Portsmouth, Hampshire PO6 3AU

