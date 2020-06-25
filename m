Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E66BC433E0
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 10:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 543EC20679
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 10:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403822AbgFYKVl convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 25 Jun 2020 06:21:41 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:34041 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403800AbgFYKVi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 06:21:38 -0400
Received: from mail.ifta.com ([80.152.142.24]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPA (Nemesis) id 1N7RDn-1ilnMD2YMn-017qMo
 for <git@vger.kernel.org>; Thu, 25 Jun 2020 12:21:36 +0200
Received: from mail.ifta.com [127.0.0.1] by mail.ifta.com with David.fx (0554.4743464A4E474B484A52);
 25 Jun 2020 10:21:36 UT
From:   "Daniel Dyk" <Daniel.Dyk@ifta.com>
Subject: Capital letters do not work when using vi as git editor
To:     <git@vger.kernel.org>
Date:   Thu, 25 Jun 2020 10:21:36 +0000
X-Priority: 3 (Normal)
Importance: normal
X-Mailer: david by Tobit.Software, Germany (0554.4743464A4E474B484A52), Mime Converter 101.20
X-David-Sym: 0
X-David-Flags: 0
Message-ID: <000232C3.5EF496D0@mail.ifta.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:5PVGfSb96M/VWfLu57GYdS6K7RnqBhnX4z7eWT2cJ7ceMttN135
 VyC5pNocyo5GCXFvzhUjhbqefAs65uFCLnHqreTu7oeIB0TIW3Eu027Ld+FZ0ZBYDfhsEyK
 LaMIUipWMO4w7g2+E198ujbDoUQbnb0YspvBzH3F/66unF1VeH0upiHyHWQcVf5PcYRz9Wf
 bzf7yg2S2ftQY/zyr2aUw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZFE8Dla2fng=:hhQ5L3AgCbNcrxX6yACu2e
 XTEVqRiwRHbh/RY5Nwc4DJA2l6QiOhu6YCg8glGqnK6W05rwF34FqrxXv0a6jVozX/Ssd3k8R
 ixF7CBmvgZsUDRhnAimc9pOx/zbKJDlJDtotwM2a0JtGRMcxlGuWuMWim1stC4iGyahkF9eD8
 WJo2RK/a6ud0Q2e7tmufIa9/JqTjByOXZX0CM50NUNJPu3sMXS1VCRykB97dBXAIj2rkxNLLR
 AfwEuKnMEkjNuvJ7G7bx9vbnTS06VBjjeAmyGA9Izp4hvWo259ZnmveDKaKSALeXZC6mEfQJp
 V+Bq3MnEwH4g8tcMYVqn+4gBWxgN3fC/oIRQ70F3TIMm2p/Ad0vS52gfRNoqVC29mEW2Nz6Ui
 eySe6qRV+c2cKUABL9lGbWiFV0HJvSvlsSk9uJvCOuvKQWsx16slBssvsXtz4kyGNMqdhjA0y
 CW/ombaGgtcuOVvCBPz7p/NyV7Q1O5vPPjaVhKmRNgB318cchD4SNM35jYjnZLHQzUaTAjlUq
 DC7Fz1AhBbAiVU/qoDzeqkVjdN7oEyaJgCSB6kVoMfR8BGTYQduNmaxqP3soEsVN8kkHhq0Fv
 z1pxYVJg5E2MFW/dQ2O61m7pCBTt+b3n/k8jVgVLlD6JfP8r+31m/yMb/7I/oKtNhacRnlFwB
 0T7i3YKKD8GlsqHR2V89vMk9eqT+I72NCO+wb7fGDEVtip6O47tNsXVeUguyteIUZhVToZn+f
 aMhXhA+/KNt2cTgk/ojCLicN+rHyd5eVN1hRNrm9yTc1cZv9ptOgOCSCjHthJ4RXnS0QCddQZ
 uFgs+ZF4wO/T00eEOE0YSPcCyjcU+Q0sAY5W240sOWfeocyitRnT1+4zA0LDj0UZfCw6ira
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi git-devs,


I installed git 2.27.0 on a fresh Windows 10 system, there where no old installations of mingw or git. Unfortunatly I have encountered a bug with vim when doing 'git rebase -i' or 'git commit':

I am not able to type capital letters, so commands for selecting rows (<Shift>V), pasting above (<Shift>P) etc are not working. I am also not able to type 'ABCDE' in insertion mode. Small letters and capital umlauts (ÄÖÜ) work. If I open the vi without git, I can type the capital letters. If I use nano as editor, I can type capital letters as well. 

Downgrading to git 2.24.1.2 solved the problem for now (I double checked and reinstalled 2.27.0 again => same issue).


Regards

Daniel Dyk


___________________________________________________________________


Daniel Dyk
Software Developer


IfTA Ingenieurbuero fuer Thermoakustik GmbH
Junkersstrasse 8
D-82178 Puchheim 
Germany 



Tel. +49-89-8392719-42
Fax +49-89-8392719-11
http://www.ifta.com


Geschaeftsfuehrer: Dr.-Ing. Jakob Hermann
Handelsregister: Amtsgericht Muenchen HRB 114 602 
Umsatzsteuer-ID: DE 812 240 350



IfTA's Datenschutzerklärung finden Sie hier: https://www.ifta.com/de/unternehmen/datenschutzerklärung
For IfTA's privacy policy please go to: https://www.ifta.com/en/company/privacy-policy 
___________________________________________________________________





Mit freundlichen Grüßen


Daniel Dyk


___________________________________________________________________


Daniel Dyk
Software Entwickler


IfTA Ingenieurbuero fuer Thermoakustik GmbH
Junkersstrasse 8
D-82178 Puchheim 
Germany 



Tel. +49-89-8392719-42
Fax +49-89-8392719-11
http://www.ifta.com


Geschaeftsfuehrer: Dr.-Ing. Jakob Hermann
Handelsregister: Amtsgericht Muenchen HRB 114 602 
Umsatzsteuer-ID: DE 812 240 350



IfTA's Datenschutzerklärung finden Sie hier: https://www.ifta.com/de/unternehmen/datenschutzerklärung
For IfTA's privacy policy please go to: https://www.ifta.com/en/company/privacy-policy 
______________________________________________________________________________________________________


