From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: [PATCH 1/9] Add has_extension()
Date: Thu, 10 Aug 2006 20:21:18 +0200
Message-ID: <20060810182117.GA13446@c165.ib.student.liu.se>
References: <11552221582769-git-send-email-rene.scharfe@lsrfire.ath.cx> <11552221581171-git-send-email-rene.scharfe@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 10 20:21:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBF9o-0000Ow-Ou
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 20:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030252AbWHJSVV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Aug 2006 14:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030649AbWHJSVV
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Aug 2006 14:21:21 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:2813 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S1030252AbWHJSVU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Aug 2006 14:21:20 -0400
Received: from c165 ([213.114.27.85] [213.114.27.85])
          by mxfep02.bredband.com with ESMTP
          id <20060810182119.GHJH23359.mxfep02.bredband.com@c165>;
          Thu, 10 Aug 2006 20:21:19 +0200
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1GBF9i-0003WB-00; Thu, 10 Aug 2006 20:21:18 +0200
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Content-Disposition: inline
In-Reply-To: <11552221581171-git-send-email-rene.scharfe@lsrfire.ath.cx>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25205>

On Thu, Aug 10, 2006 at 05:02:30PM +0200, Rene Scharfe wrote:
> +static inline int has_extension(const char *filename, int len, const char *ext)
> +{
> +	int extlen = strlen(ext);
> +	return len > extlen && !memcmp(filename + len - extlen, ext, extlen);
> +}
> +

Wouldn't this function be much easier to use if len is computed from
filename with strlen? (after a quick look through the other patches I
couldn't find a call site where filename wasn't NUL-terminated)

- Fredrik
