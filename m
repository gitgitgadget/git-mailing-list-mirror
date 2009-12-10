From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [REROLL PATCH v2 6/8] Support remote helpers implementing
	smart transports
Date: Thu, 10 Dec 2009 07:58:11 -0800
Message-ID: <20091210155811.GC30665@spearce.org>
References: <1260372394-16427-1-git-send-email-ilari.liusvaara@elisanet.fi> <1260372394-16427-7-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Thu Dec 10 16:58:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIlPN-0007Vm-Kq
	for gcvg-git-2@lo.gmane.org; Thu, 10 Dec 2009 16:58:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760890AbZLJP6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2009 10:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752408AbZLJP6N
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Dec 2009 10:58:13 -0500
Received: from mail-gx0-f212.google.com ([209.85.217.212]:43395 "EHLO
	mail-gx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752125AbZLJP6M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2009 10:58:12 -0500
Received: by gxk4 with SMTP id 4so12468729gxk.8
        for <git@vger.kernel.org>; Thu, 10 Dec 2009 07:58:19 -0800 (PST)
Received: by 10.101.134.25 with SMTP id l25mr120963ann.98.1260460699134;
        Thu, 10 Dec 2009 07:58:19 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 8sm424172yxg.42.2009.12.10.07.58.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 10 Dec 2009 07:58:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1260372394-16427-7-git-send-email-ilari.liusvaara@elisanet.fi>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135035>

Ilari Liusvaara <ilari.liusvaara@elisanet.fi> wrote:
> Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>

This is better.

> +	if (strcmp(name, exec)) {
> +		r = set_helper_option(transport, "servpath", exec);
> +		if (r > 0)
> +			fprintf(stderr, "Warning: Setting remote service path "
> +				"not supported by protocol.\n");
> +		else if (r < 0)
> +			fprintf(stderr, "Warning: Invalid remote service "
> +				"path.\n");

Style-nit: We prefer "warning: " with lowercase.

-- 
Shawn.
