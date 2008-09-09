From: Abhijit Menon-Sen <ams@toroid.org>
Subject: Re: [PATCH v2] Git.pm: Use File::Temp->tempfile instead of ->new
Date: Tue, 9 Sep 2008 07:36:05 +0530
Message-ID: <20080909020605.GA19190@toroid.org>
References: <1220889063-20387-1-git-send-email-marcus@griep.us> <1220892781-24343-1-git-send-email-marcus@griep.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>,
	"Tom G. Christensen" <tgc@statsbiblioteket.dk>
To: Marcus Griep <marcus@griep.us>
X-From: git-owner@vger.kernel.org Tue Sep 09 04:07:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcsdU-0002J8-Fm
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 04:07:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093AbYIICGJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 22:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751973AbYIICGI
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 22:06:08 -0400
Received: from fugue.toroid.org ([85.10.196.113]:46034 "EHLO fugue.toroid.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751956AbYIICGH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 22:06:07 -0400
Received: from penne.toroid.org (penne-vpn [10.8.0.6])
	by fugue.toroid.org (Postfix) with ESMTP id EBEF5558732;
	Tue,  9 Sep 2008 04:06:05 +0200 (CEST)
Received: by penne.toroid.org (Postfix, from userid 1000)
	id 0965C388403; Tue,  9 Sep 2008 07:36:05 +0530 (IST)
Content-Disposition: inline
In-Reply-To: <1220892781-24343-1-git-send-email-marcus@griep.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95330>

At 2008-09-08 12:53:01 -0400, marcus@griep.us wrote:
>
> +		my $fname;
> +		($$temp_fd, $fname) = File::Temp->tempfile(
> +			'Git_XXXXXX', UNLINK => 1
>  			) or throw Error::Simple("couldn't open new temp file");

What happens when tempfile croaks on error?

-- ams
