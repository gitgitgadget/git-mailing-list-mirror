From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 2/2] remote-curl.c: fix rpc_out()
Date: Mon, 23 Nov 2009 16:38:09 +0800
Message-ID: <be6fef0d0911230038y13c23e3ek5591ee0dc3eaa47a@mail.gmail.com>
References: <20091123110338.2b230359.rctay89@gmail.com>
	 <fabb9a1e0911222153n633ade94w179513d4aa42a3d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 23 09:38:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCUR7-0006II-Ke
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 09:38:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755527AbZKWIiF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2009 03:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752884AbZKWIiE
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 03:38:04 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:56920 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752845AbZKWIiE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2009 03:38:04 -0500
Received: by iwn1 with SMTP id 1so475625iwn.33
        for <git@vger.kernel.org>; Mon, 23 Nov 2009 00:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=0/9PtAPLKf0HiSv6eMEloDTouXUckyLJdjeQIIn16Ng=;
        b=Tz/NT30joi7HyVGqNdRpY6l1/8bP7ib734OiuIkD4w2kw8GDRhL9fxrsncpZOPbgjE
         hgLzs3j4Oj7AlNSSQRYosPHNsnWMBZqMO40USX8vl/4Z4MKpWyxDezZaNzQdwF5yv14l
         hCgSj7VgVSIBW6hwGFGKabHlQo3o1CBU0vVSg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=x4ykEeDnssZHRM5NV1JU+NBUVw1FgBct7VhgTuKutzGvw4Jzz5lBQkwb/3yxD5iFTp
         5hqhYLC4aYU3nWcebqnK4FYuivzcOl37JL0lgDALVpskkL1BtMAvQwLKdvJgrhp1naru
         Xqs+d6t2XC7fE2wSl4tgibkV7LhsyVWL9E2hA=
Received: by 10.231.9.218 with SMTP id m26mr1852563ibm.29.1258965489674; Mon, 
	23 Nov 2009 00:38:09 -0800 (PST)
In-Reply-To: <fabb9a1e0911222153n633ade94w179513d4aa42a3d4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133489>

Hi,

On Mon, Nov 23, 2009 at 1:53 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> Seems like this type of patch would do very well with a test case or two?

ah, but to trigger the code involved, a sufficiently large test
repository is needed. The git repository would be enough. :)

Any idea on how I could go about accessing this repository?

-- 
Cheers,
Ray Chuan
