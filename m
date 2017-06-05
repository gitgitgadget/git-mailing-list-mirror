Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7718C1F7D2
	for <e@80x24.org>; Mon,  5 Jun 2017 14:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751445AbdFEOAl (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 10:00:41 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:54660 "EHLO
        mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbdFEOAk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 10:00:40 -0400
Received: from tigra (tigra.domain007.com [192.168.2.102])
        by hermes.domain007.com (Postfix) with SMTP id CDDFBD400AE;
        Mon,  5 Jun 2017 17:00:32 +0300 (MSK)
Date:   Mon, 5 Jun 2017 17:00:32 +0300
From:   Konstantin Khomoutov <kostix+git@007spb.ru>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Konstantin Khomoutov <kostix+git@007spb.ru>,
        christienne shultz <cpshultz86@gmail.com>, git@vger.kernel.org
Subject: Re: Git Error Message
Message-ID: <20170605140032.jdnv32fd5lxhqkcj@tigra>
References: <CAPMR3RcMK_Dt=4g6JJjQ9DVhCn7PLY2xAPXM1OgZGaqyVSeP=A@mail.gmail.com>
 <20170605084839.mmirmdtvlpdqgwgo@tigra>
 <D86B4F1CDEF64DEEB961900D30165624@PhilipOakley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D86B4F1CDEF64DEEB961900D30165624@PhilipOakley>
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 05, 2017 at 02:54:55PM +0100, Philip Oakley wrote:

> > > I have installed the Git software and upon trying to update a
> > > repository by the "open recent repository" link and am unable to
> > > access the menu-or anything-from there.  Instead a window pops up with
> > > the following error message:
> > > 
> > > "\usage C:\Program Files\Git\mingw64/libexec/git-core\git-GUI[
> > > {blame|browser|citool}]
> 
> Can you show the full error message / dialog window?
> 
> With a little bit of staring you will see the line numbers and a few clues
> about the stack history for the error (i.e. line number and variable)
> 
> > > Can you please tell me what this error message means and how to fix
> > > the issue?  Thank you!
> > 
> > A shot in the dark until someone with access to Windows chimes in (it
> > appears that the "open recent repository" feature of `git gui` is specific
> > to Git for Windows): have you verified that repository actually exists
> > on your filesystem?
> 
> Feature is common but the implementations look slightly different
> 
> https://github.com/git/git/blob/master/git-gui/lib/choose_repository.tcl#L123
> $opts insert end [mc "Open Existing Repository"] link_open
> 
> https://github.com/git-for-windows/git/blob/master/git-gui/lib/choose_repository.tcl#L152
> -text [mc "Open Recent Repository:"]
> 
> I'm not sure how the differences are created between the two source codes.
> 
> The nominal upstream by Pat Thoyts has the same as the git.git version
> https://github.com/patthoyts/git-gui/blob/master/lib/choose_repository.tcl#L123

Heh, somehow I've got an impression the GfW's version of `git gui` was
taught to look in the registry for the recent folders and then pick
those  which have ".git" directory located inside or whose names end
in ".git" ;-)

