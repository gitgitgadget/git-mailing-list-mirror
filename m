From: Eugene Sajine <euguess@gmail.com>
Subject: Re: repo corruption - Egit's fault?
Date: Fri, 18 Dec 2009 13:30:45 -0500
Message-ID: <76c5b8580912181030k56cb7dd7l811c0a0d4773d309@mail.gmail.com>
References: <76c5b8580912181006p2aef9d2fj95bb4c8456d965b@mail.gmail.com>
	 <20091218181613.GA10687@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Dec 18 19:31:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLhbQ-000476-IS
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 19:31:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932526AbZLRSav convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Dec 2009 13:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932496AbZLRSat
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 13:30:49 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:37012 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932343AbZLRSaq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Dec 2009 13:30:46 -0500
Received: by iwn1 with SMTP id 1so2347204iwn.33
        for <git@vger.kernel.org>; Fri, 18 Dec 2009 10:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=soH4Ml4jkG9e9gffDYt8Qf+3FeFBrc7CfVoAvpIpALQ=;
        b=Ygj5ixXv6f7/SVhzmliVI/B6DSqUdwy80c3/L5RC8cUhvWvnlqYbm95AFJ7V8/FVFG
         hqYF6usWwel3mcDF3RlHkLVcguYWSqI/S4sOeaSt0Nikgadbj/bO3Ouaq9MBVpTnUCOB
         H3+ehU0EqMh8qhMQRZD/FcjNFJP+AwYVeZxbs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=segF1TRI3P22M2GeEdxrhBxXrLYQQBCzdtQaqGD2kX26k8RJ0MsdWn7r5b6GWX6w0X
         LIrv2gpLphlje+q7wcY8lU7jXV1KlYHnoiNdcBGekIxWarrI9eEZuBDC/7mxGP1/VRd6
         MYBfD7e3VLCd3n314iD+MfIB9+YG/zq1iZ71Q=
Received: by 10.231.123.41 with SMTP id n41mr2117952ibr.46.1261161045920; Fri, 
	18 Dec 2009 10:30:45 -0800 (PST)
In-Reply-To: <20091218181613.GA10687@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135426>

> To prevent this in the future, you can force a server to check during
> push by enabling receive.fsckObjects in the server repository's
> configuration file. =C2=A0A broken EGit client will have the push
> rejected immediately.
>
> --
> Shawn.
>

Thank you for prompt answer, Shawn!

The problem is that as i'm maintaining multiple repos and their
quantity will grow i would need to apply this setting site wide. Do
you know if i can specify this service for git daemon? It seems like
in git deamon docs this service is not listed, but just in case the
docs are not up to date... I really don't want to set this up for
every repo manually...

Thanks,
Eugene
