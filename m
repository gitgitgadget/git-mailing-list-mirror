From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH v4 0/7] customizable --color-words
Date: Mon, 19 Jan 2009 23:47:26 +0100
Message-ID: <adf1fd3d0901191447n7fc39dect9cf5afd88a02015b@mail.gmail.com>
References: <alpine.DEB.1.00.0901162208180.3586@pacific.mpi-cbg.de>
	 <1232209788-10408-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <junio@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	Teemu Likonen <tlikonen@iki.fi>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jan 19 23:54:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LP30V-0001HY-30
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 23:54:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752257AbZASWwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 17:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752247AbZASWwq
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 17:52:46 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:38982 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127AbZASWwp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 17:52:45 -0500
Received: by bwz14 with SMTP id 14so9594948bwz.13
        for <git@vger.kernel.org>; Mon, 19 Jan 2009 14:52:44 -0800 (PST)
Received: by 10.103.247.14 with SMTP id z14mr2768168mur.70.1232405246863; Mon, 
	19 Jan 2009 14:47:26 -0800 (PST)
In-Reply-To: <1232209788-10408-1-git-send-email-trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106397>

2009/1/17 Thomas Rast <trast@student.ethz.ch>:
> Johannes Schindelin (4):
>  Add color_fwrite_lines(), a function coloring each line individually
>  color-words: refactor word splitting and use ALLOC_GROW()
>  color-words: change algorithm to allow for 0-character word
>    boundaries
>  color-words: take an optional regular expression describing words
>
> Thomas Rast (3):
>  color-words: enable REG_NEWLINE to help user
>  color-words: expand docs with precise semantics
>  color-words: make regex configurable via attributes
>

Also, having a config (diff.color-words?) to set the default regexp
would be great. Thanks.

Santi
