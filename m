From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: Feature suggestion: git-hist
Date: Wed, 30 Jul 2008 17:23:25 +0200
Message-ID: <8aa486160807300823w3dfbdff2m4b9821d71779231d@mail.gmail.com>
References: <20080730133859.368bbd92@pc09.procura.nl>
	 <20080730133334.GB31192@lars.home.noschinski.de>
	 <20080730155835.71289eee@pc09.procura.nl>
	 <20080730145534.GD32057@genesis.frugalware.org>
	 <20080730170326.6f4f1772@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Miklos Vajna" <vmiklos@frugalware.org>,
	"Lars Noschinski" <lars-2008-1@usenet.noschinski.de>,
	git@vger.kernel.org
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Wed Jul 30 17:24:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KODXP-0003DC-SZ
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 17:24:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753391AbYG3PX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 11:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753308AbYG3PX1
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 11:23:27 -0400
Received: from rv-out-0506.google.com ([209.85.198.224]:53564 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753259AbYG3PX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 11:23:26 -0400
Received: by rv-out-0506.google.com with SMTP id k40so64476rvb.1
        for <git@vger.kernel.org>; Wed, 30 Jul 2008 08:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=5KEjH3wSgnADiYS/jfXMpwdGHILTerCZBbMl6p0bbiM=;
        b=Tvt+RpMeXzlcakfzigUpurmyjm4/I5m8evSWYJZI4tu1WYtDVLxw6sEF7m/feBHKar
         fTdJF8UQ7/jR7HU6ayN3mtttWGCcVw/lCW1EyuuylCJk+adnoZ938WkmcOjooneNxdvo
         +TFq6EiDYhJhyXCSYnHho8qNv7Dkpe56UNxdo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=go+O2hCTj7Ecst9vTHGkhzc98cqFizEeRtguJLC0cde59RlydvFmMas5KBIFVgasol
         OTgMSVEwPmQuRKGrusto3ZmqqjxDf9o1L2a0WYrvHhJm1cKVDSPXGMU66FdcmsJ/P83A
         qLerE4uF4yzfZA2Q0bFy8Z/VwV+VeuVyjw+dA=
Received: by 10.141.171.6 with SMTP id y6mr4406339rvo.84.1217431406424;
        Wed, 30 Jul 2008 08:23:26 -0700 (PDT)
Received: by 10.150.95.21 with HTTP; Wed, 30 Jul 2008 08:23:25 -0700 (PDT)
In-Reply-To: <20080730170326.6f4f1772@pc09.procura.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90803>

On Wed, Jul 30, 2008 at 17:03, H.Merijn Brand <h.m.brand@xs4all.nl> wrote:
> On Wed, 30 Jul 2008 16:55:34 +0200, Miklos Vajna
> <vmiklos@frugalware.org> wrote:
>
>> If pure hashes are not friendly enough, you can use something like:
>>
>> git describe $(git rev-list -1 HEAD -- <file>)
>
> What do I miss here?
>
>> git describe $(git rev-list -1 HEAD -- *pm)
> fatal: cannot describe 'c2220c8a544af5cd5419e238eb5f43b1f079ad85'
>

It cannot be described because there is no annotated tag before this
commit. Add --always to show the abbreviated commit as fallback.

Santi
