From: =?ISO-8859-1?Q?Gustav_H=E5llberg?= <gustav@gmail.com>
Subject: Re: [stgit PATCH] stgit.el: Stop "Summary:" being added to all commit msgs.
Date: Mon, 13 Jun 2011 11:11:08 +0200
Message-ID: <BANLkTikDdf_eVZJKezRG4e=091GpV8TGjQ@mail.gmail.com>
References: <077cac32c74edaff2f20c84897bfc171@mail.theimps.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?David_K=E5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org
To: Peter TB Brett <peter@peter-b.co.uk>
X-From: git-owner@vger.kernel.org Mon Jun 13 11:11:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QW3Ax-0003SD-Gl
	for gcvg-git-2@lo.gmane.org; Mon, 13 Jun 2011 11:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755175Ab1FMJLL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Jun 2011 05:11:11 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42694 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755110Ab1FMJLJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Jun 2011 05:11:09 -0400
Received: by iyb14 with SMTP id 14so3657583iyb.19
        for <git@vger.kernel.org>; Mon, 13 Jun 2011 02:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=z9n7VAgrL6Q3qBKDjonB5JXBGUGTlfJQpAapxfgZFnc=;
        b=vDpTJYIEUn825Y579LnbhdHN5A3NfhqWuY9o3A2J2t3Pale+ZhMcT4stxiydLnKX3X
         Sz6uf3N9lGs40m07ypUexiskUuF4AHPt6pKOc1/I5Fq6KDngdHkaBXTJ+cSBA/fOyEmi
         2XgHyK0D8vjAYHuQ6RmrB6OHjQdF4W/eNqdvw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=n3wxpg65R2LmTu7C0sGi/G7D8dxLA3ZNpuiLK+n48L4JB5vPAI6Q1k3XtEpwAZSZKM
         AgNhaIBIqDyKCaIt4ufyXN6ubOIrtuvi1eQKTIatF6IXQfloNe49htN3fEfEt756WVGb
         zGCss0qqRlYxFJ1Y66tsa7bbrUxrL1k3JZzio=
Received: by 10.42.99.133 with SMTP id w5mr6084865icn.437.1307956268486; Mon,
 13 Jun 2011 02:11:08 -0700 (PDT)
Received: by 10.231.170.147 with HTTP; Mon, 13 Jun 2011 02:11:08 -0700 (PDT)
In-Reply-To: <077cac32c74edaff2f20c84897bfc171@mail.theimps.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175694>

On Mon, Jun 13, 2011 at 10:37 AM, Peter TB Brett <peter@peter-b.co.uk> =
wrote:
> Did I mention that this is *incredibly annoying*?

I couldn't agree more, but if this is how all now-poor Emacs users
will expect log-edit to behave, maybe we ought to follow suit with
respect to adding christmas-tree-lit standard headers and such.
=46or sure, your patch improves the current situation which is broken,
but it's quite different from how git-status does it for example=85

- Gustav
