From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: git blame not respecting --find-copies-harder ?
Date: Wed, 30 Jul 2008 17:43:52 +0200
Message-ID: <bd6139dc0807300843l1d42d6fep95f6c99fe6e0ea0@mail.gmail.com>
References: <20080730093903.GA14330@cuci.nl>
	 <20080730150123.GB9758@atjola.homenet>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Stephen R. van den Berg" <srb@cuci.nl>,
	"Git Mailinglist" <git@vger.kernel.org>
To: "=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?=" <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 30 17:45:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KODrE-0004Qb-QS
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 17:44:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752086AbYG3Pnz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Jul 2008 11:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752304AbYG3Pny
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 11:43:54 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:64675 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbYG3Pnx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Jul 2008 11:43:53 -0400
Received: by yx-out-2324.google.com with SMTP id 8so24937yxm.1
        for <git@vger.kernel.org>; Wed, 30 Jul 2008 08:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=2L86a5oVOeLPSuR0V7lul9v13rWmQZqCRwANk8/L5BM=;
        b=pxh0kxj49AGO16BxbJQf38vxZf35IKCz5f3WBtBurHxANezyelNZ297HpLlkwa3bUA
         YMVJP115UM8/cV0EMKXqbea5sQLh71EZpWdpOPLm3PjKSu8IfjhzqaK2nUVVSj0E3M1o
         nB4m9ainiZvwM9eJugwaDvxxGhTBuH3o/Nc+0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=B4LfFSAts8laHEck45QAK0T38bC6X6lGZ/k4rUIY04KYEN9Xj8Fp9z5uNwYi30L2Ow
         QSXqzj/2bUtNyW/Uu849aoIp8YIzdwzF3/eI90/fSSQfFblEcb0C4RU2HwyQk7PJ1VIK
         zPKwnTOQoWpFqQStNO7s7IB5Q500o1VQivfxY=
Received: by 10.142.204.18 with SMTP id b18mr2769893wfg.126.1217432632379;
        Wed, 30 Jul 2008 08:43:52 -0700 (PDT)
Received: by 10.142.104.10 with HTTP; Wed, 30 Jul 2008 08:43:52 -0700 (PDT)
In-Reply-To: <20080730150123.GB9758@atjola.homenet>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90808>

On Wed, Jul 30, 2008 at 17:01, Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>=
 wrote:
> git blame doesn't know --find-copies-harder, it's -C -C for blame.

Shouldn't it have died with "don't know option --find-copies-harder" th=
en?

--=20
Cheers,

Sverre Rabbelier
