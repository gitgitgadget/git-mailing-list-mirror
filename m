From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [PATCH v3 2/2] Move git-dir for submodules
Date: Mon, 15 Aug 2011 17:14:35 +0200
Message-ID: <20110815151435.GA1976@kolya>
References: <1313178913-25617-1-git-send-email-iveqy@iveqy.com>
 <1313178913-25617-3-git-send-email-iveqy@iveqy.com>
 <4E492D7B.50508@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org,
	jens.lehmann@web.de, hvoigt@hvoigt.net, gitster@pobox.com
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Mon Aug 15 17:14:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qsys5-0006yu-Ej
	for gcvg-git-2@lo.gmane.org; Mon, 15 Aug 2011 17:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754482Ab1HOPO2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Aug 2011 11:14:28 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63103 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754256Ab1HOPO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2011 11:14:27 -0400
Received: by bke11 with SMTP id 11so3058227bke.19
        for <git@vger.kernel.org>; Mon, 15 Aug 2011 08:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=eqX30azQ/ChdqV0f8vC5P+B3k8dplRGoM9+l50r8Vhw=;
        b=BkplhaVDFHtMG9WNc7svauSWB0ymDaMbVWIHJJGMhx8Tp7YbvvFLft54LdlceHk1BX
         qL5mrnyXUzBDDHU6Gpo7HT6lpSqXqyRNxUFLTczKnfhQgpmte85AHu4UN4KSBFeN/Eqg
         ESVmSmAjVmiBg94XfaaX1D+RuSXz7aZ7xmgDg=
Received: by 10.204.170.130 with SMTP id d2mr877366bkz.237.1313421266339;
        Mon, 15 Aug 2011 08:14:26 -0700 (PDT)
Received: from kolya (h8n2fls303o1100.telia.com [195.67.191.8])
        by mx.google.com with ESMTPS id h26sm172581bkt.19.2011.08.15.08.14.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 15 Aug 2011 08:14:25 -0700 (PDT)
Received: from iveqy by kolya with local (Exim 4.72)
	(envelope-from <iveqy@kolya>)
	id 1Qsys8-0000XL-2G; Mon, 15 Aug 2011 17:14:36 +0200
Content-Disposition: inline
In-Reply-To: <4E492D7B.50508@xiplink.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179371>

On Mon, Aug 15, 2011 at 10:30:19AM -0400, Marc Branchaud wrote:
> On 11-08-12 03:55 PM, Fredrik Gustafsson wrote:
> >=20
> > This patch will not affect already cloned submodules at all.
>=20
> My question is perhaps a bit beyond the scope of this series...
>=20
> Is there going to be a way to migrate submodules to the new layout?  =
If the
> eventual goal is to be able to delete & restore submodule working
> directories, it would be nice if that could work with submodules clon=
ed by an
> older git.
>=20

That's not planned as far as I know. However, a new clone will do that,
(and of course it's quite easy to do it manually).

When git supports to delete and restore submodules that will not be don=
e
if there isn't a .git-FILE in the submodule.

--
Med v=E4nliga h=E4lsningar
=46redrik
