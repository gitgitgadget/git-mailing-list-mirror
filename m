From: Elijah Newren <newren@gmail.com>
Subject: Re: How do I show only log messages for commits on a specific branch?
Date: Wed, 16 Dec 2009 17:04:11 -0700
Message-ID: <51419b2c0912161604j4e3d6a9ft4b0e48d6ca74d5c9@mail.gmail.com>
References: <20091216101647.GB27373@bc-bd.org>
	 <51419b2c0912161005n1596d4a1n92ed555c98aee4c6@mail.gmail.com>
	 <20091216232641.GK25474@genesis.frugalware.org>
	 <adf1fd3d0912161558u36d9674eid36e3042d181ed8f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Miklos Vajna <vmiklos@frugalware.org>, bd@bc-bd.org,
	git@vger.kernel.org
To: =?UTF-8?B?U2FudGkgQsOpamFy?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Thu Dec 17 01:04:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NL3r2-0001VK-E7
	for gcvg-git-2@lo.gmane.org; Thu, 17 Dec 2009 01:04:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763415AbZLQAE0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Dec 2009 19:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762952AbZLQAEO
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Dec 2009 19:04:14 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:58520 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759184AbZLQAEM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Dec 2009 19:04:12 -0500
Received: by pwj9 with SMTP id 9so959010pwj.21
        for <git@vger.kernel.org>; Wed, 16 Dec 2009 16:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hSLa73e1aDutaTw/RAz59A5iNcIij7suPvlgNId3uFw=;
        b=LtzLMohFexxrmOpXH/V3MJYZeJABAPshi1/jXKbKjUfsA//mZhMm2UIOE7t/6IZL1N
         e8AyUQrbf4bbaCnNMSoAXa1l5EiGCADfRl48Tj13LeLypM23skvA8UgB7LcrtmHxKruJ
         bZMJUQSl8YHgjsm7REdV7DOcb+pf0lgIX5ipA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BxKkhaA1TvWltjSNl0Mc9OXRREseGkqHPCkiUpbma/6O5Xkkh/Z/3q6jIfQ4QMGr8Q
         yoTUGuNrdbFmruRj7r/wL6hjKW34vU/0nlomWRlYpr3Uxh62C0vGx+OoByLyYzQPZiMb
         P3EDXxjrB2aBVUvC84Bc7zLVkHFym3ZoQflnY=
Received: by 10.114.188.31 with SMTP id l31mr1124980waf.201.1261008251761; 
	Wed, 16 Dec 2009 16:04:11 -0800 (PST)
In-Reply-To: <adf1fd3d0912161558u36d9674eid36e3042d181ed8f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135347>

On Wed, Dec 16, 2009 at 4:58 PM, Santi B=C3=A9jar <santi@agolina.net> w=
rote:
> git log new --not $(git for-each-ref --format=3D'%(refname)'
> 'refs/heads/*' | grep -v refs/heads/new)

How did I miss '--not' as a git log option?  Thanks for pointing it out=
!
