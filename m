Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DFBD1FF76
	for <e@80x24.org>; Thu, 24 Nov 2016 23:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750857AbcKXX6u (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Nov 2016 18:58:50 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:34568 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750696AbcKXX6t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2016 18:58:49 -0500
Received: by mail-io0-f195.google.com with SMTP id r94so7035845ioe.1
        for <git@vger.kernel.org>; Thu, 24 Nov 2016 15:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=WmcRnc8PwFv5STCL4r0ReHBUu8FMVhIE+auFRvAkO9o=;
        b=jzVru1Ucjm2+xMEfJJgY2uAc/6Z5p7itPiwGLp+PN8jodKyfSkAqlukwRfE+h5sY6K
         /AWMO60IIna35/rM7XkTCqakTQK7HS2V4/bGDWbJlOV9to3RgUox9RJRT9kpOenfO8zG
         CCt9nskrAFZaG09/jrGQYPboGR9WBSJ9KR/XFSEbT4lMURQXUh8wYEday0WkoIz1LNQ+
         uuxbgOIj2l8L4ubPWr4x792h2yDWbzOBov2Z6a3aBLdTnCx2H1eA+/jEdP0tg+oUFICs
         On2MA4/QPDcg84WKa94oSiBP6nGa3Aobco8MBpo+oCPODiUyuMZnNtW7dCSsrwgZHu7i
         zZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=WmcRnc8PwFv5STCL4r0ReHBUu8FMVhIE+auFRvAkO9o=;
        b=T06mS9Jp/aW9rJDok3QpkQ2tkHgJdY18h18fQgmN9pVtrK6ycjwYwQczu2+CqA73CB
         VE2XL8d3vmGGLA1yXcaQSav+VUIYYeAstg5hfNQfTtx2U3SrfrfXG/RUP/rB2OyUCtYt
         wIwXuW50jyNBti1XqBeeaI+qj2GtDFagrqBH22zRt6wXQGL0/tNfYzXNP2c4Lza/vhBm
         6rPKVOqyPlx85ypgljhAk8gZjuwfIO4oSkNCoazoCogO8DA14Wo/HxWeHCah76xQthrZ
         +j1sUu7j/8HBzoUBdyDA79BBlAS9f55cQuZpWpZoiKscf/6Kn0jd5UNs0dX5ZE289FWT
         dIYQ==
X-Gm-Message-State: AKaTC03bhlD4ahGJftyKnqKRLvXsKwi3JzsayB5ISqIMpbWkGnAUdAy61/pXvKpE5HzbkA==
X-Received: by 10.107.181.19 with SMTP id e19mr4089597iof.104.1480031911046;
        Thu, 24 Nov 2016 15:58:31 -0800 (PST)
Received: from localhost ([66.117.213.188])
        by smtp.gmail.com with ESMTPSA id c101sm14201452ioj.25.2016.11.24.15.58.29
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Nov 2016 15:58:30 -0800 (PST)
Date:   Thu, 24 Nov 2016 18:58:22 -0500
From:   Walt Feasel <waltfeasel@gmail.com>
To:     git@vger.kernel.org
Subject: Git Gui bugs Debian Jessie Package: git (1:2.1.4-2.1+deb8u2)
Message-ID: <20161124235822.GA736@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These may be well know but I was not able to find a bug tracker so here it goes.

1) When selecting help, about git gui it crashes wth the error:
	
	error: git-gui died of signal 11

2) With the default installation there are two different default text types.
	
	Edit, Options, under Global (All Repositories) at the bottom for
	Main Font: DejaVu Sans-12pt
	Diff/Console Font: DejaVu Sans Mono-12pt.

	This causes a discrepence with text alignment. 
	When changed to the same it corrects this.

3) When the same text styles are selected (from above) text alignment still varies
   from what is shown in the text editor (nano for this example) and what is shown
   from using 'git add -p'. 'git add -p' will have the correct alignment but 'git gui'
   will have have lines shifted.

	This will produce varying patches dependant on which method is used.

I have spent alot of time playing with whitespace trying to get columns to align
and not having a viewable bug tracker listing has added to the this frustration.

If these issues have been corrected in a newer version than the Debian package ;)
please let me know and also if more info is requested.

Walt
