From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
Subject: Re: [PATCH 3/2] attribute "coding": specify blob encoding
Date: Fri, 04 Jan 2008 06:23:25 +0900
Message-ID: <200801032128.m03LSIn2022902@mi0.bluebottle.com>
References: <20080102.082014.02281301.tshibata@ab.jp.nec.com>
	<7v1w904x29.fsf@gitster.siamese.dyndns.org>
	<7vsl1gy2si.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Tsugikazu Shibata <tshibata@ab.jp.nec.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 03 22:24:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAXYW-0001OC-4o
	for gcvg-git-2@gmane.org; Thu, 03 Jan 2008 22:24:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752565AbYACVYW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2008 16:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752159AbYACVYW
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jan 2008 16:24:22 -0500
Received: from mi0.bluebottle.com ([206.188.25.15]:58405 "EHLO
	mi0.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565AbYACVYV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2008 16:24:21 -0500
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi0.bluebottle.com (8.13.1/8.13.1) with ESMTP id m03LSIn2022902
	for <git@vger.kernel.org>; Thu, 3 Jan 2008 13:28:18 -0800
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:to:cc:date:subject:in-reply-to:references:
	mime-version:content-type:content-transfer-encoding:x-trusted-delivery;
	b=seGQ86s0tWXfRt0UtNF5JLihGGvtB33a5n/hBvAM8zT7J2VWOmOCYuJO/94U4SiOW
	38fp7jOk09pdWkdEncm7H6Zm9JbqzEjFhtjS2YWhYuZ3EeLNfucvLaWUxyIleY6
Received: from nanako3.mail.bluebottle.com ([212.62.97.23])
	(authenticated bits=0)
	by fe0.bluebottle.com (8.13.1/8.13.1) with ESMTP id m03LO7kR022534
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 3 Jan 2008 13:24:12 -0800
In-Reply-To: <7vsl1gy2si.fsf@gitster.siamese.dyndns.org>
X-Trusted-Delivery: <46396ae70e1de6aa894344ae2c096a46>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69535>

Quoting Junio C Hamano <gitster@pobox.com>:

> This teaches "diff hunk header" function about custom character
> encoding per path via gitattributes(5) so that it can sensibly
> chomp a line without truncating a character in the middle.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * This is not intended for serious inclusion, but was done more
>    as a demonstration of the concept, hence [3/2].

Why not?  It looks a useful addition for us Japanese people.

> +static struct {
> +	const char *coding;
> +	sane_truncate_fn fn;
> +} builtin_truncate_fn[] = {
> +	{ "euc-jp", truncate_euc_jp },
> +	{ "utf-8", NULL },
> +};

Can you also do JIS and Shift JIS?  I ask because many of my old notes are in Shift JIS and I think it is the same for many other people.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
Get a free email account with anti spam protection.
http://www.bluebottle.com/tag/2
