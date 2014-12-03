From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/4] refs.c: rename transaction.updates to
 transaction.ref_updates
Date: Tue, 2 Dec 2014 18:43:01 -0800
Message-ID: <20141203024301.GE6527@google.com>
References: <1417506402-24257-1-git-send-email-sbeller@google.com>
 <1417506402-24257-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org, ronniesahlberg@gmail.com,
	mhagger@alum.mit.edu
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 03:43:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvzuJ-0008EO-0r
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 03:43:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbaLCCnG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 21:43:06 -0500
Received: from mail-ie0-f180.google.com ([209.85.223.180]:42702 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344AbaLCCnE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 21:43:04 -0500
Received: by mail-ie0-f180.google.com with SMTP id rp18so13050395iec.11
        for <git@vger.kernel.org>; Tue, 02 Dec 2014 18:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=/qDkkQuRcMw5/JcM4OrDa32+nVLisipFDXB9B5hE2sc=;
        b=wBYTIdx+xQ1xg0jhXjMlr4Fizr8x9G4lPWBAvHC3g3ftpS09JGUTKkCikRGQJfAiPk
         tvXGt1/z0SoySiYidqKGEUWACqgDYlURi5mo1qi6IHLTFtQ/kSqi9Q39bchBCQtOS3om
         l/0swg0Qsaq+rDLy7b1sH+gB+MOPvEOZ6HYEYYnCRPz7a++Dh38uNFc3hbPKKiDTVn/f
         nXNCL8Mmru58HwxpC+4FTgIbp/9DbWYkkqj+Dn7LxPkYC5mdFbqyPqfGRe/mcDmAc1gM
         kHmERYiqjFi9I8jtVEtsWlj4rtPa0JUIVHZj+wYsbRAQZaipLLQWgeybsM9vaRwrAzha
         xQPQ==
X-Received: by 10.42.255.72 with SMTP id nh8mr5295931icb.1.1417574583654;
        Tue, 02 Dec 2014 18:43:03 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:fd7b:507b:3c7b:554e])
        by mx.google.com with ESMTPSA id a1sm12057423ioa.27.2014.12.02.18.43.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Dec 2014 18:43:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1417506402-24257-3-git-send-email-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260617>

Stefan Beller wrote:

> The updates are only holding refs not reflogs, so express it to the reader.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  refs.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Makes sense.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
