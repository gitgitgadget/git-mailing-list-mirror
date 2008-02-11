From: Tim Stoakes <tim@stoakes.net>
Subject: Re: [PATCH] Technical details about the index file format.
Date: Mon, 11 Feb 2008 22:30:55 +1030
Message-ID: <20080211120054.GG27275@mail.stoakes.net>
References: <1202711335-12026-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 13:01:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOXLr-0000hl-Aq
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 13:01:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752529AbYBKMA6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 07:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752315AbYBKMA6
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 07:00:58 -0500
Received: from hosted02.westnet.com.au ([203.10.1.213]:48611 "EHLO
	hosted02.westnet.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256AbYBKMA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 07:00:57 -0500
Received: from hosted02.westnet.com.au (hosted02.westnet.com.au [127.0.0.1])
	by hosted02.westnet.com.au (Postfix) with SMTP id A26024AA68;
	Mon, 11 Feb 2008 21:00:54 +0900 (WST)
Received: from mail.stoakes.net (dsl-202-173-137-105.sa.westnet.com.au [202.173.137.105])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hosted02.westnet.com.au (Postfix) with ESMTP id 433744A2FA;
	Mon, 11 Feb 2008 21:00:50 +0900 (WST)
Received: from noodle.stoakes.net (unknown [192.168.20.209])
	by mail.stoakes.net (Postfix) with ESMTP id 6338328C3FF;
	Mon, 11 Feb 2008 22:30:49 +1030 (CST)
Received: by noodle.stoakes.net (Postfix, from userid 1000)
	id 1ACFA7F1FF; Mon, 11 Feb 2008 22:30:55 +1030 (CST)
Content-Disposition: inline
In-Reply-To: <1202711335-12026-1-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-PMX-Branch: TNG-Outgoing
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73522>

Robin Rosenberg(robin.rosenberg@dewire.com)@110208-07:28:
> diff --git a/Documentation/technical/index-format.txt b/Documentation/technical/index-format.txt

A couple of typos:

> +     Name (variable length) - encoding is undefined
> +
> +     1-8 nul bytes as necessary to pad the entry to a multiple ot eight bytes
                                                                   ^
of

>  +    The only know index extension today is a tree cache. It contains
>  +    pre-computes hashes for all trees that can be derived from the index
                   ^

computed

full stop

Tim

-- 
Tim Stoakes
