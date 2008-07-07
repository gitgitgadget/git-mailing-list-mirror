From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH 2/2] Implement "stg refresh --edit" again
Date: Mon, 7 Jul 2008 21:56:29 +0100
Message-ID: <b0943d9e0807071356v2a249e4cx4a9f94e73bffb741@mail.gmail.com>
References: <20080704063755.9637.23750.stgit@yoghurt>
	 <20080704064036.9637.52951.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Jakub Narebski" <jnareb@gmail.com>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 22:57:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFxm6-000357-Pq
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 22:57:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756315AbYGGU4c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Jul 2008 16:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756298AbYGGU4c
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 16:56:32 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:46942 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756256AbYGGU4b convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Jul 2008 16:56:31 -0400
Received: by yx-out-2324.google.com with SMTP id 8so514480yxm.1
        for <git@vger.kernel.org>; Mon, 07 Jul 2008 13:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=rUkw9+IcX9WTh84m2uCXdDUWAvzdUyc1FmuNJi3A0Pc=;
        b=KwbUI+6CVuDt5mujivzL0p9oz7WKPzXbTT6ZRZz+Sk8CIsTerE3FMvcXMp46OEewep
         NV7jCAZm2ZPOwikE7XULx64daEPEde9+eNb4KdhGslHYn/xBnHsyiAsj2ch45T9HGZPo
         MAzgVl5uD7zVPXPeLNu+nIpp20sVfpjGS81ns=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Vyu5ZH/nMYqumQYCcmXDkg+9asm3mPBOgy9ziK4kK4fL3ertNHgiYvflKMX/WndmY9
         e9eu5B2DM2lga3p4ffrRNjHou7uqVOxsa3cY2bYveAxIMzm9BoOj9SJPyxIWUhCrIKRG
         26ADhep+JywuazbcrB5FWSIYgo8oPwKfccYJw=
Received: by 10.114.198.1 with SMTP id v1mr7096658waf.64.1215464189671;
        Mon, 07 Jul 2008 13:56:29 -0700 (PDT)
Received: by 10.114.124.9 with HTTP; Mon, 7 Jul 2008 13:56:29 -0700 (PDT)
In-Reply-To: <20080704064036.9637.52951.stgit@yoghurt>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87655>

2008/7/4 Karl Hasselstr=F6m <kha@treskal.com>:
> The -e/--edit flag to "stg refresh" was dropped between v0.13 and
> v0.14, causing severe user dissatisfaction. This patch restores it,
> along with -m/--message, -f/--file, --sign, --ack, --author,
> --authname, --authemail, and --authdate.

Thanks.

> I omitted the --committer options on purpose; I think they are a
> mistake. Falsifying the committer info is not a common operation, and
> if one wishes to do it for some reason, one can always set the
> GIT_COMMITTER_* environment variables.

I agree.

--=20
Catalin
