From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGIT PATCH] Don't use patches/<branch>/current
Date: Tue, 15 May 2007 16:56:33 +0100
Message-ID: <b0943d9e0705150856n771cb696h6e8225a0bbd5d43d@mail.gmail.com>
References: <20070506150852.8985.98091.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue May 15 17:56:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnzOD-00046s-EE
	for gcvg-git@gmane.org; Tue, 15 May 2007 17:56:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756263AbXEOP4f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 15 May 2007 11:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756597AbXEOP4f
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 11:56:35 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:10545 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756263AbXEOP4e convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 May 2007 11:56:34 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1609433uga
        for <git@vger.kernel.org>; Tue, 15 May 2007 08:56:33 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kkGCD0vZ/5dUfGzLbystpkwwMdj16nP3timJFpVJNePmGtlZvazDkvqJGw/wuMZowmv3b6iTJmvOYU/zEDImyK0x8IuYyZT7SzVvOAZpa9GBeTq4Zmpv+qD4laEzLdTv1aVOQtbJQB6sVEHKpM2WsiVXiaZzSm7yAXBbxnPNZsE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VuOUtqlV5zOdthPaNu1bUfEBb48kzAMYnIv/9xTgXUr40neGiTY08JnoNeyAPKh59J0WxPCQ6hsnk75SCMZ8Vq753/OucCKDLZ/ItdLW4knkX7MWbHhoMrwD0aNdJgZT46Tm8YScw0bV5XkhIghL0ACXWxfATeD9eUSwjlitWoQ=
Received: by 10.67.90.1 with SMTP id s1mr6047935ugl.1179244593400;
        Tue, 15 May 2007 08:56:33 -0700 (PDT)
Received: by 10.67.27.11 with HTTP; Tue, 15 May 2007 08:56:33 -0700 (PDT)
In-Reply-To: <20070506150852.8985.98091.stgit@yoghurt>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47353>

On 06/05/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> The name of the current patch, if any, is always the last line of
> patches/<branch>/applied (and there is no current patch if and only i=
f
> the "applied" file is empty). So use that instead, and stop having to
> worry about keeping the redundant "current" file up-to-date.

I applied this patch. Could you also send me a patch for the
bash-completion script as it uses this file?

I think the self.__current_file (same for the base file removed in a
different patch) should still be available in the Series object and
removed when deleting a branch, otherwise you get a "Series directory
=2E.. is not empty" exception.

Thanks.

--=20
Catalin
