Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB64ECAAA6
	for <git@archiver.kernel.org>; Fri, 26 Aug 2022 18:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245004AbiHZSCj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Aug 2022 14:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiHZSCh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2022 14:02:37 -0400
Received: from mariecurie.labrat.space (mariecurie.labrat.space [116.203.185.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F23931DD5
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 11:02:35 -0700 (PDT)
Received: from labrat.space (adsl-178-38-36-59.adslplus.ch [178.38.36.59])
        by mariecurie.labrat.space (Postfix) with ESMTPSA id A8B783E52927;
        Fri, 26 Aug 2022 20:02:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=labrat.space;
        s=201904; t=1661536952;
        bh=/5WIWv65unTmSrHa3b5l5dh/o8Y1PrDOBn+k9DIlLEc=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:Content-Disposition:In-Reply-To:From:To:CC:Date:
         Subject:Content-Type:Content-Disposition:Reply-To:In-Reply-To:
         MIME-Version:Message-ID:References;
        b=XixIy94cfQqkaV+BkytQ2SlZXeLyzuLNNbUImHBTOPVYZbEV+3rU0zDGqPKe8xJQp
         nLoTAdb13f2dUAV94SxeBMAJNIJZgl7fC5Dts2tVH46kvn+7hGXvGnhZjNH/5RhlTp
         77vzLnfL0cOT2pPAfYIEb6NvETmyHHUS/c+YNtcGZ0i/uIfAzIsfw0RxKRk5O3qlZ/
         KCCVMPvYAiHiZumw8ExsvqyFePvmq9YrW6PgGhQJIgcl1kbSznHsgI1F/TVq4Yd29T
         oCHmh4v6Eh8K4v3YQWDTGzVTCtg0EVhfgUQqFLlnce0n9OsIwVaqmVU9JyFFfNkff7
         qKbFnWBdmPHhw==
Date:   Fri, 26 Aug 2022 20:02:30 +0200
From:   Reto <reto@labrat.space>
To:     Michael Hennebry <hennebry@web.cs.ndsu.nodak.edu>
Cc:     git@vger.kernel.org
Subject: Re: There is no tracking information for the current branch
Message-ID: <20220826180230.brbo32ct2255rfe3@feather>
Mail-Followup-To: Michael Hennebry <hennebry@web.cs.ndsu.nodak.edu>,
        git@vger.kernel.org
References: <alpine.DEB.2.21.2208181407290.2645@mail.cs.ndsu.nodak.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2208181407290.2645@mail.cs.ndsu.nodak.edu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

You can just run `git fetch`.
The origin/* branches will then contain what you want. Replace origin
with whatever name you gave your remote.

Assuming you really want to pull all branches directly to local
branches, add a refspec that does that.

git-fetch(1) has the details.

Hope that helps,
Reto
