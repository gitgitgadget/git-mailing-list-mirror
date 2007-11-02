From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [PATCH 3/3] Act on WS_WARN for ws_mode_trailing.
Date: Sat, 3 Nov 2007 02:07:28 +1100
Message-ID: <ee77f5c20711020807i542071c0h70166cc0e32bd0ab@mail.gmail.com>
References: <11940104611948-git-send-email-dsymonds@gmail.com>
	 <11940104621856-git-send-email-dsymonds@gmail.com>
	 <1194010463982-git-send-email-dsymonds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Andreas Ericsson" <ae@op5.se>,
	"David Symonds" <dsymonds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 02 16:07:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iny7b-00041T-Qo
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 16:07:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754193AbXKBPH3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 11:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754169AbXKBPH3
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 11:07:29 -0400
Received: from rv-out-0910.google.com ([209.85.198.191]:10690 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754152AbXKBPH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 11:07:28 -0400
Received: by rv-out-0910.google.com with SMTP id k20so828218rvb
        for <git@vger.kernel.org>; Fri, 02 Nov 2007 08:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=wZ+8eLTHHNsGPLPPUan2yZHVsy65Xqob+frPjeWn6uQ=;
        b=Of+qxpZQDv9lxX3veyo87WHa7LTVzV+qyZDCicleH+YBAbUHPKOXPXGCqSkD3DAn1w5gv93qOBDd6hdmHcADH+CsUFELOOKl6M+64ZdVyLSOe7CLN0V1/od+OtX10FAx3LKtixwbpO1edMpBsJ1ED8xewyU705Nz6///AjLQ07w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Kl2wXji+o+EtlO309hoGm7vhvaKLkBoCSMaZ0uDg2lznSnZ6vQVpVOCuP/zOsmmhXegEp+znjFyhbbJl/sNd2hSYXq/UZbqsuPqFPLwMAItTjL6BRPRFhC9PxWYFDbUZcEVLaOAd5x+oc4GZAN2DivTzOc7OGZ39ouAO16cv1yw=
Received: by 10.141.68.12 with SMTP id v12mr928058rvk.1194016048075;
        Fri, 02 Nov 2007 08:07:28 -0700 (PDT)
Received: by 10.141.115.4 with HTTP; Fri, 2 Nov 2007 08:07:28 -0700 (PDT)
In-Reply-To: <1194010463982-git-send-email-dsymonds@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63124>

On 11/3/07, David Symonds <dsymonds@gmail.com> wrote:
> Signed-off-by: David Symonds <dsymonds@gmail.com>
> ---
>  diff.c |   21 +++++++++++++--------
>  1 files changed, 13 insertions(+), 8 deletions(-)

Silly me; I somehow forgot I was only in diff.c. I'll fix and repost the series.


Dave.
