Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08BA21F461
	for <e@80x24.org>; Tue, 14 May 2019 11:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfENLtr convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 14 May 2019 07:49:47 -0400
Received: from mx4.uni-regensburg.de ([194.94.157.149]:55038 "EHLO
        mx4.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfENLtr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 07:49:47 -0400
Received: from mx4.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 86CFD6000055
        for <git@vger.kernel.org>; Tue, 14 May 2019 13:49:44 +0200 (CEST)
Received: from gwsmtp.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by mx4.uni-regensburg.de (Postfix) with ESMTP id 6B22B6000051
        for <git@vger.kernel.org>; Tue, 14 May 2019 13:49:44 +0200 (CEST)
Received: from uni-regensburg-smtp1-MTA by gwsmtp.uni-regensburg.de
        with Novell_GroupWise; Tue, 14 May 2019 13:49:44 +0200
Message-Id: <5CDAAB56020000A100031334@gwsmtp.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.1.1 
Date:   Tue, 14 May 2019 13:49:42 +0200
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     <git@vger.kernel.org>
Subject: Antw: Re: Missing branches after clone
References: <5CDA8D37020000A100031319@gwsmtp.uni-regensburg.de>
 <CACsJy8AX9Wp3W=d1=ozF9nZXGE1muooMf7fKCtdOOi1g8QRmig@mail.gmail.com>
 <0c9ec78a-9245-e1df-7ec6-a5d77d1a5261@iee.org>
In-Reply-To: <0c9ec78a-9245-e1df-7ec6-a5d77d1a5261@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

The confusing part actually is for me:
"git clone" does NOT "Clone a repository into a new directory", but "clone the current branch into a new directory" (IMHO).
So I was surprised that I couldn't merge branches under the same name in the cloned "repository".
Only "git clone --bare" actually seems to clone "the repository".
I think this is very confusing to new users. At least I didn't quite get the reasoning for that.

Regards,
Ulrich


>>> Philip Oakley <philipoakley@iee.org> schrieb am 14.05.2019 um 12:33 in
Nachricht <0c9ec78a-9245-e1df-7ec6-a5d77d1a5261@iee.org>:
> Hi Ulrich,
> On 14/05/2019 11:12, Duy Nguyen wrote:
>>> Then I 
> foundhttps://stackoverflow.com/questions/10312521/how-to-fetch-all-git-branch
> es  which handles the subject...
>>> But still the most common solution there still looks like an ugly hack.
>>> Thus I suggest to improve the man-pages (unless done already)
>> Yeah I expected to see at least some definition of remote-tracking
>> branches (vs local ones) but I didn't see one. Room for improvement.
> Yes, the 'remote tracking branch' name [RTB] is very 'French' in its 
> backwardness (see NATO/OTAN).
> 
> It is a 'branch which tracks a remote', and it is has the 'last time I 
> looked' state of the branch that is on the remote server, which may 
> have, by now, advanced or changed.
> 
> So you need to have the three distinct views in your head of 'My branch, 
> held locally', 'my copy of Their branch, from when I last looked', and 
> 'Their branch, on a remote server, in a state I haven't seen recently'.
> 
> Finding a better name for the "RTB", one with an easier cognitive load 
> for those trying to understand Git, would be an improvement.
> 
> Though there has been a similar issue with 'staging the index'. 
> Ultimately it is a new way of thinking about artefacts (perfect 
> duplicates, no originals, no master, no copies, just verification 
> hashes) so needs new terms and a difficult learning experience.
> -- 
> Philip




