From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] gitweb: Make feed entries point to commitdiff view
Date: Wed, 6 Feb 2008 22:22:37 +0100
Message-ID: <200802062222.38691.jnareb@gmail.com>
References: <1202038726-4221-1-git-send-email-jnareb@gmail.com> <7vd4r9vmnd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Florian La Roche <laroche@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 22:23:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMrjs-0007TE-IY
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 22:23:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756954AbYBFVWy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Feb 2008 16:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756902AbYBFVWx
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 16:22:53 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:29500 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756782AbYBFVWx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 16:22:53 -0500
Received: by ug-out-1314.google.com with SMTP id z38so530729ugc.16
        for <git@vger.kernel.org>; Wed, 06 Feb 2008 13:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=ehY1g4ImtHf/RmLkh0XlSJ2mF8q0ZyfUQfyKtGgfIQs=;
        b=J9iPVRs0uoGqEPcsBE6RCGZVe4ktvD/F9NhHUQr5km91rlFkLJSPYefib3ATThEQiDzMz2ZLzIlUeLk+g5Qz8Wq99bQVzCj8Q30xW5z5ve+47uT8A05ywQVInn20AaZrwHflyaB8fk2I600HjrTKh9yhDMbXXhqeAjX7xfsqITU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=UbuiMZitml79106UCFRYUC4rIFVen0FamHAyZO+nDgbanuxbO3FsrW6GqLt83HG4f1as2vlMY1mp4QOCi+uJsWHWpPfNEZ74xTNabv0fDCoaQy+ubd+9s7uWFMliUvOPx9E/3Pgcn5IfPVHGbvtbDQplgGOpuT+MFESIgE9QzXo=
Received: by 10.78.176.20 with SMTP id y20mr4945271hue.36.1202332971179;
        Wed, 06 Feb 2008 13:22:51 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.239.145])
        by mx.google.com with ESMTPS id y34sm8077110iky.6.2008.02.06.13.22.48
        (version=SSLv3 cipher=OTHER);
        Wed, 06 Feb 2008 13:22:49 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vd4r9vmnd.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72857>

Dnia =B6roda 6. lutego 2008 21:46, Junio C Hamano napisa=B3:
> Jakub Narebski <jnareb@gmail.com> writes:
>=20
> > I think that with the improved commit message the reason for this
> > change is more obvious, and it is a go.
>=20
> Thanks.  Looks good.

Errr... in the commit message

>> First, feed entries have whatchanged-like list of files which were
>> modified in a commit, so 'commitdiff' view more naturally reflects
>> feed entry (in more naturally alternate / extended version of a feed
>> item). Second, this way the patches are shown directly and code revi=
ew
>> is done more easily via watching feeds.

"... (in more naturally ..." should be "... (is more naturally ...".

Unfortunately this kind of errors are hard to catch (and spellchecker
would not help any)

--=20
Jakub Narebski
Poland
