Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAD_ENC_HEADER,BAYES_00,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_QP_LONG_LINE,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE87C43457
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 06:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 372FC2222E
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 06:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="gFliWJMi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgJNGzN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 02:55:13 -0400
Received: from pv50p00im-zteg10021401.me.com ([17.58.6.47]:49395 "EHLO
        pv50p00im-zteg10021401.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727622AbgJNGzM (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 14 Oct 2020 02:55:12 -0400
X-Greylist: delayed 661 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Oct 2020 02:54:58 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1602657833;
        bh=lgZes0MWPSEavu4M0Adpj7QtDGQg7CRviMpWuBHq9zw=;
        h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
        b=gFliWJMieKAzso7qYxoDQ1G+jwZ1YnswLk6smksWWMWOLOeQf+96kRefj/bib0aKH
         swzCWC8fNZLVrEbDbRcnH7CmPnF5RuFg5T541WLFaLjAD2sme2JLAGbr9pZOuD/een
         dS0oRC9BZ3rJ3UA+E0nWqXmQqXWh6UX9wcQ5uIe90osqLYdn+ODgKP9c20KRNc5UNY
         FJbRUmlv+RcfPD/zwwGXBLgucEaE1fvD5iBflFYHlTRDCHDvGoJSgWJIi/7sN/YFdy
         K9W3seOffdWh0Go4wW8Z9YlKAlIatZxzhwwpOqNYHNsxounSbM2gLvLljpyDB7FU7m
         fW1+pBQLpC2eQ==
Received: from [166.98.46.1] (unknown [49.228.42.96])
        by pv50p00im-zteg10021401.me.com (Postfix) with ESMTPSA id B61824802F1;
        Wed, 14 Oct 2020 06:43:50 +0000 (UTC)
Content-Type: multipart/mixed; boundary=Apple-Mail-6FC63F31-CDDD-4943-91FA-A493F7556C51
Content-Transfer-Encoding: 7bit
From:   =?utf-8?Q?PK_15_=F0=9F=8E=8B=F0=9F=8D=80=F0=9F=95=AF?=
         =?utf-8?Q?=E2=99=A5=EF=B8=8F?= <sanoocha@icloud.com>
Mime-Version: 1.0 (1.0)
Date:   Wed, 14 Oct 2020 13:43:47 +0700
Subject: CT_vcf
Message-Id: <E7A234AD-8CC3-4ED6-A006-A2C5F76700AD@icloud.com>
To:     sanoocha <sanoocha@yahoo.com>, O a <sorasicha@hotmail.com>,
        Accor Hotels <news.accorhotels@accor-mail.com>,
        =?utf-8?Q?
         "AJ._=E0=B8=9E=E0=B8=A3=E0=B8=A1=E0=B8=99=E0=B8=B1?=
        =?utf-8?Q?=E0=B8=AA" ?= <pss.nat@gmail.com>,
        Anekvich <anekvich@hotmail.com>,
        "anochanavankorn.co.th anocha@navankorn.co.th" 
        <anocha@navankorn.co.th>,
        "appleads_th@foodpanda.co.th" <appleads_th@foodpanda.co.th>,
        Amari Residences Bangkok - Reservations 
        <reservations.residencesbangkok@amari.com>,
        Billing <noreply@heroku.com>,
        Pang Bodog <pang.rachatawan@gmail.com>,
        Anne Bryce <annekerdlapphon@yahoo.com>,
        Callcontrol Support <support@callcontrol.com>,
        "Car Insurance and p.r.b" <waraphan@deves.co.th>,
        Cabin Online Continuing Care <aftercare@thecabin.com>,
        "cashiervcy@vichaiyut.com" <cashiervcy@vichaiyut.com>,
        Uncharee Chalamruk Chalamruk 
        <invite+kjdmi1_k-u-d@facebookmail.com>,
        Nuan Charurungsipong <pimsuda@mamata.com>,
        "citybankthailand@city.com" <citybankthailand@city.com>,
        The Empress Clinic <empressclinic@hotmail.com>,
        Reply to Comment 
        <g+43we7ia000zg40g8frg001s225k16j9001neojb6pyr1ob3o@groups.facebook.com>,
        Khun ding ding <apida@virgoart.co.th>,
        Pennae Engineering <pennae@outlook.com>,
        sanoocha2 GG <sanoocha2@gmail.com>, Git <git@vger.kernel.org>,
        P jae Its happens <oneroomonedog@hotmail.com>,
        Heroku <noreply@heroku.com>, mark hutten <mbhutten@yahoo.com>,
        MacPaw Inc <help@paddle.com>,
        "inkyjane@gmail.com" <inkyjane@gmail.com>,
        Saranda Intarasa <pooklook.n@gmail.com>,
        "IRDevelopment@set.or.th" <IRDevelopment@set.or.th>,
        k vee nv <veerapong_g@hotmail.com>,
        Khun Joom Netikul <nuttaput_press@hotmail.com>,
        Khun Top Netikul <bot_top@hotmail.com>,
        "komsorn@navanakorn.co.th" <komsorn@navanakorn.co.th>,
        Saovapak Kositkhun <sherryjerez@icloud.com>,
        Krungthai Card <onlineservice@ktc.co.th>,
        "ktb.netbank@ktb.co.th" <ktb.netbank@ktb.co.th>,
        "kunnika.2909@hotmail.com" <kunnika.2909@hotmail.com>,
        =?utf-8?B?4LiE4Li44LiT4Lie4Li14Lij4Lie4LiH4Lio4LmMIExhd3llcg==?= 
        <sangchunchai@gmail.com>,
        "list-management@unsubscribe.emailinboundprocessing.com" 
        <list-management@unsubscribe.emailinboundprocessing.com>,
        N pook ramkunhange <saranda.in@hotmail.com>,
        N Wut <sarawutn@kpmg.co.th>,
        "nakarinwahim@gmail.com" <nakarinwahim@gmail.com>,
        Nong Jane NaVa <pond_puk11@hotmail.com>,
        "netbank@ktb.co.th" <netbank@ktb.co.th>,
        "nipit@navanakorn.co.th" <nipit@navanakorn.co.th>,
        No Name <atchawadee@amityconsulting.net>,
        No Name <oraganya@hotmail.com>,
        "nuttaputt_press@hotmail.co.th" <nuttaputt_press@hotmail.co.th>,
        PayPal <service@intl.paypal.com>,
        Kunthida Petnaim <kunthida.p@bangkokinsurance.com>,
        "piano7007@gmail.com" <piano7007@gmail.com>,
        =?utf-8?Q?PK_15_=F0=9F=8E=8B=F0=9F=8D=80=F0=9F=95=AF?=
         =?utf-8?Q?=E2=99=A5=EF=B8=8F?= <sanoocha@icloud.com>,
        pon <kanokvibhap@ivglobal.co.th>,
        "pook.kornchanok@gmail.com" <pook.kornchanok@gmail.com>,
        "Chadthong Prapaipis (IS)" <Chadthong.P@kimeng.co.th>,
        K Pu <pu_vichittra@hotmail.com>,
        pun_pun <pun_pun19@hotmail.com>,
        "pun.pun1919@gmail.com" <pun.pun1919@gmail.com>,
        "ratvalee@set.or.th" <ratvalee@set.or.th>,
        "Pu Vijittra S." <puvijittra@hotmail.com>,
        "seller@payoneer.com" <seller@payoneer.com>,
        nond shaeennoi shaeennoi <maesheenoi@yahoo.com>,
        Siriporn Rattanamangkla <srp@wasotraining.com>,
        "subhavat@navankorn.co.th subhavat@navankorn.co.th" 
        <subhavat@navankorn.co.th>,
        "support@english-channel.tv" <support@english-channel.tv>,
        "support@statcounter.com" <support@statcounter.com>,
        The Facebook Team <info+0z6ii2@support.facebook.com>,
        Gmail Team <mail-noreply@google.com>,
        Thaiyogainsitute class <walapa_tyi@yahoo.com>,
        "toktakkung@hotmail.com" <toktakkung@hotmail.com>,
        "tuangtip1@yahoo.com" <tuangtip1@yahoo.com>,
        Unsubscribe <unsubscribe@post.pinterest.com>,
        VirusTotal <contact@virustotal.com>,
        "vitoon_press@hotmail.com" <vitoon_press@hotmail.com>,
        "voraratckv@gmail.com voraratckv@gmail.com" <voraratckv@gmail.com>,
        "warattada.meow@gmail.com" <warattada.meow@gmail.com>,
        Windows Live Team <communications@microsoft.windowslive.com>,
        Rachata Witunkolachit <cscoolingair@gmail.com>,
        "<RITA@set.or.th>" <RITA@set.or.th>,
        =?utf-8?B?4oia4oCgwqziiI/CrMO74oia4oCgwqziiI/CrMK14oia4oCgwqw=?=
         =?utf-8?B?z4DCrMOg4oia4oCgwqziiI/CrMO24oia4oCgwqziiI/CrOKIjw==?=
         =?utf-8?B?4oia4oCgwqziiI/CrMOv4oia4oCgwqziiI/CrMKjIOKImuKAoMKs?=
         =?utf-8?B?4oiPwqzDheKImuKAoMKs4oiPwqzDqeKImuKAoMKs4oiPwqzCtA==?=
         =?utf-8?B?4oia4oCgwqziiI/CrMKw4oia4oCgwqziiI/CrOKJpOKImuKAoMKs?=
         =?utf-8?B?4oiPwqzCog==?= <piyabuth@hotmail.com>,
        =?utf-8?B?4LiB4LmJ4Lit4LiiX+C4reC5guC4meC4iuC4si1HRw==?= 
        <sanoocha2@gmail.com>,
        =?utf-8?B?IuC4hOC4uOC4k+C4nuC4tOC4oeC4peC4nuC4seC4meC4mOC5jCA=?=
         =?utf-8?B?4LiB4Liy4Lij4LmA4LiH4Li04LiZIOC4o+C4ni7guIHguKPguLg=?=
         =?utf-8?B?4LiH4LmA4LiX4LieIg==?= <bmcopdcd@bangkokhospital.com>,
        =?utf-8?B?4LiE4Lij4Li54LmB4Lit4Lil?= <ellesirilak@gmail.com>,
        =?utf-8?B?4LiZ4LmJ4Lit4LiH4LiX4Lij4Liy4Lii?= 
        <tavarat1313@gmail.com>,
        =?utf-8?B?4Lie4Li14LmI4LiK4Liy4Lii4Lij4Li44LiI?= 
        <sirarujs@gmail.com>,
        =?utf-8?B?4Lie4Li14LmI4LmA4Lit4LiE4Li44LiT4LiV4LmJ4LiZ?= 
        <subhavat@navanakorn.co.th>,
        =?utf-8?B?4Lit4Lih4Lij4Liy4Lig4Lij4LiT4LmMIOC4reC4tOC4meC4lw==?=
         =?utf-8?B?4LiZ4Liy4LiE4Lih?= <aum.um.id@gmail.com>,
        Gmail1 <sanoocha1@gmail.com>
X-Mailer: iPhone Mail (18A393)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-14_03:2020-10-14,2020-10-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2010140045
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Apple-Mail-6FC63F31-CDDD-4943-91FA-A493F7556C51
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit




--Apple-Mail-6FC63F31-CDDD-4943-91FA-A493F7556C51
Content-Type: text/x-vcard;
	name="1104 Contacts.vcf";
	x-apple-part-url=DEF12D6C-452B-4367-A9EE-85B39FBAAF46
Content-Disposition: attachment;
	filename="1104 Contacts.vcf"
Content-Transfer-Encoding: quoted-printable

BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:a;O;;;=0D
FN:O a=0D
EMAIL;type=3DINTERNET;type=3Dpref:sorasicha@hotmail.com=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Acc 2;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0.=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AF=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=
=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3 Acc 2;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0.=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AF=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3 Acc 2 Acc 2=0D
TEL;type=3Dpref:098-825-3646=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Acc 2;=E0=B8=AD.=E0=B8=88=E0=B8=B4=E0=B8=95=E0=B8=A3=E0=B8=B2=E0=B8=9E=E0=B8=
=A3;;;=0D
FN:=E0=B8=AD.=E0=B8=88=E0=B8=B4=E0=B8=95=E0=B8=A3=E0=B8=B2=E0=B8=9E=E0=B8=A3=
 Acc 2=0D
TEL;type=3Dpref:098-825-3646=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Accor Hotels;;;=0D
FN:Accor Hotels=0D
EMAIL;type=3DINTERNET;type=3Dpref:news.accorhotels@accor-mail.com=0D
TEL;type=3DWORK;type=3DVOICE;type=3Dpref:800 221-4542=0D
X-SOCIALPROFILE;type=3DLINE;x-user=3D=E2=80=AD8002214542=E2=80=AC:x-apple:%E=
2%80%AD8002214542%E2%80%AC=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Aie Aot;;;=0D
FN:Aie Aot=0D
TEL;type=3Dpref:080-445-0555=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:air.;Anun;auto;;=0D
FN:Anun auto air.=0D
TEL;type=3DWORK;type=3DVOICE;type=3Dpref:0894582938=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Airport;;;=0D
FN:Airport=0D
TEL;type=3Dpref:+6621321888=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;AIS;;;=0D
FN:AIS=0D
TEL;type=3Dpref:1175=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;AJ Big;;;=0D
FN:AJ Big=0D
TEL;type=3Dpref:081-803-3803=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;AJ. =E0=B8=9E=E0=B8=A3=E0=B8=A1=E0=B8=99=E0=B8=B1=E0=B8=AA;;;=0D
FN:AJ. =E0=B8=9E=E0=B8=A3=E0=B8=A1=E0=B8=99=E0=B8=B1=E0=B8=AA=0D
EMAIL;type=3DINTERNET;type=3Dpref:pss.nat@gmail.com=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:081-907-7638=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Ake =E0=B8=AA=E0=B8=A3=E0=B8=B5=E0=B8=A7=E0=B8=B4=E0=B8=97;;;=0D
FN:Ake =E0=B8=AA=E0=B8=A3=E0=B8=B5=E0=B8=A7=E0=B8=B4=E0=B8=97=0D
TEL;type=3Dpref:0841188555=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Anekvich;;;=0D
FN:Anekvich=0D
EMAIL;type=3DINTERNET;type=3Dpref:anekvich@hotmail.com=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Ann Piyarat;;;=0D
FN:Ann Piyarat=0D
TEL;type=3Dpref:089-896-6142=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Anne Marshr;;;=0D
FN:Anne Marshr=0D
TEL;type=3Dpref:088-871-4266=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Anne;P;tuii P;;=0D
FN:P tuii P Anne=0D
TEL;type=3Dpref:0860350395=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Anne;P;;;=0D
FN:P Anne=0D
TEL;type=3Dpref:0818376242=0D
X-SOCIALPROFILE;type=3DLINE;x-user=3D=E2=80=AD081-837-6242=E2=80=AC:x-apple:=
%E2%80%AD081-837-6242%E2%80%AC=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Anne;P Anne;;;=0D
FN:P Anne Anne=0D
TEL;type=3Dpref:0818376242=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Anne;P Anne;tuii P;;=0D
FN:P Anne tuii P Anne=0D
TEL;type=3Dpref:0860350395=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Anocha;Koi;;;=0D
FN:Koi Anocha=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:anocha@navankorn.co.th;anochanavankorn.co.th;;;=0D
FN:anochanavankorn.co.th anocha@navankorn.co.th=0D
EMAIL;type=3DINTERNET;type=3Dpref:anocha@navankorn.co.th=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Aott JL;;;=0D
FN:Aott JL=0D
TEL;type=3Dpref:081-555-1551=0D
TEL:095-991-4246=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Api;Chade;;;=0D
FN:Chade Api=0D
TEL;type=3DWORK;type=3DVOICE;type=3Dpref:0818483388=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Apple Hotline Thailand;;;=0D
FN:Apple Hotline Thailand=0D
TEL;type=3DWORK;type=3DFAX;type=3Dpref:001 800 656957=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:appleads_th@foodpanda.co.th;;;;=0D
FN:appleads_th@foodpanda.co.th=0D
EMAIL;type=3DINTERNET;type=3Dpref:appleads_th@foodpanda.co.th=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Aree Garden;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=
=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=80=A2=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2 Pennae=
 Floral Aree Garden;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=CF=80=
=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=80=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2 Pennae Floral Aree=
 Garden Aree Garden=0D
TEL;type=3Dpref:081-486-2534=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Aree Garden;=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B8=9E=E0=B8=A5=E0=B8=AD=
=E0=B8=A2 Pennae Floral;;;=0D
FN:=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B8=9E=E0=B8=A5=E0=B8=AD=E0=B8=A2 P=
ennae Floral Aree Garden=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:081-486-2534=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Art;;;=0D
FN:Art=0D
TEL;type=3Dpref:0814499111=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Ashtanga Yoga Bkk;;;=0D
FN:Ashtanga Yoga Bkk=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:082-011-1433=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Asia Book;;;=0D
FN:Asia Book=0D
ORG:Fahsion Iceland;=0D
TEL;type=3Dpref:02-947-5629=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Asia Book Fahsion Iceland;;;=0D
FN:Asia Book Fahsion Iceland=0D
ORG:Fahsion Iceland;=0D
TEL;type=3Dpref:02-947-5629=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:assistant;R;jooe;;=0D
FN:R jooe assistant=0D
TEL;type=3Dpref:0818376154=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Au;P;;;=0D
FN:P Au=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:0814993177=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Au;P Au;;;=0D
FN:P Au Au=0D
TEL;type=3Dpref:081-499-3177=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Ayudhaya;Piano;Phungbun Na;;=0D
FN:Piano Phungbun Na Ayudhaya=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:081-831-6612=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:BabyPowder;Pammy;Tayanee;;=0D
FN:Pammy Tayanee BabyPowder=0D
TEL;type=3Dpref:090-964-4456=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Balance;;;=0D
FN:Balance=0D
TEL;type=3Dpref:#123#=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Bangkok - Reservations;Amari;Residences;;=0D
FN:Amari Residences Bangkok - Reservations=0D
EMAIL;type=3DINTERNET;type=3Dpref:reservations.residencesbangkok@amari.com=0D=

END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Bau Sirithapin;;;=0D
FN:Bau Sirithapin=0D
TEL;type=3Dpref:081-848-6333=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:bee;Kru;;;=0D
FN:Kru bee=0D
TEL;type=3Dpref:081-551-7005=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:bee;Kru bee;;;=0D
FN:Kru bee bee=0D
TEL;type=3Dpref:081-551-7005=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Belle;;;=0D
FN:Belle=0D
TEL;type=3Dpref:0869935577=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Belle New;;;=0D
FN:Belle New=0D
TEL;type=3Dpref:0619289646=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Bhooanusas;Nuntanij =E0=B8=AB=E0=B8=A1=E0=B8=AD=E0=B8=9F=E0=B9=89=E0=B8=B2=
;;;=0D
FN:Nuntanij =E0=B8=AB=E0=B8=A1=E0=B8=AD=E0=B8=9F=E0=B9=89=E0=B8=B2 Bhooanusa=
s=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:099-232-3566=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Big;;;=0D
FN:Big=0D
TEL;type=3Dpref:+66818033803=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Billing;;;=0D
FN:Billing=0D
EMAIL;type=3DINTERNET;type=3Dpref:noreply@heroku.com=0D
EMAIL;type=3DINTERNET:billing@heroku.com=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Bird;Blue;;;=0D
FN:Blue Bird=0D
TEL;type=3Dpref:02075591140=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Bodog;Pang;;;=0D
FN:Pang Bodog=0D
EMAIL;type=3DINTERNET;type=3Dpref:pang.rachatawan@gmail.com=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:081-454-5494=0D
TEL:0813550636=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:bonm;P;Tok;;=0D
FN:P Tok bonm=0D
TEL;type=3Dpref:0818357344=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:bonm;P bonm;Tok;;=0D
FN:P bonm Tok bonm=0D
TEL;type=3Dpref:0818357344=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Boonrucksatrakun;Pairoj;;;=0D
FN:Pairoj Boonrucksatrakun=0D
TEL;type=3Dpref:0814496565=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Brio Clinic;;;=0D
FN:Brio Clinic=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:092-383-1771=0D
TEL:02-656-1908=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Brio;Dr. =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B3=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=
=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=CF=80=
=C2=AC=C3=A5 Brio;;;=0D
FN:Dr. =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B3=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=
=AC=C3=A5 Brio Brio=0D
TEL;type=3Dpref:084-659-9393=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Brio;Dr. =E0=B8=9E=E0=B8=A3=E0=B8=97=E0=B8=B4=E0=B8=9E=E0=B8=A2=E0=B9=8C;;=
;=0D
FN:Dr. =E0=B8=9E=E0=B8=A3=E0=B8=97=E0=B8=B4=E0=B8=9E=E0=B8=A2=E0=B9=8C Brio=0D=

TEL;type=3DCELL;type=3DVOICE;type=3Dpref:084-659-9393=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Bryce;Anne;;;=0D
FN:Anne Bryce=0D
item1.EMAIL;type=3DINTERNET;type=3Dpref:annekerdlapphon@yahoo.com=0D
item1.X-ABLabel:_%2524%2521%253COther%253E%2521%2524_=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Bua 54;;;=0D
FN:Bua 54=0D
TEL;type=3Dpref:086-549-9454=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Bua Pattamon;;;=0D
FN:Bua Pattamon=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:+66894454555=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Bua Siri;;;=0D
FN:Bua Siri=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:+66 0 86-549-9454=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Bua Siri;;;=0D
FN:Bua Siri=0D
TEL;type=3Dpref:+66 0 86-549-9454=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Bug;;;=0D
FN:Bug=0D
TEL;type=3Dpref:1113=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Bunnag;Khim;;;=0D
FN:Khim Bunnag=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:081-841-7999=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:C;Sumana;;;=0D
FN:Sumana C=0D
TEL;type=3Dpref:081-911-6922=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Calee;;;=0D
FN:Calee=0D
TEL;type=3Dpref:0816438707=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Call Center;.AIS;;;=0D
FN:.AIS Call Center=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:1175=0D
item1.URL;type=3Dpref:ms-outlook://people/AQMkAGM4YzkwMAItMjM5OC01OTU4LTAwAi=
0wMAoARgAAA4lPVhdeXgB8SKotnuI_8RfOBwDiulGfBVPESL-9FOXxou_fAAACAQ4AAADiulGfBV=
PESL-9FOXxou_fAAAAJCOruAAAAA=3D=3D?accountKey=3Dfbcfd54b16181902db402212ea7f=
a1a5&accountExportedAt=3D549396167.507626=0D
item1.X-ABLabel:Outlook=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:call center;dtac;;;=0D
FN:dtac call center=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:1678=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:call center;dtac call center;;;=0D
FN:dtac call center call center=0D
TEL;type=3Dpref:1678=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;CallCenter;;;=0D
FN:CallCenter=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:+66891001331=0D
TEL;type=3DWORK;type=3DVOICE:1678=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Callcontrol Support;;;=0D
FN:Callcontrol Support=0D
EMAIL;type=3DINTERNET;type=3Dpref:support@callcontrol.com=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Car Insurance and p.r.b;;;=0D
FN:Car Insurance and p.r.b=0D
EMAIL;type=3DINTERNET;type=3Dpref:waraphan@deves.co.th=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:care.;aey;skin;Dr;=0D
FN:Dr aey skin care.=0D
TEL;type=3Dpref:0815704883=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:care.;aey care.;skin;Dr;=0D
FN:Dr aey care. skin care.=0D
TEL;type=3Dpref:0815704883=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Care;Cabin;Online Continuing;;=0D
FN:Cabin Online Continuing Care=0D
EMAIL;type=3DINTERNET;type=3Dpref:aftercare@thecabin.com=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:care.;Clinic =E0=B8=AB=E0=B8=A1=E0=B8=AD=E0=B8=88=E0=B8=A3=E0=B8=B4=E0=B8=A2=
=E0=B8=B2;;;=0D
FN:Clinic =E0=B8=AB=E0=B8=A1=E0=B8=AD=E0=B8=88=E0=B8=A3=E0=B8=B4=E0=B8=A2=E0=
=B8=B2 care.=0D
TEL;type=3DWORK;type=3DVOICE;type=3Dpref:026151914=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:cashiervcy@vichaiyut.com;;;;=0D
FN:cashiervcy@vichaiyut.com=0D
EMAIL;type=3DINTERNET;type=3Dpref:cashiervcy@vichaiyut.com=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:cats.;Auum.;My;Dr.;=0D
FN:Dr. Auum. My cats.=0D
TEL;type=3Dpref:0816571705=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:cats.;Auum. cats.;My;Dr.;=0D
FN:Dr. Auum. cats. My cats.=0D
TEL;type=3Dpref:0816571705=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Central East.;Melatonin Shop;;;=0D
FN:Melatonin Shop Central East.=0D
TEL;type=3Dpref:0813759824=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Central EW;Vergin Finess Club;;;=0D
FN:Vergin Finess Club Central EW=0D
TEL;type=3Dpref:020179755=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Centre;Holistic-medical;;;=0D
FN:Holistic-medical Centre=0D
TEL;type=3Dpref:081-399-8545=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Chalamruk;Uncharee Chalamruk;;;=0D
FN:Uncharee Chalamruk Chalamruk=0D
EMAIL;type=3DINTERNET;type=3Dpref:invite+kjdmi1_k-u-d@facebookmail.com=0D
TEL;type=3DWORK;type=3DVOICE;type=3Dpref:650 543-4800=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;chalee;;;=0D
FN:chalee=0D
TEL;type=3Dpref:081-643-8707=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;ChangePro;;;=0D
FN:ChangePro=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:9305=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Charurungsipong;Nuan;;;=0D
FN:Nuan Charurungsipong=0D
EMAIL;type=3DINTERNET;type=3Dpref:pimsuda@mamata.com=0D
EMAIL;type=3DINTERNET:varakorn@amata.com=0D
EMAIL;type=3DINTERNET:vikrom@amata.com=0D
EMAIL;type=3DINTERNET:https://www.facebook.com/VikromKromadit/=0D
TEL;type=3DWORK;type=3DVOICE;type=3Dpref:02-790-007=0D
TEL;type=3DCELL;type=3DVOICE:086-806-2007=0D
TEL;type=3DWORK;type=3DVOICE:02-709-0007=0D
TEL;type=3DCELL;type=3DVOICE:081-806-0007=0D
TEL;type=3DHOME;type=3DVOICE:027920007=0D
TEL;type=3DCELL;type=3DVOICE:086-666-2007=0D
TEL;type=3DCELL;type=3DVOICE:086-662-0007=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Checkbill;;;=0D
FN:Checkbill=0D
TEL;type=3Dpref:*9399=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Checkpromo;;;=0D
FN:Checkpromo=0D
TEL;type=3Dpref:*9399=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:chinnavorn.;Khnu;r;;=0D
FN:Khnu r chinnavorn.=0D
TEL;type=3Dpref:0818897555=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:chinnavorn.;Khnu chinnavorn.;r;;=0D
FN:Khnu chinnavorn. r chinnavorn.=0D
TEL;type=3Dpref:0818897555=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;City Bank CC;;;=0D
FN:City Bank CC=0D
TEL;type=3Dpref:022322484=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;City Care Center;;;=0D
FN:City Care Center=0D
TEL;type=3Dpref:089-921-3056=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:citybankthailand@city.com;;;;=0D
FN:citybankthailand@city.com=0D
EMAIL;type=3DINTERNET;type=3Dpref:citybankthailand@city.com=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Cleaning;Khun Aoon 3M;;;=0D
FN:Khun Aoon 3M Cleaning=0D
TEL;type=3Dpref:029148984=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Cleaning;Khun Aoon 3M Cleaning;;;=0D
FN:Khun Aoon 3M Cleaning Cleaning=0D
TEL;type=3Dpref:029148984=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Cleleb Nail Bar;;;=0D
FN:Cleleb Nail Bar=0D
TEL;type=3Dpref:02-515-0552=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Clinic Care;;;=0D
FN:Clinic Care=0D
TEL;type=3Dpref:02-615-1419=0D
TEL:02-615-1914=0D
TEL:087-615-1914=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:clinic.;Kamon;;Dr.;=0D
FN:Dr. Kamon clinic.=0D
TEL;type=3DWORK;type=3DVOICE;type=3Dpref:026693147=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Clinic;The Empress;;;=0D
FN:The Empress Clinic=0D
ORG:The Empress Clinic;=0D
EMAIL;type=3DINTERNET;type=3Dpref:empressclinic@hotmail.com=0D
TEL;type=3Dpref:095-446-5669=0D
item1.ADR;type=3Dpref:;;Plearnary Mall F.2 Zone A;;;;=0D
item1.X-ABLabel:Home=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Clinic =E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B3=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A5=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C3=A7 Plastic Sur.;;;=0D
FN:Clinic =E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B3=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A5=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C3=A7 Plastic Sur.=0D
ORG:Plastic Sur.;=0D
TEL;type=3Dpref:022603932=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Clinic =E0=B9=81=E0=B8=9E=E0=B8=97=E0=B8=A2=E0=B9=8C=E0=B8=88=E0=B8=A3=E0=
=B8=B1=E0=B8=8D;;;=0D
FN:Clinic =E0=B9=81=E0=B8=9E=E0=B8=97=E0=B8=A2=E0=B9=8C=E0=B8=88=E0=B8=A3=E0=
=B8=B1=E0=B8=8D=0D
ORG:Plastic Sur.;=0D
TEL;type=3Dpref:022603932=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Club;Chik;;;=0D
FN:Chik Club=0D
TEL;type=3Dpref:026584147=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Club;Chik Club;;;=0D
FN:Chik Club Club=0D
TEL;type=3Dpref:026584147=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Comment;Reply;to;;=0D
FN:Reply to Comment=0D
EMAIL;type=3DINTERNET;type=3Dpref:g+43we7ia000zg40g8frg001s225k16j9001neojb6=
pyr1ob3o@groups.facebook.com=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Commercial;Scb;Siam;;=0D
FN:Scb Siam Commercial=0D
TEL;type=3Dpref:02-777-7777=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Contract numbers;;Contract numbers;=0D
FN:Contract numbers Contract numbers=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:cop.;R;Somchai;;=0D
FN:R Somchai cop.=0D
TEL;type=3Dpref:0899251111=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:cop.;R cop.;Somchai;;=0D
FN:R cop. Somchai cop.=0D
TEL;type=3Dpref:0899251111=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Crosley;Lisa;;;=0D
FN:Lisa Crosley=0D
TEL;type=3Dpref:66833003151=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Crystal Pet;;;=0D
FN:Crystal Pet=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:02-944-4788=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Crytal Dentist;;;=0D
FN:Crytal Dentist=0D
TEL;type=3Dpref:081-466-5640=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Crytal Park;Asia Book;;;=0D
FN:Asia Book Crytal Park=0D
TEL;type=3Dpref:02-515-0940=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Crytal Pet New 2;;;=0D
FN:Crytal Pet New 2=0D
TEL;type=3Dpref:0632276969=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:dad;P;Chai;;=0D
FN:P Chai dad=0D
TEL;type=3Dpref:0819410173=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:dad;P dad;Chai;;=0D
FN:P dad Chai dad=0D
TEL;type=3Dpref:0819410173=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Daddy =F0=9F=92=95;;;=0D
FN:Daddy =F0=9F=92=95=0D
TEL;type=3Dpref:095-737-0336=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:daddy;Nonh;ohh;;=0D
FN:Nonh ohh daddy=0D
TEL;type=3Dpref:0894876424=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Daddy =E2=88=9A=E2=88=9E=C2=AC=C3=BC=C2=AC=C3=AD=C2=AC=C3=AF;;;=0D
FN:Daddy =E2=88=9A=E2=88=9E=C2=AC=C3=BC=C2=AC=C3=AD=C2=AC=C3=AF=0D
TEL;type=3Dpref:095-737-0336=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:dang;Nuu;;;=0D
FN:Nuu dang=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:0816599333=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:dang;Nuu dang;;;=0D
FN:Nuu dang dang=0D
TEL;type=3Dpref:0816599333=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Dc.;Earth;;;=0D
FN:Earth Dc.=0D
TEL;type=3Dpref:0819050345=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Dc.;Earth Dc.;;;=0D
FN:Earth Dc. Dc.=0D
TEL;type=3Dpref:0819050345=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:DC.;PA;Noom earth;;=0D
FN:PA Noom earth DC.=0D
TEL;type=3Dpref:0846498964=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:DC.;PA DC.;Noom earth;;=0D
FN:PA DC. Noom earth DC.=0D
TEL;type=3Dpref:0846498964=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;DD=F0=9F=8D=80=E2=9C=A8=E2=99=A5=EF=B8=8F;;;=0D
FN:DD=F0=9F=8D=80=E2=9C=A8=E2=99=A5=EF=B8=8F=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:0819288888=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Dee 96;;;=0D
FN:Dee 96=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:0809696966=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Devahastin;Panitee;;;=0D
FN:Panitee Devahastin=0D
TEL;type=3DWORK;type=3DVOICE;type=3Dpref:66894294646=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:diary;K;dow;;=0D
FN:K dow diary=0D
TEL;type=3Dpref:0867776500=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:diary;K diary;dow;;=0D
FN:K diary dow diary=0D
TEL;type=3Dpref:0867776500=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:ding;Khun ding;;;=0D
FN:Khun ding ding=0D
EMAIL;type=3DINTERNET;type=3Dpref:apida@virgoart.co.th=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Directory;;;=0D
FN:Directory=0D
TEL;type=3Dpref:1133=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Divive Yoga;;;=0D
FN:Divive Yoga=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:02-712-7100=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:dolly;P;gai p;;=0D
FN:P gai p dolly=0D
TEL;type=3Dpref:+66818528677=0D
TEL:081-822-1158=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:dolly;P dolly;gai p;;=0D
FN:P dolly gai p dolly=0D
TEL;type=3Dpref:081-822-1158=0D
TEL:+66818528677=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Dr.2 Crytal Pet;;;=0D
FN:Dr.2 Crytal Pet=0D
TEL;type=3Dpref:082-559-6969=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Dr Anekvich;;;=0D
FN:Dr Anekvich=0D
TEL;type=3Dpref:0816566587=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Dr Kamon;;;=0D
FN:Dr Kamon=0D
TEL;type=3Dpref:081-657-1877=0D
TEL:081-657-1705=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Dr. =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B3=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=
=AC=C3=A5;;;=0D
FN:Dr. =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B3=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=
=AC=C3=A5=0D
TEL;type=3Dpref:094-068-4080=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Dr. =E0=B8=9E=E0=B8=A3=E0=B8=97=E0=B8=B4=E0=B8=9E=E0=B8=A2=E0=B9=8C;;;=0D=

FN:Dr. =E0=B8=9E=E0=B8=A3=E0=B8=97=E0=B8=B4=E0=B8=9E=E0=B8=A2=E0=B9=8C=0D
TEL;type=3Dpref:094-068-4080=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Dr =E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=81=E0=B8=A4=E0=B8=95;;;=0D
FN:Dr =E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=81=E0=B8=A4=E0=B8=95=0D
TEL;type=3Dpref:093-635-6556=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Dr =E0=B8=AA=E0=B8=B8=E0=B8=9E=E0=B8=88=E0=B8=99=E0=B9=8C =E0=B8=A3=E0=B8=
=9E.=E0=B8=A2=E0=B8=B1=E0=B8=99=E0=B8=AE=E0=B8=B5;;;=0D
FN:Dr =E0=B8=AA=E0=B8=B8=E0=B8=9E=E0=B8=88=E0=B8=99=E0=B9=8C =E0=B8=A3=E0=B8=
=9E.=E0=B8=A2=E0=B8=B1=E0=B8=99=E0=B8=AE=E0=B8=B5=0D
TEL;type=3Dpref:081-832-8116=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;E Jim;;;=0D
FN:E Jim=0D
TEL;type=3Dpref:086-329-5599=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;E Khopthong NEW;;;=0D
FN:E Khopthong NEW=0D
TEL;type=3Dpref:+66996655624=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;E Mon New;;;=0D
FN:E Mon New=0D
TEL;type=3Dpref:086-651-9566=0D
X-SOCIALPROFILE;type=3DLINE;x-user=3D086-651-9566:x-apple:086-651-9566=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;E Nam;;;=0D
FN:E Nam=0D
TEL;type=3Dpref:081-717-8778=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;E Sang;;;=0D
FN:E Sang=0D
TEL;type=3Dpref:081-497-8904=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Eam;Praew;;;=0D
FN:Praew Eam=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:082-441-5651=0D
TEL:0818022345=0D
X-SOCIALPROFILE;x-user=3D_dbhp1VyrgeWoupdfs18LdaRgjU53w5rsZJokA4E:x-apple:_d=
bhp1VyrgeWoupdfs18LdaRgjU53w5rsZJokA4E=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Earth;;;=0D
FN:Earth=0D
TEL;type=3Dpref:081-816-4181=0D
TEL:+841267274975=0D
TEL:092-556-9131=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Earth Dc14;;;=0D
FN:Earth Dc14=0D
TEL;type=3Dpref:+669-8747-4181=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Eath;;;=0D
FN:Eath=0D
TEL;type=3Dpref:0819050345=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Eath.;;;=0D
FN:Eath.=0D
TEL;type=3Dpref:0819050345=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Eath;Ja;;;=0D
FN:Ja Eath=0D
TEL;type=3Dpref:0868855594=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Eath1;;;=0D
FN:Eath1=0D
TEL;type=3Dpref:0819050345=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;EDee;;;=0D
FN:EDee=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:080-969-6966=0D
TEL;type=3DWORK;type=3DVOICE:086-773-4444=0D
TEL;type=3DCELL;type=3DVOICE:086-959-9559=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:EK;P;;;=0D
FN:P EK=0D
TEL;type=3Dpref:0813088999=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:EK;P EK;;;=0D
FN:P EK EK=0D
TEL;type=3Dpref:0813088999=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Engineering;Pennae;;;=0D
FN:Pennae Engineering=0D
EMAIL;type=3DINTERNET;type=3Dpref:pennae@outlook.com=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Feel =E0=B8=9E=E0=B8=B5=E0=B8=A5=E0=B8=B2=E0=B8=97=E0=B8=B5=E0=B8=AA;;;=0D=

FN:Feel =E0=B8=9E=E0=B8=B5=E0=B8=A5=E0=B8=B2=E0=B8=97=E0=B8=B5=E0=B8=AA=0D
TEL;type=3Dpref:02-652-2526=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:flow;K;Sud;;=0D
FN:K Sud flow=0D
TEL;type=3Dpref:0897770895=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:flow;K flow;Sud;;=0D
FN:K flow Sud flow=0D
TEL;type=3Dpref:0897770895=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:GG;sanoocha2;;;=0D
FN:sanoocha2 GG=0D
item1.EMAIL;type=3DINTERNET;type=3Dpref:sanoocha2@gmail.com=0D
item1.X-ABLabel:_%2524%2521%253COther%253E%2521%2524_=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Gipgip 14;;;=0D
FN:Gipgip 14=0D
TEL;type=3Dpref:089-415-5514=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Git;;;=0D
FN:Git=0D
EMAIL;type=3DINTERNET;type=3Dpref:git@vger.kernel.org=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Goft messenger;;;=0D
FN:Goft messenger=0D
TEL;type=3Dpref:0973217424=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Grandmom;;;=0D
FN:Grandmom=0D
TEL;type=3DWORK;type=3DVOICE;type=3Dpref:022433270=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:h.;Mom;Tim;;=0D
FN:Mom Tim h.=0D
TEL;type=3Dpref:022611941=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:h.;Mom h.;Tim;;=0D
FN:Mom h. Tim h.=0D
TEL;type=3Dpref:022611941=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:H.;Nong;;;=0D
FN:Nong H.=0D
TEL;type=3DWORK;type=3DVOICE;type=3Dpref:0846959655=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:h;P;Prapad;;=0D
FN:P Prapad h=0D
TEL;type=3DWORK;type=3DVOICE;type=3Dpref:0865150258=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:h.;R;Aoy;;=0D
FN:R Aoy h.=0D
TEL;type=3Dpref:0891733339=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:h.;R;Auy;;=0D
FN:R Auy h.=0D
TEL;type=3Dpref:0818743224=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:h.;R h.;Aoy;;=0D
FN:R h. Aoy h.=0D
TEL;type=3Dpref:0891733339=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:h.;R h.;Auy;;=0D
FN:R h. Auy h.=0D
TEL;type=3Dpref:0818743224=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:H.;Salin;;;=0D
FN:Salin H.=0D
TEL;type=3Dpref:026691750=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:H.;Salin H.;;;=0D
FN:Salin H. H.=0D
TEL;type=3Dpref:026691750=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:H.;Sompong;;;=0D
FN:Sompong H.=0D
TEL;type=3Dpref:0841227406=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:H.;Yui;;;=0D
FN:Yui H.=0D
TEL;type=3Dpref:022433325=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:H.;Yui H.;;;=0D
FN:Yui H. H.=0D
TEL;type=3Dpref:022433325=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Hair;P;Noy;;=0D
FN:P Noy Hair=0D
TEL;type=3DWORK;type=3DVOICE;type=3Dpref:0819194443=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Happen;Its;;;=0D
FN:Its Happen=0D
TEL;type=3Dpref:66815652028=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Happen;Its Happen;;;=0D
FN:Its Happen Happen=0D
TEL;type=3Dpref:66815652028=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:happens;P;jae Its;;=0D
FN:P jae Its happens=0D
EMAIL;type=3DINTERNET;type=3Dpref:oneroomonedog@hotmail.com=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Harnpongthum;Kobthong;;;=0D
FN:Kobthong Harnpongthum=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:095-545-4154=0D
TEL;type=3DHOME;type=3DVOICE:098-965-9282=0D
TEL;type=3DCELL;type=3DVOICE:+668-9770-6969=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;HealthEmer;;;=0D
FN:HealthEmer=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:1669=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Heroku;;;=0D
FN:Heroku=0D
EMAIL;type=3DINTERNET;type=3Dpref:noreply@heroku.com=0D
EMAIL;type=3DINTERNET:communications@heroku.com=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:HMC;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B9=84=E0=B8=81=E0=B8=94=E0=B9=8C;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B9=84=E0=B8=81=E0=B8=94=E0=B9=8C HMC=0D
TEL;type=3Dpref:0979824541=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Ho;Manarom;;;=0D
FN:Manarom Ho=0D
TEL;type=3Dpref:027259595=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Ho;Manarom Ho;;;=0D
FN:Manarom Ho Ho=0D
TEL;type=3Dpref:027259595=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;holistic.;;;=0D
FN:holistic.=0D
TEL;type=3Dpref:081-399-8545=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Holistic Yoga;;;=0D
FN:Holistic Yoga=0D
TEL;type=3Dpref:085-484-6836=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Holostic Call Center;;;=0D
FN:Holostic Call Center=0D
TEL;type=3Dpref:02-640-8090=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Holostic Medical Center;;;=0D
FN:Holostic Medical Center=0D
TEL;type=3Dpref:089-798-0558=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:HospItal.;Pra;MongKut;;=0D
FN:Pra MongKut HospItal.=0D
TEL;type=3Dpref:023547711=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:HospItal.;Pra HospItal.;MongKut;;=0D
FN:Pra HospItal. MongKut HospItal.=0D
TEL;type=3Dpref:023547711=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:hospital.;Tong;dam;;=0D
FN:Tong dam hospital.=0D
TEL;type=3DWORK;type=3DVOICE;type=3Dpref:029498615=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:hutten;mark;;;=0D
FN:mark hutten=0D
EMAIL;type=3DINTERNET;type=3Dpref:mbhutten@yahoo.com=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Iampongsai;Look;;;=0D
FN:Look Iampongsai=0D
TEL;type=3Dpref:081-811-1333=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;iMac;;;=0D
FN:iMac=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;IMedic;;;=0D
FN:IMedic=0D
TEL;type=3Dpref:02-955-5718=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Imigration;;;=0D
FN:Imigration=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:1178=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Inc;MacPaw;;;=0D
FN:MacPaw Inc=0D
EMAIL;type=3DINTERNET;type=3Dpref:help@paddle.com=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Index Man =E0=B8=8B=E0=B8=B1=E0=B8=81=E0=B8=9C=E0=B9=89=E0=B8=B2=E0=B9=80=
=E0=B8=84=E0=B8=A3=E0=B8=B7=E0=B9=88=E0=B8=AD=E0=B8=87;;;=0D
FN:Index Man =E0=B8=8B=E0=B8=B1=E0=B8=81=E0=B8=9C=E0=B9=89=E0=B8=B2=E0=B9=80=
=E0=B8=84=E0=B8=A3=E0=B8=B7=E0=B9=88=E0=B8=AD=E0=B8=87=0D
TEL;type=3Dpref:0614090908=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Info;Bill;;;=0D
FN:Bill Info=0D
TEL;type=3Dpref:*121#=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Info;Fun;;;=0D
FN:Fun Info=0D
TEL;type=3Dpref:*7474=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:inkyjane@gmail.com;;;;=0D
FN:inkyjane@gmail.com=0D
EMAIL;type=3DINTERNET;type=3Dpref:inkyjane@gmail.com=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Intanakom;Amaraporn;;;=0D
FN:Amaraporn Intanakom=0D
TEL;type=3Dpref:091-094-6426=0D
TEL:0632032684=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Intanakom;Amaraporn Intanakom;;;=0D
FN:Amaraporn Intanakom Intanakom=0D
TEL;type=3Dpref:091-094-6426=0D
TEL:0632032684=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Intarasa;Saranda;;;=0D
FN:Saranda Intarasa=0D
EMAIL;type=3DINTERNET;type=3Dpref:pooklook.n@gmail.com=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:IRDevelopment@set.or.th;;;;=0D
FN:IRDevelopment@set.or.th=0D
EMAIL;type=3DINTERNET;type=3Dpref:IRDevelopment@set.or.th=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:It-Slow;Patt;;;=0D
FN:Patt It-Slow=0D
TEL;type=3Dpref:081-845-5449=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;iVoice;;;=0D
FN:iVoice=0D
TEL;type=3Dpref:*4952=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;J =E0=B9=81=E0=B8=9F=E0=B8=99;;;=0D
FN:J =E0=B9=81=E0=B8=9F=E0=B8=99=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:084-656-9337=0D
X-SOCIALPROFILE;type=3DLINE;x-user=3D=E2=80=AD084-656-9337=E2=80=AC:x-apple:=
%E2%80%AD084-656-9337%E2%80%AC=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Ja RB;;;=0D
FN:Ja RB=0D
TEL;type=3Dpref:087-517-1282=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Jakusii Pizza;;;=0D
FN:Jakusii Pizza=0D
TEL;type=3Dpref:0909901190=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Jan;P;;;=0D
FN:P Jan=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:081-303-8696=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Janadhip;Bom;;;=0D
FN:Bom Janadhip=0D
TEL;type=3Dpref:081-812-9924=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Janenich;;;=0D
FN:Janenich=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:088-788-6558=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Janet New;;;=0D
FN:Janet New=0D
TEL;type=3Dpref:092-789-3242=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Janet New 2;;;=0D
FN:Janet New 2=0D
TEL;type=3Dpref:0843995397=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Jeedz;N Jeaw J;;;=0D
FN:N Jeaw J Jeedz=0D
TEL;type=3Dpref:0818258853=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Jeedz;N Jeaw J Jeedz;;;=0D
FN:N Jeaw J Jeedz Jeedz=0D
TEL;type=3Dpref:0818258853=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Jeedz;N Jewaw J;;;=0D
FN:N Jewaw J Jeedz=0D
TEL;type=3Dpref:081-825-8853=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Jerd;P;;;=0D
FN:P Jerd=0D
TEL;type=3Dpref:0817324724=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Jerd;P Jerd;;;=0D
FN:P Jerd Jerd=0D
TEL;type=3Dpref:0817324724=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:jin;P;;;=0D
FN:P jin=0D
TEL;type=3Dpref:0818437890=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:jin;P jin;;;=0D
FN:P jin jin=0D
TEL;type=3Dpref:0818437890=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Jip-Ying;;;=0D
FN:Jip-Ying=0D
TEL;type=3Dpref:081-402-0505=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Joe-=E0=B9=80=E0=B8=88;;;=0D
FN:Joe-=E0=B9=80=E0=B8=88=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:084-656-9337=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Joom;Nuttaputt;;;=0D
FN:Nuttaputt Joom=0D
ORG:Natikul Printing company;=0D
TEL;type=3Dpref:0898888777=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Joy E Mon;;;=0D
FN:Joy E Mon=0D
TEL;type=3Dpref:+66853446481=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Jub;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=E2=89=A4 Jub;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=E2=89=A4 Jub Jub=0D
TEL;type=3Dpref:0818432222=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Jub;=E0=B8=AD=E0=B8=B2;;;=0D
FN:=E0=B8=AD=E0=B8=B2 Jub=0D
TEL;type=3Dpref:0818432222=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Jung;Joy;;;=0D
FN:Joy Jung=0D
TEL;type=3Dpref:+66853446481=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Jup;Mom;;;=0D
FN:Mom Jup=0D
TEL;type=3Dpref:0818296222=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Jup;Mom Jup;;;=0D
FN:Mom Jup Jup=0D
TEL;type=3Dpref:0818296222=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:K.;Home;;;=0D
FN:Home K.=0D
TEL;type=3Dpref:025198229=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:K.;Home K.;;;=0D
FN:Home K. K.=0D
TEL;type=3Dpref:025198229=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;K Mai Vichivut;;;=0D
FN:K Mai Vichivut=0D
TEL;type=3Dpref:0845351146=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;K Mic;;;=0D
FN:K Mic=0D
ORG:We Signature Fitnees;=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:086-757-2335=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;K Nuch P =E0=B8=9A=E0=B8=B8=E0=B9=8B=E0=B8=A1;;;=0D
FN:K Nuch P =E0=B8=9A=E0=B8=B8=E0=B9=8B=E0=B8=A1=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:0849215529=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;K R Tony 11;;;=0D
FN:K R Tony 11=0D
TEL;type=3Dpref:086-511-1111=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;K. SAM yoga;;;=0D
FN:K. SAM yoga=0D
TEL;type=3Dpref:089-488-0414=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:K Suvit;K Suvit;;;=0D
FN:K Suvit K Suvit=0D
ORG:ARYS;=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:06-1362-8736=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;k vee nv;;;=0D
FN:k vee nv=0D
EMAIL;type=3DINTERNET;type=3Dpref:veerapong_g@hotmail.com=0D
EMAIL;type=3DINTERNET:veerapong@hotmail.com=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:K2.;Home;;;=0D
FN:Home K2.=0D
TEL;type=3Dpref:022415589=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:K2.;Home K2.;;;=0D
FN:Home K2. K2.=0D
TEL;type=3Dpref:022415589=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Kaew;N;;;=0D
FN:N Kaew=0D
TEL;type=3Dpref:081-818-8444=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Kaew;N Kaew;;;=0D
FN:N Kaew Kaew=0D
TEL;type=3Dpref:081-818-8444=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Kam New;;;=0D
FN:Kam New=0D
TEL;type=3Dpref:085-666-2974=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Kampanathsanyakorn;Yuipee;;;=0D
FN:Yuipee Kampanathsanyakorn=0D
TEL;type=3DOTHER;type=3DVOICE;type=3Dpref:+66838351717=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:kea;P;Ko;;=0D
FN:P Ko kea=0D
TEL;type=3Dpref:0891313131=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:kea;P kea;Ko;;=0D
FN:P kea Ko kea=0D
TEL;type=3Dpref:0891313131=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:kh;P;Joe p;;=0D
FN:P Joe p kh=0D
TEL;type=3Dpref:0818057777=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:kh;P kh;Joe p;;=0D
FN:P kh Joe p kh=0D
TEL;type=3Dpref:0818057777=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Khaithong;P;;;=0D
FN:P Khaithong=0D
TEL;type=3Dpref:0818331384=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Khaithong;P Khaithong;;;=0D
FN:P Khaithong Khaithong=0D
TEL;type=3Dpref:0818331384=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Khomson H.Jamuree;;;=0D
FN:Khomson H.Jamuree=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:082-858-2172=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Khong;P;Moo P.;;=0D
FN:P Moo P. Khong=0D
TEL;type=3Dpref:0896056500=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Khong;P Khong;Moo P.;;=0D
FN:P Khong Moo P. Khong=0D
TEL;type=3Dpref:0819255555=0D
TEL:0896056500=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Khong2;P;;;=0D
FN:P Khong2=0D
TEL;type=3Dpref:085-113-5555=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Khong2;P Khong2;;;=0D
FN:P Khong2 Khong2=0D
TEL;type=3Dpref:085-113-5555=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Khun 1 Benz PV;;;=0D
FN:Khun 1 Benz PV=0D
TEL;type=3Dpref:084-877-8876=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Khun A Photo;;;=0D
FN:Khun A Photo=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:086-998-7799=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Khun Frang P Neng;;;=0D
FN:Khun Frang P Neng=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:081-629-6269=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Khun Hawood;;;=0D
FN:Khun Hawood=0D
TEL;type=3Dpref:081-906-7991=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Khun Joom Netikul;;;=0D
FN:Khun Joom Netikul=0D
EMAIL;type=3DINTERNET;type=3Dpref:nuttaput_press@hotmail.com=0D
TEL;type=3Dpref:089-888-8777=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Khun Kim EM;;;=0D
FN:Khun Kim EM=0D
TEL;type=3Dpref:089-500-7139=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Khun Ni Shishado;;;=0D
FN:Khun Ni Shishado=0D
TEL;type=3Dpref:081-489-0778=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Khun Nui Hair@crysal;;;=0D
FN:Khun Nui Hair@crysal=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:084-929-6970=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Khun R Chinnavorn;;;=0D
FN:Khun R Chinnavorn=0D
TEL;type=3Dpref:081-889-7555=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Khun R Didok;P Ann;;;=0D
FN:P Ann Khun R Didok=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:092-461-9496=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Khun R Tony;;;=0D
FN:Khun R Tony=0D
TEL;type=3Dpref:089-139-2199=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Khun Rita;;;=0D
FN:Khun Rita=0D
ORG:Set;=0D
TEL;type=3Dpref:086-565-9443=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Khun Sataphon;;;=0D
FN:Khun Sataphon=0D
TEL;type=3Dpref:0939900305=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Khun T;;;=0D
FN:Khun T=0D
ORG:Mind English;=0D
TEL;type=3Dpref:099-051-6646=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Khun T Mind English;;;=0D
FN:Khun T Mind English=0D
ORG:Mind English;=0D
TEL;type=3Dpref:099-051-6646=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Khun Tin HP Computer;;;=0D
FN:Khun Tin HP Computer=0D
ORG:Fahion Iceland;=0D
TEL;type=3Dpref:083-989-2005=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Khun Tin HP Computer Fahion Iceland;;;=0D
FN:Khun Tin HP Computer Fahion Iceland=0D
ORG:Fahion Iceland;=0D
TEL;type=3Dpref:083-989-2005=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Khun Top Netikul;;;=0D
FN:Khun Top Netikul=0D
EMAIL;type=3DINTERNET;type=3Dpref:bot_top@hotmail.com=0D
TEL;type=3Dpref:084-974-4224=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Khun Vad Makeup;;;=0D
FN:Khun Vad Makeup=0D
TEL;type=3Dpref:06-1919-4916=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Khun =E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=87=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=
=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A1 IR;=
;;=0D
FN:Khun =E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=87=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=
=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A1 IR=0D=

ORG:IR;=0D
TEL;type=3Dpref:088-016-8906=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Khun =E0=B9=84=E0=B8=81=E0=B8=94=E0=B9=8C HMC;;;=0D
FN:Khun =E0=B9=84=E0=B8=81=E0=B8=94=E0=B9=8C HMC=0D
TEL;type=3Dpref:081-190-5852=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Khun =E0=B8=94=E0=B8=B2=E0=B8=A7 Maid;;;=0D
FN:Khun =E0=B8=94=E0=B8=B2=E0=B8=A7 Maid=0D
TEL;type=3Dpref:0989367665=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Khun =E0=B9=82=E0=B8=AB=E0=B8=99=E0=B9=88=E0=B8=87;;;=0D
FN:Khun =E0=B9=82=E0=B8=AB=E0=B8=99=E0=B9=88=E0=B8=87=0D
ORG:IR;=0D
TEL;type=3Dpref:088-016-8906=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;KhunNong NV;;;=0D
FN:KhunNong NV=0D
TEL;type=3Dpref:081-808-8778=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Kiatfuengfoo;Belle;;;=0D
FN:Belle Kiatfuengfoo=0D
TEL;type=3Dpref:0869935577=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Kim;P;;;=0D
FN:P Kim=0D
TEL;type=3DWORK;type=3DVOICE;type=3Dpref:0818417999=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Klumklomchit;Nu;;;=0D
FN:Nu Klumklomchit=0D
TEL;type=3Dpref:081-402-4214=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Kob;E;;;=0D
FN:E Kob=0D
TEL;type=3Dpref:098-965-9282=0D
TEL:+668-9770-6969=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Kobthong;;;=0D
FN:Kobthong=0D
TEL;type=3Dpref:095-545-4154=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Koi-work;;;=0D
FN:Koi-work=0D
TEL;type=3Dpref:0816437242=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:komsorn@navanakorn.co.th;;;;=0D
FN:komsorn@navanakorn.co.th=0D
EMAIL;type=3DINTERNET;type=3Dpref:komsorn@navanakorn.co.th=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Kositkhun;Saovapak;;;=0D
FN:Saovapak Kositkhun=0D
EMAIL;type=3DINTERNET;type=3Dpref:sherryjerez@icloud.com=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Kriyoga;;;=0D
FN:Kriyoga=0D
TEL;type=3Dpref:02-684-1185=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Krongkitjakan;Jira-abha;;;=0D
FN:Jira-abha Krongkitjakan=0D
TEL;type=3Dpref:0816437242=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Kru Bee;;;=0D
FN:Kru Bee=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:081-551-7005=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Krug;Parr;;;=0D
FN:Parr Krug=0D
TEL;type=3Dpref:035241555=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Krug;Parr Krug;;;=0D
FN:Parr Krug Krug=0D
TEL;type=3Dpref:035241555=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Krungthai Card;;;=0D
FN:Krungthai Card=0D
EMAIL;type=3DINTERNET;type=3Dpref:onlineservice@ktc.co.th=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:ktb.netbank@ktb.co.th;;;;=0D
FN:ktb.netbank@ktb.co.th=0D
EMAIL;type=3DINTERNET;type=3Dpref:ktb.netbank@ktb.co.th=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Ktbnetbank;;;=0D
FN:Ktbnetbank=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Ktc =E0=B8=81=E0=B8=A3=E0=B8=B8=E0=B8=87=E0=B9=84=E0=B8=97=E0=B8=A2;;;=0D=

FN:Ktc =E0=B8=81=E0=B8=A3=E0=B8=B8=E0=B8=87=E0=B9=84=E0=B8=97=E0=B8=A2=0D
TEL;type=3Dpref:021235000=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Ktc;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=81=E0=B8=B2=E0=B8=A3=E0=B9=80=E0=B8=81=
=E0=B8=95=E0=B8=B8;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=81=E0=B8=B2=E0=B8=A3=E0=B9=80=E0=B8=81=E0=
=B8=95=E0=B8=B8 Ktc=0D
TEL;type=3Dpref:026313738=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Kun Jane NV.;;;=0D
FN:Kun Jane NV.=0D
TEL;type=3Dpref:089-925-8800=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:kunnika.2909@hotmail.com;;;;=0D
FN:kunnika.2909@hotmail.com=0D
EMAIL;type=3DINTERNET;type=3Dpref:kunnika.2909@hotmail.com=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;L Sewing Studio;;;=0D
FN:L Sewing Studio=0D
TEL;type=3Dpref:087-922-4669=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Lawyer;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=9E=E0=B8=B5=E0=B8=A3=E0=B8=9E=E0=B8=
=87=E0=B8=A8=E0=B9=8C;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=9E=E0=B8=B5=E0=B8=A3=E0=B8=9E=E0=B8=87=E0=
=B8=A8=E0=B9=8C Lawyer=0D
EMAIL;type=3DINTERNET;type=3Dpref:sangchunchai@gmail.com=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:089-195-1145=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:learning;A;chance;;=0D
FN:A chance learning=0D
TEL;type=3Dpref:0896653599=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:learning;A learning;chance;;=0D
FN:A learning chance learning=0D
TEL;type=3Dpref:0896653599=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Lek;P;;;=0D
FN:P Lek=0D
TEL;type=3Dpref:0870301165=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Lek;P Lek;;;=0D
FN:P Lek Lek=0D
TEL;type=3Dpref:0870301165=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Lek;Pa;;;=0D
FN:Pa Lek=0D
TEL;type=3Dpref:0877100429=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Lek;Pa Lek;;;=0D
FN:Pa Lek Lek=0D
TEL;type=3Dpref:0870301165=0D
TEL:0877100429=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Lets Talk Ipd;;;=0D
FN:Lets Talk Ipd=0D
TEL;type=3Dpref:0614106184=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:li;K;Pavit;;=0D
FN:K Pavit li=0D
TEL;type=3Dpref:0814248688=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:li;K li;Pavit;;=0D
FN:K li Pavit li=0D
TEL;type=3Dpref:0814248688=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Liauburindr;Jaime;;;=0D
FN:Jaime Liauburindr=0D
TEL;type=3DWORK;type=3DVOICE;type=3Dpref:0818258814=0D
TEL:0878023614=0D
X-SOCIALPROFILE;type=3DLINE;x-user=3D=E2=80=AD087-802-3614=E2=80=AC:x-apple:=
%E2%80%AD087-802-3614%E2%80%AC=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:lips;Chade;from;;=0D
FN:Chade from lips=0D
TEL;type=3Dpref:0818483388=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:lips;Chade lips;from;;=0D
FN:Chade lips from lips=0D
TEL;type=3Dpref:0818483388=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Lisa;;;=0D
FN:Lisa=0D
TEL;type=3Dpref:66833003151=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:list-management@unsubscribe.emailinboundprocessing.com;;;;=0D
FN:list-management@unsubscribe.emailinboundprocessing.com=0D
EMAIL;type=3DINTERNET;type=3Dpref:list-management@unsubscribe.emailinboundpr=
ocessing.com=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;LOOK;;;=0D
FN:LOOK=0D
TEL;type=3Dpref:0818111333=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Luk;;;=0D
FN:Luk=0D
TEL;type=3Dpref:0818414657=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:m.;Pa;Noi;;=0D
FN:Pa Noi m.=0D
TEL;type=3Dpref:0818335779=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:m.;Pa m.;Noi;;=0D
FN:Pa m. Noi m.=0D
TEL;type=3Dpref:0818335779=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Macha;Anne.;;;=0D
FN:Anne. Macha=0D
TEL;type=3Dpref:0820156777=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Macha;Anne. Macha;;;=0D
FN:Anne. Macha Macha=0D
TEL;type=3Dpref:0820156777=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Mam;N;;;=0D
FN:N Mam=0D
TEL;type=3Dpref:0899111118=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Mam;N Mam;;;=0D
FN:N Mam Mam=0D
TEL;type=3Dpref:0899111118=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Manoon Petshop;;;=0D
FN:Manoon Petshop=0D
TEL;type=3DIPHONE;type=3DCELL;type=3DVOICE;type=3Dpref:+66 2 945 7895=0D
ADR;type=3DHOME;type=3Dpref:;;;;;0;TH=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Mater Syam;;;=0D
FN:Mater Syam=0D
TEL;type=3Dpref:088-871-4748=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:may-Tap;P;;;=0D
FN:P may-Tap=0D
TEL;type=3Dpref:0812091515=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:may-Tap;P may-Tap;;;=0D
FN:P may-Tap may-Tap=0D
TEL;type=3Dpref:0812091515=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Me_PK=E2=98=98=EF=B8=8F=F0=9F=8E=8B=E2=99=A5=EF=B8=8F=F0=9F=95=AF=F0=9F=99=
=8F=F0=9F=8D=80;;;=0D
FN:Me_PK=E2=98=98=EF=B8=8F=F0=9F=8E=8B=E2=99=A5=EF=B8=8F=F0=9F=95=AF=F0=9F=99=
=8F=F0=9F=8D=80=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:096-919-8716=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Mean;;;=0D
FN:Mean=0D
TEL;type=3DIPHONE;type=3DCELL;type=3DVOICE;type=3Dpref:098-926-8603=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Medical;S;;;=0D
FN:S Medical=0D
TEL;type=3Dpref:022531010=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Medical;S Medical;;;=0D
FN:S Medical Medical=0D
TEL;type=3Dpref:022531010=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:mee;Nong;look;;=0D
FN:Nong look mee=0D
TEL;type=3Dpref:0878023614=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Mee;Nong;;;=0D
FN:Nong Mee=0D
TEL;type=3Dpref:0818258814=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Mee;Nong Mee;;;=0D
FN:Nong Mee Mee=0D
TEL;type=3Dpref:0878023614=0D
TEL:0818258814=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Meow P;;;=0D
FN:Meow P=0D
TEL;type=3Dpref:082-221-2999=0D
TEL:086-972-4444=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Mew;P Mew;;;=0D
FN:P Mew Mew=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:0819277777=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Mind English;;;=0D
FN:Mind English=0D
TEL;type=3Dpref:099-546-5446=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;MissNoMore;;;=0D
FN:MissNoMore=0D
TEL;type=3Dpref:*77=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Mogen;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=94=E0=B8=B2;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=94=E0=B8=B2 Mogen=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:0970847019=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Mom;;;=0D
FN:Mom=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:+66816432707=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Mom Tim;;;=0D
FN:Mom Tim=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:081-643-2707=0D
ADR;type=3DHOME;type=3Dpref:;;31 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B6=
=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=
=B1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C3=A7=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=AF=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5 =E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B1.=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=
=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C3=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=
=80=A0=C2=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A9=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C2=B0 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AF.=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C3=A1=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C3=85;;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=84=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=80=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=89=A0 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4 =E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=A0.=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B5=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=E2=88=9E=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B6=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=
=B5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=87=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B2=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=
=A5;77110;Thailand=0D
item1.ADR;type=3DHOME:;;31 =E0=B8=9A=E0=B9=89=E0=B8=B2=E0=B8=99=E0=B8=9E=E0=B8=
=B4=E0=B8=8A=E0=B8=B1=E0=B8=A2=E0=B8=8D=E0=B8=B2=E0=B8=95=E0=B8=B4 =E0=B8=96=
.=E0=B9=80=E0=B8=9E=E0=B8=8A=E0=B8=A3=E0=B9=80=E0=B8=81=E0=B8=A9=E0=B8=A1 =E0=
=B8=95.=E0=B8=AB=E0=B8=99=E0=B8=AD=E0=B8=87=E0=B9=81=E0=B8=81;;=E0=B8=AD=E0=B8=
=B3=E0=B9=80=E0=B8=A0=E0=B8=AD =E0=B8=AB=E0=B8=B1=E0=B8=A7=E0=B8=AB=E0=B8=B4=
=E0=B8=99 =E0=B8=88.=E0=B8=9B=E0=B8=A3=E0=B8=B0=E0=B8=88=E0=B8=A7=E0=B8=9A=E0=
=B8=84=E0=B8=B5=E0=B8=A3=E0=B8=B5=E0=B8=82=E0=B8=B1=E0=B8=99=E0=B8=98=E0=B9=8C=
;77110;Thailand=0D
item1.X-ABADR:th=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:MooK;P;;;=0D
FN:P MooK=0D
TEL;type=3DWORK;type=3DVOICE;type=3Dpref:0819116678=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Muji Central EW;;;=0D
FN:Muji Central EW=0D
TEL;type=3Dpref:0870060848=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Muji CEW;;;=0D
FN:Muji CEW=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:02-042-0646=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;My U. Aood Daddy;;;=0D
FN:My U. Aood Daddy=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:+66818434114=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;N Aui P Fah;;;=0D
FN:N Aui P Fah=0D
TEL;type=3Dpref:081-984-3855=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;N Ball Nv1;;;=0D
FN:N Ball Nv1=0D
TEL;type=3Dpref:081-732-4741=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;N Ball NV2;;;=0D
FN:N Ball NV2=0D
TEL;type=3Dpref:085-253-5888=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;N Bee Saab;;;=0D
FN:N Bee Saab=0D
TEL;type=3Dpref:+66854849939=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;N Bua;;;=0D
FN:N Bua=0D
TEL;type=3Dpref:086-356-5755=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;N dear Piano;;;=0D
FN:N dear Piano=0D
TEL;type=3Dpref:0804465553=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;N Indy;;;=0D
FN:N Indy=0D
TEL;type=3DWORK;type=3DVOICE;type=3Dpref:086-340-9761=0D
TEL;type=3DWORK;type=3DVOICE:086-629-3541=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;N JJ New 56;;;=0D
FN:N JJ New 56=0D
TEL;type=3Dpref:06-3826-3456=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;N Kaew;;;=0D
FN:N Kaew=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:081-818-8444=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;N Keaw New;;;=0D
FN:N Keaw New=0D
TEL;type=3Dpref:091-994-2625=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;N Kun;;;=0D
FN:N Kun=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:087-107-5331=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;N Lek Sw;;;=0D
FN:N Lek Sw=0D
TEL;type=3Dpref:087-219-9933=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;N Pai;;;=0D
FN:N Pai=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:089-894-1175=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;N Ploy NV.;;;=0D
FN:N Ploy NV.=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:082-325-9372=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;N pook ramkunhange;;;=0D
FN:N pook ramkunhange=0D
EMAIL;type=3DINTERNET;type=3Dpref:saranda.in@hotmail.com=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:N Ppoy ARYS;N Ppoy ARYS;;;=0D
FN:N Ppoy ARYS N Ppoy ARYS=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:0882605501=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;N Preaw DD Nurse=F0=9F=92=95;;;=0D
FN:N Preaw DD Nurse=F0=9F=92=95=0D
TEL;type=3Dpref:082-341-6214=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;N Preaw DD Nurse=E2=88=9A=E2=88=9E=C2=AC=C3=BC=C2=AC=C3=AD=C2=AC=C3=AF;;;=
=0D
FN:N Preaw DD Nurse=E2=88=9A=E2=88=9E=C2=AC=C3=BC=C2=AC=C3=AD=C2=AC=C3=AF=0D=

TEL;type=3Dpref:082-341-6214=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;N Shine New;;;=0D
FN:N Shine New=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:096-629-4651=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;N Wut;;;=0D
FN:N Wut=0D
ORG:CFO P =E0=B8=A1=E0=B8=A5;=0D
item1.EMAIL;type=3DINTERNET;type=3Dpref:sarawutn@kpmg.co.th=0D
item1.X-ABLabel:_%2524%2521%253COther%253E%2521%2524_=0D
TEL;type=3DOTHER;type=3DVOICE;type=3Dpref:091-808-4032=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:nakarinwahim@gmail.com;;;;=0D
FN:nakarinwahim@gmail.com=0D
EMAIL;type=3DINTERNET;type=3Dpref:nakarinwahim@gmail.com=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Nam;;;=0D
FN:Nam=0D
TEL;type=3DWORK;type=3DVOICE;type=3Dpref:0817178778=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Nava;Khun;Veerapong;;=0D
FN:Khun Veerapong Nava=0D
TEL;type=3Dpref:0819021939=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Nava.;Khun;jane;;=0D
FN:Khun jane Nava.=0D
TEL;type=3DWORK;type=3DVOICE;type=3Dpref:0899258800=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Nava;Khun Nava;Veerapong;;=0D
FN:Khun Nava Veerapong Nava=0D
TEL;type=3Dpref:0819021939=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:NaVa;Nong;Jane;;=0D
FN:Nong Jane NaVa=0D
EMAIL;type=3DINTERNET;type=3Dpref:pond_puk11@hotmail.com=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:NaVa;P;Jette;;=0D
FN:P Jette NaVa=0D
TEL;type=3DWORK;type=3DVOICE;type=3Dpref:0818497320=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Nep;P Yui;;;=0D
FN:P Yui Nep=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:089-406-422=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Nep;=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B8=99=E0=B8=B1=E0=B8=99;;;=0D
FN:=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B8=99=E0=B8=B1=E0=B8=99 Nep=0D
TEL;type=3Dpref:086-864-4666=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Net;Check;;;=0D
FN:Check Net=0D
TEL;type=3Dpref:*900#=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:netbank@ktb.co.th;;;;=0D
FN:netbank@ktb.co.th=0D
EMAIL;type=3DINTERNET;type=3Dpref:netbank@ktb.co.th=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Net-Off;;;=0D
FN:Net-Off=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:*902*02#=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Net-On;;;=0D
FN:Net-On=0D
TEL;type=3Dpref:*902*01#=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Neung Sw;;;=0D
FN:Neung Sw=0D
TEL;type=3Dpref:081-371-0444=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:new1;P;jah its happened;;=0D
FN:P jah its happened new1=0D
TEL;type=3DWORK;type=3DVOICE;type=3Dpref:0817541791=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:nipit@navanakorn.co.th;;;;=0D
FN:nipit@navanakorn.co.th=0D
EMAIL;type=3DINTERNET;type=3Dpref:nipit@navanakorn.co.th=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;No Name;;;=0D
FN:No Name=0D
TEL;type=3Dpref:1669=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;No Name;;;=0D
FN:No Name=0D
TEL;type=3Dpref:1193=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;No Name;;;=0D
FN:No Name=0D
EMAIL;type=3DINTERNET;type=3Dpref:atchawadee@amityconsulting.net=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;No Name;;;=0D
FN:No Name=0D
EMAIL;type=3DINTERNET;type=3Dpref:oraganya@hotmail.com=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Nong;;;=0D
FN:Nong=0D
TEL;type=3Dpref:66843991311=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Nong a Photo;;;=0D
FN:Nong a Photo=0D
TEL;type=3Dpref:0818822503=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Nong Apple;;;=0D
FN:Nong Apple=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:0612925268=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Nong Kaew 25;;;=0D
FN:Nong Kaew 25=0D
TEL;type=3DOTHER;type=3DVOICE;type=3Dpref:091-994-2625=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Nong Loukmee;;;=0D
FN:Nong Loukmee=0D
TEL;type=3Dpref:087-802-3614=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Nong Mam;;;=0D
FN:Nong Mam=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:096-924-6116=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Nong nN;;;=0D
FN:Nong nN=0D
TEL;type=3Dpref:0804542901=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Nong Nok;;;=0D
FN:Nong Nok=0D
TEL;type=3Dpref:086-980-3993=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Nong nu 2;;;=0D
FN:Nong nu 2=0D
TEL;type=3Dpref:0612925268=0D
X-SOCIALPROFILE;type=3DLINE;x-user=3D=E2=80=AD06-1292-5268=E2=80=AC:x-apple:=
%E2%80%AD06-1292-5268%E2%80%AC=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Nong nu 2;;;=0D
FN:Nong nu 2=0D
TEL;type=3Dpref:0612925268=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Nong Oh Dad;;;=0D
FN:Nong Oh Dad=0D
TEL;type=3Dpref:089-487-6424=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Nong;P;;;=0D
FN:P Nong=0D
TEL;type=3Dpref:66818285413=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Nong;P Nong;;;=0D
FN:P Nong Nong=0D
TEL;type=3Dpref:66818285413=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Nong Phrm;;;=0D
FN:Nong Phrm=0D
ORG:Ru;=0D
TEL;type=3Dpref:097-004-8119=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Nong Pook RU.;;;=0D
FN:Nong Pook RU.=0D
TEL;type=3Dpref:087-035-0544=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Nong Shine;;;=0D
FN:Nong Shine=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:081-833-8222=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Nong Shine New;;;=0D
FN:Nong Shine New=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:096-629-4651=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Nong Trin Salin;;;=0D
FN:Nong Trin Salin=0D
TEL;type=3Dpref:081-906-9683=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Nong =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4 Paivate;;=
;=0D
FN:Nong =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4 Paivate=0D=

TEL;type=3Dpref:0972412628=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Nong =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=80=A2=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=CF=80=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=
=B0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B5;;;=0D
FN:Nong =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=80=A2=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=CF=80=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=
=B0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B5=0D
TEL;type=3Dpref:06-2461-4245=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Nong =E0=B8=81=E0=B8=B5=E0=B9=89;;;=0D
FN:Nong =E0=B8=81=E0=B8=B5=E0=B9=89=0D
TEL;type=3Dpref:083-068-4944=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Nong =E0=B8=A1=E0=B8=B5=E0=B8=99 Paivate;;;=0D
FN:Nong =E0=B8=A1=E0=B8=B5=E0=B8=99 Paivate=0D
TEL;type=3Dpref:0972412628=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Nong =E0=B8=A5=E0=B8=B9=E0=B8=81=E0=B8=AB=E0=B8=A1=E0=B8=B5;;;=0D
FN:Nong =E0=B8=A5=E0=B8=B9=E0=B8=81=E0=B8=AB=E0=B8=A1=E0=B8=B5=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:06-2461-4245=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Noon Yuiyui;;;=0D
FN:Noon Yuiyui=0D
TEL;type=3Dpref:081-860-5353=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Nu Dang;;;=0D
FN:Nu Dang=0D
TEL;type=3DIPHONE;type=3DCELL;type=3DVOICE;type=3Dpref:+66 81 659 9333=0D
ADR;type=3DHOME;type=3Dpref:;;;;;0;TH=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:nurse;R;Aoi Daddy;;=0D
FN:R Aoi Daddy nurse=0D
TEL;type=3Dpref:0863944500=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Nusasirive ONE;;;=0D
FN:Nusasirive ONE=0D
ORG:PH ~ifthey Ha;=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Nutt =E0=B8=A3=E0=B8=B2=E0=B8=8A=E0=B8=B4=E0=B8=99=E0=B8=B5;;;=0D
FN:Nutt =E0=B8=A3=E0=B8=B2=E0=B8=8A=E0=B8=B4=E0=B8=99=E0=B8=B5=0D
TEL;type=3Dpref:085-236-5678=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:nuttaputt_press@hotmail.co.th;;;;=0D
FN:nuttaputt_press@hotmail.co.th=0D
EMAIL;type=3DINTERNET;type=3Dpref:nuttaputt_press@hotmail.co.th=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:nv.;K;Bung;;=0D
FN:K Bung nv.=0D
TEL;type=3DWORK;type=3DVOICE;type=3Dpref:0891441282=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:nv.;Khun;nong;;=0D
FN:Khun nong nv.=0D
TEL;type=3DWORK;type=3DVOICE;type=3Dpref:0818088778=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:nv;N;ball;;=0D
FN:N ball nv=0D
TEL;type=3DWORK;type=3DVOICE;type=3Dpref:0852535888=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:nv.;P;s;;=0D
FN:P s nv.=0D
TEL;type=3Dpref:0816670552=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:nv.;P;Nang;;=0D
FN:P Nang nv.=0D
TEL;type=3Dpref:0830517586=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:nv;P;Lin;;=0D
FN:P Lin nv=0D
TEL;type=3Dpref:0890486432=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:NV;P;aoon;;=0D
FN:P aoon NV=0D
TEL;type=3Dpref:0868998181=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:nv;P nv;Lin;;=0D
FN:P nv Lin nv=0D
TEL;type=3Dpref:0890486432=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:NV;P NV;aoon;;=0D
FN:P NV aoon NV=0D
TEL;type=3Dpref:0868998181=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;NV;;;=0D
FN:NV=0D
ORG:=E0=B8=9B=E0=B8=97=E0=B8=B8=E0=B8=A1=E0=B8=AF;=0D
TEL;type=3Dpref:02-529-0031=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;O Cousin New;;;=0D
FN:O Cousin New=0D
TEL;type=3Dpref:085-356-5445=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Oak;;;=0D
FN:Oak=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:06-2447-8242=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Oak ELin;;;=0D
FN:Oak ELin=0D
TEL;type=3Dpref:06-2447-8242=0D
X-SOCIALPROFILE;type=3DLINE;x-user=3D=E2=80=AD06-2447-8242=E2=80=AC:x-apple:=
%E2%80%AD06-2447-8242%E2%80%AC=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;O-cousin;;;=0D
FN:O-cousin=0D
TEL;type=3DWORK;type=3DVOICE;type=3Dpref:0818036803=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Olala;;;=0D
FN:Olala=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:085-677-5050=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Olala New;;;=0D
FN:Olala New=0D
TEL;type=3Dpref:098-824-591=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Olive@52;;;=0D
FN:Olive@52=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:02-793-4509=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:One;Luk;;;=0D
FN:Luk One=0D
TEL;type=3Dpref:0813113311=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:One;Luk One;;;=0D
FN:Luk One One=0D
TEL;type=3Dpref:0813113311=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;P Ae 28;;;=0D
FN:P Ae 28=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:+66993635959=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;P Aey =E0=B8=A5=E0=B8=B8=E0=B8=87=E0=B8=95=E0=B8=B8=E0=B9=89=E0=B8=A1;;;=0D=

FN:P Aey =E0=B8=A5=E0=B8=B8=E0=B8=87=E0=B8=95=E0=B8=B8=E0=B9=89=E0=B8=A1=0D
TEL;type=3Dpref:081-841-2903=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;P Ahe PAnne;;;=0D
FN:P Ahe PAnne=0D
TEL;type=3Dpref:0637829515=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;P Amp;;;=0D
FN:P Amp=0D
TEL;type=3Dpref:086-129-1234=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;P Amp USA;;;=0D
FN:P Amp USA=0D
TEL;type=3Dpref:+1 954 736-6677=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;P Anne =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=
=80=A0=C2=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=
=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A3;;;=0D
FN:P Anne =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=
=80=A0=C2=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=
=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A3=0D
TEL;type=3Dpref:088-670-4935=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;P Anne =E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B9=80=E0=B8=AD=E0=B9=8B;;;=0D
FN:P Anne =E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B9=80=E0=B8=AD=E0=B9=8B=0D
TEL;type=3Dpref:088-670-4935=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;P Aon NV;;;=0D
FN:P Aon NV=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:081-291-1926=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;P Aor;;;=0D
FN:P Aor=0D
TEL;type=3Dpref:+66893499999=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;P Au;;;=0D
FN:P Au=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:081-499-3177=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;P Cherry Cousin;;;=0D
FN:P Cherry Cousin=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:081-174-2933=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;P Chum Home Ram 88;;;=0D
FN:P Chum Home Ram 88=0D
TEL;type=3Dpref:0898251188=0D
X-SOCIALPROFILE;type=3DLINE;x-user=3D089-825-1188:x-apple:089-825-1188=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;P Fah O Cousin;;;=0D
FN:P Fah O Cousin=0D
TEL;type=3Dpref:089-931-3382=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;P g;;;=0D
FN:P g=0D
TEL;type=3Dpref:090-971-5599=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;P Jan;;;=0D
FN:P Jan=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:081-303-8696=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;P Jin =E0=B8=A3=E0=B8=B3=E0=B9=80=E0=B8=97=E0=B8=B5=E0=B8=A2=E0=B8=99;;;=0D=

FN:P Jin =E0=B8=A3=E0=B8=B3=E0=B9=80=E0=B8=97=E0=B8=B5=E0=B8=A2=E0=B8=99=0D
TEL;type=3Dpref:083-075-6232=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;P Jooe Jirayut;;;=0D
FN:P Jooe Jirayut=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:081-813-9696=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;P Khim;;;=0D
FN:P Khim=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:081-841-7999=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;P Khong 2;;;=0D
FN:P Khong 2=0D
TEL;type=3Dpref:0911145555=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;P Leena;;;=0D
FN:P Leena=0D
TEL;type=3Dpref:0891170391=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;P Lex Clothing =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B1=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C2=B0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C3=AF=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3;;;=0D
FN:P Lex Clothing =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B1=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C2=B0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C3=AF=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=0D
TEL;type=3Dpref:086-390-0102=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;P Lex Clothing =E0=B8=96=E0=B8=99=E0=B8=AD=E0=B8=A1=E0=B8=A1=E0=B8=B4=E0=B8=
=95=E0=B8=A3;;;=0D
FN:P Lex Clothing =E0=B8=96=E0=B8=99=E0=B8=AD=E0=B8=A1=E0=B8=A1=E0=B8=B4=E0=B8=
=95=E0=B8=A3=0D
TEL;type=3Dpref:086-390-0102=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;P May;;;=0D
FN:P May=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:06-5604-6015=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;P Meow 4;;;=0D
FN:P Meow 4=0D
TEL;type=3Dpref:0869724444=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;P Meow 44;;;=0D
FN:P Meow 44=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:0624564544=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;P Moo /P Khong;;;=0D
FN:P Moo /P Khong=0D
TEL;type=3DOTHER;type=3DVOICE;type=3Dpref:085-554-0657=0D
TEL;type=3DOTHER;type=3DVOICE:089-605-6500=0D
TEL;type=3DOTHER;type=3DVOICE:0818057777=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;P Moo Pkong;;;=0D
FN:P Moo Pkong=0D
TEL;type=3Dpref:089-605-6500=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;P Nok;;;=0D
FN:P Nok=0D
TEL;type=3Dpref:081-639-6674=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;P Nuk  P Neng;;;=0D
FN:P Nuk  P Neng=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:089-449-2422=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;P Nuk P Neng;;;=0D
FN:P Nuk P Neng=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:089-449-2422=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;P Pravit NV;;;=0D
FN:P Pravit NV=0D
TEL;type=3Dpref:081-732-4715=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;P Pum P Sao;;;=0D
FN:P Pum P Sao=0D
TEL;type=3Dpref:081-805-1262=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;P Ree;;;=0D
FN:P Ree=0D
ORG:algal;=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:+66 91-994-0505=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;P Rit Olala;;;=0D
FN:P Rit Olala=0D
TEL;type=3Dpref:081-925-4557=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;P Saonoi 55;;;=0D
FN:P Saonoi 55=0D
TEL;type=3Dpref:0986362955=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;P Sit;;;=0D
FN:P Sit=0D
TEL;type=3Dpref:087-091-1503=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;P Soanoi;;;=0D
FN:P Soanoi=0D
TEL;type=3Dpref:098-636-2655=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;P Third;;;=0D
FN:P Third=0D
TEL;type=3Dpref:085-558-5988=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;P Tii;;;=0D
FN:P Tii=0D
TEL;type=3Dpref:081-867-5743=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;P tii 15;;;=0D
FN:P tii 15=0D
TEL;type=3Dpref:092-426-9915=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;P Ton NV;;;=0D
FN:P Ton NV=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:0818293010=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;P Tu;;;=0D
FN:P Tu=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:086-902-7888=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;P VU;;;=0D
FN:P VU=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:081-840-7888=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;P Yai;;;=0D
FN:P Yai=0D
TEL;type=3Dpref:081-559-0480=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;P =E0=B8=99=E0=B8=B4=E0=B9=88=E0=B8=99;;;=0D
FN:P =E0=B8=99=E0=B8=B4=E0=B9=88=E0=B8=99=0D
ORG:Violet Blue;=0D
TEL;type=3Dpref:081-629-3175=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Pack;MMS;;;=0D
FN:MMS Pack=0D
TEL;type=3Dpref:*9000=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Pack;Net;;;=0D
FN:Net Pack=0D
TEL;type=3Dpref:*9000=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Pack;SMS;;;=0D
FN:SMS Pack=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:*9000=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Pai;N;;;=0D
FN:N Pai=0D
TEL;type=3Dpref:089-894-1175=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Pai;N Pai;;;=0D
FN:N Pai Pai=0D
TEL;type=3Dpref:089-894-1175=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:pain;R;Add;;=0D
FN:R Add pain=0D
TEL;type=3Dpref:0813359604=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:pain;R pain;Add;;=0D
FN:R pain Add pain=0D
TEL;type=3Dpref:0813359604=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Paino 15 New;;;=0D
FN:Paino 15 New=0D
TEL;type=3Dpref:084-655-3615=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Paino 55;;;=0D
FN:Paino 55=0D
TEL;type=3Dpref:+66921535555=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Patra;Koi;;;=0D
FN:Koi Patra=0D
TEL;type=3Dpref:0818237777=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Paybill;;;=0D
FN:Paybill=0D
TEL;type=3Dpref:*9399=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;PayPal;;;=0D
FN:PayPal=0D
EMAIL;type=3DINTERNET;type=3Dpref:service@intl.paypal.com=0D
TEL;type=3DWORK;type=3DVOICE;type=3Dpref:402 935-2050=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Pem hupen ta;;;=0D
FN:Pem hupen ta=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:+66879952220=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Petnaim;Kunthida;;;=0D
FN:Kunthida Petnaim=0D
EMAIL;type=3DINTERNET;type=3Dpref:kunthida.p@bangkokinsurance.com=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:photo.;A;;;=0D
FN:A photo.=0D
TEL;type=3Dpref:0869987799=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:photo.;A photo.;;;=0D
FN:A photo. photo.=0D
TEL;type=3Dpref:0869987799=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Piano;;;=0D
FN:Piano=0D
TEL;type=3DWORK;type=3DVOICE;type=3Dpref:66818316612=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Piano 12;;;=0D
FN:Piano 12=0D
TEL;type=3Dpref:081-831-6612=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Piano 15;;;=0D
FN:Piano 15=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:+66846553615=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Piano 99;;;=0D
FN:Piano 99=0D
TEL;type=3Dpref:086-342-3999=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:piano7007@gmail.com;;;;=0D
FN:piano7007@gmail.com=0D
EMAIL;type=3DINTERNET;type=3Dpref:piano7007@gmail.com=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Pinto;;;=0D
FN:Pinto=0D
TEL;type=3Dpref:081-924-4747=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Piroon;;;=0D
FN:Piroon=0D
TEL;type=3Dpref:+66834900122=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Piyawan;Mhai;;;=0D
FN:Mhai Piyawan=0D
TEL;type=3Dpref:0819624056=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Pk=E2=9C=A8=E2=99=A5=EF=B8=8F15=E2=9C=A8;;;=0D
FN:Pk=E2=9C=A8=E2=99=A5=EF=B8=8F15=E2=9C=A8=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:06-5628-9615=0D
X-SOCIALPROFILE;type=3DLINE;x-user=3D=E2=80=AD06-5628-9615=E2=80=AC:x-apple:=
%E2%80%AD06-5628-9615%E2%80%AC=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;PK 15 =F0=9F=8E=8B=F0=9F=8D=80=F0=9F=95=AF=E2=99=A5=EF=B8=8F;;;=0D
FN:PK 15 =F0=9F=8E=8B=F0=9F=8D=80=F0=9F=95=AF=E2=99=A5=EF=B8=8F=0D
EMAIL;type=3DINTERNET;type=3Dpref:sanoocha@icloud.com=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;PK 15 =F0=9F=8E=8B=F0=9F=8D=80=F0=9F=95=AF=E2=99=A5=EF=B8=8F;;;=0D
FN:PK 15 =F0=9F=8E=8B=F0=9F=8D=80=F0=9F=95=AF=E2=99=A5=EF=B8=8F=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Pk_16=F0=9F=8E=90=E2=99=A5=EF=B8=8F=E2=99=A5=EF=B8=8F=E2=99=A5=EF=B8=8F=E2=
=99=A5=EF=B8=8F;;;=0D
FN:Pk_16=F0=9F=8E=90=E2=99=A5=EF=B8=8F=E2=99=A5=EF=B8=8F=E2=99=A5=EF=B8=8F=E2=
=99=A5=EF=B8=8F=0D
TEL;type=3DIPHONE;type=3DCELL;type=3DVOICE;type=3Dpref:+66 96-919-8716=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;PK_55 =E2=9C=A8=E2=99=A5=EF=B8=8F=E2=9C=A8;;;=0D
FN:PK_55 =E2=9C=A8=E2=99=A5=EF=B8=8F=E2=9C=A8=0D
TEL;type=3Dpref:0946394655=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;PK_mIpad;;;=0D
FN:PK_mIpad=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:082-086-8187=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Pkmipad;;;=0D
FN:Pkmipad=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:082-086-8187=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Plangton;;;=0D
FN:Plangton=0D
TEL;type=3Dpref:081-258-9740=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:PlearnWan;Jikko;;;=0D
FN:Jikko PlearnWan=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:PlearnWan;Jikko PlearnWan;;;=0D
FN:Jikko PlearnWan PlearnWan=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;PN Flure Derivery;;;=0D
FN:PN Flure Derivery=0D
TEL;type=3Dpref:094-489-6416=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;pon;;;=0D
FN:pon=0D
EMAIL;type=3DINTERNET;type=3Dpref:kanokvibhap@ivglobal.co.th=0D
TEL;type=3Dpref:0818550865=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Pook B;;;=0D
FN:Pook B=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:0817441119=0D
TEL;type=3DWORK;type=3DVOICE:081-622-4442=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Pook JN;;;=0D
FN:Pook JN=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:0804156454=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:pook.kornchanok@gmail.com;;;;=0D
FN:pook.kornchanok@gmail.com=0D
EMAIL;type=3DINTERNET;type=3Dpref:pook.kornchanok@gmail.com=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Pooklook;;;=0D
FN:Pooklook=0D
TEL;type=3Dpref:081-811-1333=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Pornratananukul;Aoh;;;=0D
FN:Aoh Pornratananukul=0D
TEL;type=3DOTHER;type=3DVOICE;type=3Dpref:00116193168514=0D
TEL;type=3DOTHER;type=3DVOICE:00916193375009=0D
X-SOCIALPROFILE;type=3DLINE;x-user=3D=E2=80=AD00916193375009=E2=80=AC:x-appl=
e:%E2%80%AD00916193375009%E2%80%AC=0D
X-SOCIALPROFILE;type=3DLINE;x-user=3D=E2=80=AD001 1 619 316-8514=E2=80=AC:x-=
apple:%E2%80%AD001%201%20619%20316-8514%E2%80%AC=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Prapaipis;Chadthong;;;(IS)=0D
FN:Chadthong Prapaipis (IS)=0D
EMAIL;type=3DINTERNET;type=3Dpref:Chadthong.P@kimeng.co.th=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Praw;;;=0D
FN:Praw=0D
TEL;type=3Dpref:0818022345=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Prayad;P;;;=0D
FN:P Prayad=0D
TEL;type=3Dpref:0891064151=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Prayad;P Prayad;;;=0D
FN:P Prayad Prayad=0D
TEL;type=3Dpref:0891064151=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Privilege;;;=0D
FN:Privilege=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:*878#=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Pro;Check;;;=0D
FN:Check Pro=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:*935#=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Promotion;;;=0D
FN:Promotion=0D
TEL;type=3Dpref:*1878=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Proon;;;=0D
FN:Proon=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Pu;K;;;=0D
FN:K Pu=0D
EMAIL;type=3DINTERNET;type=3Dpref:pu_vichittra@hotmail.com=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Pueng;;;=0D
FN:Pueng=0D
TEL;type=3Dpref:0814210240=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Pueng Essex;;;=0D
FN:Pueng Essex=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:081-421-0240=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Pun;;;=0D
FN:Pun=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:0819855898=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:pun;Nong;kor;;=0D
FN:Nong kor pun=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;pun_pun;;;=0D
FN:pun_pun=0D
EMAIL;type=3DINTERNET;type=3Dpref:pun_pun19@hotmail.com=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:pun.pun1919@gmail.com;;;;=0D
FN:pun.pun1919@gmail.com=0D
EMAIL;type=3DINTERNET;type=3Dpref:pun.pun1919@gmail.com=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Pun;Si;;;=0D
FN:Si Pun=0D
TEL;type=3DWORK;type=3DVOICE;type=3Dpref:0859209449=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Pun15;;;=0D
FN:Pun15=0D
TEL;type=3Dpref:092-410-4224=0D
TEL:080-961-9915=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Punch;Prom;;;=0D
FN:Prom Punch=0D
ORG:=E0=B8=A3=E0=B8=B2=E0=B8=8A=E0=B8=B4=E0=B8=99=E0=B8=B5=E0=B8=9A=E0=B8=99=
;=0D
TEL;type=3Dpref:086-175-0535=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Punpun New1;;;=0D
FN:Punpun New1=0D
TEL;type=3Dpref:097-942-2442=0D
X-SOCIALPROFILE;type=3DLINE;x-user=3D=E2=80=AD097-942-2442=E2=80=AC:x-apple:=
%E2%80%AD097-942-2442%E2%80%AC=0D
X-SOCIALPROFILE;type=3DLINE;x-user=3D=E2=80=AD097-942-2442=E2=80=AC:x-apple:=
%E2%80%AD097-942-2442%E2%80%AC=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Punpun New2;;;=0D
FN:Punpun New2=0D
TEL;type=3Dpref:0979422442=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Purd;R;;;=0D
FN:R Purd=0D
TEL;type=3Dpref:0816110709=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Purd;R Purd;;;=0D
FN:R Purd Purd=0D
TEL;type=3Dpref:0816110709=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;R;;;=0D
FN:R=0D
TEL;type=3Dpref:081-453-4444=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;R Aoi Daddy Nurse 80;;;=0D
FN:R Aoi Daddy Nurse 80=0D
TEL;type=3Dpref:0924390880=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;R Aoi Grandmom;;;=0D
FN:R Aoi Grandmom=0D
TEL;type=3Dpref:083-751-8383=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:R.;Home;;;=0D
FN:Home R.=0D
TEL;type=3Dpref:025198979=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:R.;Home R.;;;=0D
FN:Home R. R.=0D
TEL;type=3Dpref:025198979=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;R Jim Yuiyui;;;=0D
FN:R Jim Yuiyui=0D
TEL;type=3Dpref:081-819-1919=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:R;M;Mun h.;;=0D
FN:M Mun h. R=0D
TEL;type=3Dpref:0839049438=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:R;M R;Mun h.;;=0D
FN:M R Mun h. R=0D
TEL;type=3Dpref:0839049438=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;R Noi =E0=B8=95=E0=B9=89=E0=B8=99=E0=B8=A1=E0=B8=B0=E0=B8=82=E0=B8=B2=E0=B8=
=A1;;;=0D
FN:R Noi =E0=B8=95=E0=B9=89=E0=B8=99=E0=B8=A1=E0=B8=B0=E0=B8=82=E0=B8=B2=E0=B8=
=A1=0D
TEL;type=3Dpref:081-836-9995=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;R Nopporn NV;;;=0D
FN:R Nopporn NV=0D
TEL;type=3Dpref:081-813-9854=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:ram.;My;number home;;=0D
FN:My number home ram.=0D
TEL;type=3DWORK;type=3DVOICE;type=3Dpref:029481904=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:RaMinthra;Naii;Nice;;=0D
FN:Naii Nice RaMinthra=0D
TEL;type=3Dpref:025525343=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:RaMinthra;Naii RaMinthra;Nice;;=0D
FN:Naii RaMinthra Nice RaMinthra=0D
TEL;type=3Dpref:025525343=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Ratanaporn;Aor;;;=0D
FN:Aor Ratanaporn=0D
TEL;type=3Dpref:+66893499999=0D
X-SOCIALPROFILE;type=3DLINE;x-user=3D=E2=80=AD+66 89-349-9999=E2=80=AC:x-app=
le:%E2%80%AD+66%2089-349-9999%E2%80%AC=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:ratvalee@set.or.th;;;;=0D
FN:ratvalee@set.or.th=0D
EMAIL;type=3DINTERNET;type=3Dpref:ratvalee@set.or.th=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:RB;Pii;prun love;;=0D
FN:Pii prun love RB=0D
TEL;type=3DWORK;type=3DVOICE;type=3Dpref:0898966142=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Re;Noomjit;;;=0D
FN:Noomjit Re=0D
TEL;type=3DWORK;type=3DVOICE;type=3Dpref:023928000=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Ree@ Satriwit;;;=0D
FN:Ree@ Satriwit=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:081-904-6151=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Ring4U;;;=0D
FN:Ring4U=0D
TEL;type=3Dpref:*119=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;RoamingOff;;;=0D
FN:RoamingOff=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:*106#=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;RoamingOn;;;=0D
FN:RoamingOn=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:*113*1#=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Rockacadamy ~ =E0=B8=A1=E0=B8=B4=E0=B9=80=E0=B8=8A=E0=B8=A5;;;=0D
FN:Rockacadamy ~ =E0=B8=A1=E0=B8=B4=E0=B9=80=E0=B8=8A=E0=B8=A5=0D
TEL;type=3Dpref:0972414562=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:RU.;Pook;Look;;=0D
FN:Pook Look RU.=0D
TEL;type=3DWORK;type=3DVOICE;type=3Dpref:0870350544=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;RU =E0=B8=A3=E0=B8=B2=E0=B8=A1=E0=B8=84=E0=B8=B3=E0=B9=81=E0=B8=AB=E0=B8=87=
;;;=0D
FN:RU =E0=B8=A3=E0=B8=B2=E0=B8=A1=E0=B8=84=E0=B8=B3=E0=B9=81=E0=B8=AB=E0=B8=87=
=0D
TEL;type=3Dpref:086-306-5174=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Rud;O's;;;=0D
FN:O's Rud=0D
TEL;type=3DWORK;type=3DVOICE;type=3Dpref:026697232=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Runway;Runwaymall;;;=0D
FN:Runwaymall Runway=0D
TEL;type=3Dpref:084-648-8413=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:s.;P;Meaw;;=0D
FN:P Meaw s.=0D
TEL;type=3Dpref:0869724444=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:s.;P s.;Meaw;;=0D
FN:P s. Meaw s.=0D
TEL;type=3Dpref:0869724444=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:S.;Pu;Vijittra;;=0D
FN:Pu Vijittra S.=0D
EMAIL;type=3DINTERNET;type=3Dpref:puvijittra@hotmail.com=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Saam;;;=0D
FN:Saam=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:081-559-0476=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Sahawat;Phattra;;;=0D
FN:Phattra Sahawat=0D
TEL;type=3Dpref:0896159999=0D
TEL:0822822822=0D
TEL:0818237777=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Sai-ubol;Siritapin;;;=0D
FN:Siritapin Sai-ubol=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:081-848-6333=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Salon Diva Hair =E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=AD=E0=B8=AD=E0=B8=A2;;;=
=0D
FN:Salon Diva Hair =E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=AD=E0=B8=AD=E0=B8=A2=0D=

TEL;type=3Dpref:02-949-8486=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Sang;;;=0D
FN:Sang=0D
TEL;type=3Dpref:0814978904=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;sanoocha@gmail.com;;;=0D
FN:sanoocha@gmail.com=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Sanpetchnarong;Sirisomsri;;;=0D
FN:Sirisomsri Sanpetchnarong=0D
TEL;type=3Dpref:087-825-4422=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Saonoi;P;;;=0D
FN:P Saonoi=0D
TEL;type=3Dpref:0816464270=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Saonoi;P Saonoi;;;=0D
FN:P Saonoi Saonoi=0D
TEL;type=3Dpref:0816464270=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Sarinjit;Lynny;;;=0D
FN:Lynny Sarinjit=0D
TEL;type=3Dpref:084-542-9888=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Sasiprapha;Apisada;;;=0D
FN:Apisada Sasiprapha=0D
TEL;type=3Dpref:081-174-2933=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Sasiprapha;Chantima;;;=0D
FN:Chantima Sasiprapha=0D
TEL;type=3Dpref:0818036803=0D
TEL:085-356-5445=0D
X-SOCIALPROFILE;type=3DLINE;x-user=3D=E2=80=AD085-356-5445=E2=80=AC:x-apple:=
%E2%80%AD085-356-5445%E2%80%AC=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Sasiprapha;Kam;;;=0D
FN:Kam Sasiprapha=0D
TEL;type=3Dpref:085-666-2974=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Scarlet Bar Pullman;;;=0D
FN:Scarlet Bar Pullman=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:022381991=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Scoozi;;;=0D
FN:Scoozi=0D
TEL;type=3Dpref:02-715-8555=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Scoozzi Pizza;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A4=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=AE=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=AE=E2=88=9A=
=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C2=AE=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A5 Scoozzi Pizza;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=AE=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=8F=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=AE=E2=88=9A=E2=80=A0=C2=AC=
=CF=80=C2=AC=C3=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=AE=E2=
=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A5 Scoozzi Pizza Scoozzi Pizza=0D
TEL;type=3Dpref:0909901154=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Scoozzi Pizza;=E0=B8=8A=E0=B8=B4=E0=B8=A8=E0=B8=93=E0=B8=B8=E0=B8=9E=E0=B8=
=87=E0=B8=A8=E0=B9=8C=E0=B8=9E=E0=B8=87=E0=B8=A8=E0=B9=8C;;;=0D
FN:=E0=B8=8A=E0=B8=B4=E0=B8=A8=E0=B8=93=E0=B8=B8=E0=B8=9E=E0=B8=87=E0=B8=A8=E0=
=B9=8C=E0=B8=9E=E0=B8=87=E0=B8=A8=E0=B9=8C Scoozzi Pizza=0D
TEL;type=3Dpref:0909901154=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Sek;R;;;=0D
FN:R Sek=0D
TEL;type=3DWORK;type=3DVOICE;type=3Dpref:0818292610=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:seller@payoneer.com;;;;=0D
FN:seller@payoneer.com=0D
EMAIL;type=3DINTERNET;type=3Dpref:seller@payoneer.com=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:shaeennoi;nond shaeennoi;;;=0D
FN:nond shaeennoi shaeennoi=0D
EMAIL;type=3DINTERNET;type=3Dpref:maesheenoi@yahoo.com=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:shine;N;;;=0D
FN:N shine=0D
TEL;type=3Dpref:0818338222=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Si Punpun;;;=0D
FN:Si Punpun=0D
TEL;type=3Dpref:085-920-9449=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Sii Pun;;;=0D
FN:Sii Pun=0D
TEL;type=3Dpref:085-920-9449=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Sirana;Tu;;;=0D
FN:Tu Sirana=0D
TEL;type=3Dpref:081-922-5559=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Siriporn Rattanamangkla;;;=0D
FN:Siriporn Rattanamangkla=0D
ORG:waso training;=0D
EMAIL;type=3DINTERNET;type=3Dpref:srp@wasotraining.com=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:sis;Kam;kam;;=0D
FN:Kam kam sis=0D
TEL;type=3Dpref:0870928070=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:sis;Kam sis;kam;;=0D
FN:Kam sis kam sis=0D
TEL;type=3Dpref:0870928070=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Smile Yoga;;;=0D
FN:Smile Yoga=0D
TEL;type=3Dpref:080-295-2964=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:SMS;Cancel;;;=0D
FN:Cancel SMS=0D
TEL;type=3Dpref:*137=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Somjit;R.;;;=0D
FN:R. Somjit=0D
TEL;type=3Dpref:0817421387=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Somjit;R. Somjit;;;=0D
FN:R. Somjit Somjit=0D
TEL;type=3Dpref:0817421387=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Springmate =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C2=A7=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B5=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C2=A3;;;=0D
FN:Springmate =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C2=A7=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B5=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C2=A3=0D
TEL;type=3Dpref:02-322-4320=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Springmate =E0=B8=99=E0=B8=A4=E0=B8=9B=E0=B8=81=E0=B8=A3;;;=0D
FN:Springmate =E0=B8=99=E0=B8=A4=E0=B8=9B=E0=B8=81=E0=B8=A3=0D
TEL;type=3Dpref:02-322-4320=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Sriyabhandha;Komsun;Gobgap;;=0D
FN:Komsun Gobgap Sriyabhandha=0D
TEL;type=3Dpref:0894915659=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Style;In;;;=0D
FN:In Style=0D
TEL;type=3DWORK;type=3DVOICE;type=3Dpref:026196616=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:subhavat@navankorn.co.th;subhavat@navankorn.co.th;;;=0D
FN:subhavat@navankorn.co.th subhavat@navankorn.co.th=0D
EMAIL;type=3DINTERNET;type=3Dpref:subhavat@navankorn.co.th=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Sukanant;Jim;;;=0D
FN:Jim Sukanant=0D
ORG:P Joom;=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:089-245-1974=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;support@english-channel.tv;;;=0D
FN:support@english-channel.tv=0D
EMAIL;type=3DINTERNET;type=3Dpref:support@english-channel.tv=0D
EMAIL;type=3DINTERNET:tracey@team.enfour.com=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:support@statcounter.com;;;;=0D
FN:support@statcounter.com=0D
EMAIL;type=3DINTERNET;type=3Dpref:support@statcounter.com=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Suvaree;Wuthikorn;;;=0D
FN:Wuthikorn Suvaree=0D
TEL;type=3Dpref:085-558-5988=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Suwapen;May;;;=0D
FN:May Suwapen=0D
TEL;type=3Dpref:0812091515=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Tap;;;=0D
FN:Tap=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:081-620-9843=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Tea;P;;;=0D
FN:P Tea=0D
TEL;type=3Dpref:0841598212=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Team;Facebook;;The;=0D
FN:The Facebook Team=0D
EMAIL;type=3DINTERNET;type=3Dpref:info+0z6ii2@support.facebook.com=0D
TEL;type=3DWORK;type=3DVOICE;type=3Dpref:650 543-4800=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Team;Gmail;;;=0D
FN:Gmail Team=0D
EMAIL;type=3DINTERNET;type=3Dpref:mail-noreply@google.com=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Thai Dancing School;P May;;;=0D
FN:P May Thai Dancing School=0D
TEL;type=3Dpref:096-142-3613=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Thai Dancing School;P May Thai Dancing School;;;=0D
FN:P May Thai Dancing School Thai Dancing School=0D
TEL;type=3Dpref:096-142-3613=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:thai.;Kru;wun rum;;=0D
FN:Kru wun rum thai.=0D
TEL;type=3Dpref:0815632278=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Thaiyogainsitute class;;;=0D
FN:Thaiyogainsitute class=0D
EMAIL;type=3DINTERNET;type=3Dpref:walapa_tyi@yahoo.com=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;The Klinigue Siam;;;=0D
FN:The Klinigue Siam=0D
TEL;type=3Dpref:0800009800=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;The Klinique FI;;;=0D
FN:The Klinique FI=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:0847627999=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;The Skin Clinic =E0=B8=A7=E0=B8=B1=E0=B8=8A=E0=B8=A3=E0=B8=9E=E0=B8=A5;;;=
=0D
FN:The Skin Clinic =E0=B8=A7=E0=B8=B1=E0=B8=8A=E0=B8=A3=E0=B8=9E=E0=B8=A5=0D=

TEL;type=3Dpref:02-793-4517=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:The Walk;Yoga&Me;;;=0D
FN:Yoga&Me The Walk=0D
TEL;type=3Dpref:0985629264=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:The Walk;YogaMe The Walk;;;=0D
FN:YogaMe The Walk The Walk=0D
TEL;type=3Dpref:0985629264=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Thop =E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=AD=E0=B8=B2=E0=B8=88;;;=0D
FN:Thop =E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=AD=E0=B8=B2=E0=B8=88=0D
TEL;type=3Dpref:081-621-4332=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Tiger sofewre =E0=B8=81=E0=B8=A5=E0=B8=AD=E0=B8=99;=E0=B8=84=E0=B8=B8=E0=B8=
=93 =E0=B8=A1=E0=B8=B4=E0=B8=84=E0=B8=81=E0=B8=B5=E0=B9=89 Admin;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93 =E0=B8=A1=E0=B8=B4=E0=B8=84=E0=B8=81=E0=B8=B5=
=E0=B9=89 Admin Tiger sofewre =E0=B8=81=E0=B8=A5=E0=B8=AD=E0=B8=99=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:0970818787=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:tiii;Piii;;;=0D
FN:Piii tiii=0D
TEL;type=3Dpref:0818675743=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:tiii;Piii tiii;;;=0D
FN:Piii tiii tiii=0D
TEL;type=3Dpref:0818675743=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;TMB;;;=0D
FN:TMB=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:1558=0D
TEL:0642139089=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Toi;Na;;;=0D
FN:Na Toi=0D
TEL;type=3Dpref:0818345550=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Toi;Na Toi;;;=0D
FN:Na Toi Toi=0D
TEL;type=3Dpref:0818345550=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;toktakkung@hotmail.com;;;=0D
FN:toktakkung@hotmail.com=0D
EMAIL;type=3DINTERNET;type=3Dpref:toktakkung@hotmail.com=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Ton;P;;;=0D
FN:P Ton=0D
TEL;type=3Dpref:0818293010=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Ton;P Ton;;;=0D
FN:P Ton Ton=0D
TEL;type=3Dpref:0818293010=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Tongbai;;;=0D
FN:Tongbai=0D
TEL;type=3DWORK;type=3DVOICE;type=3Dpref:0875168804=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Tongbai New;;;=0D
FN:Tongbai New=0D
TEL;type=3Dpref:0968521956=0D
X-SOCIALPROFILE;type=3DLINE;x-user=3D=E2=80=AD096-852-1956=E2=80=AC:x-apple:=
%E2%80%AD096-852-1956%E2%80%AC=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Tongbai nNew;;;=0D
FN:Tongbai nNew=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:0968521956=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Tont Womg;;;=0D
FN:Tont Womg=0D
TEL;type=3DOTHER;type=3DVOICE;type=3Dpref:0904146999=0D
ADR;type=3DHOME;type=3Dpref:;;;;;0;TH=0D
X-SOCIALPROFILE;type=3DLINE;x-user=3D=E2=80=AD+66 90-414-6999=E2=80=AC:x-app=
le:%E2%80%AD+66%2090-414-6999%E2%80%AC=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Tont Wong;;;=0D
FN:Tont Wong=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:081-626-7111=0D
TEL;type=3DCELL;type=3DVOICE:090-414-6999=0D
X-SOCIALPROFILE;type=3DLINE;x-user=3D=E2=80=AD081-626-7111=E2=80=AC:x-apple:=
%E2%80%AD081-626-7111%E2%80%AC=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Tooth Fairy;;;=0D
FN:Tooth Fairy=0D
TEL;type=3Dpref:02-949-8988=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Top;Up;;;=0D
FN:Up Top=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:9301=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;TourisInfo;;;=0D
FN:TourisInfo=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:1672=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;TrueLife;;;=0D
FN:TrueLife=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:029009119=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;TrueMoney;;;=0D
FN:TrueMoney=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:*876#=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;TrueYou;;;=0D
FN:TrueYou=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:029995555=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Tu;P;;;=0D
FN:P Tu=0D
TEL;type=3Dpref:086-902-7888=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Tu;P Tu;;;=0D
FN:P Tu Tu=0D
TEL;type=3Dpref:086-902-7888=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:tuangtip1@yahoo.com;;;;=0D
FN:tuangtip1@yahoo.com=0D
EMAIL;type=3DINTERNET;type=3Dpref:tuangtip1@yahoo.com=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Tud Tu;;;=0D
FN:Tud Tu=0D
TEL;type=3Dpref:086-311-2019=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;U;;;=0D
FN:U=0D
TEL;type=3Dpref:0801562916=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;U Drink I Drive;;;=0D
FN:U Drink I Drive=0D
TEL;type=3Dpref:091-080-9108=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;UDID;;;=0D
FN:UDID=0D
ORG:Driver;=0D
TEL;type=3Dpref:0934391959=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Un;;;=0D
FN:Un=0D
TEL;type=3DWORK;type=3DVOICE;type=3Dpref:0818151144=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Unsubscribe;;;=0D
FN:Unsubscribe=0D
item1.EMAIL;type=3DINTERNET;type=3Dpref:unsubscribe@post.pinterest.com=0D
item1.X-ABLabel:_%2524%2521%253COther%253E%2521%2524_=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Usa.;Salin;;;=0D
FN:Salin Usa.=0D
TEL;type=3Dpref:00116193168514=0D
TEL:00916193375009=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Usa.;Salin Usa.;;;=0D
FN:Salin Usa. Usa.=0D
TEL;type=3Dpref:00916193375009=0D
TEL:00116193168514=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:USA;=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B9=81=E0=B8=AD=E0=B8=99;;;=0D
FN:=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B9=81=E0=B8=AD=E0=B8=99 USA=0D
TEL;type=3Dpref:+1 425 753-7955=0D
ADR;type=3DWORK;type=3Dpref:;;14805 89th Pl. NE;Kenmore;WA;98028;United Stat=
es=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Usicha;Fai;;;=0D
FN:Fai Usicha=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:081-611-7507=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Vaidyanuvatti;Noon;;;=0D
FN:Noon Vaidyanuvatti=0D
ORG:Tiger Square;=0D
TEL;type=3DWORK;type=3DVOICE;type=3Dpref:0818605353=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Vichaiyut Dentist;;;=0D
FN:Vichaiyut Dentist=0D
TEL;type=3Dpref:086-783-7006=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Vichitratana;Amp;;;=0D
FN:Amp Vichitratana=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:+1 954 736-6677=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;VIP;;;=0D
FN:VIP=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;VirusTotal;;;=0D
FN:VirusTotal=0D
EMAIL;type=3DINTERNET;type=3Dpref:contact@virustotal.com=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:vitoon_press@hotmail.com;;;;=0D
FN:vitoon_press@hotmail.com=0D
EMAIL;type=3DINTERNET;type=3Dpref:vitoon_press@hotmail.com=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:VK;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=93=E0=B8=AD=E0=B8=B2;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=93=E0=B8=AD=E0=B8=B2 VK=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:0818060007=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:voraratckv@gmail.com;voraratckv@gmail.com;;;=0D
FN:voraratckv@gmail.com voraratckv@gmail.com=0D
EMAIL;type=3DINTERNET;type=3Dpref:voraratckv@gmail.com=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;VVwear;;;=0D
FN:VVwear=0D
TEL;type=3Dpref:095-641-4456=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;W Plastic Surgery Hospital;;;=0D
FN:W Plastic Surgery Hospital=0D
TEL;type=3Dpref:0917746666=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:warattada.meow@gmail.com;;;;=0D
FN:warattada.meow@gmail.com=0D
EMAIL;type=3DINTERNET;type=3Dpref:warattada.meow@gmail.com=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Warmmy;Warm;;;=0D
FN:Warm Warmmy=0D
TEL;type=3Dpref:081-716-8333=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:wat;N;Bow;;=0D
FN:N Bow wat=0D
TEL;type=3DWORK;type=3DVOICE;type=3Dpref:66843991311=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:wat;P;Bim;;=0D
FN:P Bim wat=0D
TEL;type=3Dpref:0892427159=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:wat;P wat;Bim;;=0D
FN:P wat Bim wat=0D
TEL;type=3Dpref:0892427159=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:wat;Pa;Toi;;=0D
FN:Pa Toi wat=0D
TEL;type=3Dpref:0897812442=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:watch;Contina;;;=0D
FN:Contina watch=0D
TEL;type=3Dpref:022541038=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Wattanasin;Jirayut;;;=0D
FN:Jirayut Wattanasin=0D
TEL;type=3DWORK;type=3DVOICE;type=3Dpref:0818139696=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;We Ra~=E0=B8=9D=E0=B8=99;;;=0D
FN:We Ra~=E0=B8=9D=E0=B8=99=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:081-425-5007=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Wellness Spa;;;=0D
FN:Wellness Spa=0D
TEL;type=3Dpref:093-394-2464=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Windows Live Team;;;=0D
FN:Windows Live Team=0D
EMAIL;type=3DINTERNET;type=3Dpref:communications@microsoft.windowslive.com=0D=

END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Witunkolachit;Rachata;;;=0D
FN:Rachata Witunkolachit=0D
EMAIL;type=3DINTERNET;type=3Dpref:cscoolingair@gmail.com=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Wong;Tont;;;=0D
FN:Tont Wong=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:081-626-7111=0D
TEL;type=3DCELL;type=3DVOICE:090-414-6999=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Woon;Howard;;;=0D
FN:Howard Woon=0D
TEL;type=3Dpref:081-906-7991=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Y;;;=0D
FN:Y=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:2-588-0=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Yanhee;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=9B=E0=B8=A5=E0=B8=B2=E0=B8=A7=E0=B8=
=B2=E0=B8=AC;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=9B=E0=B8=A5=E0=B8=B2=E0=B8=A7=E0=B8=B2=E0=
=B8=AC Yanhee=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:096-095-4177=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Yoga Elements;;;=0D
FN:Yoga Elements=0D
ORG:Studio;=0D
TEL;type=3Dpref:02-655-5671=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Yoga Elements Studio;;;=0D
FN:Yoga Elements Studio=0D
ORG:Studio;=0D
TEL;type=3Dpref:02-655-5671=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:yud;Pa;Say;;=0D
FN:Pa Say yud=0D
TEL;type=3Dpref:038223002=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Yugala;Mieng;;;=0D
FN:Mieng Yugala=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:+66 81-927-9942=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Yui;Noon;;;=0D
FN:Noon Yui=0D
ORG:Tiger Square;=0D
TEL;type=3DWORK;type=3DVOICE;type=3Dpref:0818605353=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Yui-cousin;;;=0D
FN:Yui-cousin=0D
TEL;type=3Dpref:0840999099=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Yuiyui;;;=0D
FN:Yuiyui=0D
TEL;type=3Dpref:083-835-1717=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Zanotti;Gee;;;=0D
FN:Gee Zanotti=0D
TEL;type=3Dpref:090-971-5599=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Zecret;;;=0D
FN:Zecret=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:085 159 7777=0D
ADR;type=3DWORK;type=3Dpref:;;;;;;Thailand=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Zecret Clinic;;;=0D
FN:Zecret Clinic=0D
TEL;type=3Dpref:0851597777=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Zentana SPA;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=
=CF=80=C2=AC=C3=A5 Zentana SPA;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=
=C3=A5 Zentana SPA Zentana SPA=0D
TEL;type=3Dpref:02-793-4525=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:Zentana SPA;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=99=E0=B8=87=E0=B8=84=E0=B9=8C=
;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=99=E0=B8=87=E0=B8=84=E0=B9=8C Zentana S=
PA=0D
TEL;type=3Dpref:02-793-4525=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;Zija;;;=0D
FN:Zija=0D
TEL;type=3Dpref:02-694-2286=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=F0=9F=8E=8B=E2=9C=A8=F0=9F=90=B0=E2=9C=A815;PK=F0=9F=8E=8B=E2=9C=A8=F0=9F=
=90=AE=E2=9C=A815=F0=9F=92=99;;;=0D
FN:PK=F0=9F=8E=8B=E2=9C=A8=F0=9F=90=AE=E2=9C=A815=F0=9F=92=99 =F0=9F=8E=8B=E2=
=9C=A8=F0=9F=90=B0=E2=9C=A815=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:+66 6-5628-9615=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=F0=9F=8E=8B=F0=9F=8D=80=F0=9F=95=AF=E2=99=A5=EF=B8=8F;PK 55;;;=0D
FN:PK 55 =F0=9F=8E=8B=F0=9F=8D=80=F0=9F=95=AF=E2=99=A5=EF=B8=8F=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:094-639-4655=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;0057;;;=0D
FN:0057=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:098-017-0557=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;;;;=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:027920021=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;;;;=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:0866662007=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;;;;=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:0928582172=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:0986362955;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=84=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=
 0986362955;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=E2=84=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2 098636295=
5 0986362955=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:0986362955;=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=AA=E0=B8=B2=E0=B8=A7=E0=B8=99=
=E0=B9=89=E0=B8=AD=E0=B8=A2;;;=0D
FN:=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=AA=E0=B8=B2=E0=B8=A7=E0=B8=99=E0=B9=89=E0=
=B8=AD=E0=B8=A2 0986362955=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;1 =E2=9D=A4=EF=B8=8F Cleaner;;;=0D
FN:1 =E2=9D=A4=EF=B8=8F Cleaner=0D
TEL;type=3Dpref:023005763=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:1.;N;ball nv;;=0D
FN:N ball nv 1.=0D
TEL;type=3Dpref:0817324741=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:1.;N 1.;ball nv;;=0D
FN:N 1. ball nv 1.=0D
TEL;type=3Dpref:0817324741=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;;;;=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:*106#=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;;;;=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:1193=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;;;;=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:*121#=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;;;;=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:*129#=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;15/1 Nurse PMK;;;=0D
FN:15/1 Nurse PMK=0D
TEL;type=3Dpref:02-763-3294=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;151 Nurse PMK;;;=0D
FN:151 Nurse PMK=0D
TEL;type=3Dpref:02-763-3294=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;;;;=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:*165=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;;;;=0D
TEL;type=3Dpref:*165=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;;;;=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:*165*1#=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;;;;=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:*165*2#=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;;;;=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:1669=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;;;;=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:1677=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;;;;=0D
TEL;type=3Dpref:*1802=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:2199;Khun R Tony;;;=0D
FN:Khun R Tony 2199=0D
TEL;type=3Dpref:089-139-2199=0D
X-SOCIALPROFILE;type=3DLINE;x-user=3D=E2=80=AD089-139-2199=E2=80=AC:x-apple:=
%E2%80%AD089-139-2199%E2%80%AC=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:2199;Khun R Tony 2199;;;=0D
FN:Khun R Tony 2199 2199=0D
TEL;type=3Dpref:089-139-2199=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;3;;;=0D
FN:3=0D
TEL;type=3Dpref:0815590476=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:3;P;Khong;;=0D
FN:P Khong 3=0D
TEL;type=3Dpref:0863355668=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:3;P 3;Khong;;=0D
FN:P 3 Khong 3=0D
TEL;type=3Dpref:0863355668=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:5656;P;Khong;;=0D
FN:P Khong 5656=0D
TEL;type=3Dpref:085-529-5656=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:57 Total Beauty Hair;57 Total Beauty Hair;;;=0D
FN:57 Total Beauty Hair 57 Total Beauty Hair=0D
TEL;type=3Dpref:02-108-9874=0D
item1.URL;type=3Dpref:ms-outlook://people/AQMkAGM4YzkwMAItMjM5OC01OTU4LTAwAi=
0wMAoARgAAA4lPVhdeXgB8SKotnuI_8RfOBwDiulGfBVPESL-9FOXxou_fAAACAQ4AAADiulGfBV=
PESL-9FOXxou_fAAAAJCOrqQAAAA=3D=3D?accountKey=3Dfbcfd54b16181902db402212ea7f=
a1a5&accountExportedAt=3D549396167.507626=0D
item1.X-ABLabel:Outlook=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:69;=E0=B8=99=E0=B9=89=E0=B8=B2=E0=B8=99=E0=B8=B8=E0=B8=8A;;;=0D
FN:=E0=B8=99=E0=B9=89=E0=B8=B2=E0=B8=99=E0=B8=B8=E0=B8=8A 69=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:090-059-9969=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;;;;=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:*700#=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;700/22 Soi Nawamin 74;;;=0D
FN:700/22 Soi Nawamin 74=0D
item1.URL;type=3Dpref:ms-outlook://people/AQMkAGM4YzkwMAItMjM5OC01OTU4LTAwAi=
0wMAoARgAAA4lPVhdeXgB8SKotnuI_8RfOBwDiulGfBVPESL-9FOXxou_fAAACAQ4AAADiulGfBV=
PESL-9FOXxou_fAAAAJCOrHAAAAA=3D=3D?accountKey=3Dfbcfd54b16181902db402212ea7f=
a1a5&accountExportedAt=3D549396167.507626=0D
item1.X-ABLabel:Outlook=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;;;;=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:*777#=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:8 Thonglor;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=
=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C3=A3=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=9E=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=
=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B5=E2=88=9A=E2=80=A0=C2=AC=
=CF=80=C2=AC=C3=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4 8 Thonglo=
r;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=CF=80=
=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A3=E2=88=
=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=
=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=E2=88=9E=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=84=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=
=C3=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4 8 Thonglor 8 Thonglor=
=0D
TEL;type=3Dpref:085-350-5267=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:8 Thonglor;=E0=B8=A3=E0=B9=89=E0=B8=B2=E0=B8=99=E0=B8=8B=E0=B9=88=E0=B8=AD=
=E0=B8=A1=E0=B8=81=E0=B8=A3=E0=B8=B0=E0=B9=80=E0=B8=9B=E0=B9=8B=E0=B8=B2;;;=0D=

FN:=E0=B8=A3=E0=B9=89=E0=B8=B2=E0=B8=99=E0=B8=8B=E0=B9=88=E0=B8=AD=E0=B8=A1=E0=
=B8=81=E0=B8=A3=E0=B8=B0=E0=B9=80=E0=B8=9B=E0=B9=8B=E0=B8=B2 8 Thonglor=0D
TEL;type=3Dpref:085-350-5267=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:9 JWR;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=
=E2=80=A0=C2=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B5=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=
=AC=C3=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C3=85 JTC 9 JWR;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=
=A0=C2=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B5=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=
=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C3=85 JTC 9 JWR 9 JWR=0D
TEL;type=3Dpref:0896883644=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:9 JWR;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B9=80=E0=B8=9B=E0=B8=B5=E0=B9=8A=E0=B8=
=A2=E0=B8=81 JTC;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B9=80=E0=B8=9B=E0=B8=B5=E0=B9=8A=E0=B8=A2=E0=
=B8=81 JTC 9 JWR=0D
TEL;type=3Dpref:0896883644=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;912;;;=0D
FN:912=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A0=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=82=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=
=85;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A0=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=82=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=
=85=0D
TEL;type=3Dpref:0898814949=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C3=A4;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=
=80=A0=C2=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AF =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=
=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A4;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=
=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AF =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=
=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A4 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=
=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A4=0D
TEL;type=3Dpref:083-297-8498=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C2=A3 =E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=84=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=80=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=E2=84=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B3=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3;=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=8F=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C3=A1 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4 PMK =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3 =E2=
=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=E2=80=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=84=A2=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A4=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=
=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C2=A3;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A1 =E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4 PMK =E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C3=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C2=A3 =E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=E2=80=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=84=
=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C3=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B3=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3 =E2=
=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=E2=80=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=84=A2=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A4=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=
=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C2=A3=0D
TEL;type=3Dpref:087-564-0989=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A8=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4 Book Siam;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A8=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4 Book Siam=0D
TEL;type=3Dpref:02-218-9888=0D
TEL:02-218-9881=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AF=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AF;=
;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AF=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AF=0D=

TEL;type=3Dpref:085-955-6999=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91 (=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=BA=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0)=
;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=
=A0=C2=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B6=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A7 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C3=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C3=91 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BA=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=
=A0=C2=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B6=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A7 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C3=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C3=91 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BA=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C3=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C3=91 (=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BA=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0)=0D
TEL;type=3Dpref:0641813589=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=B5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=AE=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=E2=84=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C3=AF=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=
=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A5;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=
=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=89=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A0=
 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=B5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=AE=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=E2=84=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C3=AF=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=
=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A5;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A5=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A0 =E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B5=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=AE=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=84=A2=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AF=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A5=
 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=B5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=AE=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=E2=84=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C3=AF=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=
=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A5=0D
TEL;type=3Dpref:081-945-3280=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A3.=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B5=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=
=AC=C3=A5;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=E2=80=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C2=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=
=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=CF=
=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=B3 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A3.=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=88=
=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A5 =E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=
=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C3=B3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=
=C2=AC=CF=80=C2=AC=C3=A5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=85=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BA=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=
=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C3=B3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C3=B5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=9E=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=
=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AF=E2=88=9A=E2=80=
=A0=C2=AC=CF=80=C2=AC=C3=A5;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=80=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=8F=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=
=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C3=B3 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A3.=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=
=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=
=A0=C2=AC=CF=80=C2=AC=C3=A5 =E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=85=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C3=B3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=CF=
=80=C2=AC=C3=A5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C3=BA=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=
=E2=80=A0=C2=AC=CF=80=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B3=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C3=B5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=E2=88=9E=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AF=E2=88=9A=E2=80=A0=C2=AC=
=CF=80=C2=AC=C3=A5 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A3.=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=
=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=
=A0=C2=AC=CF=80=C2=AC=C3=A5=0D
ORG:=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B3=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A5=E2=88=9A=
=E2=80=A0=C2=AC=CF=80=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BA=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=
=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B3=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B5=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=
=9E=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=AF=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A5;=0D=

TEL;type=3Dpref:02-617-0285=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=80=A2=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C3=B1 benz;=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C3=86=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B5=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=
=84=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C2=AE=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AE=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=
=C3=A5 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=E2=80=A2=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=
=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C3=B1 benz;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C3=86=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=84=A2=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C2=AE=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AE=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A5 =E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=E2=80=A2=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=
=B1 benz =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=E2=80=A2=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=
=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C3=B1 benz=0D
TEL;type=3Dpref:06-1445-6565=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=CF=80=
=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C2=A2 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=
=AC=CF=80=C2=AC=C3=A5;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=CF=80=
=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C2=A2 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=
=AC=CF=80=C2=AC=C3=A5=0D
TEL;type=3Dpref:086-626-4321=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=80=A2=E2=88=9A=E2=
=80=A0=C2=AC=CF=80=C2=AC=C3=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BC S=
w;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=80=A2=E2=88=9A=E2=
=80=A0=C2=AC=CF=80=C2=AC=C3=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BC S=
w=0D
TEL;type=3Dpref:080-624-6008=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=89=A5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=91=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C2=A3 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C3=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B5=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B6=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=
=B4;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=89=A5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=91=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C2=A3 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C3=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B5=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B6=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=
=B4=0D
ORG:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A4=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C3=B6=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4;=0D
TEL;type=3Dpref:086-175-0535=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AE=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A1 =E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=B5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C3=B5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C3=B4;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AE=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A1 =E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=B5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C3=B5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C3=B4=0D
TEL;type=3Dpref:06-4456-3536=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AE=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=E2=80=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=
=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=E2=84=A2=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=84=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AF=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=
=AC=CF=80=C2=AC=C3=A5;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AE=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=E2=80=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=
=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=E2=84=A2=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=84=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AF=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=
=AC=CF=80=C2=AC=C3=A5=0D
TEL;type=3Dpref:0863551466=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=8F=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85 Makeup;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=8F=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85 Makeup=0D
TEL;type=3Dpref:081-996-1565=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C3=A3=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C3=A1;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C3=A3=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C3=A1=0D
TEL;type=3Dpref:0909075750=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C3=A3=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C3=A1;Atrium =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C3=AC=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C2=B0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A3=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=
=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A1;;;=0D
FN:Atrium =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C2=B0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C3=A3=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=A1 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C3=AC=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A3=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=
=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A1=0D
TEL;type=3Dpref:083-786-7000=0D
TEL:02-729-6988=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=8F=
=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C2=B0 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AF=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=87=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=80=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C3=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=E2=89=A4;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=8F=
=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C2=B0 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AF=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=87=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=80=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C3=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=E2=89=A4=0D
TEL;type=3Dpref:0813587210=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=8F=
=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C3=A1 =E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C3=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A1=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=CF=80=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=
=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B5=E2=88=9A=E2=80=A0=C2=AC=CF=
=80=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=AF=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4;=
;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=8F=
=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C3=A1 =E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C3=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A1=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=CF=80=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=
=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B5=E2=88=9A=E2=80=A0=C2=AC=CF=
=80=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=AF=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=0D=

TEL;type=3Dpref:081-307-6002=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A7=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C3=AC=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=
=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A5 Benz =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C2=B0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=
=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B3=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A7=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C3=AC=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=
=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A5 Benz =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C2=B0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=
=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B3=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=0D
ORG:Benz =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C2=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C3=B3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4;=0D
TEL;type=3Dpref:085-660-8171=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=AA=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5 =E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=
=CF=80=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=9F;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=AA=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5 =E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=
=CF=80=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=0D
TEL;type=3Dpref:089-120-8082=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=AE=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F Holostic;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=AE=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F Holostic=0D
TEL;type=3Dpref:081-818-7309=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=AE=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=
=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85 =E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=
=C2=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B3=E2=88=9A=
=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=
=A4;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=AE=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=
=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85 =E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=
=C2=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B3=E2=88=9A=
=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=
=A4=0D
TEL;type=3Dpref:083-248-5091=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=CF=80=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2 =E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=
=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A8=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C2=AE=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=E2=80=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B5=
=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A5 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=E2=84=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B2=E2=88=9A=E2=80=A0=C2=AC=CF=
=80=C2=AC=C3=A5;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=CF=80=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2 =E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=
=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A8=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C2=AE=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=E2=80=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B5=
=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A5 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=E2=84=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B2=E2=88=9A=E2=80=A0=C2=AC=CF=
=80=C2=AC=C3=A5=0D
TEL;type=3Dpref:0852855118=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C3=AC=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=9E =E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B6=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A4=
 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=
=A0=C2=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C3=B4;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C3=AC=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=9E =E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B6=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A4=
 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=
=A0=C2=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C3=B4=0D
TEL;type=3Dpref:02-310-8237=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=B6=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C3=AE=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C3=A0 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=
=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C3=B5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=AE;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=B6=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C3=AE=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C3=A0 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=
=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C3=B5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=AE=0D
TEL;type=3Dpref:0879951110=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=B5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=91=
=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C3=AE;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=B5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=91=
=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C3=AE=0D
TEL;type=3Dpref:081-356-4302=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=
=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B6=E2=88=9A=E2=80=A0=C2=AC=CF=80=
=C2=AC=C3=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=B6 Jewel Trade;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=
=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B6=E2=88=9A=E2=80=A0=C2=AC=CF=80=
=C2=AC=C3=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=B6 Jewel Trade=0D
ORG:Jewel Trade;=0D
TEL;type=3Dpref:081-913-5611=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=E2=84=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A4=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C3=AF=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5 Call center;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=E2=84=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A4=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C3=AF=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5 Call center=0D
ORG:Call center;=0D
TEL;type=3Dpref:02-755-1058=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=E2=84=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=
=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AE;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=E2=84=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=
=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AE=0D
TEL;type=3Dpref:087-509-0808=0D
TEL:089-777-0895=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC =E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4 TMB =E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F;=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=
=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC =E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=B4 TMB =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=
=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC =E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4 TMB =E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F =E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=
=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC =E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=B4 TMB =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=
=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=0D
TEL;type=3Dpref:085-487-9239=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=8F=
=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C3=A1 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B5=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C3=AF=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=8F=
=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C3=A1 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B5=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C3=AF=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=0D
TEL;type=3Dpref:0818701976=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=
=A0=C2=AC=CF=80=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=
=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C3=AE =E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C3=B6=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A1=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B3=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=E2=80=A2=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=
=A0=C2=AC=CF=80=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=
=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C3=AE =E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C3=B6=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A1=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B3=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=E2=80=A2=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=0D
TEL;type=3Dpref:081-732-1441=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=
=A4=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=87=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C3=B3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0 22;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=
=A4=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=87=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C3=B3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0 22=0D
TEL;type=3Dpref:089-814-2222=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=
=A0=C2=AC=CF=80=C2=AC=C3=89=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=
=A0 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AE=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=8F=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=
=B2;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=
=A0=C2=AC=CF=80=C2=AC=C3=89=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=
=A0 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AE=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=8F=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=
=B2=0D
TEL;type=3Dpref:089-573-4843=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=
=A0=C2=AC=CF=80=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=
=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0 =E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=
=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=80=A2=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C3=87=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4 =E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AE=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=
=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=
=A0=C2=AC=CF=80=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=
=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0 =E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=
=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=80=A2=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C3=87=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4 =E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AE=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=
=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=0D
TEL;type=3Dpref:081-442-4942=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=80=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=
=80=A2;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=E2=80=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=
=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=E2=80=A2;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=80=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=
=80=A2 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=E2=80=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=
=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=E2=80=A2=0D
TEL;type=3Dpref:02-669-3147=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=CF=80=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=B6=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B5=E2=88=
=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A3;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=CF=80=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=B6=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B5=E2=88=
=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A3=0D
TEL;type=3Dpref:081-551-7005=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=CF=80=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=
=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=
=B3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB =E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3. English =E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=80=A2=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=
=B3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=CF=80=
=C2=AC=C3=A5;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=CF=80=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=
=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=
=B3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB =E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3. English =E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=80=A2=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=
=B3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=CF=80=
=C2=AC=C3=A5=0D
ORG:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C2=A3. English =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=E2=80=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=
=A3=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A5;=0D
TEL;type=3Dpref:081-633-8696=0D
TEL:02-363-7650=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=80=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=B4 2558;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=80=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=B4 2558=0D
TEL;type=3Dpref:+16193168514=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=80=A0=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C3=B3;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A3=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C2=A2 RU =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=E2=80=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B3;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=
=8F=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C2=A2 RU =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=E2=80=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=B3 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=E2=80=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B3=0D
TEL;type=3Dpref:086-390-1005=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C3=B6=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=E2=80=A2 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB. =E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=
=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C3=B3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C3=B6=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=E2=80=A2 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB. =E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=
=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C3=B3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=0D
TEL;type=3Dpref:023103013=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=AE=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=80=A0=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AF=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A5;=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=8F=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AE =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C2=A2 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=AE=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=80=A0=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C2=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AF=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A5;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=
=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AE =E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=
=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=CF=
=80=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C2=A2 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=AE=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=80=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AF=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=
=C3=A5 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=AE=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=80=A0=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C2=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AF=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A5=0D
TEL;type=3Dpref:088-227-7081=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B3=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C2=A3 Ram =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=
=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=CF=80=
=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=B6=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C3=B4;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BC=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=E2=80=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=8F=E2=88=
=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=
=91 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B3=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3 Ram =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=CF=
=80=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=B6=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C3=B4;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BC=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=80=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=8F=E2=88=9A=E2=
=80=A0=C2=AC=CF=80=C2=AC=C3=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91 =E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C2=A3 Ram =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=
=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C3=B6=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=
 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B3=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C2=A3 Ram =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=
=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=CF=80=
=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=B6=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C3=B4=0D
TEL;type=3Dpref:099-110-2051=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AE=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C2=B1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=8F=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B2=
;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AE=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C2=B1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=8F=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B2=
=0D
TEL;type=3Dpref:088-257-4158=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C3=BB.=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=84=A2=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=
=87=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C3=AF=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5 =E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AF=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=
=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C3=A4 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C2=B0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=E2=89=A5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=85=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A1;=
;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C3=BB.=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=84=A2=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=
=87=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C3=AF=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5 =E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AF=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=
=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C3=A4 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C2=B0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=E2=89=A5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=85=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A1=0D=

ORG:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AF=E2=88=9A=E2=80=
=A0=C2=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A4 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C2=B0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=
=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C3=A1;=0D
TEL;type=3Dpref:02-374-0200=0D
TEL:02-374-0216=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=CF=80=
=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=
=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85 Clinic Care;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=CF=80=
=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=
=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85 Clinic Care=0D
TEL;type=3Dpref:0816151914=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=CF=80=
=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A7=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C2=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A1;Nail Boutique FI =E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=A7=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A1 Fashion Iceland;;;=0D
FN:Nail Boutique FI =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=
=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A7=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A1 Fashio=
n Iceland =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=
=AC=CF=80=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=
=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A7=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A1=0D
ORG:Fashion Iceland;=0D
TEL;type=3Dpref:02-947-5858=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=
=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A7;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A4 Farm =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C3=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=
=A7;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A4 Far=
m =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=
=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A7 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C3=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C3=A7=0D
TEL;type=3Dpref:022411774=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=CF=80=
=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C3=AF Ipad;CEW =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=
=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=AF Ipad;;;=0D
FN:CEW =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=
=CF=80=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=
=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C3=AF Ipad =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=
=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=AF Ipad=0D
TEL;type=3Dpref:090-969-9626=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=
=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=8F=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AE =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AF=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=
=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=88=9A=E2=80=A0=C2=AC=
=CF=80=C2=AC=C3=A2;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=
=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=8F=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AE =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AF=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=
=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=88=9A=E2=80=A0=C2=AC=
=CF=80=C2=AC=C3=A2=0D
TEL;type=3Dpref:089-026-4616=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=CF=80=
=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AF=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=CF=80=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=
=A0 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=87=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=8F=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=CF=80=
=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AF=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=CF=80=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=
=A0 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=87=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=8F=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=0D
TEL;type=3Dpref:081-922-5559=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=CF=80=
=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C2=B5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0 RU;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=CF=80=
=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C2=B5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0 RU=0D
TEL;type=3Dpref:06-1819-8789=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=CF=80=
=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B6=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C2=B0;DD =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=
=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C3=B6=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C2=B0;;;=0D
FN:DD =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=CF=
=80=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B6=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C2=B0 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=
=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C3=B6=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C2=B0=0D
TEL;type=3Dpref:0853447766=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=CF=80=
=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=
=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0 =E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A5=E2=88=9A=E2=80=A0=C2=AC=
=CF=80=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=A1;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=CF=80=
=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=
=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0 =E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A5=E2=88=9A=E2=80=A0=C2=AC=
=CF=80=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=A1=0D
TEL;type=3Dpref:084-641-9843=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=CF=80=
=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=85=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=
=B0 RU;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=CF=80=
=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=85=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=
=B0 RU=0D
TEL;type=3Dpref:097-004-8119=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=CF=80=
=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=84=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=80=A2=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=
=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85 =E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=E2=84=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AF=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B5=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B3;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=CF=80=
=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=84=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=80=A2=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=
=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85 =E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=E2=84=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AF=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B5=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B3=0D
TEL;type=3Dpref:087-219-9933=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=CF=80=
=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=89=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=
=B0=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0 =E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B0=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4;;;=0D=

FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=CF=80=
=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=89=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=
=B0=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0 =E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B0=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=0D
TEL;type=3Dpref:0819624056=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=CF=80=
=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=AF=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A3=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C2=A2;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=CF=80=
=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=AF=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A3=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C2=A2=0D
TEL;type=3Dpref:+66818345550=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=CF=80=
=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C3=AC;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=CF=80=
=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C3=AC=0D
TEL;type=3Dpref:081-819-0003=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;<RITA@set.or.th>;;;=0D
FN:<RITA@set.or.th>=0D
EMAIL;type=3DINTERNET;type=3Dpref:RITA@set.or.th=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A4=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=80=A2 Pet Clinic Care;=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=8F=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C2=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AE=E2=88=9A=E2=80=A0=C2=AC=CF=
=80=C2=AC=C3=A5 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A4=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=80=A2 Pet Clinic Care;;;=
=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C2=B0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AE=E2=88=
=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A5 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C3=9F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C3=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=80=A2=
 Pet Clinic Care =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A4=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=80=A2 Pet Clinic Care=0D=

TEL;type=3Dpref:086-009-6609=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=80=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=
=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C3=AF=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=
=AC=CF=80=C2=AC=C3=A5 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AF=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=
=B2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B0=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=87=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C2=B0;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=80=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=
=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C3=AF=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=
=AC=CF=80=C2=AC=C3=A5 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AF=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=
=B2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B0=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=87=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C2=B0=0D
TEL;type=3Dpref:086-043-9833=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4;=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=
=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=A7 =E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=84=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BC=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=84=A2 =E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A7 =E2=88=
=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=
=BC=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=E2=84=A2 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=
=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4 =E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=0D
TEL;type=3Dpref:084-317-3377=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A4=E2=88=9A=E2=
=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A1;=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=84=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C2=B0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F =E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B5=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C3=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A4=E2=88=9A=E2=80=A0=C2=AC=CF=
=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=A1;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=
=A0=C2=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C2=B5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C3=9F =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C3=A4=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A1 =E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B5=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C3=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A4=E2=88=9A=E2=80=A0=C2=AC=CF=
=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=A1=0D
TEL;type=3Dpref:02-692-6225=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=80=A2=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=E2=80=A2=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B5=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=
=C3=A5;=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C3=B6=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A0=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C2=A9=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A5 =E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C3=B9=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=84=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=87=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=
=C3=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0 =E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=E2=80=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=
=80=A2=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=
=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A5 =E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C3=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=E2=89=A0;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C3=B6=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=
=A9=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A5 =E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C3=B9=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=84=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=87=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A1=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0 =E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=E2=80=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=80=A2=
=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A5 =E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=
=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=E2=89=A0 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=80=A2=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=80=A2=E2=88=9A=E2=80=A0=C2=AC=CF=80=
=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=
=AC=CF=80=C2=AC=C3=A5=0D
ORG:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C2=B0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0;=0D
TEL;type=3Dpref:02-279-9591=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=84=A2=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=E2=80=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=E2=80=A2 2558;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=84=A2=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=E2=80=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=E2=80=A2 2558=0D
TEL;type=3Dpref:0951794303=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=84=A2=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0;=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=88=9A=
=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=
 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=84=A2=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=CF=80=
=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=85=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=
=B0=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C2=B0 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=84=A2=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=
 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=84=A2=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=0D
TEL;type=3Dpref:093-554-5464=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=89=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BA=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85 (=
=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A4=E2=88=9A=E2=80=A0=C2=AC=
=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A4=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2)=
;Lamon Farm =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=E2=89=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BA=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C3=85 =E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A4=E2=88=9A=E2=80=
=A0=C2=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A4=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C2=A2 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AF=E2=88=9A=E2=80=A0=C2=AC=
=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0 104;;;=0D=

FN:Lamon Farm =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=E2=89=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BA=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C3=85 =E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A4=E2=88=9A=E2=
=80=A0=C2=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A4=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C2=A2 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AF=E2=88=9A=E2=80=A0=C2=
=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0 104 =E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=E2=89=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BA=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85 (=E2=88=
=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=
=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A4=E2=88=9A=E2=80=A0=C2=AC=CF=80=
=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A4=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2)=0D
ORG:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AF=E2=88=9A=E2=80=A0=C2=AC=CF=
=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0 104;=0D
TEL;type=3Dpref:02-575-2222=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=80=A2;Copy World =E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=80=A2;;;=0D
FN:Copy World =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=80=A2 =E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=80=A2=0D
TEL;type=3Dpref:02-615-2876=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C3=BB =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=86=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C2=B5;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C3=BB =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=86=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C2=B5=0D
TEL;type=3Dpref:028790300=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=80=A2=E2=88=
=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=
=9F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2 =E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=
=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4 =E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=E2=84=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C3=AF;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=80=A2=E2=88=
=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=
=9F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2 =E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=
=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4 =E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=E2=84=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C3=AF=0D
ORG:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=84=A2=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B5=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AF;=0D
TEL;type=3Dpref:089-211-4499=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=
=A2 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A4;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=
=A2 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A4=0D
TEL;type=3Dpref:+66892227173=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C3=AF=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=
=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=
 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=87=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C3=AF=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=
=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=
 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=87=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=0D
TEL;type=3Dpref:0895691569=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C3=AF=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=
=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=
 NV;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C3=AF=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=
=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=
 NV=0D
TEL;type=3Dpref:0819849133=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C3=B6=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=8F=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AF=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C2=A3 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C3=A9=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=
=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C3=B6=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=8F=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AF=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C2=A3 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C3=A9=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=
=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=0D
EMAIL;type=3DINTERNET;type=3Dpref:piyabuth@hotmail.com=0D
TEL;type=3Dpref:081-732-4716=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AF =E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B6;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AF =E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B6=0D
TEL;type=3Dpref:098-665-6554=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C3=B5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C3=AC=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B5 =E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C3=B5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C3=AC=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B5 =E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=91=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=0D
TEL;type=3Dpref:089-532-1911=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C3=B3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A5=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=BA=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0 Sal=
on Diva;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C3=B3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A5=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=BA=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0 Sal=
on Diva=0D
ORG:Salon Diva;=0D
TEL;type=3Dpref:02-949-8486=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C3=B5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=8F=E2=88=
=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A4 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C3=AE=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A4=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B3=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B2;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C3=B5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=8F=E2=88=
=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A4 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C3=AE=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A4=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B3=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B2=0D
TEL;type=3Dpref:088-883-8696=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C3=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=
=B4 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C3=A1;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C3=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=
=B4 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C3=A1=0D
TEL;type=3Dpref:0813639383=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C3=B6=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=8F=E2=88=
=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=
=B0 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=88=9A=E2=80=A0=C2=AC=CF=
=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=B4;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C3=B6=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=8F=E2=88=
=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=
=B0 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=88=9A=E2=80=A0=C2=AC=CF=
=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=0D
TEL;type=3Dpref:081-995-4014=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C3=B6=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=E2=80=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=CF=80=E2=88=9A=E2=80=A0=C2=
=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=
=80=A0=C2=AC=CF=80=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A0;=
;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C3=B6=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=E2=80=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=CF=80=E2=88=9A=E2=80=A0=C2=
=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=
=80=A0=C2=AC=CF=80=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A0=0D=

TEL;type=3Dpref:0855555995=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=E2=84=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B3 Home;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=E2=84=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B3 Home=0D
TEL;type=3Dpref:087-091-1503=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C3=BC=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4 O Cousin;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C3=BC=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4 O Cousin=0D
TEL;type=3Dpref:082-464-9828=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=
=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=
=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=0D
TEL;type=3Dpref:082-543-2572=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=
=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A0=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AF NV;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=
=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A0=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AF NV=0D
TEL;type=3Dpref:081-849-7320=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=
=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=86=E2=88=9A=E2=
=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2;=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=
=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=87=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C2=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B3=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=
=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=E2=80=A2=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=E2=89=A0 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=
=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C3=86=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C2=A2;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=CF=80=
=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=87=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B3=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C3=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=E2=80=A2=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=
=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=
=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C3=86=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C2=A2 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=
=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C3=86=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C2=A2=0D
TEL;type=3Dpref:023911369=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=8F=E2=
=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A4;Dr =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A7=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C3=AF =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=
=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A4;;;=0D
FN:Dr =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C2=A7=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AF =E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B5=
=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=
=C2=AC=CF=80=C2=AC=C3=A4 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=
=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=E2=88=8F=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A4=0D
TEL;type=3Dpref:081-411-7413=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=
=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AF=E2=88=9A=E2=
=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=
 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A4=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=
=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AF=E2=88=9A=E2=
=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=
 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A4=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=0D
TEL;type=3Dpref:081-852-8200=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=0D
TEL;type=3Dpref:089-407-7766=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=
=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=84=A2=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=E2=89=A0;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=
=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=84=A2=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=E2=89=A0=0D
TEL;type=3Dpref:095-706-4874=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=
=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=
=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A3 Trade Jew;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=
=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=
=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A3 Trade Jew=0D
ORG:Trade Jew;=0D
TEL;type=3Dpref:085-963-2517=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=
=AC=CF=80=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=
=80=A0=C2=AC=CF=80=C2=AC=C3=A0;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=
=AC=CF=80=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=
=80=A0=C2=AC=CF=80=C2=AC=C3=A0=0D
TEL;type=3Dpref:091-491-4170=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BA=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=CF=80=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C3=A4=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=
=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C3=9F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=E2=84=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=
=AE=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=AE=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C2=A9=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A5=E2=88=9A=E2=80=A0=C2=AC=CF=80=
=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=98;=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=9E=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C3=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=CF=80=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A9=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A5=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AD=E2=88=9A=E2=80=A0=C2=AC=
=CF=80=C2=AC=C3=A5 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BA=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=CF=80=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A4=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=
=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=84=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C3=AE=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=AE=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C2=A9=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A5=E2=88=9A=E2=
=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=98;=
;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=9E=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=CF=80=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C3=A1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A9=E2=88=9A=E2=80=A0=C2=AC=
=CF=80=C2=AC=C3=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AD=E2=
=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A5 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C3=BA=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=CF=80=E2=88=9A=E2=80=A0=C2=AC=
=CF=80=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A4=E2=88=9A=E2=80=
=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=
=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=CF=80=
=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=84=A2=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AE=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C2=AE=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A1=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A9=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=
=AC=C3=A5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C3=98 =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BA=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=CF=80=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A4=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=
=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=84=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C3=AE=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=AE=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A1=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C2=A9=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A5=E2=88=9A=E2=
=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=98=0D=

TEL;type=3Dpref:086-540-8346=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C2=B0;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C2=B0=0D
TEL;type=3Dpref:081-811-9191=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C3=B5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=
=AC=CF=80=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=80=A2 DC;;;=0D=

FN:=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C3=B5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A5=E2=88=9A=E2=80=A0=C2=
=AC=CF=80=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=80=A2 DC=0D
TEL;type=3Dpref:+66815734444=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=CF=80=
=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=85=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C3=AF=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4 Crystal;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=CF=80=
=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=85=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C3=AF=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4 Crystal=0D
TEL;type=3Dpref:086-399-0783=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=85=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A3=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=
=C2=AC=CF=80=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=85=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=C3=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A3=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F =E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=
=AC=E2=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=
=C2=AC=CF=80=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=0D
TEL;type=3Dpref:089-444-9222=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=CF=80=
=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=85=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=
=9F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=CF=80=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4;=
;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=CF=80=
=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=85=E2=88=9A=
=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=
=9F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=CF=80=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B4=E2=88=9A=E2=80=A0=
=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=0D=

TEL;type=3Dpref:0859037371=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=CF=80=
=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C2=B0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AE=E2=88=9A=
=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C3=A4=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=AC=CF=80=
=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C2=B0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AE=E2=88=9A=
=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=9F=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C3=A4=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C3=9F=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=B1=
=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=0D
TEL;type=3Dpref:1677=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C3=9F 51;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A3=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C3=9F 51=0D
TEL;type=3Dpref:0824415651=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=
=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4;=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=CF=80=
=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AE=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=E2=88=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A0=E2=
=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4 =E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=
=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=
=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=
=8F=C2=AC=C2=B5=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=
=AC=CF=80=C2=AC=C3=84=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AE=E2=88=9A=E2=
=80=A0=C2=AC=E2=88=8F=C2=AC=E2=88=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=
=89=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4 =E2=88=9A=E2=80=A0=C2=AC=
=CF=80=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=
=A0=C2=AC=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4 =E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=
=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=85=E2=88=9A=E2=80=A0=C2=AC=
=CF=80=C2=AC=C3=A0=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=B4=E2=88=9A=E2=80=
=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=0D
TEL;type=3Dpref:092-257-4711=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C3=B3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C2=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A4=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A5;;;=0D
FN:=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=91=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=
=C2=AC=C3=B3=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=
=AC=E2=88=8F=C2=AC=C3=BB=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=E2=89=A4=E2=88=
=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=AC=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=
=C2=A5=E2=88=9A=E2=80=A0=C2=AC=E2=88=8F=C2=AC=C3=A4=E2=88=9A=E2=80=A0=C2=AC=E2=
=88=8F=C2=AC=C2=A2=E2=88=9A=E2=80=A0=C2=AC=CF=80=C2=AC=C3=A5=0D
TEL;type=3Dpref:02-777-7777=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E0=B8=81=E0=B8=A3=E0=B8=A1=E0=B8=9B=E0=B8=A8=E0=B8=B8=E0=B8=AA=E0=B8=B1=E0=
=B8=95=E0=B8=A7=E0=B9=8C;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=AB=E0=B8=A1=E0=B8=
=AD=E0=B8=AD=E0=B8=B3=E0=B8=99=E0=B8=B2=E0=B8=88;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=AB=E0=B8=A1=E0=B8=AD=E0=B8=AD=E0=B8=B3=E0=
=B8=99=E0=B8=B2=E0=B8=88 =E0=B8=81=E0=B8=A3=E0=B8=A1=E0=B8=9B=E0=B8=A8=E0=B8=
=B8=E0=B8=AA=E0=B8=B1=E0=B8=95=E0=B8=A7=E0=B9=8C=0D
TEL;type=3Dpref:081-945-3280=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=81=E0=B8=A3=E0=B8=B8=E0=B8=87=E0=B9=80=E0=B8=97=E0=B8=9E=E0=B8=9B=E0=
=B8=A3=E0=B8=B0=E0=B8=81=E0=B8=B1=E0=B8=99=E0=B8=A0=E0=B8=B1=E0=B8=A2;;;=0D
FN:=E0=B8=81=E0=B8=A3=E0=B8=B8=E0=B8=87=E0=B9=80=E0=B8=97=E0=B8=9E=E0=B8=9B=E0=
=B8=A3=E0=B8=B0=E0=B8=81=E0=B8=B1=E0=B8=99=E0=B8=A0=E0=B8=B1=E0=B8=A2=0D
TEL;type=3Dpref:022858000=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E0=B8=81=E0=B8=A3=E0=B8=B8=E0=B8=87=E0=B9=84=E0=B8=97=E0=B8=A2;=E0=B8=84=E0=
=B8=B8=E0=B8=93=E0=B8=AD=E0=B8=B8=E0=B9=8B=E0=B8=A1 =E0=B8=9B=E0=B8=97=E0=B8=
=B4=E0=B8=99=E0=B8=A2=E0=B8=B2;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=AD=E0=B8=B8=E0=B9=8B=E0=B8=A1 =E0=B8=9B=
=E0=B8=97=E0=B8=B4=E0=B8=99=E0=B8=A2=E0=B8=B2 =E0=B8=81=E0=B8=A3=E0=B8=B8=E0=
=B8=87=E0=B9=84=E0=B8=97=E0=B8=A2=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:0840755591=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E0=B8=81=E0=B8=A5=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B8=A3=E0=B8=96 benz;=E0=B9=
=80=E0=B8=AE=E0=B8=B5=E0=B8=A2=E0=B8=AA=E0=B8=A1=E0=B8=A8=E0=B8=B1=E0=B8=81=E0=
=B8=94=E0=B8=B4=E0=B9=8C;;;=0D
FN:=E0=B9=80=E0=B8=AE=E0=B8=B5=E0=B8=A2=E0=B8=AA=E0=B8=A1=E0=B8=A8=E0=B8=B1=E0=
=B8=81=E0=B8=94=E0=B8=B4=E0=B9=8C =E0=B8=81=E0=B8=A5=E0=B9=89=E0=B8=AD=E0=B8=
=87=E0=B8=A3=E0=B8=96 benz=0D
TEL;type=3Dpref:06-1445-6565=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=81=E0=B9=89=E0=B8=AD=E0=B8=99 =E0=B8=A5=E0=B8=B1=E0=B9=88=E0=B8=A5=
=E0=B8=A5=E0=B8=B2;;;=0D
FN:=E0=B8=81=E0=B9=89=E0=B8=AD=E0=B8=99 =E0=B8=A5=E0=B8=B1=E0=B9=88=E0=B8=A5=
=E0=B8=A5=E0=B8=B2=0D
TEL;type=3Dpref:081-823-1111=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=81=E0=B9=89=E0=B8=AD=E0=B8=A2 =E0=B8=AD=E0=B8=99=E0=B8=87=E0=B8=84=
=E0=B9=8C;;;=0D
FN:=E0=B8=81=E0=B9=89=E0=B8=AD=E0=B8=A2 =E0=B8=AD=E0=B8=99=E0=B8=87=E0=B8=84=
=E0=B9=8C=0D
TEL;type=3Dpref:086-626-4321=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=81=E0=B9=89=E0=B8=AD=E0=B8=A2=E0=B8=8A=E0=B8=A7=E0=B8=B5;;;=0D
FN:=E0=B8=81=E0=B9=89=E0=B8=AD=E0=B8=A2=E0=B8=8A=E0=B8=A7=E0=B8=B5=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:081-702-4380=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=81=E0=B9=89=E0=B8=AD=E0=B8=A2_=E0=B8=AD=E0=B9=82=E0=B8=99=E0=B8=8A=
=E0=B8=B2-GG;;;=0D
FN:=E0=B8=81=E0=B9=89=E0=B8=AD=E0=B8=A2_=E0=B8=AD=E0=B9=82=E0=B8=99=E0=B8=8A=
=E0=B8=B2-GG=0D
item1.EMAIL;type=3DINTERNET;type=3Dpref:sanoocha2@gmail.com=0D
item1.X-ABLabel:_%2524%2521%253COther%253E%2521%2524_=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=81=E0=B8=AD=E0=B8=A5=E0=B9=8C=E0=B8=9F Sw;;;=0D
FN:=E0=B8=81=E0=B8=AD=E0=B8=A5=E0=B9=8C=E0=B8=9F Sw=0D
TEL;type=3Dpref:080-624-6008=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E0=B8=81=E0=B8=AD=E0=B8=A5=E0=B9=8C=E0=B8=9F;=E0=B8=81=E0=B8=AD=E0=B8=A5=E0=
=B9=8C=E0=B8=9F;;;=0D
FN:=E0=B8=81=E0=B8=AD=E0=B8=A5=E0=B9=8C=E0=B8=9F =E0=B8=81=E0=B8=AD=E0=B8=A5=
=E0=B9=8C=E0=B8=9F=0D
TEL;type=3Dpref:080-624-6008=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E0=B8=81=E0=B8=B2=E0=B8=A3=E0=B9=80=E0=B8=87=E0=B8=B4=E0=B8=99 =E0=B8=A3=E0=
=B8=9E.=E0=B8=81=E0=B8=A3=E0=B8=B8=E0=B8=87=E0=B9=80=E0=B8=97=E0=B8=9E;=E0=B8=
=84=E0=B8=B8=E0=B8=93=E0=B8=9E=E0=B8=B4=E0=B8=A1=E0=B8=A5=E0=B8=9E=E0=B8=B1=E0=
=B8=99=E0=B8=98=E0=B9=8C;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=9E=E0=B8=B4=E0=B8=A1=E0=B8=A5=E0=B8=9E=E0=
=B8=B1=E0=B8=99=E0=B8=98=E0=B9=8C =E0=B8=81=E0=B8=B2=E0=B8=A3=E0=B9=80=E0=B8=
=87=E0=B8=B4=E0=B8=99 =E0=B8=A3=E0=B8=9E.=E0=B8=81=E0=B8=A3=E0=B8=B8=E0=B8=87=
=E0=B9=80=E0=B8=97=E0=B8=9E=0D
EMAIL;type=3DINTERNET;type=3Dpref:bmcopdcd@bangkokhospital.com=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:0909707869=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=81=E0=B8=B2=E0=B8=A3=E0=B9=84=E0=B8=9F=E0=B8=9F=E0=B9=89=E0=B8=B2 =E0=
=B8=9A=E0=B8=B2=E0=B8=87=E0=B9=80=E0=B8=82=E0=B8=99;;;=0D
FN:=E0=B8=81=E0=B8=B2=E0=B8=A3=E0=B9=84=E0=B8=9F=E0=B8=9F=E0=B9=89=E0=B8=B2 =E0=
=B8=9A=E0=B8=B2=E0=B8=87=E0=B9=80=E0=B8=82=E0=B8=99=0D
TEL;type=3Dpref:02-792-5222=0D
TEL:02-792-5200=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=81=E0=B8=B3=E0=B9=84=E0=B8=A3;;;=0D
FN:=E0=B8=81=E0=B8=B3=E0=B9=84=E0=B8=A3=0D
ORG:=E0=B8=A3=E0=B8=B2=E0=B8=8A=E0=B8=B4=E0=B8=99=E0=B8=B5=E0=B8=9A=E0=B8=99=
;=0D
TEL;type=3Dpref:086-175-0535=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E0=B9=84=E0=B8=81=E0=B9=88=E0=B8=99=E0=B8=B2;=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=
=B9=80=E0=B8=94=E0=B8=B7=E0=B8=AD=E0=B8=99;;;=0D
FN:=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B9=80=E0=B8=94=E0=B8=B7=E0=B8=AD=E0=B8=99 =E0=
=B9=84=E0=B8=81=E0=B9=88=E0=B8=99=E0=B8=B2=0D
TEL;type=3Dpref:092-257-4711=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=82=E0=B8=99=E0=B8=B8=E0=B8=99;;;=0D
FN:=E0=B8=82=E0=B8=99=E0=B8=B8=E0=B8=99=0D
TEL;type=3Dpref:086-931-9858=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=82=E0=B8=B1=E0=B8=95=E0=B8=B4=E0=B8=A2=E0=B8=B2=E0=B8=9E=E0=B8=A3 S=
eeker;;;=0D
FN:=E0=B8=82=E0=B8=B1=E0=B8=95=E0=B8=B4=E0=B8=A2=E0=B8=B2=E0=B8=9E=E0=B8=A3 S=
eeker=0D
TEL;type=3Dpref:0918044475=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=82=E0=B8=B2=E0=B8=A2=E0=B8=9A=E0=B8=B2=E0=B8=87=E0=B8=AD=E0=B8=81=E0=
=B9=89=E0=B8=A7 =E0=B8=A7=E0=B8=B1=E0=B8=8A=E0=B8=A3=E0=B8=9E=E0=B8=A5;;;=0D=

FN:=E0=B8=82=E0=B8=B2=E0=B8=A2=E0=B8=9A=E0=B8=B2=E0=B8=87=E0=B8=AD=E0=B8=81=E0=
=B9=89=E0=B8=A7 =E0=B8=A7=E0=B8=B1=E0=B8=8A=E0=B8=A3=E0=B8=9E=E0=B8=A5=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B9=80=E0=B8=82=E0=B8=A5=E0=B8=B2=E0=B8=87=E0=B8=84=E0=B9=8C;;;=0D
FN:=E0=B9=80=E0=B8=82=E0=B8=A5=E0=B8=B2=E0=B8=87=E0=B8=84=E0=B9=8C=0D
ORG:Khun Aui;=0D
TEL;type=3Dpref:02-945-6957=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=93=E0=B8=B0 =E0=B8=9A/=E0=B8=8A =E0=B8=81=E0=B8=B2=E0=B8=A3=
=E0=B9=80=E0=B8=87=E0=B8=B4=E0=B8=99;;;=0D
FN:=E0=B8=84=E0=B8=93=E0=B8=B0 =E0=B8=9A/=E0=B8=8A =E0=B8=81=E0=B8=B2=E0=B8=A3=
=E0=B9=80=E0=B8=87=E0=B8=B4=E0=B8=99=0D
TEL;type=3Dpref:02-310-8237=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=A3=E0=B8=B9=E0=B8=9A=E0=B8=B5=E0=B9=8B;;;=0D
FN:=E0=B8=84=E0=B8=A3=E0=B8=B9=E0=B8=9A=E0=B8=B5=E0=B9=8B=0D
TEL;type=3Dpref:081-551-7005=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=A3=E0=B8=B9=E0=B8=9E=E0=B8=A3=E0=B9=80=E0=B8=97=E0=B8=9E;=
;;=0D
FN:=E0=B8=84=E0=B8=A3=E0=B8=B9=E0=B8=9E=E0=B8=A3=E0=B9=80=E0=B8=97=E0=B8=9E=0D=

ORG:=E0=B8=A3=E0=B8=A3. English =E0=B8=99=E0=B8=A7=E0=B8=A5=E0=B8=88=E0=B8=B1=
=E0=B8=99=E0=B8=97=E0=B8=A3=E0=B9=8C;=0D
TEL;type=3Dpref:02-363-7650=0D
TEL:081-633-8696=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=A3=E0=B8=B9=E0=B9=81=E0=B8=AD=E0=B8=A5;;;=0D
FN:=E0=B8=84=E0=B8=A3=E0=B8=B9=E0=B9=81=E0=B8=AD=E0=B8=A5=0D
ORG:Ashtanga mysore bkk;=0D
EMAIL;type=3DINTERNET;type=3Dpref:ellesirilak@gmail.com=0D
TEL;type=3Dpref:089-487-9077=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=A5=E0=B8=B4=E0=B8=99=E0=B8=B4=E0=B8=81 =E0=B8=AD=E0=B8=B2=
=E0=B8=A2=E0=B8=B8=E0=B8=A3=E0=B9=80=E0=B8=A7=E0=B8=97;;;=0D
FN:=E0=B8=84=E0=B8=A5=E0=B8=B4=E0=B8=99=E0=B8=B4=E0=B8=81 =E0=B8=AD=E0=B8=B2=
=E0=B8=A2=E0=B8=B8=E0=B8=A3=E0=B9=80=E0=B8=A7=E0=B8=97=0D
ORG:=E0=B8=8B=E0=B8=AD=E0=B8=A2=E0=B8=AD=E0=B8=B2=E0=B8=A3=E0=B8=B5;=0D
TEL;type=3Dpref:02-617-085=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E0=B8=84=E0=B8=A5=E0=B8=B4=E0=B8=99=E0=B8=B4=E0=B8=81=E0=B8=AB=E0=B8=A1=E0=
=B8=AD=E0=B8=81=E0=B8=A1=E0=B8=A5;;;;=0D
FN:=E0=B8=84=E0=B8=A5=E0=B8=B4=E0=B8=99=E0=B8=B4=E0=B8=81=E0=B8=AB=E0=B8=A1=E0=
=B8=AD=E0=B8=81=E0=B8=A1=E0=B8=A5=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:02-669-3147=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E0=B8=84=E0=B8=A5=E0=B8=B4=E0=B8=99=E0=B8=B4=E0=B8=81=E0=B8=AB=E0=B8=A1=E0=
=B8=AD=E0=B8=81=E0=B8=A1=E0=B8=A5;=E0=B8=84=E0=B8=A5=E0=B8=B4=E0=B8=99=E0=B8=
=B4=E0=B8=81=E0=B8=AB=E0=B8=A1=E0=B8=AD=E0=B8=81=E0=B8=A1=E0=B8=A5;;;=0D
FN:=E0=B8=84=E0=B8=A5=E0=B8=B4=E0=B8=99=E0=B8=B4=E0=B8=81=E0=B8=AB=E0=B8=A1=E0=
=B8=AD=E0=B8=81=E0=B8=A1=E0=B8=A5 =E0=B8=84=E0=B8=A5=E0=B8=B4=E0=B8=99=E0=B8=
=B4=E0=B8=81=E0=B8=AB=E0=B8=A1=E0=B8=AD=E0=B8=81=E0=B8=A1=E0=B8=A5=0D
TEL;type=3Dpref:02-669-3147=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93 Fait;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93 Fait=0D
TEL;type=3Dpref:088-082-8186=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E0=B8=84=E0=B8=B8=E0=B8=93 =E0=B8=9E=E0=B8=B4=E0=B8=99 TMB =E0=B8=99=E0=B8=
=A7;;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93 =E0=B8=9E=E0=B8=B4=E0=B8=99 TMB =E0=B8=99=E0=B8=
=A7=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:085-487-9239=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E0=B8=84=E0=B8=B8=E0=B8=93 =E0=B8=9E=E0=B8=B4=E0=B8=99 TMB =E0=B8=99=E0=B8=
=A7;=E0=B8=84=E0=B8=B8=E0=B8=93 =E0=B8=9E=E0=B8=B4=E0=B8=99 TMB =E0=B8=99=E0=
=B8=A7;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93 =E0=B8=9E=E0=B8=B4=E0=B8=99 TMB =E0=B8=99=E0=B8=
=A7 =E0=B8=84=E0=B8=B8=E0=B8=93 =E0=B8=9E=E0=B8=B4=E0=B8=99 TMB =E0=B8=99=E0=
=B8=A7=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:085-487-9239=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B9=80=E0=B8=AB=E0=B8=A1 Zija;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B9=80=E0=B8=AB=E0=B8=A1 Zija=0D
TEL;type=3Dpref:0971401556=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=81=E0=B8=9A CP;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=81=E0=B8=9A CP=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:083-042-7999=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=81=E0=B8=B8=E0=B9=89=E0=B8=87 =E0=B9=80=
=E0=B8=9B=E0=B9=87=E0=B8=99=E0=B8=AB=E0=B8=B9=E0=B9=80=E0=B8=9B=E0=B9=87=E0=B8=
=99=E0=B8=95=E0=B8=B2;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=81=E0=B8=B8=E0=B9=89=E0=B8=87 =E0=B9=80=
=E0=B8=9B=E0=B9=87=E0=B8=99=E0=B8=AB=E0=B8=B9=E0=B9=80=E0=B8=9B=E0=B9=87=E0=B8=
=99=E0=B8=95=E0=B8=B2=0D
TEL;type=3Dpref:081-307-6002=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B9=82=E0=B8=81=E0=B9=8B;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B9=82=E0=B8=81=E0=B9=8B=0D
ORG:CG =E0=B8=95.=E0=B8=A5.=E0=B8=97.;=0D
TEL;type=3Dpref:081-552-0339=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B9=84=E0=B8=81=E0=B9=88 =E0=B9=80=E0=B8=A5=
=E0=B8=82=E0=B8=B2 =E0=B8=AD=E0=B8=B2=E0=B8=99=E0=B8=B4=E0=B8=94=E0=B8=AB=E0=
=B8=99=E0=B9=88=E0=B8=AD=E0=B8=A2;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B9=84=E0=B8=81=E0=B9=88 =E0=B9=80=E0=B8=A5=
=E0=B8=82=E0=B8=B2 =E0=B8=AD=E0=B8=B2=E0=B8=99=E0=B8=B4=E0=B8=94=E0=B8=AB=E0=
=B8=99=E0=B9=88=E0=B8=AD=E0=B8=A2=0D
TEL;type=3Dpref:081-442-4942=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B9=84=E0=B8=81=E0=B8=94=E0=B9=8C Index Liv=
ivg;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B9=84=E0=B8=81=E0=B8=94=E0=B9=8C Index Liv=
ivg=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:095-335-0481=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=84=E0=B8=A3=E0=B8=B9=E0=B8=99=E0=B9=89=E0=
=B8=AD=E0=B8=A2 =E0=B8=99=E0=B8=B2=E0=B8=8F=E0=B8=A8=E0=B8=B4=E0=B8=A5=E0=B8=
=9B=E0=B9=8C =E0=B8=AA=E0=B8=B1=E0=B8=A1=E0=B8=9E=E0=B8=B1=E0=B8=99=E0=B8=98=
=E0=B9=8C;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=84=E0=B8=A3=E0=B8=B9=E0=B8=99=E0=B9=89=E0=
=B8=AD=E0=B8=A2 =E0=B8=99=E0=B8=B2=E0=B8=8F=E0=B8=A8=E0=B8=B4=E0=B8=A5=E0=B8=
=9B=E0=B9=8C =E0=B8=AA=E0=B8=B1=E0=B8=A1=E0=B8=9E=E0=B8=B1=E0=B8=99=E0=B8=98=
=E0=B9=8C=0D
TEL;type=3Dpref:0852855118=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=84=E0=B8=B4=E0=B9=89=E0=B8=A1;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=84=E0=B8=B4=E0=B9=89=E0=B8=A1=0D
ORG:=E0=B8=AB=E0=B8=A1=E0=B8=AD=E0=B9=84=E0=B8=81=E0=B9=88 Brio Clinic;=0D
TEL;type=3Dpref:02-656-1907=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=88=E0=B8=B5=E0=B8=A3=E0=B8=97=E0=B8=B5=E0=
=B8=9B Benz =E0=B8=A3=E0=B8=B2=E0=B8=A1=E0=B8=AD=E0=B8=B4=E0=B8=99=E0=B8=97=E0=
=B8=A3=E0=B8=B2;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=88=E0=B8=B5=E0=B8=A3=E0=B8=97=E0=B8=B5=E0=
=B8=9B Benz =E0=B8=A3=E0=B8=B2=E0=B8=A1=E0=B8=AD=E0=B8=B4=E0=B8=99=E0=B8=97=E0=
=B8=A3=E0=B8=B2=0D
TEL;type=3Dpref:0856608170=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=88=E0=B8=B7=E0=B8=AD;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=88=E0=B8=B7=E0=B8=AD=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:0815519111=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=88=E0=B8=B8=E0=B9=8B=E0=B8=A1 =E0=B8=88=
=E0=B8=B4=E0=B8=95=E0=B8=A3=E0=B9=82=E0=B8=A0=E0=B8=8A=E0=B8=99=E0=B8=B2;;;=0D=

FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=88=E0=B8=B8=E0=B9=8B=E0=B8=A1 =E0=B8=88=
=E0=B8=B4=E0=B8=95=E0=B8=A3=E0=B9=82=E0=B8=A0=E0=B8=8A=E0=B8=99=E0=B8=B2=0D
TEL;type=3Dpref:0813587210=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=8A=E0=B9=89=E0=B8=A7=E0=B8=87 =E0=B8=8A=
=E0=B8=B8=E0=B8=94=E0=B9=82=E0=B8=A2=E0=B8=84=E0=B8=B0;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=8A=E0=B9=89=E0=B8=A7=E0=B8=87 =E0=B8=8A=
=E0=B8=B8=E0=B8=94=E0=B9=82=E0=B8=A2=E0=B8=84=E0=B8=B0=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:089-666-8823=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=90=E0=B8=B4 =E0=B8=81=E0=B8=A3=E0=B8=87=
=E0=B9=81=E0=B8=A1=E0=B8=A7;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=90=E0=B8=B4 =E0=B8=81=E0=B8=A3=E0=B8=87=
=E0=B9=81=E0=B8=A1=E0=B8=A7=0D
TEL;type=3Dpref:089-120-8082=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=94=E0=B8=B2=E0=B8=A7 Holostic;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=94=E0=B8=B2=E0=B8=A7 Holostic=0D
TEL;type=3Dpref:081-818-7309=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=94=E0=B8=B2=E0=B8=A7 WAPA;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=94=E0=B8=B2=E0=B8=A7 WAPA=0D
TEL;type=3Dpref:081-823-4466=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=94=E0=B8=B4=E0=B9=80=E0=B8=A3=E0=B8=81 =E0=
=B8=A3=E0=B9=89=E0=B8=B2=E0=B8=99=E0=B8=A3=E0=B8=AD=E0=B8=87=E0=B9=80=E0=B8=97=
=E0=B9=89=E0=B8=B2;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=94=E0=B8=B4=E0=B9=80=E0=B8=A3=E0=B8=81 =E0=
=B8=A3=E0=B9=89=E0=B8=B2=E0=B8=99=E0=B8=A3=E0=B8=AD=E0=B8=87=E0=B9=80=E0=B8=97=
=E0=B9=89=E0=B8=B2=0D
TEL;type=3Dpref:083-248-5091=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=95=E0=B8=AD=E0=B8=87;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=95=E0=B8=AD=E0=B8=87=0D
TEL;type=3Dpref:091-875-3075=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=95=E0=B8=B1=E0=B9=8A=E0=B8=81;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=95=E0=B8=B1=E0=B9=8A=E0=B8=81=0D
TEL;type=3DWORK;type=3DVOICE;type=3Dpref:081-303-9011=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=95=E0=B8=B2=E0=B8=A5;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=95=E0=B8=B2=E0=B8=A5=0D
ORG:Bags Spa;=0D
TEL;type=3Dpref:089-136-0010=0D
TEL:087-812-3123=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=95=E0=B8=B4=E0=B9=88=E0=B8=87 seekslers=
;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=95=E0=B8=B4=E0=B9=88=E0=B8=87 seekslers=
=0D
TEL;type=3Dpref:+66970511929=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B9=82=E0=B8=95=E0=B9=8B;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B9=82=E0=B8=95=E0=B9=8B=0D
ORG:=E0=B8=A3=E0=B9=89=E0=B8=B2=E0=B8=99=E0=B8=8B=E0=B8=B1=E0=B8=81=E0=B9=81=
=E0=B8=AB=E0=B9=89=E0=B8=87=E0=B8=9B=E0=B8=A3=E0=B8=B0=E0=B8=88=E0=B8=B3=E0=B8=
=B2;=0D
TEL;type=3DWORK;type=3DVOICE;type=3Dpref:094-234-2997=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=97=E0=B8=B1=E0=B8=81=E0=B8=94=E0=B8=99=E0=
=B8=B1=E0=B8=A2 HR;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=97=E0=B8=B1=E0=B8=81=E0=B8=94=E0=B8=99=E0=
=B8=B1=E0=B8=A2 HR=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:+668-1802-3281=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=99=E0=B8=81 TMB;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=99=E0=B8=81 TMB=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:081-843-0792=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=99=E0=B8=B4=E0=B8=84 =E0=B8=A8=E0=B8=AA=
=E0=B8=AD;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=99=E0=B8=B4=E0=B8=84 =E0=B8=A8=E0=B8=AA=
=E0=B8=AD=0D
TEL;type=3Dpref:0880082686=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=9A=E0=B8=B1=E0=B8=99=E0=B8=94=E0=B8=B4=E0=
=B8=88 =E0=B8=A7=E0=B8=87=E0=B8=88=E0=B8=A3=E0=B8=9B=E0=B8=B4=E0=B8=94;;;=0D=

FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=9A=E0=B8=B1=E0=B8=99=E0=B8=94=E0=B8=B4=E0=
=B8=88 =E0=B8=A7=E0=B8=87=E0=B8=88=E0=B8=A3=E0=B8=9B=E0=B8=B4=E0=B8=94=0D
TEL;type=3Dpref:0879951110=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=9A=E0=B8=B5=E0=B9=8B =E0=B8=9B=E0=B8=A3=
=E0=B8=B0=E0=B8=81=E0=B8=B1=E0=B8=99=E0=B8=97=E0=B8=AD=E0=B8=87=E0=B8=AB=E0=B8=
=A5=E0=B9=88=E0=B8=AD;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=9A=E0=B8=B5=E0=B9=8B =E0=B8=9B=E0=B8=A3=
=E0=B8=B0=E0=B8=81=E0=B8=B1=E0=B8=99=E0=B8=97=E0=B8=AD=E0=B8=87=E0=B8=AB=E0=B8=
=A5=E0=B9=88=E0=B8=AD=0D
TEL;type=3Dpref:0878007980=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=9A=E0=B8=B9=E0=B8=A5 =E0=B8=84=E0=B8=B8=
=E0=B8=93=E0=B9=80=E0=B8=AD=E0=B8=81=E0=B8=AA=E0=B8=96=E0=B8=B2=E0=B8=9B=E0=B8=
=99=E0=B8=B4=E0=B8=81;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=9A=E0=B8=B9=E0=B8=A5 =E0=B8=84=E0=B8=B8=
=E0=B8=93=E0=B9=80=E0=B8=AD=E0=B8=81=E0=B8=AA=E0=B8=96=E0=B8=B2=E0=B8=9B=E0=B8=
=99=E0=B8=B4=E0=B8=81=0D
TEL;type=3Dpref:0817343934=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=9B=E0=B8=A3=E0=B8=B0=E0=B9=80=E0=B8=AA=E0=
=B8=A3=E0=B8=B4=E0=B8=90 =E0=B8=84=E0=B8=B8=E0=B8=93=E0=B9=80=E0=B8=81=E0=B8=
=A9=E0=B8=A1;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=9B=E0=B8=A3=E0=B8=B0=E0=B9=80=E0=B8=AA=E0=
=B8=A3=E0=B8=B4=E0=B8=90 =E0=B8=84=E0=B8=B8=E0=B8=93=E0=B9=80=E0=B8=81=E0=B8=
=A9=E0=B8=A1=0D
ORG:=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=A3=E0=B8=B5=E0=B9=88;=0D
TEL;type=3Dpref:0899934264=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=9B=E0=B8=B1=E0=B8=97=E0=B8=A1=E0=B8=B2 T=
MB =E0=B8=A7=E0=B8=B1=E0=B8=8A=E0=B8=A3=E0=B8=9E=E0=B8=A5;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=9B=E0=B8=B1=E0=B8=97=E0=B8=A1=E0=B8=B2 T=
MB =E0=B8=A7=E0=B8=B1=E0=B8=8A=E0=B8=A3=E0=B8=9E=E0=B8=A5=0D
TEL;type=3Dpref:02-347-0157=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=9B=E0=B8=B7=E0=B9=8A=E0=B8=94;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=9B=E0=B8=B7=E0=B9=8A=E0=B8=94=0D
TEL;type=3Dpref:081-356-4302=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B9=81=E0=B8=9B=E0=B9=89=E0=B8=87 =E0=B8=A3=
=E0=B8=B2=E0=B8=A1=E0=B8=84=E0=B8=B3=E0=B9=81=E0=B8=AB=E0=B8=87;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B9=81=E0=B8=9B=E0=B9=89=E0=B8=87 =E0=B8=A3=
=E0=B8=B2=E0=B8=A1=E0=B8=84=E0=B8=B3=E0=B9=81=E0=B8=AB=E0=B8=87=0D
TEL;type=3Dpref:087-256-6007=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=9E=E0=B8=B4=E0=B9=89=E0=B8=87 Fitness Fu=
n;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=9E=E0=B8=B4=E0=B9=89=E0=B8=87 Fitness Fu=
n=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:081-867-1434=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=9E=E0=B8=B5 =E0=B8=AD=E0=B8=9A=E0=B9=82=
=E0=B8=AD=E0=B9=82=E0=B8=8B=E0=B8=99;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=9E=E0=B8=B5 =E0=B8=AD=E0=B8=9A=E0=B9=82=
=E0=B8=AD=E0=B9=82=E0=B8=8B=E0=B8=99=0D
TEL;type=3Dpref:0870315533=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=9E=E0=B8=B5=E0=B8=A3=E0=B8=9E=E0=B8=A5 B=
enz Tonglor =E0=B8=A2=E0=B8=B2=E0=B8=87;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=9E=E0=B8=B5=E0=B8=A3=E0=B8=9E=E0=B8=A5 B=
enz Tonglor =E0=B8=A2=E0=B8=B2=E0=B8=87=0D
TEL;type=3Dpref:081-352-6507=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=9F=E0=B9=89=E0=B8=B2 Dmor;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=9F=E0=B9=89=E0=B8=B2 Dmor=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:092-341-3634=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=9F=E0=B9=89=E0=B8=B2 =E0=B8=A1=E0=B8=99=
=E0=B8=B9=E0=B8=8D =E0=B8=81=E0=B8=B0=E0=B8=97=E0=B8=B4;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=9F=E0=B9=89=E0=B8=B2 =E0=B8=A1=E0=B8=99=
=E0=B8=B9=E0=B8=8D =E0=B8=81=E0=B8=B0=E0=B8=97=E0=B8=B4=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:+66985483132=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=A1=E0=B8=B1=E0=B8=94 =E0=B8=A7=E0=B8=B1=
=E0=B8=87=E0=B8=88=E0=B8=B1=E0=B8=81=E0=B8=A3=E0=B8=9E=E0=B8=87=E0=B8=A8=E0=B9=
=8C;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=A1=E0=B8=B1=E0=B8=94 =E0=B8=A7=E0=B8=B1=
=E0=B8=87=E0=B8=88=E0=B8=B1=E0=B8=81=E0=B8=A3=E0=B8=9E=E0=B8=87=E0=B8=A8=E0=B9=
=8C=0D
TEL;type=3Dpref:0800457778=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=A1=E0=B8=B8=E0=B8=81 Makeup;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=A1=E0=B8=B8=E0=B8=81 Makeup=0D
TEL;type=3Dpref:081-996-1565=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B9=80=E0=B8=A1=E0=B9=88=E0=B8=99 ~ =E0=B8=9E=
=E0=B8=B5=E0=B9=88=E0=B8=81=E0=B8=B8=E0=B9=89=E0=B8=87~;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B9=80=E0=B8=A1=E0=B9=88=E0=B8=99 ~ =E0=B8=9E=
=E0=B8=B5=E0=B9=88=E0=B8=81=E0=B8=B8=E0=B9=89=E0=B8=87~=0D
ORG:=E0=B9=80=E0=B8=9B=E0=B9=87=E0=B8=99=E0=B8=AB=E0=B8=B9=E0=B9=80=E0=B8=9B=
=E0=B9=87=E0=B8=99=E0=B8=95=E0=B8=B2;=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:0619987879=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=A3=E0=B8=B8=E0=B9=88=E0=B8=87 =E0=B8=9B=
=E0=B8=B2=E0=B8=A3=E0=B8=B4=E0=B8=89=E0=B8=B1=E0=B8=95=E0=B8=A3;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=A3=E0=B8=B8=E0=B9=88=E0=B8=87 =E0=B8=9B=
=E0=B8=B2=E0=B8=A3=E0=B8=B4=E0=B8=89=E0=B8=B1=E0=B8=95=E0=B8=A3=0D
TEL;type=3Dpref:0818701976=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=A5=E0=B8=B1=E0=B8=94=E0=B8=94=E0=B8=B2 =E0=
=B8=A7=E0=B8=B4=E0=B8=A3=E0=B8=B4=E0=B8=A2=E0=B8=B0=E0=B8=9B=E0=B8=A3=E0=B8=B0=
=E0=B8=81=E0=B8=B1=E0=B8=99=E0=B8=A0=E0=B8=B1=E0=B8=A2;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=A5=E0=B8=B1=E0=B8=94=E0=B8=94=E0=B8=B2 =E0=
=B8=A7=E0=B8=B4=E0=B8=A3=E0=B8=B4=E0=B8=A2=E0=B8=B0=E0=B8=9B=E0=B8=A3=E0=B8=B0=
=E0=B8=81=E0=B8=B1=E0=B8=99=E0=B8=A0=E0=B8=B1=E0=B8=A2=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:081-689-0876=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=A5=E0=B8=B8=E0=B8=87=E0=B8=99=E0=B9=89=E0=
=B8=AD=E0=B8=A2;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=A5=E0=B8=B8=E0=B8=87=E0=B8=99=E0=B9=89=E0=
=B8=AD=E0=B8=A2=0D
TEL;type=3Dpref:0810654673=0D
X-SOCIALPROFILE;type=3DLINE;x-user=3D=E2=80=AD081-065-4673=E2=80=AC:x-apple:=
%E2%80%AD081-065-4673%E2%80%AC=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=A7=E0=B8=99=E0=B8=B4=E0=B8=94=E0=B8=B2;=
;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=A7=E0=B8=99=E0=B8=B4=E0=B8=94=E0=B8=B2=0D=

ORG:Mogen;=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:099-580-2493=0D
TEL:0879179829=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=AA=E0=B8=B8=E0=B8=94;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=AA=E0=B8=B8=E0=B8=94=0D
TEL;type=3Dpref:087-509-0808=0D
TEL:089-777-0895=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=AB=E0=B8=99=E0=B8=B6=E0=B9=88=E0=B8=87 =E0=
=B8=AD=E0=B8=B8=E0=B9=82=E0=B8=A1=E0=B8=87=E0=B9=81=E0=B8=A1=E0=B8=A7;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=AB=E0=B8=99=E0=B8=B6=E0=B9=88=E0=B8=87 =E0=
=B8=AD=E0=B8=B8=E0=B9=82=E0=B8=A1=E0=B8=87=E0=B9=81=E0=B8=A1=E0=B8=A7=0D
TEL;type=3Dpref:087-488-6362=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=AB=E0=B8=99=E0=B8=B8=E0=B9=88=E0=B8=A1 l=
uxus;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=AB=E0=B8=99=E0=B8=B8=E0=B9=88=E0=B8=A1 l=
uxus=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:087-790-5045=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=AB=E0=B8=A1=E0=B8=AD=E0=B8=8B=E0=B9=89=E0=
=B8=87;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=AB=E0=B8=A1=E0=B8=AD=E0=B8=8B=E0=B9=89=E0=
=B8=87=0D
TEL;type=3Dpref:0909075750=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=AB=E0=B8=A1=E0=B8=AD=E0=B8=8B=E0=B9=89=E0=
=B8=87;Atrium;;;=0D
FN:Atrium =E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=AB=E0=B8=A1=E0=B8=AD=E0=B8=8B=E0=
=B9=89=E0=B8=87=0D
TEL;type=3Dpref:083-786-7000=0D
TEL:02-729-6988=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=AB=E0=B8=A1=E0=B8=AD=E0=B8=93=E0=B8=B8=E0=
=B8=A7=E0=B8=B1=E0=B8=92=E0=B8=99=E0=B9=8C;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=AB=E0=B8=A1=E0=B8=AD=E0=B8=93=E0=B8=B8=E0=
=B8=A7=E0=B8=B1=E0=B8=92=E0=B8=99=E0=B9=8C=0D
ORG:=E0=B8=8B=E0=B8=B2=E0=B8=9F=E0=B8=B2=E0=B8=A3=E0=B8=B5=E0=B9=80=E0=B8=A7=
=E0=B8=B4=E0=B8=A5;=0D
TEL;type=3Dpref:081-844-8849=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=AB=E0=B8=A1=E0=B8=AD=E0=B8=A3=E0=B8=B4=E0=
=B8=99 =E0=B8=9B=E0=B9=89=E0=B8=B2=E0=B8=AD=E0=B9=89=E0=B8=AD=E0=B8=A2;;;=0D=

FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=AB=E0=B8=A1=E0=B8=AD=E0=B8=A3=E0=B8=B4=E0=
=B8=99 =E0=B8=9B=E0=B9=89=E0=B8=B2=E0=B8=AD=E0=B9=89=E0=B8=AD=E0=B8=A2=0D
TEL;type=3Dpref:084-542-9888=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=AB=E0=B8=A1=E0=B8=AD=E0=B8=A7=E0=B8=A3=E0=
=B8=A5=E0=B8=B1=E0=B8=81=E0=B8=A9=E0=B8=93=E0=B8=B2;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=AB=E0=B8=A1=E0=B8=AD=E0=B8=A7=E0=B8=A3=E0=
=B8=A5=E0=B8=B1=E0=B8=81=E0=B8=A9=E0=B8=93=E0=B8=B2=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:02-725-9595=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=AB=E0=B8=A1=E0=B8=AD=E0=B8=AA=E0=B8=B8=E0=
=B8=A3=E0=B8=8A=E0=B8=B2=E0=B8=95=E0=B8=B4;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=AB=E0=B8=A1=E0=B8=AD=E0=B8=AA=E0=B8=B8=E0=
=B8=A3=E0=B8=8A=E0=B8=B2=E0=B8=95=E0=B8=B4=0D
ORG:Call center;=0D
TEL;type=3Dpref:02-755-1058=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=AB=E0=B8=A1=E0=B8=AD=E0=B8=AD=E0=B8=93=E0=
=B8=B8=E0=B8=A7=E0=B8=B1=E0=B8=92=E0=B8=99=E0=B9=8C;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=AB=E0=B8=A1=E0=B8=AD=E0=B8=AD=E0=B8=93=E0=
=B8=B8=E0=B8=A7=E0=B8=B1=E0=B8=92=E0=B8=99=E0=B9=8C=0D
ORG:=E0=B8=8B=E0=B8=B2=E0=B8=9F=E0=B8=B2=E0=B8=A3=E0=B8=B5=E0=B9=80=E0=B8=A7=
=E0=B8=B4=E0=B8=A5;=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:081-844-8849=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=AB=E0=B8=B2=E0=B8=8D=E0=B8=93=E0=B8=A3=E0=
=B8=87=E0=B8=84=E0=B9=8C;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=AB=E0=B8=B2=E0=B8=8D=E0=B8=93=E0=B8=A3=E0=
=B8=87=E0=B8=84=E0=B9=8C=0D
ORG:Benz =E0=B8=A3=E0=B8=B2=E0=B8=A1=E0=B8=AD=E0=B8=B4=E0=B8=99=E0=B8=97=E0=B8=
=A3=E0=B8=B2;=0D
TEL;type=3Dpref:085-660-8171=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B9=83=E0=B8=AB=E0=B8=A1=E0=B9=88 =E0=B8=8B=
=E0=B8=B1=E0=B8=81=E0=B8=9E=E0=B8=A3=E0=B8=A1;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B9=83=E0=B8=AB=E0=B8=A1=E0=B9=88 =E0=B8=8B=
=E0=B8=B1=E0=B8=81=E0=B8=9E=E0=B8=A3=E0=B8=A1=0D
TEL;type=3Dpref:0971452828=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B9=83=E0=B8=AB=E0=B8=A1=E0=B9=88 =E0=B8=99=
=E0=B8=A7=E0=B8=94=E0=B8=A7=E0=B8=B4=E0=B8=8A=E0=B8=B1=E0=B8=A2=E0=B8=A2=E0=B8=
=B8=E0=B8=97=E0=B8=98;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B9=83=E0=B8=AB=E0=B8=A1=E0=B9=88 =E0=B8=99=
=E0=B8=A7=E0=B8=94=E0=B8=A7=E0=B8=B4=E0=B8=8A=E0=B8=B1=E0=B8=A2=E0=B8=A2=E0=B8=
=B8=E0=B8=97=E0=B8=98=0D
TEL;type=3Dpref:089-573-4843=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=AD=E0=B8=99=E0=B8=B8=E0=B8=AA=E0=B8=A3 K=
amakamet;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=AD=E0=B8=99=E0=B8=B8=E0=B8=AA=E0=B8=A3 K=
amakamet=0D
ORG:040-3525782 =E0=B8=81=E0=B8=AA=E0=B8=B4=E0=B8=81=E0=B8=A3;=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:097-223-6063=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=AD=E0=B8=AD=E0=B8=A1;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=AD=E0=B8=AD=E0=B8=A1=0D
ORG:Yogaelement;=0D
TEL;type=3Dpref:02-655-5671=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=AD=E0=B8=B2=E0=B8=8A=E0=B8=B4=E0=B8=93=E0=
=B8=A7=E0=B8=A3;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=AD=E0=B8=B2=E0=B8=8A=E0=B8=B4=E0=B8=93=E0=
=B8=A7=E0=B8=A3=0D
TEL;type=3Dpref:0943474623=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=AD=E0=B8=B2=E0=B9=82=E0=B8=97=E0=B8=99=E0=
=B8=B5=E0=B9=88 22;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=AD=E0=B8=B2=E0=B9=82=E0=B8=97=E0=B8=99=E0=
=B8=B5=E0=B9=88 22=0D
TEL;type=3Dpref:089-814-2222=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=AD=E0=B8=B2=E0=B8=9A=E0=B9=8A=E0=B8=AD=E0=
=B8=9A;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=AD=E0=B8=B2=E0=B8=9A=E0=B9=8A=E0=B8=AD=E0=
=B8=9A=0D
ORG:Jewel Trade;=0D
TEL;type=3Dpref:081-913-5611=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=AD=E0=B8=B2=E0=B8=A2=E0=B8=B8;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=AD=E0=B8=B2=E0=B8=A2=E0=B8=B8=0D
TEL;type=3Dpref:0835619595=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B9=80=E0=B8=AD =E0=B8=8B=E0=B8=B1=E0=B8=81=
=E0=B8=A3=E0=B8=B5=E0=B8=94 =E0=B8=A3=E0=B8=B1=E0=B8=9A=E0=B8=AA=E0=B9=88=E0=
=B8=87;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B9=80=E0=B8=AD =E0=B8=8B=E0=B8=B1=E0=B8=81=
=E0=B8=A3=E0=B8=B5=E0=B8=94 =E0=B8=A3=E0=B8=B1=E0=B8=9A=E0=B8=AA=E0=B9=88=E0=
=B8=87=0D
ORG:=E0=B8=A3=E0=B8=B1=E0=B8=9A=E0=B8=AA=E0=B9=88=E0=B8=87=E0=B8=96=E0=B8=B6=
=E0=B8=87=E0=B8=9A=E0=B9=89=E0=B8=B2=E0=B8=99;=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:0890519779=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B9=80=E0=B8=AD=E0=B8=81 =E0=B8=AA=E0=B8=96=
=E0=B8=B2=E0=B8=9B=E0=B8=99=E0=B8=B4=E0=B8=81;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B9=80=E0=B8=AD=E0=B8=81 =E0=B8=AA=E0=B8=96=
=E0=B8=B2=E0=B8=9B=E0=B8=99=E0=B8=B4=E0=B8=81=0D
TEL;type=3Dpref:0866100069=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B9=80=E0=B8=AD=E0=B8=81=E0=B8=A3=E0=B8=B4=E0=
=B8=93 =E0=B9=81=E0=B8=AD=E0=B8=A3=E0=B9=8C;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B9=80=E0=B8=AD=E0=B8=81=E0=B8=A3=E0=B8=B4=E0=
=B8=93 =E0=B9=81=E0=B8=AD=E0=B8=A3=E0=B9=8C=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:085-149-2800=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B9=81=E0=B8=AD=E0=B9=89=E0=B8=94 =E0=B9=80=
=E0=B8=9A=E0=B9=87=E0=B8=99=E0=B8=97=E0=B8=AD=E0=B8=87=E0=B8=AB=E0=B8=A5=E0=B9=
=88=E0=B8=AD;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B9=81=E0=B8=AD=E0=B9=89=E0=B8=94 =E0=B9=80=
=E0=B8=9A=E0=B9=87=E0=B8=99=E0=B8=97=E0=B8=AD=E0=B8=87=E0=B8=AB=E0=B8=A5=E0=B9=
=88=E0=B8=AD=0D
TEL;type=3Dpref:081-732-1441=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B9=81=E0=B8=AD=E0=B8=99;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B9=81=E0=B8=AD=E0=B8=99=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:0960593966=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B9=82=E0=B8=AD=E0=B8=A1 Bonmache;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B9=82=E0=B8=AD=E0=B8=A1 Bonmache=0D
TEL;type=3Dpref:080-812-9669=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B9=81=E0=B8=AE=E0=B8=A1;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B9=81=E0=B8=AE=E0=B8=A1=0D
ORG:Mogen;=0D
TEL;type=3Dpref:0868488131=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E0=B8=88=E0=B8=B1=E0=B8=81=E0=B8=A3=E0=B8=A3=E0=B8=B2=E0=B8=8A;=E0=B8=9E=E0=
=B8=B5=E0=B9=88=E0=B9=80=E0=B8=A1=E0=B8=95;;;=0D
FN:=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B9=80=E0=B8=A1=E0=B8=95 =E0=B8=88=E0=B8=B1=
=E0=B8=81=E0=B8=A3=E0=B8=A3=E0=B8=B2=E0=B8=8A=0D
TEL;type=3Dpref:083-297-8498=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=88=E0=B8=B8=E0=B8=AC=E0=B8=B2 Book Call Center;;;=0D
FN:=E0=B8=88=E0=B8=B8=E0=B8=AC=E0=B8=B2 Book Call Center=0D
TEL;type=3Dpref:02-255-4433=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=88=E0=B8=B8=E0=B8=AC=E0=B8=B2 Book Siam;;;=0D
FN:=E0=B8=88=E0=B8=B8=E0=B8=AC=E0=B8=B2 Book Siam=0D
TEL;type=3Dpref:02-218-9881=0D
TEL:02-218-9888=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E0=B8=8A=E0=B8=99=E0=B8=B4=E0=B8=94=E0=B8=99=E0=B9=89=E0=B8=B3;Bk Clean M=
outh;;;=0D
FN:Bk Clean Mouth =E0=B8=8A=E0=B8=99=E0=B8=B4=E0=B8=94=E0=B8=99=E0=B9=89=E0=B8=
=B3=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:0924165196=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=8A=E0=B9=88=E0=B8=B2=E0=B8=87=E0=B8=8B=E0=B9=88=E0=B8=AD=E0=B8=A1=E0=
=B8=AA=E0=B9=89=E0=B8=A7=E0=B8=A1=E0=B8=95=E0=B8=B1=E0=B8=99;;;=0D
FN:=E0=B8=8A=E0=B9=88=E0=B8=B2=E0=B8=87=E0=B8=8B=E0=B9=88=E0=B8=AD=E0=B8=A1=E0=
=B8=AA=E0=B9=89=E0=B8=A7=E0=B8=A1=E0=B8=95=E0=B8=B1=E0=B8=99=0D
TEL;type=3Dpref:0633973322=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=8A=E0=B9=88=E0=B8=B2=E0=B8=87=E0=B8=94=E0=B8=B4=E0=B8=A7 =E0=B8=AA=
=E0=B8=B8=E0=B8=82=E0=B8=A0=E0=B8=B1=E0=B8=93=E0=B9=8C;;;=0D
FN:=E0=B8=8A=E0=B9=88=E0=B8=B2=E0=B8=87=E0=B8=94=E0=B8=B4=E0=B8=A7 =E0=B8=AA=
=E0=B8=B8=E0=B8=82=E0=B8=A0=E0=B8=B1=E0=B8=93=E0=B9=8C=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:097-026-0546=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=8A=E0=B9=88=E0=B8=B2=E0=B8=87=E0=B8=9B=E0=B8=B2=E0=B8=99 =E0=B8=81=
=E0=B8=B8=E0=B8=8D=E0=B9=81=E0=B8=88;;;=0D
FN:=E0=B8=8A=E0=B9=88=E0=B8=B2=E0=B8=87=E0=B8=9B=E0=B8=B2=E0=B8=99 =E0=B8=81=
=E0=B8=B8=E0=B8=8D=E0=B9=81=E0=B8=88=0D
TEL;type=3Dpref:0851088797=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E0=B8=8A=E0=B9=88=E0=B8=B2=E0=B8=87=E0=B9=80=E0=B8=9B=E0=B8=A5=E0=B8=B5=E0=
=B9=88=E0=B8=99=E0=B8=AA=E0=B9=89=E0=B8=A7=E0=B8=A1;=E0=B8=8A=E0=B9=88=E0=B8=
=B2=E0=B8=87=E0=B8=9E=E0=B8=B1=E0=B8=81;;;=0D
FN:=E0=B8=8A=E0=B9=88=E0=B8=B2=E0=B8=87=E0=B8=9E=E0=B8=B1=E0=B8=81 =E0=B8=8A=
=E0=B9=88=E0=B8=B2=E0=B8=87=E0=B9=80=E0=B8=9B=E0=B8=A5=E0=B8=B5=E0=B9=88=E0=B8=
=99=E0=B8=AA=E0=B9=89=E0=B8=A7=E0=B8=A1=0D
TEL;type=3Dpref:0849199915=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=8A=E0=B8=B2=E0=B8=95=E0=B8=B4=E0=B8=95;;;=0D
FN:=E0=B8=8A=E0=B8=B2=E0=B8=95=E0=B8=B4=E0=B8=95=0D
TEL;type=3Dpref:085-955-6999=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E0=B8=8A=E0=B8=B4=E0=B8=84 (=E0=B8=9C=E0=B8=A1);=E0=B8=84=E0=B8=B8=E0=B8=93=
=E0=B9=80=E0=B8=9A=E0=B8=8D;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B9=80=E0=B8=9A=E0=B8=8D =E0=B8=8A=E0=B8=B4=
=E0=B8=84 (=E0=B8=9C=E0=B8=A1)=0D
TEL;type=3Dpref:0641813589=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E0=B8=8B.=E0=B8=AD=E0=B8=B2=E0=B8=A3=E0=B8=B5=E0=B8=A2=E0=B9=8C;=E0=B8=84=
=E0=B8=A5=E0=B8=B4=E0=B8=99=E0=B8=B4=E0=B8=81=E0=B8=AD=E0=B8=B2=E0=B8=A2=E0=B8=
=B8=E0=B8=A3=E0=B9=80=E0=B8=A7=E0=B8=97;;;=0D
FN:=E0=B8=84=E0=B8=A5=E0=B8=B4=E0=B8=99=E0=B8=B4=E0=B8=81=E0=B8=AD=E0=B8=B2=E0=
=B8=A2=E0=B8=B8=E0=B8=A3=E0=B9=80=E0=B8=A7=E0=B8=97 =E0=B8=8B.=E0=B8=AD=E0=B8=
=B2=E0=B8=A3=E0=B8=B5=E0=B8=A2=E0=B9=8C=0D
ORG:=E0=B9=81=E0=B8=9E=E0=B8=97=E0=B8=A2=E0=B9=8C=E0=B9=81=E0=B8=9C=E0=B8=99=
=E0=B9=84=E0=B8=97=E0=B8=A2=E0=B8=9B=E0=B8=A3=E0=B8=B0=E0=B8=A2=E0=B8=B8=E0=B8=
=81=E0=B8=95=E0=B9=8C;=0D
TEL;type=3Dpref:02-617-0285=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=8B=E0=B8=B1=E0=B8=81=E0=B8=A3=E0=B8=B5=E0=B8=94;;;=0D
FN:=E0=B8=8B=E0=B8=B1=E0=B8=81=E0=B8=A3=E0=B8=B5=E0=B8=94=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:+66 2 945 7387=0D
ADR;type=3DHOME;type=3Dpref:;;;;;;Thailand=0D
X-SOCIALPROFILE;type=3DLINE;x-user=3D=E2=80=AD+66 2-945-7387=E2=80=AC:x-appl=
e:%E2%80%AD+66%202-945-7387%E2%80%AC=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=94=E0=B8=A7=E0=B8=87 =E0=B8=9B=E0=B8=B1=E0=B8=99=E0=B8=9B=E0=B8=B1=
=E0=B8=99;;;=0D
FN:=E0=B8=94=E0=B8=A7=E0=B8=87 =E0=B8=9B=E0=B8=B1=E0=B8=99=E0=B8=9B=E0=B8=B1=
=E0=B8=99=0D
TEL;type=3Dpref:06-4456-3536=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=94=E0=B8=B5=E0=B9=89 =E0=B8=AB=E0=B8=A5=E0=B8=B4=E0=B8=99;;;=0D
FN:=E0=B8=94=E0=B8=B5=E0=B9=89 =E0=B8=AB=E0=B8=A5=E0=B8=B4=E0=B8=99=0D
TEL;type=3Dpref:+66809696966=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=95=E0=B8=B1=E0=B9=89=E0=B8=A1 =E0=B8=A1=E0=B8=99=E0=B8=B9=E0=B8=8D=
 Pet Shop;;;=0D
FN:=E0=B8=95=E0=B8=B1=E0=B9=89=E0=B8=A1 =E0=B8=A1=E0=B8=99=E0=B8=B9=E0=B8=8D=
 Pet Shop=0D
TEL;type=3Dpref:0973204958=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E0=B8=95=E0=B8=B5=E0=B8=A3=E0=B9=80=E0=B8=A5=E0=B8=B4=E0=B8=A8=E0=B8=9E=E0=
=B8=B2=E0=B8=99=E0=B8=B4=E0=B8=8A;=E0=B8=81=E0=B8=A3=E0=B8=A7=E0=B8=B4=E0=B8=
=8A=E0=B8=8D=E0=B9=8C;;;=0D
FN:=E0=B8=81=E0=B8=A3=E0=B8=A7=E0=B8=B4=E0=B8=8A=E0=B8=8D=E0=B9=8C =E0=B8=95=
=E0=B8=B5=E0=B8=A3=E0=B9=80=E0=B8=A5=E0=B8=B4=E0=B8=A8=E0=B8=9E=E0=B8=B2=E0=B8=
=99=E0=B8=B4=E0=B8=8A=0D
TEL;type=3Dpref:086-311-2019=0D
X-SOCIALPROFILE;x-user=3D_dYy2d2Da9ng5uNtOAv48U1IeQLMI_7xq0fnjRgM:x-apple:_d=
Yy2d2Da9ng5uNtOAv48U1IeQLMI_7xq0fnjRgM=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=95=E0=B8=B6=E0=B8=81;;;=0D
FN:=E0=B8=95=E0=B8=B6=E0=B8=81=0D
TEL;type=3Dpref:084-532-8222=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=97=E0=B8=AB=E0=B8=B2=E0=B8=A3 Home Ram;;;=0D
FN:=E0=B8=97=E0=B8=AB=E0=B8=B2=E0=B8=A3 Home Ram=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:098-863-6051=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E0=B8=97=E0=B8=AB=E0=B8=B2=E0=B8=A3 Ram =E0=B8=AB=E0=B8=99=E0=B9=89=E0=B8=
=B2=E0=B8=9A=E0=B9=89=E0=B8=B2=E0=B8=99;=E0=B8=9F=E0=B8=A5=E0=B8=B8=E0=B9=8A=
=E0=B8=84;;;=0D
FN:=E0=B8=9F=E0=B8=A5=E0=B8=B8=E0=B9=8A=E0=B8=84 =E0=B8=97=E0=B8=AB=E0=B8=B2=
=E0=B8=A3 Ram =E0=B8=AB=E0=B8=99=E0=B9=89=E0=B8=B2=E0=B8=9A=E0=B9=89=E0=B8=B2=
=E0=B8=99=0D
TEL;type=3Dpref:099-110-2051=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E0=B8=97=E0=B8=B2=E0=B9=82=E0=B8=A3=E0=B9=88=E0=B8=95=E0=B9=8C;=E0=B8=95=E0=
=B8=B8=E0=B9=8A=E0=B8=81;;;=0D
FN:=E0=B8=95=E0=B8=B8=E0=B9=8A=E0=B8=81 =E0=B8=97=E0=B8=B2=E0=B9=82=E0=B8=A3=
=E0=B9=88=E0=B8=95=E0=B9=8C=0D
TEL;type=3Dpref:0818357344=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=97=E0=B8=B3=E0=B8=9F=E0=B8=B1=E0=B8=99 =E0=B8=A7=E0=B8=B4=E0=B8=8A=
=E0=B8=B1=E0=B8=A2=E0=B8=A2=E0=B8=B8=E0=B8=97=E0=B8=98;;;=0D
FN:=E0=B8=97=E0=B8=B3=E0=B8=9F=E0=B8=B1=E0=B8=99 =E0=B8=A7=E0=B8=B4=E0=B8=8A=
=E0=B8=B1=E0=B8=A2=E0=B8=A2=E0=B8=B8=E0=B8=97=E0=B8=98=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:086-783-7006=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B9=84=E0=B8=97=E0=B8=A2=E0=B8=9E=E0=B8=B2=E0=B8=93=E0=B8=B4=E0=B8=8A=E0=
=B8=A2=E0=B9=8C;;;=0D
FN:=E0=B9=84=E0=B8=97=E0=B8=A2=E0=B8=9E=E0=B8=B2=E0=B8=93=E0=B8=B4=E0=B8=8A=E0=
=B8=A2=E0=B9=8C=0D
TEL;type=3Dpref:02-777-7777=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=98.=E0=B8=81=E0=B8=A3=E0=B8=B8=E0=B8=87=E0=B9=84=E0=B8=97=E0=B8=A2=
;;;=0D
FN:=E0=B8=98.=E0=B8=81=E0=B8=A3=E0=B8=B8=E0=B8=87=E0=B9=84=E0=B8=97=E0=B8=A2=
=0D
TEL;type=3Dpref:02-111-1111=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=99=E0=B8=9E.=E0=B8=AA=E0=B8=B8=E0=B8=82=E0=B8=B2=E0=B8=95=E0=B8=B4=
;;;=0D
FN:=E0=B8=99=E0=B8=9E.=E0=B8=AA=E0=B8=B8=E0=B8=82=E0=B8=B2=E0=B8=95=E0=B8=B4=
=0D
ORG:=E0=B8=88=E0=B8=B4=E0=B8=95=E0=B9=80=E0=B8=A7=E0=B8=8A =E0=B8=A3=E0=B8=B2=
=E0=B8=A1=E0=B8=84=E0=B8=B3=E0=B9=81=E0=B8=AB=E0=B8=87;=0D
TEL;type=3Dpref:02-374-0216=0D
TEL:02-374-0200=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=99=E0=B8=A7=E0=B8=94=E0=B8=9A=E0=B9=89=E0=B8=B2=E0=B8=99=E0=B8=AA=E0=
=B8=A7=E0=B8=99;;;=0D
FN:=E0=B8=99=E0=B8=A7=E0=B8=94=E0=B8=9A=E0=B9=89=E0=B8=B2=E0=B8=99=E0=B8=AA=E0=
=B8=A7=E0=B8=99=0D
ORG:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=AB=E0=B8=99=E0=B9=88=E0=B8=AD=E0=B8=A2=
;=0D
TEL;type=3Dpref:02-517-5880=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=99=E0=B8=A7=E0=B8=94=E0=B8=A7=E0=B8=B4=E0=B8=8A=E0=B8=B1=E0=B8=A2=E0=
=B8=A2=E0=B8=B8=E0=B8=97=E0=B8=98;;;=0D
FN:=E0=B8=99=E0=B8=A7=E0=B8=94=E0=B8=A7=E0=B8=B4=E0=B8=8A=E0=B8=B1=E0=B8=A2=E0=
=B8=A2=E0=B8=B8=E0=B8=97=E0=B8=98=0D
TEL;type=3Dpref:088-257-4158=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87 =E0=B9=80=E0=B8=81=E0=B8=A3=E0=B8=8B=
 =E0=B8=99=E0=B8=A7=E0=B8=99=E0=B8=84=E0=B8=A3;;;=0D
FN:=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87 =E0=B9=80=E0=B8=81=E0=B8=A3=E0=B8=8B=
 =E0=B8=99=E0=B8=A7=E0=B8=99=E0=B8=84=E0=B8=A3=0D
TEL;type=3Dpref:+66865599920=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87 =E0=B8=A12;;;=0D
FN:=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87 =E0=B8=A12=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:0612925268=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B8=81=E0=B8=A7=E0=B8=B2=E0=B8=87;=
;;=0D
FN:=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B8=81=E0=B8=A7=E0=B8=B2=E0=B8=87=0D=

TEL;type=3DCELL;type=3DVOICE;type=3Dpref:099-285-4256=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B8=81=E0=B8=B4=E0=B9=89=E0=B8=81 C=
C;;;=0D
FN:=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B8=81=E0=B8=B4=E0=B9=89=E0=B8=81 C=
C=0D
TEL;type=3Dpref:0989384676=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B8=81=E0=B8=B4=E0=B9=89=E0=B8=81 C=
linic Care;;;=0D
FN:=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B8=81=E0=B8=B4=E0=B9=89=E0=B8=81 C=
linic Care=0D
TEL;type=3Dpref:0816151914=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B8=84=E0=B8=A3=E0=B8=B5=E0=B8=A1 R=
U;;;=0D
FN:=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B8=84=E0=B8=A3=E0=B8=B5=E0=B8=A1 R=
U=0D
TEL;type=3Dpref:06-1819-8789=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B9=81=E0=B8=88=E0=B8=87;;;=0D
FN:=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B9=81=E0=B8=88=E0=B8=87=0D
ORG:7/11;=0D
TEL;type=3Dpref:0930021296=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B9=81=E0=B8=88=E0=B9=8B=E0=B8=A7 =E0=
=B8=9B=E0=B8=B8=E0=B9=89=E0=B8=81;;;=0D
FN:=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B9=81=E0=B8=88=E0=B9=8B=E0=B8=A7 =E0=
=B8=9B=E0=B8=B8=E0=B9=89=E0=B8=81=0D
TEL;type=3Dpref:+66 6-3826-3456=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B8=8A=E0=B8=B5 =E0=B8=9E=E0=B8=B4=
=E0=B8=A5=E0=B8=B4=E0=B8=99;;;=0D
FN:=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B8=8A=E0=B8=B5 =E0=B8=9E=E0=B8=B4=
=E0=B8=A5=E0=B8=B4=E0=B8=99=0D
TEL;type=3Dpref:081-018-5073=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B8=8A=E0=B8=B5 =E0=B8=9E=E0=B8=B4=
=E0=B8=A5=E0=B8=B4=E0=B8=99 95;;;=0D
FN:=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B8=8A=E0=B8=B5 =E0=B8=9E=E0=B8=B4=
=E0=B8=A5=E0=B8=B4=E0=B8=99 95=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:092-973-0695=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B8=95=E0=B8=B9=E0=B9=88;;;=0D
FN:=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B8=95=E0=B8=B9=E0=B9=88=0D
ORG:Home Pro;=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:0879195636=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B8=95=E0=B8=B9=E0=B9=88 =E0=B8=82=
=E0=B8=99=E0=B8=B8=E0=B8=99;;;=0D
FN:=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B8=95=E0=B8=B9=E0=B9=88 =E0=B8=82=
=E0=B8=99=E0=B8=B8=E0=B8=99=0D
TEL;type=3Dpref:081-922-5559=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B8=97=E0=B8=A3=E0=B8=B2=E0=B8=A2;=
;;=0D
FN:=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B8=97=E0=B8=A3=E0=B8=B2=E0=B8=A2=0D=

EMAIL;type=3DINTERNET;type=3Dpref:tavarat1313@gmail.com=0D
TEL;type=3Dpref:081-807-3289=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B8=9A=E0=B8=AD=E0=B8=A1;DD;;;=0D
FN:DD =E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B8=9A=E0=B8=AD=E0=B8=A1=0D
TEL;type=3Dpref:0853447766=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B8=9A=E0=B8=AD=E0=B8=A5;;;=0D
FN:=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B8=9A=E0=B8=AD=E0=B8=A5=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:06-4195-9996=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B8=9A=E0=B8=B1=E0=B9=89=E0=B8=A1 P=
LG;;;=0D
FN:=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B8=9A=E0=B8=B1=E0=B9=89=E0=B8=A1 P=
LG=0D
TEL;type=3Dpref:081-998-2918=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B8=9A=E0=B8=B1=E0=B8=A7;;;=0D
FN:=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B8=9A=E0=B8=B1=E0=B8=A7=0D
TEL;type=3Dpref:086-644-5954=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B8=9A=E0=B8=B1=E0=B8=A7 Charity C=
ovid;;;=0D
FN:=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B8=9A=E0=B8=B1=E0=B8=A7 Charity C=
ovid=0D
TEL;type=3Dpref:0652326529=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B9=82=E0=B8=9A=E0=B8=A7=E0=B9=8C K=
ryoga;;;=0D
FN:=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B9=82=E0=B8=9A=E0=B8=A7=E0=B9=8C K=
ryoga=0D
TEL;type=3Dpref:095-440-6992=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B8=9B=E0=B8=A3=E0=B8=B4=E0=B9=89=E0=
=B8=99 2558;;;=0D
FN:=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B8=9B=E0=B8=A3=E0=B8=B4=E0=B9=89=E0=
=B8=99 2558=0D
TEL;type=3Dpref:092-751-8555=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B8=9B=E0=B8=AD=E0=B8=99 NV;;;=0D
FN:=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B8=9B=E0=B8=AD=E0=B8=99 NV=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:087-563-7942=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B8=9E=E0=B8=A3 =E0=B8=9E=E0=B8=A7=
=E0=B8=87=E0=B8=A1=E0=B8=B2=E0=B8=A5=E0=B8=B1=E0=B8=A2=E0=B8=82=E0=B8=B2=E0=B8=
=A7;;;=0D
FN:=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B8=9E=E0=B8=A3 =E0=B8=9E=E0=B8=A7=
=E0=B8=87=E0=B8=A1=E0=B8=B2=E0=B8=A5=E0=B8=B1=E0=B8=A2=E0=B8=82=E0=B8=B2=E0=B8=
=A7=0D
TEL;type=3Dpref:0613302630=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B8=9E=E0=B8=B4=E0=B8=A1 =E0=B8=AD=
=E0=B8=B2=E0=B8=99=E0=B8=B4=E0=B8=94;;;=0D
FN:=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B8=9E=E0=B8=B4=E0=B8=A1 =E0=B8=AD=
=E0=B8=B2=E0=B8=99=E0=B8=B4=E0=B8=94=0D
ORG:=E0=B9=80=E0=B8=95=E0=B8=B5=E0=B8=A2=E0=B8=87=E0=B8=99=E0=B8=AD=E0=B8=99=
;=0D
TEL;type=3Dpref:0814515757=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B9=81=E0=B8=9E=E0=B8=A1 RU;;;=0D
FN:=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B9=81=E0=B8=9E=E0=B8=A1 RU=0D
TEL;type=3Dpref:097-004-8119=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B8=A1=E0=B8=B4=E0=B9=89=E0=B8=A1 =E0=
=B8=9E=E0=B8=A2=E0=B8=B2=E0=B8=9A=E0=B8=B2=E0=B8=A5;;;=0D
FN:=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B8=A1=E0=B8=B4=E0=B9=89=E0=B8=A1 =E0=
=B8=9E=E0=B8=A2=E0=B8=B2=E0=B8=9A=E0=B8=B2=E0=B8=A5=0D
TEL;type=3Dpref:0653989525=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B9=80=E0=B8=A5=E0=B9=87=E0=B8=81 =E0=
=B8=AA=E0=B8=95=E0=B8=A3=E0=B8=B5=E0=B8=A7=E0=B8=B4=E0=B8=97;;;=0D
FN:=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B9=80=E0=B8=A5=E0=B9=87=E0=B8=81 =E0=
=B8=AA=E0=B8=95=E0=B8=A3=E0=B8=B5=E0=B8=A7=E0=B8=B4=E0=B8=97=0D
TEL;type=3Dpref:087-219-9933=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B8=AB=E0=B8=8D=E0=B8=B4=E0=B8=87;N=
ail Boutique FI;;;=0D
FN:Nail Boutique FI =E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B8=AB=E0=B8=8D=E0=
=B8=B4=E0=B8=87=0D
ORG:Fashion Iceland;=0D
TEL;type=3Dpref:02-947-5858=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B9=84=E0=B8=AB=E0=B8=A1 =E0=B8=A1=
=E0=B9=88=E0=B8=AD=E0=B8=99;;;=0D
FN:=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B9=84=E0=B8=AB=E0=B8=A1 =E0=B8=A1=
=E0=B9=88=E0=B8=AD=E0=B8=99=0D
TEL;type=3Dpref:081-962-4056=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B8=AD=E0=B8=B1=E0=B8=95 Ipad;CEW;;=
;=0D
FN:CEW =E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B8=AD=E0=B8=B1=E0=B8=95 Ipad=0D=

TEL;type=3Dpref:090-969-9626=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B8=AD=E0=B8=B1=E0=B8=95;Istudio Ce=
w;;;=0D
FN:Istudio Cew =E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B8=AD=E0=B8=B1=E0=B8=95=
=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:0909699626=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B8=AD=E0=B8=B8=E0=B9=89=E0=B8=A1 =E0=
=B8=A3=E0=B8=B2=E0=B8=A1=E0=B8=84=E0=B8=B3=E0=B9=81=E0=B8=AB=E0=B8=87;;;=0D
FN:=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B8=AD=E0=B8=B8=E0=B9=89=E0=B8=A1 =E0=
=B8=A3=E0=B8=B2=E0=B8=A1=E0=B8=84=E0=B8=B3=E0=B9=81=E0=B8=AB=E0=B8=87=0D
TEL;type=3Dpref:084-641-9843=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B9=81=E0=B8=AD=E0=B8=A5 =E0=B8=99=
=E0=B8=B2=E0=B8=87=E0=B8=9E=E0=B8=A2=E0=B8=B2=E0=B8=9A=E0=B8=B2=E0=B8=A5;;;=0D=

FN:=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B9=81=E0=B8=AD=E0=B8=A5 =E0=B8=99=
=E0=B8=B2=E0=B8=87=E0=B8=9E=E0=B8=A2=E0=B8=B2=E0=B8=9A=E0=B8=B2=E0=B8=A5=0D
TEL;type=3Dpref:084-374-9429=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E0=B8=99=E0=B8=B1=E0=B8=AD=E0=B8=87=E0=B8=A0=E0=B8=B1=E0=B8=97;=E0=B8=84=E0=
=B8=B8=E0=B8=93=E0=B8=AD=E0=B8=B8=E0=B9=8B=E0=B8=A2 RU;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=AD=E0=B8=B8=E0=B9=8B=E0=B8=A2 RU =E0=B8=
=99=E0=B8=B1=E0=B8=AD=E0=B8=87=E0=B8=A0=E0=B8=B1=E0=B8=97=0D
TEL;type=3Dpref:086-390-1005=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=99=E0=B8=B2=E0=B8=87=E0=B8=9E=E0=B8=A2=E0=B8=B2=E0=B8=9A=E0=B8=B2=E0=
=B8=A5 =E0=B8=A3=E0=B8=9E. =E0=B8=81=E0=B8=A3=E0=B8=B8=E0=B8=87=E0=B9=80=E0=B8=
=97=E0=B8=9E;;;=0D
FN:=E0=B8=99=E0=B8=B2=E0=B8=87=E0=B8=9E=E0=B8=A2=E0=B8=B2=E0=B8=9A=E0=B8=B2=E0=
=B8=A5 =E0=B8=A3=E0=B8=9E. =E0=B8=81=E0=B8=A3=E0=B8=B8=E0=B8=87=E0=B9=80=E0=B8=
=97=E0=B8=9E=0D
TEL;type=3Dpref:023103013=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=99=E0=B9=89=E0=B8=B2=E0=B8=95=E0=B9=8B=E0=B8=AD=E0=B8=A2;;;=0D
FN:=E0=B8=99=E0=B9=89=E0=B8=B2=E0=B8=95=E0=B9=8B=E0=B8=AD=E0=B8=A2=0D
TEL;type=3Dpref:+66818345550=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=99=E0=B9=89=E0=B8=B2=E0=B8=99=E0=B8=B8=E0=B8=8A;;;=0D
FN:=E0=B8=99=E0=B9=89=E0=B8=B2=E0=B8=99=E0=B8=B8=E0=B8=8A=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:0900599969=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=99=E0=B9=89=E0=B8=B2=E0=B8=A7=E0=B8=A3=E0=B8=A3=E0=B8=93;;;=0D
FN:=E0=B8=99=E0=B9=89=E0=B8=B2=E0=B8=A7=E0=B8=A3=E0=B8=A3=E0=B8=93=0D
TEL;type=3Dpref:081-819-0003=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=99=E0=B8=B8=E0=B9=88=E0=B8=A2 DC;;;=0D
FN:=E0=B8=99=E0=B8=B8=E0=B9=88=E0=B8=A2 DC=0D
TEL;type=3Dpref:081-940-9988=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B9=81=E0=B8=99=E0=B8=99 Sw;;;=0D
FN:=E0=B9=81=E0=B8=99=E0=B8=99 Sw=0D
TEL;type=3Dpref:086-771-8768=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=9A Seekler;;;=0D
FN:=E0=B8=9A Seekler=0D
ORG:Cleaning;=0D
TEL;type=3DWORK;type=3DVOICE;type=3Dpref:02-080-3939=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=9A=E0=B8=AD=E0=B8=A5;;;=0D
FN:=E0=B8=9A=E0=B8=AD=E0=B8=A5=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:*8812=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=9A=E0=B8=B1=E0=B8=A7 =E0=B8=9B=E0=B8=B1=E0=B8=97;;;=0D
FN:=E0=B8=9A=E0=B8=B1=E0=B8=A7 =E0=B8=9B=E0=B8=B1=E0=B8=97=0D
TEL;type=3Dpref:0965054564=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=9A=E0=B8=B2=E0=B9=80=E0=B8=8B=E0=B8=B5=E0=B8=A2 Front Desk;;;=0D
FN:=E0=B8=9A=E0=B8=B2=E0=B9=80=E0=B8=8B=E0=B8=B5=E0=B8=A2 Front Desk=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:0989385911=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=9A=E0=B9=89=E0=B8=B2=E0=B8=99=E0=B9=83=E0=B8=99=E0=B8=81=E0=B8=A3=E0=
=B8=A1;;;=0D
FN:=E0=B8=9A=E0=B9=89=E0=B8=B2=E0=B8=99=E0=B9=83=E0=B8=99=E0=B8=81=E0=B8=A3=E0=
=B8=A1=0D
TEL;type=3Dpref:022415040=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E0=B8=9A=E0=B8=B8=E0=B8=8D=E0=B8=98=E0=B8=B2=E0=B8=A7=E0=B8=A3;=E0=B8=95=E0=
=B8=B8=E0=B8=93=E0=B8=AD=E0=B8=A0=E0=B8=B4=E0=B8=8A=E0=B8=B2=E0=B8=95=E0=B8=B4=
;;;=0D
FN:=E0=B8=95=E0=B8=B8=E0=B8=93=E0=B8=AD=E0=B8=A0=E0=B8=B4=E0=B8=8A=E0=B8=B2=E0=
=B8=95=E0=B8=B4 =E0=B8=9A=E0=B8=B8=E0=B8=8D=E0=B8=98=E0=B8=B2=E0=B8=A7=E0=B8=
=A3=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:0610101042=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E0=B8=9B=E0=B8=97=E0=B8=B4=E0=B8=99=E0=B8=A2=E0=B8=B2;=E0=B8=84=E0=B8=B8=E0=
=B8=93=E0=B8=AD=E0=B8=B8=E0=B9=8B=E0=B8=A1;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=AD=E0=B8=B8=E0=B9=8B=E0=B8=A1 =E0=B8=9B=
=E0=B8=97=E0=B8=B4=E0=B8=99=E0=B8=A2=E0=B8=B2=0D
ORG:=E0=B8=98.=E0=B8=81=E0=B8=A3=E0=B8=B8=E0=B8=87=E0=B9=84=E0=B8=97=E0=B8=A2=
;=0D
TEL;type=3Dpref:086-381-5700=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=9B.=E0=B8=9A=E0=B8=A3=E0=B8=B1=E0=B9=88=E0=B8=99=E0=B8=94=E0=B8=B5=
;;;=0D
FN:=E0=B8=9B.=E0=B8=9A=E0=B8=A3=E0=B8=B1=E0=B9=88=E0=B8=99=E0=B8=94=E0=B8=B5=
=0D
TEL;type=3DWORK;type=3DVOICE;type=3Dpref:086-321-5556=0D
TEL;type=3DHOME;type=3DVOICE:02-252-5876=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=9B=E0=B8=AD;;;=0D
FN:=E0=B8=9B=E0=B8=AD=0D
TEL;type=3Dpref:081-696-6602=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E0=B8=9B=E0=B8=B1=E0=B9=89=E0=B8=99=E0=B8=99=E0=B8=B2=E0=B8=84;=E0=B8=89=E0=
=B8=B1=E0=B8=95=E0=B8=A3=E0=B8=94=E0=B8=B2=E0=B8=A7;;;=0D
FN:=E0=B8=89=E0=B8=B1=E0=B8=95=E0=B8=A3=E0=B8=94=E0=B8=B2=E0=B8=A7 =E0=B8=9B=
=E0=B8=B1=E0=B9=89=E0=B8=99=E0=B8=99=E0=B8=B2=E0=B8=84=0D
TEL;type=3Dpref:081-818-7309=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=9B=E0=B8=B1=E0=B8=99=E0=B8=9B=E0=B8=B1=E0=B8=99 66;;;=0D
FN:=E0=B8=9B=E0=B8=B1=E0=B8=99=E0=B8=9B=E0=B8=B1=E0=B8=99 66=0D
TEL;type=3Dpref:0971782666=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E0=B8=9B=E0=B9=89=E0=B8=B2=E0=B8=81=E0=B8=B2=E0=B8=8D;=E0=B8=A7=E0=B8=B4=E0=
=B8=A3=E0=B8=B1=E0=B8=8A Farm;;;=0D
FN:=E0=B8=A7=E0=B8=B4=E0=B8=A3=E0=B8=B1=E0=B8=8A Farm =E0=B8=9B=E0=B9=89=E0=B8=
=B2=E0=B8=81=E0=B8=B2=E0=B8=8D=0D
TEL;type=3Dpref:022411774=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=9B=E0=B9=89=E0=B8=B2=E0=B8=88=E0=B8=B3=E0=B8=A3=E0=B8=B1=E0=B8=AA;=
;;=0D
FN:=E0=B8=9B=E0=B9=89=E0=B8=B2=E0=B8=88=E0=B8=B3=E0=B8=A3=E0=B8=B1=E0=B8=AA=0D=

TEL;type=3Dpref:089-673-6326=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=9B=E0=B9=89=E0=B8=B2=E0=B8=88=E0=B8=B8=E0=B8=94 =E0=B8=A3=E0=B9=89=
=E0=B8=B2=E0=B8=99=E0=B8=95=E0=B9=89=E0=B8=99=E0=B9=84=E0=B8=A1=E0=B9=89;;;=0D=

FN:=E0=B8=9B=E0=B9=89=E0=B8=B2=E0=B8=88=E0=B8=B8=E0=B8=94 =E0=B8=A3=E0=B9=89=
=E0=B8=B2=E0=B8=99=E0=B8=95=E0=B9=89=E0=B8=99=E0=B9=84=E0=B8=A1=E0=B9=89=0D
TEL;type=3Dpref:089-026-4616=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B9=80=E0=B8=9B=E0=B8=B4=E0=B9=89=E0=B8=A5 DC;;;=0D
FN:=E0=B9=80=E0=B8=9B=E0=B8=B4=E0=B9=89=E0=B8=A5 DC=0D
TEL;type=3Dpref:+66815734444=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B9=81=E0=B8=9B=E0=B9=89=E0=B8=87 =E0=B8=81=E0=B8=AD=E0=B8=9A;;;=0D
FN:=E0=B9=81=E0=B8=9B=E0=B9=89=E0=B8=87 =E0=B8=81=E0=B8=AD=E0=B8=9A=0D
TEL;type=3Dpref:090-964-4456=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E0=B8=9C=E0=B8=B9=E0=B9=89=E0=B8=8A=E0=B9=88=E0=B8=A7=E0=B8=A2=E0=B9=80=E0=
=B8=88=E0=B9=89=E0=B8=B2=E0=B8=AD=E0=B8=B2=E0=B8=A7=E0=B8=B2=E0=B8=AA=E0=B8=A7=
=E0=B8=B1=E0=B8=94=E0=B8=A8=E0=B8=B4=E0=B8=A3=E0=B8=B4=E0=B8=9E=E0=B8=87=E0=B8=
=A9=E0=B9=8C=E0=B9=88=E0=B8=AF;=E0=B8=9E=E0=B8=A3=E0=B8=B0=E0=B8=8A=E0=B8=B9=
=E0=B8=9E=E0=B8=87=E0=B8=A9=E0=B9=8C=E0=B8=9E=E0=B8=B1=E0=B8=92=E0=B9=8C;;;=0D=

FN:=E0=B8=9E=E0=B8=A3=E0=B8=B0=E0=B8=8A=E0=B8=B9=E0=B8=9E=E0=B8=87=E0=B8=A9=E0=
=B9=8C=E0=B8=9E=E0=B8=B1=E0=B8=92=E0=B9=8C =E0=B8=9C=E0=B8=B9=E0=B9=89=E0=B8=
=8A=E0=B9=88=E0=B8=A7=E0=B8=A2=E0=B9=80=E0=B8=88=E0=B9=89=E0=B8=B2=E0=B8=AD=E0=
=B8=B2=E0=B8=A7=E0=B8=B2=E0=B8=AA=E0=B8=A7=E0=B8=B1=E0=B8=94=E0=B8=A8=E0=B8=B4=
=E0=B8=A3=E0=B8=B4=E0=B8=9E=E0=B8=87=E0=B8=A9=E0=B9=8C=E0=B9=88=E0=B8=AF=0D
TEL;type=3Dpref:086-540-8346=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E0=B8=9E=E0=B8=A3=E0=B8=A1 =E0=B8=9C=E0=B9=89=E0=B8=B2=E0=B8=A1=E0=B9=88=E0=
=B8=B2=E0=B8=99 =E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=AB=E0=B8=A1=E0=B8=B1=E0=B9=
=88=E0=B8=99;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=A7=E0=B8=B4=E0=B8=97=E0=B8=A7=
=E0=B8=B1=E0=B8=AA;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=A7=E0=B8=B4=E0=B8=97=E0=B8=A7=E0=B8=B1=E0=
=B8=AA =E0=B8=9E=E0=B8=A3=E0=B8=A1 =E0=B8=9C=E0=B9=89=E0=B8=B2=E0=B8=A1=E0=B9=
=88=E0=B8=B2=E0=B8=99 =E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=AB=E0=B8=A1=E0=B8=B1=
=E0=B9=88=E0=B8=99=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:086-907-5293=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E0=B8=9E=E0=B8=A7=E0=B8=87=E0=B8=A1=E0=B8=B2=E0=B8=A5=E0=B8=B1=E0=B8=A2;=E0=
=B8=84=E0=B8=B8=E0=B8=93=E0=B8=AB=E0=B8=99=E0=B8=B4=E0=B8=87;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=AB=E0=B8=99=E0=B8=B4=E0=B8=87 =E0=B8=9E=
=E0=B8=A7=E0=B8=87=E0=B8=A1=E0=B8=B2=E0=B8=A5=E0=B8=B1=E0=B8=A2=0D
ORG:=E0=B8=95.=E0=B8=96=E0=B8=99=E0=B8=AD=E0=B8=A1=E0=B8=A1=E0=B8=B4=E0=B8=95=
=E0=B8=A3;=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:083-307-3939=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E0=B8=9E=E0=B8=AB=E0=B8=A5;Copy World;;;=0D
FN:Copy World =E0=B8=9E=E0=B8=AB=E0=B8=A5=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:02-615-2876=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=81=E0=B8=A5=E0=B9=89=E0=B8=A7=E0=B8=A2 =E0=
=B8=A7=E0=B8=B1=E0=B8=87=E0=B8=AB=E0=B8=99=E0=B9=89=E0=B8=B2;;;=0D
FN:=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=81=E0=B8=A5=E0=B9=89=E0=B8=A7=E0=B8=A2 =E0=
=B8=A7=E0=B8=B1=E0=B8=87=E0=B8=AB=E0=B8=99=E0=B9=89=E0=B8=B2=0D
ORG:=E0=B8=AA=E0=B8=B1=E0=B8=87=E0=B8=84=E0=B8=B5=E0=B8=95;=0D
TEL;type=3Dpref:089-211-4499=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=81=E0=B9=89=E0=B8=AD=E0=B8=A2 =E0=B8=9E=
=E0=B8=B5=E0=B9=88=E0=B8=A7=E0=B8=B1=E0=B8=8A;;;=0D
FN:=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=81=E0=B9=89=E0=B8=AD=E0=B8=A2 =E0=B8=9E=
=E0=B8=B5=E0=B9=88=E0=B8=A7=E0=B8=B1=E0=B8=8A=0D
TEL;type=3Dpref:+66892227173=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B9=81=E0=B8=81=E0=B9=89=E0=B8=9A =E0=B8=9E=
=E0=B8=B5=E0=B9=88=E0=B8=9A=E0=B8=B8=E0=B9=8B=E0=B8=A1;;;=0D
FN:=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B9=81=E0=B8=81=E0=B9=89=E0=B8=9A =E0=B8=9E=
=E0=B8=B5=E0=B9=88=E0=B8=9A=E0=B8=B8=E0=B9=8B=E0=B8=A1=0D
TEL;type=3Dpref:0894915659=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B9=84=E0=B8=81=E0=B9=88;;;=0D
FN:=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B9=84=E0=B8=81=E0=B9=88=0D
TEL;type=3Dpref:091-491-4170=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B9=80=E0=B8=88=E0=B8=95 NV;;;=0D
FN:=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B9=80=E0=B8=88=E0=B8=95 NV=0D
TEL;type=3Dpref:081-849-7320=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=8A=E0=B9=88=E0=B8=B2=E0=B8=87=E0=B9=80=E0=
=B8=A5=E0=B9=87=E0=B8=81;;;=0D
FN:=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=8A=E0=B9=88=E0=B8=B2=E0=B8=87=E0=B9=80=E0=
=B8=A5=E0=B9=87=E0=B8=81=0D
TEL;type=3Dpref:089-129-1923=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=8A=E0=B8=B2=E0=B8=A2=E0=B8=A3=E0=B8=B8=E0=
=B8=88;;;=0D
FN:=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=8A=E0=B8=B2=E0=B8=A2=E0=B8=A3=E0=B8=B8=E0=
=B8=88=0D
EMAIL;type=3DINTERNET;type=3Dpref:sirarujs@gmail.com=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=8A=E0=B8=B8=E0=B8=A1;;;=0D
FN:=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=8A=E0=B8=B8=E0=B8=A1=0D
TEL;type=3Dpref:081-912-9888=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=95=E0=B9=89=E0=B8=99 Zoulviet;;;=0D
FN:=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=95=E0=B9=89=E0=B8=99 Zoulviet=0D
TEL;type=3Dpref:0814496565=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=95=E0=B8=B4=E0=B9=88=E0=B8=81 =E0=B8=8A=
=E0=B8=B5=E0=B9=82=E0=B8=A3=E0=B9=88;;;=0D
FN:=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=95=E0=B8=B4=E0=B9=88=E0=B8=81 =E0=B8=8A=
=E0=B8=B5=E0=B9=82=E0=B8=A3=E0=B9=88=0D
TEL;type=3Dpref:0895691569=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=95=E0=B8=B4=E0=B9=8B=E0=B8=A1 NV;;;=0D
FN:=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=95=E0=B8=B4=E0=B9=8B=E0=B8=A1 NV=0D
TEL;type=3Dpref:0819849133=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B9=80=E0=B8=95=E0=B9=89=E0=B8=AD =E0=B8=AD=
=E0=B8=B2=E0=B8=A7=E0=B8=B4=E0=B8=8A=E0=B8=B2;;;=0D
FN:=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B9=80=E0=B8=95=E0=B9=89=E0=B8=AD =E0=B8=AD=
=E0=B8=B2=E0=B8=A7=E0=B8=B4=E0=B8=8A=E0=B8=B2=0D
TEL;type=3Dpref:081-852-8200=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B9=82=E0=B8=95=E0=B9=8B =E0=B8=9E=E0=B8=B5=
=E0=B9=88=E0=B9=80=E0=B9=80=E0=B8=AB=E0=B8=A7=E0=B8=A7;;;=0D
FN:=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B9=82=E0=B8=95=E0=B9=8B =E0=B8=9E=E0=B8=B5=
=E0=B9=88=E0=B9=80=E0=B9=80=E0=B8=AB=E0=B8=A7=E0=B8=A7=0D
TEL;type=3Dpref:0819533567=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=99=E0=B8=95 =E0=B8=81=E0=B8=AD=E0=B8=9A=
;;;=0D
FN:=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=99=E0=B8=95 =E0=B8=81=E0=B8=AD=E0=B8=9A=
=0D
TEL;type=3Dpref:098-665-6554=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=9A=E0=B8=AD=E0=B8=A2 =E0=B8=A0=E0=B8=B9=
=E0=B9=80=E0=B8=81=E0=B9=87=E0=B8=88;;;=0D
FN:=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=9A=E0=B8=AD=E0=B8=A2 =E0=B8=A0=E0=B8=B9=
=E0=B9=80=E0=B8=81=E0=B9=87=E0=B8=88=0D
TEL;type=3Dpref:0855555995=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=9A=E0=B8=B8=E0=B9=8B=E0=B8=A1 =E0=B8=A1=
=E0=B9=88=E0=B8=AD=E0=B8=99;;;=0D
FN:=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=9A=E0=B8=B8=E0=B9=8B=E0=B8=A1 =E0=B8=A1=
=E0=B9=88=E0=B8=AD=E0=B8=99=0D
TEL;type=3Dpref:081-995-4014=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=9B=E0=B8=A3=E0=B8=B0=E0=B8=A0=E0=B8=B2=E0=
=B8=AA;;;=0D
FN:=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=9B=E0=B8=A3=E0=B8=B0=E0=B8=A0=E0=B8=B2=E0=
=B8=AA=0D
TEL;type=3Dpref:086-515-0258=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=9B=E0=B8=A3=E0=B8=B2=E0=B8=93=E0=B8=B5 =E0=
=B8=99=E0=B8=A7=E0=B8=99=E0=B8=84=E0=B8=A3;;;=0D
FN:=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=9B=E0=B8=A3=E0=B8=B2=E0=B8=93=E0=B8=B5 =E0=
=B8=99=E0=B8=A7=E0=B8=99=E0=B8=84=E0=B8=A3=0D
TEL;type=3Dpref:089-532-1911=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=9B=E0=B9=89=E0=B8=AD=E0=B8=A1 =E0=B8=8A=
=E0=B9=88=E0=B8=A7=E0=B8=A2=E0=B8=97=E0=B8=B3=E0=B8=9A=E0=B8=B8=E0=B8=8D;;;=0D=

FN:=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=9B=E0=B9=89=E0=B8=AD=E0=B8=A1 =E0=B8=8A=
=E0=B9=88=E0=B8=A7=E0=B8=A2=E0=B8=97=E0=B8=B3=E0=B8=9A=E0=B8=B8=E0=B8=8D=0D
TEL;type=3Dpref:083-709-6089=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=9B=E0=B9=88=E0=B8=B2=E0=B8=99 =E0=B8=9E=
=E0=B8=B5=E0=B9=88=E0=B8=81=E0=B9=89=E0=B8=AD=E0=B8=87;;;=0D
FN:=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=9B=E0=B9=88=E0=B8=B2=E0=B8=99 =E0=B8=9E=
=E0=B8=B5=E0=B9=88=E0=B8=81=E0=B9=89=E0=B8=AD=E0=B8=87=0D
TEL;type=3Dpref:0813639383=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=9B=E0=B8=B8=E0=B9=8A =E0=B8=99=E0=B8=A7=
=E0=B8=94_=E0=B8=A7=E0=B8=B4=E0=B8=8A=E0=B8=B1=E0=B8=A2=E0=B8=A2=E0=B8=B8=E0=
=B8=97=E0=B8=98;;;=0D
FN:=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=9B=E0=B8=B8=E0=B9=8A =E0=B8=99=E0=B8=A7=
=E0=B8=94_=E0=B8=A7=E0=B8=B4=E0=B8=8A=E0=B8=B1=E0=B8=A2=E0=B8=A2=E0=B8=B8=E0=
=B8=97=E0=B8=98=0D
TEL;type=3Dpref:088-883-8696=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=9B=E0=B8=B9 =E0=B8=A3=E0=B8=96=E0=B8=8A=
=E0=B8=99;;;=0D
FN:=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=9B=E0=B8=B9 =E0=B8=A3=E0=B8=96=E0=B8=8A=
=E0=B8=99=0D
ORG:CPT CO\, Lt;=0D
TEL;type=3Dpref:0818178335=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B9=80=E0=B8=9B=E0=B8=B5=E0=B9=89=E0=B8=A2=E0=
=B8=A7;;;=0D
FN:=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B9=80=E0=B8=9B=E0=B8=B5=E0=B9=89=E0=B8=A2=E0=
=B8=A7=0D
TEL;type=3Dpref:081-341-3760=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=9E=E0=B8=A3 =E0=B8=A7=E0=B8=B1=E0=B8=87=
=E0=B8=AB=E0=B8=99=E0=B9=89=E0=B8=B2;;;=0D
FN:=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=9E=E0=B8=A3 =E0=B8=A7=E0=B8=B1=E0=B8=87=
=E0=B8=AB=E0=B8=99=E0=B9=89=E0=B8=B2=0D
ORG:=E0=B8=AA=E0=B8=B1=E0=B8=87=E0=B8=84=E0=B8=B5=E0=B8=95;=0D
TEL;type=3Dpref:0849161247=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=9F=E0=B9=89=E0=B8=B2 O Cousin;;;=0D
FN:=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=9F=E0=B9=89=E0=B8=B2 O Cousin=0D
TEL;type=3Dpref:082-464-9828=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B9=80=E0=B8=A1;;;=0D
FN:=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B9=80=E0=B8=A1=0D
TEL;type=3Dpref:082-543-2572=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B9=80=E0=B8=A1=E0=B8=95 =E0=B9=84=E0=B8=81=
=E0=B9=88=E0=B8=A2=E0=B9=88=E0=B8=B2=E0=B8=87 =E0=B8=88=E0=B8=B1=E0=B8=81=E0=
=B8=A3=E0=B8=B2=E0=B8=8A;;;=0D
FN:=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B9=80=E0=B8=A1=E0=B8=95 =E0=B9=84=E0=B8=81=
=E0=B9=88=E0=B8=A2=E0=B9=88=E0=B8=B2=E0=B8=87 =E0=B8=88=E0=B8=B1=E0=B8=81=E0=
=B8=A3=E0=B8=B2=E0=B8=8A=0D
TEL;type=3Dpref:095-691-3412=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B9=80=E0=B8=A5=E0=B9=87=E0=B8=81;;;=0D
FN:=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B9=80=E0=B8=A5=E0=B9=87=E0=B8=81=0D
ORG:=E0=B8=A3=E0=B9=89=E0=B9=88=E0=B8=B2=E0=B8=99=E0=B8=8B=E0=B9=88=E0=B8=AD=
=E0=B8=A1=E0=B8=9C=E0=B9=89=E0=B8=B2 =E0=B8=99=E0=B8=A7=E0=B8=99=E0=B8=84=E0=
=B8=A3;=0D
TEL;type=3Dpref:092-403-6230=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=AA=E0=B8=B4=E0=B8=97 Home;;;=0D
FN:=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=AA=E0=B8=B4=E0=B8=97 Home=0D
TEL;type=3Dpref:087-091-1503=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B9=80=E0=B8=AA=E0=B8=B7=E0=B8=AD;;;=0D
FN:=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B9=80=E0=B8=AA=E0=B8=B7=E0=B8=AD=0D
TEL;type=3Dpref:095-706-4874=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=AB=E0=B8=8D=E0=B8=B4=E0=B8=87 Crazy Ste=
p;;;=0D
FN:=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=AB=E0=B8=8D=E0=B8=B4=E0=B8=87 Crazy Ste=
p=0D
TEL;type=3Dpref:021368003=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=AB=E0=B8=99=E0=B8=B9 =E0=B8=A5=E0=B8=B8=
=E0=B9=89=E0=B8=81;;;=0D
FN:=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=AB=E0=B8=99=E0=B8=B9 =E0=B8=A5=E0=B8=B8=
=E0=B9=89=E0=B8=81=0D
TEL;type=3Dpref:081-402-4214=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=AB=E0=B8=A1=E0=B8=B1=E0=B9=88=E0=B8=99;=
;;=0D
FN:=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=AB=E0=B8=A1=E0=B8=B1=E0=B9=88=E0=B8=99=0D=

TEL;type=3Dpref:089-407-7766=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=AD=E0=B9=89=E0=B8=99;;;=0D
FN:=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=AD=E0=B9=89=E0=B8=99=0D
TEL;type=3Dpref:083-197-9958=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=AD=E0=B8=AD=E0=B8=A2 =E0=B8=97=E0=B8=B3=
=E0=B8=9C=E0=B8=A1;;;=0D
FN:=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=AD=E0=B8=AD=E0=B8=A2 =E0=B8=97=E0=B8=B3=
=E0=B8=9C=E0=B8=A1=0D
ORG:Salon Diva;=0D
TEL;type=3Dpref:02-949-8486=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=AD=E0=B8=B8=E0=B9=8A;Dr =E0=B8=81=E0=B8=A4=
=E0=B8=95;;;=0D
FN:Dr =E0=B8=81=E0=B8=A4=E0=B8=95 =E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B8=AD=E0=B8=
=B8=E0=B9=8A=0D
TEL;type=3Dpref:081-411-7413=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B9=80=E0=B8=AD=E0=B9=8B;;;=0D
FN:=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B9=80=E0=B8=AD=E0=B9=8B=0D
ORG:Trade Jew;=0D
TEL;type=3Dpref:085-963-2517=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B9=80=E0=B8=AD=E0=B9=8B;=E0=B8=8A=E0=B8=99;=
;;=0D
FN:=E0=B8=8A=E0=B8=99 =E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B9=80=E0=B8=AD=E0=B9=8B=
=0D
TEL;type=3Dpref:+66 99-363-5959=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B9=80=E0=B8=AD=E0=B8=84=E0=B8=B8=E0=B8=93=E0=
=B8=95=E0=B9=89=E0=B8=99;;;=0D
FN:=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B9=80=E0=B8=AD=E0=B8=84=E0=B8=B8=E0=B8=93=E0=
=B8=95=E0=B9=89=E0=B8=99=0D
EMAIL;type=3DINTERNET;type=3Dpref:subhavat@navanakorn.co.th=0D
TEL;type=3Dpref:081-937-9039=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E0=B8=9E=E0=B8=B5=E0=B9=88=E0=B9=80=E0=B8=AE=E0=B9=89=E0=B8=A2;=E0=B8=A3=E0=
=B9=89=E0=B8=B2=E0=B8=A2=E0=B8=82=E0=B8=B2=E0=B8=A2=E0=B8=A2=E0=B8=B2=E0=B8=97=
=E0=B8=AD=E0=B8=87=E0=B8=AB=E0=B8=A5=E0=B9=88=E0=B8=AD;;;=0D
FN:=E0=B8=A3=E0=B9=89=E0=B8=B2=E0=B8=A2=E0=B8=82=E0=B8=B2=E0=B8=A2=E0=B8=A2=E0=
=B8=B2=E0=B8=97=E0=B8=AD=E0=B8=87=E0=B8=AB=E0=B8=A5=E0=B9=88=E0=B8=AD =E0=B8=
=9E=E0=B8=B5=E0=B9=88=E0=B9=80=E0=B8=AE=E0=B9=89=E0=B8=A2=0D
TEL;type=3Dpref:023911369=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B9=81=E0=B8=9E=E0=B8=A3=E0=B8=A7 51;;;=0D
FN:=E0=B9=81=E0=B8=9E=E0=B8=A3=E0=B8=A7 51=0D
TEL;type=3Dpref:0824415651=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E0=B8=9F=E0=B8=A3=E0=B8=B5;=E0=B8=9B=E0=B8=B4=E0=B8=94data;roaming;;=0D
FN:=E0=B8=9B=E0=B8=B4=E0=B8=94data roaming =E0=B8=9F=E0=B8=A3=E0=B8=B5=0D
TEL;type=3Dpref:*106#=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=A1=E0=B9=88=E0=B8=AD=E0=B8=99 New;;;=0D
FN:=E0=B8=A1=E0=B9=88=E0=B8=AD=E0=B8=99 New=0D
TEL;type=3Dpref:086-651-9566=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B9=81=E0=B8=A1=E0=B8=99;;;=0D
FN:=E0=B9=81=E0=B8=A1=E0=B8=99=0D
TEL;type=3Dpref:086-899-2929=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E0=B8=A2=E0=B8=81=E0=B9=80=E0=B8=A5=E0=B8=B4=E0=B8=81=E0=B8=A3=E0=B8=B1=E0=
=B8=9ASMS;.=E0=B8=9F=E0=B8=A3=E0=B8=B5;;;=0D
FN:.=E0=B8=9F=E0=B8=A3=E0=B8=B5 =E0=B8=A2=E0=B8=81=E0=B9=80=E0=B8=A5=E0=B8=B4=
=E0=B8=81=E0=B8=A3=E0=B8=B1=E0=B8=9ASMS=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:*137=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E0=B8=A2=E0=B8=B3=E0=B8=9C=E0=B8=B1=E0=B8=81 (=E0=B9=81=E0=B8=84=E0=B8=8A=
=E0=B9=80=E0=B8=8A=E0=B8=B5=E0=B8=A2);Lamon Farm;;;=0D
FN:Lamon Farm =E0=B8=A2=E0=B8=B3=E0=B8=9C=E0=B8=B1=E0=B8=81 (=E0=B9=81=E0=B8=
=84=E0=B8=8A=E0=B9=80=E0=B8=8A=E0=B8=B5=E0=B8=A2)=0D
ORG:=E0=B8=95=E0=B9=88=E0=B8=AD 104;=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:02-575-2222=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=A2=E0=B8=B4=E0=B9=89=E0=B8=A1;;;=0D
FN:=E0=B8=A2=E0=B8=B4=E0=B9=89=E0=B8=A1=0D
TEL;type=3Dpref:081-811-9191=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=A3=E0=B8=9E =E0=B8=A2=E0=B8=B1=E0=B8=99=E0=B8=AE=E0=B8=B5;;;=0D
FN:=E0=B8=A3=E0=B8=9E =E0=B8=A2=E0=B8=B1=E0=B8=99=E0=B8=AE=E0=B8=B5=0D
TEL;type=3Dpref:028790300=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=A3=E0=B9=88=E0=B8=A7=E0=B8=A1=E0=B8=94=E0=B9=89=E0=B8=A7=E0=B8=A2=E0=
=B8=8A=E0=B9=88=E0=B8=A7=E0=B8=A2=E0=B8=81=E0=B8=B1=E0=B8=99;;;=0D
FN:=E0=B8=A3=E0=B9=88=E0=B8=A7=E0=B8=A1=E0=B8=94=E0=B9=89=E0=B8=A7=E0=B8=A2=E0=
=B8=8A=E0=B9=88=E0=B8=A7=E0=B8=A2=E0=B8=81=E0=B8=B1=E0=B8=99=0D
TEL;type=3Dpref:1677=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E0=B8=A3=E0=B8=B0=E0=B8=87=E0=B8=B1=E0=B8=9ASMS=E0=B9=82=E0=B8=86=E0=B8=A9=
=E0=B8=93=E0=B8=B2;=E0=B8=9F=E0=B8=A3=E0=B8=B5;;;=0D
FN:=E0=B8=9F=E0=B8=A3=E0=B8=B5 =E0=B8=A3=E0=B8=B0=E0=B8=87=E0=B8=B1=E0=B8=9A=
SMS=E0=B9=82=E0=B8=86=E0=B8=A9=E0=B8=93=E0=B8=B2=0D
TEL;type=3Dpref:*137=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=A3=E0=B9=89=E0=B8=B2=E0=B8=99=E0=B8=8B=E0=B9=88=E0=B8=AD=E0=B8=A1=E0=
=B8=81=E0=B8=A3=E0=B8=B0=E0=B9=80=E0=B8=9B=E0=B9=8B=E0=B8=B2;;;=0D
FN:=E0=B8=A3=E0=B9=89=E0=B8=B2=E0=B8=99=E0=B8=8B=E0=B9=88=E0=B8=AD=E0=B8=A1=E0=
=B8=81=E0=B8=A3=E0=B8=B0=E0=B9=80=E0=B8=9B=E0=B9=8B=E0=B8=B2=0D
ORG:8 Thonglor;=0D
TEL;type=3Dpref:+66 83 085 7407=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=A3=E0=B9=89=E0=B8=B2=E0=B8=99=E0=B9=81=E0=B8=A1=E0=B8=A7=E0=B8=AB=E0=
=B8=B9=E0=B8=AB=E0=B8=99=E0=B8=B2;;;=0D
FN:=E0=B8=A3=E0=B9=89=E0=B8=B2=E0=B8=99=E0=B9=81=E0=B8=A1=E0=B8=A7=E0=B8=AB=E0=
=B8=B9=E0=B8=AB=E0=B8=99=E0=B8=B2=0D
TEL;type=3Dpref:0859037371=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=A3=E0=B9=89=E0=B8=B2=E0=B8=99=E0=B8=A2=E0=B8=B2=E0=B8=87=E0=B8=81=E0=
=B9=88=E0=B8=AD=E0=B9=80=E0=B8=88=E0=B8=A3=E0=B8=B4=E0=B8=8D;;;=0D
FN:=E0=B8=A3=E0=B9=89=E0=B8=B2=E0=B8=99=E0=B8=A2=E0=B8=B2=E0=B8=87=E0=B8=81=E0=
=B9=88=E0=B8=AD=E0=B9=80=E0=B8=88=E0=B8=A3=E0=B8=B4=E0=B8=8D=0D
TEL;type=3Dpref:086-318-1403=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=A3=E0=B9=89=E0=B8=B2=E0=B8=99=E0=B9=80=E0=B8=AA=E0=B8=B7=E0=B9=89=E0=
=B8=AD The Nine;;;=0D
FN:=E0=B8=A3=E0=B9=89=E0=B8=B2=E0=B8=99=E0=B9=80=E0=B8=AA=E0=B8=B7=E0=B9=89=E0=
=B8=AD The Nine=0D
TEL;type=3Dpref:+66814467742=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E0=B8=A3=E0=B8=B2=E0=B8=A1=E0=B8=84=E0=B8=B3=E0=B9=81=E0=B8=AB=E0=B8=87 6=
5;=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B8=9A=E0=B8=B9 =E0=B8=9A/=E0=B8=8A=
 =E0=B8=88=E0=B8=B8=E0=B8=A3=E0=B8=B2;;;=0D
FN:=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B8=9A=E0=B8=B9 =E0=B8=9A/=E0=B8=8A=
 =E0=B8=88=E0=B8=B8=E0=B8=A3=E0=B8=B2 =E0=B8=A3=E0=B8=B2=E0=B8=A1=E0=B8=84=E0=
=B8=B3=E0=B9=81=E0=B8=AB=E0=B8=87 65=0D
ORG:Grand Sport;=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:0846698122=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E0=B8=A5=E0=B9=88=E0=B8=B3;Mint;;;=0D
FN:Mint =E0=B8=A5=E0=B9=88=E0=B8=B3=0D
TEL;type=3Dpref:06-2461-4245=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E0=B9=80=E0=B8=A5=E0=B8=82=E0=B8=B2=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=AD=E0=
=B8=B2=E0=B8=A7=E0=B8=B4=E0=B8=81=E0=B8=A5=E0=B8=A1;=E0=B8=84=E0=B8=B8=E0=B8=
=93=E0=B9=81=E0=B8=9E=E0=B8=A3;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B9=81=E0=B8=9E=E0=B8=A3 =E0=B9=80=E0=B8=A5=
=E0=B8=82=E0=B8=B2=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=AD=E0=B8=B2=E0=B8=A7=E0=B8=
=B4=E0=B8=81=E0=B8=A5=E0=B8=A1=0D
TEL;type=3Dpref:027920021=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E0=B8=A7=E0=B8=B1=E0=B8=8A=E0=B8=A3=E0=B8=9E=E0=B8=A5 Pet Clinic Care;=E0=
=B8=84=E0=B8=B8=E0=B8=93=E0=B8=AB=E0=B8=A1=E0=B8=AD=E0=B8=A1=E0=B8=B2=E0=B8=A2=
=E0=B8=94=E0=B9=8C;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=AB=E0=B8=A1=E0=B8=AD=E0=B8=A1=E0=B8=B2=E0=
=B8=A2=E0=B8=94=E0=B9=8C =E0=B8=A7=E0=B8=B1=E0=B8=8A=E0=B8=A3=E0=B8=9E=E0=B8=
=A5 Pet Clinic Care=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:086-009-6609=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E0=B8=A7=E0=B8=B4=E0=B8=A5=E0=B8=A5=E0=B9=88=E0=B8=B2=E0=B8=AD=E0=B8=B2=E0=
=B8=A3=E0=B8=B5=E0=B8=A2=E0=B9=8C;=E0=B9=80=E0=B8=9A=E0=B8=88=E0=B8=A3=E0=B8=
=B1=E0=B8=81=E0=B8=A9=E0=B9=8C =E0=B8=9D=E0=B8=B1=E0=B8=87=E0=B9=80=E0=B8=82=
=E0=B9=87=E0=B8=A1;;;=0D
FN:=E0=B9=80=E0=B8=9A=E0=B8=88=E0=B8=A3=E0=B8=B1=E0=B8=81=E0=B8=A9=E0=B9=8C =E0=
=B8=9D=E0=B8=B1=E0=B8=87=E0=B9=80=E0=B8=82=E0=B9=87=E0=B8=A1 =E0=B8=A7=E0=B8=
=B4=E0=B8=A5=E0=B8=A5=E0=B9=88=E0=B8=B2=E0=B8=AD=E0=B8=B2=E0=B8=A3=E0=B8=B5=E0=
=B8=A2=E0=B9=8C=0D
ORG:=E0=B8=AB=E0=B8=A1=E0=B8=AD=E0=B8=9B=E0=B9=89=E0=B8=AD;=0D
TEL;type=3Dpref:02-279-9591=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E0=B8=A7=E0=B8=B5=E0=B8=A3=E0=B8=8A=E0=B8=B1=E0=B8=A2=E0=B8=81=E0=B8=B2=E0=
=B8=A3=E0=B8=8A=E0=B9=88=E0=B8=B2=E0=B8=87;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B9=
=80=E0=B8=AB=E0=B8=A1=E0=B8=B5=E0=B8=A2=E0=B8=A7;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B9=80=E0=B8=AB=E0=B8=A1=E0=B8=B5=E0=B8=A2=E0=
=B8=A7 =E0=B8=A7=E0=B8=B5=E0=B8=A3=E0=B8=8A=E0=B8=B1=E0=B8=A2=E0=B8=81=E0=B8=
=B2=E0=B8=A3=E0=B8=8A=E0=B9=88=E0=B8=B2=E0=B8=87=0D
TEL;type=3Dpref:02-692-6225=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=A8.=E0=B8=AA.=E0=B8=AD.;;;=0D
FN:=E0=B8=A8.=E0=B8=AA.=E0=B8=AD.=0D
TEL;type=3Dpref:02-224-1129=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E0=B8=A8=E0=B8=B8=E0=B8=A0=E0=B8=99=E0=B8=B4=E0=B8=95=E0=B8=A2=E0=B9=8C;=E0=
=B8=84=E0=B8=B8=E0=B8=93=E0=B8=AD=E0=B8=B2=E0=B8=99=E0=B8=B4=E0=B8=94 =E0=B8=
=AD=E0=B8=B2=E0=B8=AD=E0=B9=89=E0=B8=AD=E0=B8=A2;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=AD=E0=B8=B2=E0=B8=99=E0=B8=B4=E0=B8=94 =E0=
=B8=AD=E0=B8=B2=E0=B8=AD=E0=B9=89=E0=B8=AD=E0=B8=A2 =E0=B8=A8=E0=B8=B8=E0=B8=
=A0=E0=B8=99=E0=B8=B4=E0=B8=95=E0=B8=A2=E0=B9=8C=0D
TEL;type=3DCELL;type=3DVOICE;type=3Dpref:088-227-7081=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=AA=E0=B8=A5=E0=B8=B4=E0=B8=A5 2558;;;=0D
FN:=E0=B8=AA=E0=B8=A5=E0=B8=B4=E0=B8=A5 2558=0D
TEL;type=3Dpref:0951794303=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E0=B8=AA=E0=B8=B2=E0=B8=A1;=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B9=81=E0=
=B8=AB=E0=B8=A1=E0=B9=88=E0=B8=A1;;;=0D
FN:=E0=B8=99=E0=B9=89=E0=B8=AD=E0=B8=87=E0=B9=81=E0=B8=AB=E0=B8=A1=E0=B9=88=E0=
=B8=A1 =E0=B8=AA=E0=B8=B2=E0=B8=A1=0D
TEL;type=3Dpref:093-554-5464=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E0=B8=AA=E0=B8=B8=E0=B8=94;Sud;;;=0D
FN:Sud =E0=B8=AA=E0=B8=B8=E0=B8=94=0D
TEL;type=3DWORK;type=3DVOICE;type=3Dpref:087-509-0808=0D
TEL;type=3DOTHER;type=3DVOICE:0897770895=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=AB=E0=B8=99=E0=B8=B9=E0=B9=80=E0=B8=A5=E0=B9=87=E0=B8=81;;;=0D
FN:=E0=B8=AB=E0=B8=99=E0=B8=B9=E0=B9=80=E0=B8=A5=E0=B9=87=E0=B8=81=0D
TEL;type=3Dpref:089-131-8311=0D
TEL:090-985-6729=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=AB=E0=B8=A1=E0=B8=B4=E0=B8=A7 =E0=B8=99=E0=B8=B8=E0=B9=89=E0=B8=A2=
 DC;;;=0D
FN:=E0=B8=AB=E0=B8=A1=E0=B8=B4=E0=B8=A7 =E0=B8=99=E0=B8=B8=E0=B9=89=E0=B8=A2=
 DC=0D
TEL;type=3Dpref:094-326-6354=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=AB=E0=B8=A5=E0=B8=A7=E0=B8=87=E0=B8=9E=E0=B9=88=E0=B8=AD=E0=B9=80=E0=
=B8=99=E0=B8=B2=E0=B8=A7=E0=B8=A3=E0=B8=B1=E0=B8=95=E0=B8=99=E0=B9=8C =E0=B8=
=81=E0=B8=95=E0=B8=98=E0=B8=B1=E0=B8=A1=E0=B9=82=E0=B8=A1;;;=0D
FN:=E0=B8=AB=E0=B8=A5=E0=B8=A7=E0=B8=87=E0=B8=9E=E0=B9=88=E0=B8=AD=E0=B9=80=E0=
=B8=99=E0=B8=B2=E0=B8=A7=E0=B8=A3=E0=B8=B1=E0=B8=95=E0=B8=99=E0=B9=8C =E0=B8=
=81=E0=B8=95=E0=B8=98=E0=B8=B1=E0=B8=A1=E0=B9=82=E0=B8=A1=0D
TEL;type=3Dpref:086-043-9833=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=AB=E0=B8=A5=E0=B8=B4=E0=B8=99 2558;;;=0D
FN:=E0=B8=AB=E0=B8=A5=E0=B8=B4=E0=B8=99 2558=0D
TEL;type=3Dpref:+16193168514=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B9=82=E0=B8=AB=E0=B8=99=E0=B9=88=E0=B8=87 RB;;;=0D
FN:=E0=B9=82=E0=B8=AB=E0=B8=99=E0=B9=88=E0=B8=87 RB=0D
TEL;type=3Dpref:081-801-3353=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E0=B8=AD=E0=B8=87=E0=B8=81=E0=B8=A3 =E0=B9=80=E0=B8=A0=E0=B8=AA=E0=B8=B1=E0=
=B8=8A=E0=B8=97=E0=B8=AB=E0=B8=B2=E0=B8=A3;=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=
=99=E0=B8=B2=E0=B8=87 =E0=B8=A2=E0=B8=B2 PMK;;;=0D
FN:=E0=B8=84=E0=B8=B8=E0=B8=93=E0=B8=99=E0=B8=B2=E0=B8=87 =E0=B8=A2=E0=B8=B2=
 PMK =E0=B8=AD=E0=B8=87=E0=B8=81=E0=B8=A3 =E0=B9=80=E0=B8=A0=E0=B8=AA=E0=B8=B1=
=E0=B8=8A=E0=B8=97=E0=B8=AB=E0=B8=B2=E0=B8=A3=0D
TEL;type=3DHOME;type=3DVOICE;type=3Dpref:087-564-0989=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=AD=E0=B8=B1=E0=B8=94=E0=B8=A0=E0=B8=B2=E0=B8=9E=E0=B8=A1=E0=B8=B2=E0=
=B8=AA=E0=B9=80=E0=B8=95=E0=B8=AD=E0=B8=A3=E0=B9=8C;;;=0D
FN:=E0=B8=AD=E0=B8=B1=E0=B8=94=E0=B8=A0=E0=B8=B2=E0=B8=9E=E0=B8=A1=E0=B8=B2=E0=
=B8=AA=E0=B9=80=E0=B8=95=E0=B8=AD=E0=B8=A3=E0=B9=8C=0D
TEL;type=3Dpref:0863551466=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=AD=E0=B8=B2;;;=0D
FN:=E0=B8=AD=E0=B8=B2=0D
TEL;type=3Dpref:081-453-4444=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=AD=E0=B8=B2=E0=B8=88=E0=B8=B6=E0=B8=81;;;=0D
FN:=E0=B8=AD=E0=B8=B2=E0=B8=88=E0=B8=B6=E0=B8=81=0D
TEL;type=3Dpref:0898814949=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=AD=E0=B8=B2=E0=B8=88=E0=B8=B8=E0=B9=8A=E0=B8=9A 61;;;=0D
FN:=E0=B8=AD=E0=B8=B2=E0=B8=88=E0=B8=B8=E0=B9=8A=E0=B8=9A 61=0D
TEL;type=3Dpref:086-155-5961=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=AD=E0=B8=B2=E0=B8=88=E0=B8=B8=E0=B9=8A=E0=B8=9A New;;;=0D
FN:=E0=B8=AD=E0=B8=B2=E0=B8=88=E0=B8=B8=E0=B9=8A=E0=B8=9A New=0D
TEL;type=3Dpref:0861555961=0D
TEL:0982896665=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=AD=E0=B8=B2=E0=B9=81=E0=B8=9B=E0=B9=8B=E0=B8=A7 =E0=B8=AD=E0=B8=B2=
=E0=B9=81=E0=B8=A1=E0=B8=A7;;;=0D
FN:=E0=B8=AD=E0=B8=B2=E0=B9=81=E0=B8=9B=E0=B9=8B=E0=B8=A7 =E0=B8=AD=E0=B8=B2=
=E0=B9=81=E0=B8=A1=E0=B8=A7=0D
TEL;type=3Dpref:089-444-9222=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:=E0=B8=AD=E0=B8=B4=E0=B8=99=E0=B8=97=E0=B8=99=E0=B8=B2=E0=B8=84=E0=B8=A1;=E0=
=B8=AD=E0=B8=A1=E0=B8=A3=E0=B8=B2=E0=B8=A0=E0=B8=A3=E0=B8=93=E0=B9=8C;;;=0D
FN:=E0=B8=AD=E0=B8=A1=E0=B8=A3=E0=B8=B2=E0=B8=A0=E0=B8=A3=E0=B8=93=E0=B9=8C =E0=
=B8=AD=E0=B8=B4=E0=B8=99=E0=B8=97=E0=B8=99=E0=B8=B2=E0=B8=84=E0=B8=A1=0D
EMAIL;type=3DINTERNET;type=3Dpref:aum.um.id@gmail.com=0D
END:VCARD=0D
BEGIN:VCARD=0D
VERSION:3.0=0D
PRODID:-//Apple Inc.//iPhone OS 14.0.1//EN=0D
N:;=E0=B8=AD=E0=B8=B5=E0=B9=80=E0=B8=9B=E0=B8=B5=E0=B8=A2=E0=B8=99 New;;;=0D=

FN:=E0=B8=AD=E0=B8=B5=E0=B9=80=E0=B8=9B=E0=B8=B5=E0=B8=A2=E0=B8=99 New=0D
TEL;type=3Dpref:0921535555=0D
END:VCARD=0D

--Apple-Mail-6FC63F31-CDDD-4943-91FA-A493F7556C51
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit



Sent from my iPhone
--Apple-Mail-6FC63F31-CDDD-4943-91FA-A493F7556C51--
