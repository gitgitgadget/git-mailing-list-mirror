Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E53501FF40
	for <e@80x24.org>; Tue, 28 Jun 2016 08:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752521AbcF1IzK (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 04:55:10 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:62403 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193AbcF1IzG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2016 04:55:06 -0400
Received: from pflsmail.localdomain ([37.123.123.67]) by
 mrelayeu.kundenserver.de (mreue104) with ESMTPSA (Nemesis) id
 0M25kJ-1bbXKq38eJ-00u1p3; Tue, 28 Jun 2016 10:54:43 +0200
Received: from localhost (localhost [127.0.0.1])
	by pflsmail.localdomain (Postfix) with ESMTP id CEAAFB00EA4;
	Tue, 28 Jun 2016 10:54:42 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at pflsmail.corp.cetitec.com
Received: from pflsmail.localdomain ([127.0.0.1])
	by localhost (pflsmail.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4P62m4CCE-+F; Tue, 28 Jun 2016 10:54:40 +0200 (CEST)
Received: from pfwsexchange.corp.cetitec.com (unknown [10.10.1.99])
	by pflsmail.localdomain (Postfix) with ESMTPS id 48790B00E5D;
	Tue, 28 Jun 2016 10:54:40 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (10.10.11.230) by
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) with Microsoft SMTP Server (TLS)
 id 15.0.847.32; Tue, 28 Jun 2016 10:54:22 +0200
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)	id
 CAC13804B0; Tue, 28 Jun 2016 10:54:21 +0200 (CEST)
Date:	Tue, 28 Jun 2016 10:54:21 +0200
From:	Alex Riesen <alexander.riesen@cetitec.com>
To:	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
CC:	<git@vger.kernel.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Support for $FILENAMES in tool definitions
Message-ID: <20160628085421.GC3710@pflmari>
Reply-To: Alex Riesen <alexander.riesen@cetitec.com>
References: <20160627132137.GC4194@pflmari>
 <57716227.1030104@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <57716227.1030104@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [10.10.11.230]
X-ClientProxiedBy: PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) To
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99)
X-Antivirus: avast! (VPS 160627-1, 27.06.2016), Outbound message
X-Antivirus-Status: Clean
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K0:DQc+EFYF5P78TkxP0diN5zzW7SlQlcZrOZvaNVpJTYEfwzIWDXV
 BYQLIRliJGzXFBaLvl5dpQ+LKKKvMhqrEOPhPlyPSVhW+6G835t4/CAfPwnO6kMUFsyhyY8
 knf+fAU0yNmnI/NP+6+Yezh6AFdcjfPKgjYuF9wg16hPg+fbXSmOgipqyySjgYyTNgQF4AS
 1Wlad9Xm947tztDrqS5HQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:sgu2zMednpY=:fTJotndMCLNdwfIYJ7Cwt/
 35Jyc1oj6f/ZSH+IMfTw7QY4xcqU5iW8j5amrMjBFxL33KQhpxdqu5vE0lcjQyh6GB55PLa5y
 WJtrAyXs3bIM21GOscsnR6lckP+VenpVRw+NZR2V+pX1jXGdLJYaOmy7N7ANRb8kmYTtmdkec
 eUHS42ivRBjYnAlBZyqFk3mLIBRuN90cDrWDPt0beNnwySgnay5kH8znqSFy82Uhh6fbA/gpS
 DJpMiZebp2XMSCMjxbwY2ySW3UukDtYJqM3tkY6iPXh/xW7CzKRPLD2YWA6xHHkeY4tZGSzai
 wzUOr0Af9s/AIoaqAdJea1H7jIOR8d+eqaDD3f5/dm8R0mKjh9Ts1kl1vfb3XTNW1huINktFj
 icvXLBoUBQoGjQT8nvYqePBLmPoXARdOTuKe0ncLPgkS57h0dkJ8P+anEj436vNUzorGy5C/E
 dFWwqWGonMqUpomzrExffgx40UJeyeBwM9utn/AH3Y5hIm8d4Wy399kO2JVxrMaK9eqMjGRgr
 gUaAhC/9nOYuzjHAELlzdqSO6DbPlBOt5iuGrEZDXTGflkJW3mv62pOghUtnupFM+wKfEXu4V
 U4yAYywTSlV/wxOKp8hjl9bB1uemtxXfhsnnoXxyXiWRAejisE25Bt8Rpea07ND5Tt5AYsXW9
 mpyCBTxMfGYM6Xe/Gc2Z3s2HHucfboghKfQTmKircEmp3eYPgPDFR4s7dERfuqHdMmPw=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jakub Narębski, Mon, Jun 27, 2016 19:28:07 +0200:
> On 2016-06-27, Alex Riesen wrote:
> 
> > This adds a FILENAMES environment variable, which contains the repository
> > pathnames of all selected files the list.
> > The variable contains the names separated by spaces.
> 
> Why not separate filenames with end-of-line character (LF)? It would still
> be broken for some filenames, but only for unportable ones.  Filenames with
> internal space (common on MS Windows) would work then.
> 
>   http://www.dwheeler.com/essays/filenames-in-shell.html
>  

Done. Thanks for the reference, BTW.

> If Tcl allows it, you could separate filenames in FILENAMES environment
> variable with NUL ("\0") character...

It allows using of NUL to join the file names. The problem is that the shell
does not know that the variable $FILENAMES doesn't end at the first NUL.

Looks like the script should do the expansion (and quoting!) on its own for
this. Or implement another syntax for custom tools, which will allow for, i.e.
passing the list of files on stdin. LF or NUL separated than.

> > Similar to the FILENAME it is broken yet, if the names contain spaces.
> 
> Could you clarify? Did you meant that FILENAMES environment variable is
> similar to existing FILENAME variable, but broken for filenames which contain
> spaces, or did you mean that both FILENAME (how?) and FILENAMES are broken
> for filenames with spaces in them?

Passing a filename with spaces plainly $FILENAME into the command (i.e.
without quoting) produces multiple arguments instead of one.
The new $FILENAMES produces incorrect number of arguments for files with
spaces for the same reason.

> > Note that the file marked and diffed immediately after starting the GUI up,
> > is not actually selected. One must click on it once to really select it.
> 
> I'm not that familiar with git-gui / gitk; what do you mean by this sentence?

The git-gui (its completely different from gitk) keeps two variables for
current files: a scalar variable for the file diff of which is displayed in
the lower right pane, and a Tcl array (more like a string-to-int map, if I
understand the code) with the names of the files selected in the file list.
The array is populated every time you click on a name in the file list, and
can contain multiple entries if you hold "Ctrl" while clicking.

> Could you summarize how FILENAME and FILENAMES work, please?

These are just environment variables set before running the tool command. They
are unset immediately after starting the command.

The tool command is unconditionally run using "sh -c <command>", so the
references to the environment variables are expanded by "sh".

Regards,
Alex

---
Diese E-Mail wurde von Avast Antivirus-Software auf Viren geprüft.
https://www.avast.com/antivirus

