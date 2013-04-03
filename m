From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH V3 4/5] Help.c: add list_common_guides_help() function
Date: Tue, 2 Apr 2013 22:30:32 -0400
Message-ID: <CAPig+cRv8P6jr-UaTFgo7H3JnNPDLGkW3R3B-+8_N+=+cL90_A@mail.gmail.com>
References: <1364942392-576-1-git-send-email-philipoakley@iee.org>
	<1364942392-576-5-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	"W. Trevor King" <wking@tremily.us>,
	David Aguilar <davvid@gmail.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Wed Apr 03 04:31:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNDTd-000311-VH
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 04:31:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761292Ab3DCCaf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 22:30:35 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:60538 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761268Ab3DCCae (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 22:30:34 -0400
Received: by mail-lb0-f178.google.com with SMTP id q13so1111345lbi.37
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 19:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=3APpFaL25Q8yl60T3EISGBfoclmEjLF2vqKY12VC+pE=;
        b=YxpXCmEOeHYQF36roxF1bJfV3+2gHm5Q62QiLZZ0g8LOgPF3RdZ6SwNMBaHDLos+A/
         cnZuG877Fpn15tM0jQ0TaktH3Htw606qTSTRsyqYZC0o8rpXNRvvmZpO655TXuHK/gzs
         30+MxwSj1Ta7XAB2TrBjz7vTy/Hy8nn8AdSnYnuRo8jPYTI8amQ+T3FsVWXqRihxYYIS
         E2Xg56ire3UIvrdx9StBa2KNAYGfolllA9DITbu3U7a1G1NOzyOJKUIuMwD+8hFNCdgA
         OdHhYnsQWtV6tutmHVSyF/Nf8vGQ7el3hb1pyH7l4CXPehE0gCe04LNnKy0FLgNRJebZ
         BJXQ==
X-Received: by 10.152.128.98 with SMTP id nn2mr8977788lab.17.1364956232920;
 Tue, 02 Apr 2013 19:30:32 -0700 (PDT)
Received: by 10.114.1.43 with HTTP; Tue, 2 Apr 2013 19:30:32 -0700 (PDT)
In-Reply-To: <1364942392-576-5-git-send-email-philipoakley@iee.org>
X-Google-Sender-Auth: 1y_7WXWwx3NWnsxgA_cy_bTOVRA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219911>

On Tue, Apr 2, 2013 at 6:39 PM, Philip Oakley <philipoakley@iee.org> wrote:
> Re-use list_common_cmds_help but simply change the array name.
> Candidate for future refactoring to pass a pointer to the array.
>
> The common-guides.h list was generated with a simple variant of the
> generate-cmdlist.sh and command-list.txt.
>
> Do not list User-manual and Everday Git which not follow the naming

s/which not/which do not/

> convention, nor gitrepository-layout which doesn't fit within the
> name field size.
