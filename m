Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 933BA1F597
	for <e@80x24.org>; Mon, 30 Jul 2018 12:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732393AbeG3Obm (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 10:31:42 -0400
Received: from mail.gooeysoftware.com ([208.100.15.213]:59544 "EHLO
        mail.gooeysoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729138AbeG3Obl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 10:31:41 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Jul 2018 10:31:41 EDT
Received: from [192.168.1.3] (82-69-83-224.dsl.in-addr.zen.co.uk [82.69.83.224])
        by mail.gooeysoftware.com (Postfix) with ESMTPSA id B0C6818A025C
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 07:50:52 -0500 (CDT)
Message-ID: <5B5F096A.7030404@game-point.net>
Date:   Mon, 30 Jul 2018 13:49:46 +0100
From:   Jeremy Morton <admin@game-point.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     git@vger.kernel.org
Subject: Strange bug with "git log" - pdftotext?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm trying to search my git log history for a particular term - 
"unobtrusive" - so I run this command:

git log -S unobtrusive --oneline

When I do this, this is displayed and I'm in an interactive less 
terminal or something:

pdftotext version 4.00
Copyright 1996-2017 Glyph & Cog, LLC
Usage: pdftotext [options] <PDF-file> [<text-file>]
  -f <int>             : first page to convert
  -l <int>             : last page to convert
  -layout              : maintain original physical layout
  -simple              : simple one-column page layout
  -table               : similar to -layout, but optimized for tables
  -lineprinter         : use strict fixed-pitch/height layout
  -raw                 : keep strings in content stream order
  -fixed <number>      : assume fixed-pitch (or tabular) text
  -linespacing <number>: fixed line spacing for LinePrinter mode
  -clip                : separate clipped text
  -nodiag              : discard diagonal text
  -enc <string>        : output text encoding name
  -eol <string>        : output end-of-line convention (unix, dos, or mac)
  -nopgbrk             : don't insert page breaks between pages
  -bom                 : insert a Unicode BOM at the start of the text 
file
  -opw <string>        : owner password (for encrypted files)
  -upw <string>        : user password (for encrypted files)
  -q                   : don't print any messages or errors
  -cfg <string>        : configuration file to use in place of .xpdfrc
  -v                   : print copyright and version info
:

When I hit the down arrow, it scrolls down, repeating this output 
infinitely until I hit 'q'.  What is going on here??

-- 
Best regards,
Jeremy Morton (Jez)
