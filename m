Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1D402023C
	for <e@80x24.org>; Tue,  5 Jul 2016 11:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932954AbcGELpO (ORCPT <rfc822;e@80x24.org>);
	Tue, 5 Jul 2016 07:45:14 -0400
Received: from mail-vk0-f42.google.com ([209.85.213.42]:33858 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754659AbcGELpN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Jul 2016 07:45:13 -0400
Received: by mail-vk0-f42.google.com with SMTP id c2so260979443vkg.1
        for <git@vger.kernel.org>; Tue, 05 Jul 2016 04:45:13 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=OgkLMEYMqbV7SVI3ucyHv0aLkUW6pPCghbXc1Sx2jdk=;
        b=L9H+4fJofZ7ylDMjMOC13arSfODE6At+Vx3Z0znqNNKfFJaxFljN36ajKSMoJ0rD+o
         NAy7IIpACyKFOK/fLfiMBWu+9a6YJKG7Zgi5w1+CMi58ynl8vqMcED1yQyyJm6GsFfvw
         bRXOtn0/MqPMIDdzRmNj7m4sGt6u2Mchaq4mVQDVyZB65egB200TINMOAAI4qcySdHtJ
         QJiRPNVrHy4wc/Z0ArqKML2x8iVULk8zYihA7RxxVwJuFwQDMI+Y2x1LwTKILflzxRdl
         iz7LX97tnQl/Y0p/PPswnj4/uEd7OR+w0CJ7bimTsNp6uc6PoPvlC6d/ERzDwZtQ7zqv
         +Y9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=OgkLMEYMqbV7SVI3ucyHv0aLkUW6pPCghbXc1Sx2jdk=;
        b=fBdFog9Uda9KOR1C1geOewcsVSnep8PmcqDYFRqocpy3/YqggWjgKrgc/RzQVidbOQ
         MbOW9unQm84jJxJP1syIn20Wvlk0PylX7+ccdxDQo9YgMjNvDMU7Z894tGxXNgNNcrNc
         JXXZ7x7/+keg3Juw7CZW90WCbYWXp1ITvMreahszb/i/YD+MwuIu5ZiIy72+NfaEntBg
         aulJ5HUalrIknjLU2jYLcgxw10cUhkFiwmiY6hBZ9Rehre35zP86fSND2tDRDweGc1GZ
         UG9j/gcWG5kPsRMtf+YpMg6YmNwb409VDewqZQDycaMyicX6SqKqRQ53/lpX7/qHNMSO
         +wWw==
X-Gm-Message-State: ALyK8tLFCEhx44BAlOy3V375yhhIAz57JvFUM7wOpVQAj0OIPr5T24X/zktRaPQrTbROL595xYW8dIy77C4A4g==
X-Received: by 10.176.0.108 with SMTP id 99mr1402398uai.71.1467719112495; Tue,
 05 Jul 2016 04:45:12 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kpaxton@paxdesigns.com
Received: by 10.103.110.131 with HTTP; Tue, 5 Jul 2016 04:45:12 -0700 (PDT)
From:	Kevin Paxton <kpaxton@paxdesigns.com>
Date:	Tue, 5 Jul 2016 07:45:12 -0400
X-Google-Sender-Auth: o2_0BMZFTiPdtXtZC0psWCfFsq0
Message-ID: <CAOkrQrwH=Rj4OS4WphGqzc07hjFBB4B9BFy92qPWdJfB70KPnA@mail.gmail.com>
Subject: Dependencies required for offline installation
To:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

I’m looking to install git on a separate network that is running
Redhat 5.5. I need to know what is the list of packages that I need to
download to be able to install git-all? I plan on using git-svn to
migrate an existing svn repo over to git as well. Svn version we have
installed is 1.9.3.


Does the tarball contain all dependencies already? Should I go that
route? Or should I try and find all the rpm's required?


Thanks,

Kevin Paxton
