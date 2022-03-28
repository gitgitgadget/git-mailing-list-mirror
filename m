Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74E6C433EF
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 19:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243829AbiC1TVg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 15:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234167AbiC1TVe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 15:21:34 -0400
X-Greylist: delayed 310 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 28 Mar 2022 12:19:52 PDT
Received: from mout3.freenet.de (mout3.freenet.de [IPv6:2001:748:100:40::2:5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADC64FC4B
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 12:19:51 -0700 (PDT)
Received: from [195.4.92.120] (helo=sub1.freenet.de)
        by mout3.freenet.de with esmtpa (ID tomritzow@freenet.de) (port 25) (Exim 4.94.2 #2)
        id 1nYup4-00GxA7-Q6
        for git@vger.kernel.org; Mon, 28 Mar 2022 21:14:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=freenet.de;
        s=mjaymdexmjqk; h=To:Date:Message-Id:Subject:Mime-Version:From:
        Content-Transfer-Encoding:Content-Type:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=INPZIyyG3/VtFXvYMl8iwMf9URGdkL/C0FJkIlv4a4o=; b=XZ56I2iJBVZ/c79cqN7KsOxco/
        mpGiJ0uLvRYvfkLJ0RFHCxn7d9r2ceo4S49UOOE3UZInU/StIXUExIJtn7g0Wma5ew92OM5NK1wyK
        8yZYGMVF4jJNqdU78DuMvodvjxUbNMNcThMZFMee811RuQzJIpfPSZ8FgQGosxPqE95I9wazKb2Bx
        tSrbg/3lzYLarI1Bp/L3ZebbAPWDbFKKFBBaXLA7iwzPb9ddF7jWdbhDAt2PX0Qtj0v8BUwfsCGWH
        sWuYRTo/DMpZNghA4V7/+FJJSIh5IwHNd0/OHBrY0EWnSy8/MUWwnnQsPTLBWBx3OPvplyn+aDzXH
        6xHLEgWA==;
Received: from [2a02:8108:9ec0:22f9:cc12:f6f4:5d88:3233] (port=52787 helo=smtpclient.apple)
        by sub1.freenet.de with esmtpsa (ID tomritzow@freenet.de) (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (port 587) (Exim 4.94.2 #2)
        id 1nYup4-00HakB-2r; Mon, 28 Mar 2022 21:14:38 +0200
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Tom Ritzow <tomritzow@freenet.de>
Mime-Version: 1.0 (1.0)
Subject: =?utf-8?Q?_About_Documentation_Reference_Book_Videos_External_Li?=
 =?utf-8?Q?nks_Downloads_Community_English_=E2=96=BETopics_?=
 =?utf-8?Q?=E2=96=BE_Version_2.35.1_=E2=96=BE_gitglossary_last_up?=
 =?utf-8?Q?dated_in_2.35.1_NAME_gitglossary_-_A_Git_Glossary__SYN?=
 =?utf-8?Q?OPSIS_*__DESCRIPTION_alternate_object_database_Via_the?=
 =?utf-8?Q?_alternates_mechanism,_a_repository_can_inherit_part_o?=
 =?utf-8?Q?f_its_object_database_from_another_object_database,_wh?=
 =?utf-8?Q?ich_is_called_an_"alternate".__bare_repository_A_bare_?=
 =?utf-8?Q?repository_is_normally_an_appropriately_named_director?=
 =?utf-8?Q?y_with_a_.git_suffix_that_does_not_have_a_locally_chec?=
 =?utf-8?Q?ked-out_copy_of_any_of_the_files_under_revision_contro?=
 =?utf-8?Q?l._That_is,_all_of_the_Git_administrative_and_control_?=
 =?utf-8?Q?files_that_would_normally_be_present_in_the_hidden_.gi?=
 =?utf-8?Q?t_sub-directory_are_directly_present_in_the_repository?=
 =?utf-8?Q?.git_directory_instead,_and_no_other_files_are_present?=
 =?utf-8?Q?_and_checked_out._Usually_publishers_of_public_reposit?=
 =?utf-8?Q?ories_make_bare_repositories_available.__blob_object_U?=
 =?utf-8?Q?ntyped_object,_e.g._the_contents_of_a_file.__branch_A_?=
 =?utf-8?Q?"branch"_is_a_line_of_development._The_most_recent_com?=
 =?utf-8?Q?mit_?=
Message-Id: <BD836853-B966-475A-A07F-E1B6ACFE758D@freenet.de>
Date:   Mon, 28 Mar 2022 21:14:37 +0200
To:     git@vger.kernel.org
X-Mailer: iPhone Mail (19E241)
X-Originated-At: 2a02:8108:9ec0:22f9:cc12:f6f4:5d88:3233!52787
X-Scan-TS: Mon, 28 Mar 2022 21:14:38 +0200
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=EF=BB=BF

Von meinem iPhone gesendet


Von meinem iPhone gesendet=

