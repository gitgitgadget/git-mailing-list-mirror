From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] t/lib-terminal: test test-terminal's sanity
Date: Mon, 12 Dec 2011 12:25:30 -0600
Message-ID: <20111212182530.GF31793@elie.hsd1.il.comcast.net>
References: <b97d14da67bd6097e5b04f6ae3057c0f1d536a0b.1323713230.git.trast@student.ethz.ch>
 <44602402ecfd0e49c202f03e87540934aa23bce0.1323713230.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Dec 12 19:25:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaAZK-0001ku-3d
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 19:25:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753445Ab1LLSZh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 13:25:37 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:60890 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753418Ab1LLSZh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 13:25:37 -0500
Received: by ghbf16 with SMTP id f16so25585ghb.19
        for <git@vger.kernel.org>; Mon, 12 Dec 2011 10:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=fLsHPz4TwYNMj9VL1S0VtWVbQIFLt6MKs2lWPoQWAXU=;
        b=aeQpa53r6xoMUlQAwhZrP4G9zLN2r7ebcLH7yK0n9TvIWkZwRPRZmfS242yXrA4EMo
         9KmwFbNwBgKFywhOiz9AN1WdfXeka+/y01u9FGLE2OXd0Kde8/cngl8vpWV0IkwMzP2S
         6dyVSYTvgO4ymyFgxY4mRDlmEjkWD83WWsvwc=
Received: by 10.236.176.3 with SMTP id a3mr27937785yhm.111.1323714336873;
        Mon, 12 Dec 2011 10:25:36 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id i4sm31922040yhk.21.2011.12.12.10.25.35
        (version=SSLv3 cipher=OTHER);
        Mon, 12 Dec 2011 10:25:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <44602402ecfd0e49c202f03e87540934aa23bce0.1323713230.git.trast@student.ethz.ch>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186928>

Thomas Rast wrote:

> The previous two commits show that getting test-terminal.perl right is
> not trivial.  Let lib-terminal.sh run a simple test that ensures it
> actually opens TTYs for std{in,out,err} and that it does not let stdin
> pass through.

This test would get run again for each lib-terminal.sh user.  If we
want to "test the test machinery" like this, I suppose it would make
the most sense to run the check somewhere in the t00* series.
