Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69FB91FA7B
	for <e@80x24.org>; Thu, 15 Jun 2017 11:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752421AbdFOLws (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 07:52:48 -0400
Received: from sonic318-24.consmr.mail.gq1.yahoo.com ([98.137.70.150]:43534
        "EHLO sonic318-24.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752401AbdFOLwr (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 15 Jun 2017 07:52:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com.br; s=s2048; t=1497527567; bh=8pc9uJhNJiY79k45SqYctODMOj4HddzKuGppCDklRzY=; h=Date:From:Reply-To:To:In-Reply-To:References:Subject:From:Subject; b=sXBMKyuIZX4izQGiNp1ZHee0Vj6PsYKTbtFOul96qngWJMp97UhZYDlmNXgaIfCTBz4Lr3Q8QSFZrsLwMUMMpnZfMkiXxzUqB8UVwIH/tuN4E2qFRoTNTPsNvsM722i5GHquEFhna55OPgfUChMbWR6BDTqvyCJtGls9F+1QeOWIxYIHls7gfj6fVUPIwTPkbtXIb1s7BbkBaoObNHb53fYNJAEJOFVLRxg7qev3ySulaSvfgBJvRswNd/H2/ymaxCmfGzouJGVun0ZIwr5IAWRTuYMtqOflCYnAlMj95JgD5zKDgLdy2mRacHuVdVmrkBabpPQjozpX5C4o3jZ7bg==
X-YMail-OSG: d6OslA8VM1mhOXbrGbSRwsSqVJTkjlqH_9Y6nRkFVwgEwdAHv4H1tzGykzplujW
 XYtqDmD9IkSxkS.UU4xpChQzW9WFbyTOYpRyp2Knc5qMxZFvo4jWyA7JfICZu5AIouCoSRNZZb49
 fpe9n.oY1JLYzjKWzKjExyJ.A3pk4VsEMkyX3eSWD901sBBKlw0qx2t4Seqz7QuZTDhZBPmZufw6
 Uk2vVJfj_FoGSlXTNu4q3xcmS4KO1tnWBj_CyuNB4qZrGOnD22alFmAnTpC9F1oT40SHCNq87yye
 x7Uf.eOlBlUSsdiFqeDzGiaPNv8_QfHvRPvEVlOIBkKICSwQDaG6dEO9yXwDQfdCUCvw1PvBUQ2f
 fQTV4DJbnqYqoBt_L.5dx9hgMCpaFdca.JG68ugmd9KkPUmmSxpEGnhkJO1wsexEgOiQ849F__Gk
 IaIw6xx2Gije3fiGZTOL3UL30AmNXqQ.DPrhBRuPsPyJUqPlyWo9QzuMMmBk8P9LbJ.vhF0guc26
 dWHdN5DqkByhhhE1oWZbVhWXF0EBREw8uzUaMPgoontD3yTsqGPwvgAes
Received: from sonic.gate.mail.ne1.yahoo.com by sonic318.consmr.mail.gq1.yahoo.com with HTTP; Thu, 15 Jun 2017 11:52:47 +0000
Date:   Thu, 15 Jun 2017 11:52:46 +0000 (UTC)
From:   =?UTF-8?Q?Cl=C3=A9bio_C=2E_Felix?= <clebiofelix@yahoo.com.br>
Reply-To: =?UTF-8?Q?Cl=C3=A9bio_C=2E_Felix?= <clebiofelix@yahoo.com.br>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <1527808373.12987632.1497527566906@mail.yahoo.com>
In-Reply-To: <905919609.12947564.1497527369339@mail.yahoo.com>
References: <905919609.12947564.1497527369339.ref@mail.yahoo.com> <905919609.12947564.1497527369339@mail.yahoo.com>
Subject: [BUG] GITK don't show unstaged changes
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.9778 YahooMailNeo Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:53.0) Gecko/20100101 Firefox/53.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Details:  https://github.com/git-for-windows/git/issues/1203  

Version with bug: 2.13.1
Normal: 2.13.0


CCFelix
