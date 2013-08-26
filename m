From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 2/2] grep: use slash for path delimiter, not colon
Date: Mon, 26 Aug 2013 22:13:14 +0200
Message-ID: <521BB6DA.5050807@kdbg.org>
References: <20130826195331.GA21051@sigill.intra.peff.net> <20130826195616.GB21074@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Phil Hord <hordp@cisco.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: phil.hord@gmail.com
X-From: git-owner@vger.kernel.org Mon Aug 26 22:13:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VE3AA-0004nl-Nh
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 22:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751681Ab3HZUNS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 16:13:18 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:7993 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751529Ab3HZUNS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 16:13:18 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id F38601300AD;
	Mon, 26 Aug 2013 22:13:14 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 54A8219F61C;
	Mon, 26 Aug 2013 22:13:14 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <20130826195616.GB21074@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233022>

Am 26.08.2013 21:56, schrieb Jeff King:
> Also, prevent the delimiter being added twice, as happens now in these
> examples:
> 
>   git grep -l foo HEAD:
>   HEAD::some/path/to/foo.txt
>        ^

Which one of these two does it print then?

    HEAD:/some/path/to/foo.txt
    HEAD:some/path/to/foo.txt

-- Hannes
