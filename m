From: Eric Raible <raible@gmail.com>
Subject: Re: RFH - git-log variant that _does_ search through diffs
Date: Tue, 30 Jun 2009 11:06:50 -0700
Message-ID: <279b37b20906301106h4ccbeaa5l621e427981e5c483@mail.gmail.com>
References: <279b37b20906291708g67da3a75p316ea4893f02666a@mail.gmail.com>
	 <20090630040337.GA23741@sigio.peff.net>
	 <7vd48m9m8i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 20:07:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLhjS-0006lF-1q
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 20:07:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753346AbZF3SGv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Jun 2009 14:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752938AbZF3SGu
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 14:06:50 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:45159 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752612AbZF3SGt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Jun 2009 14:06:49 -0400
Received: by qw-out-2122.google.com with SMTP id 9so146818qwb.37
        for <git@vger.kernel.org>; Tue, 30 Jun 2009 11:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xN7C+trx7qfR2LfBrGKVMTBNqiOms0zz+5KdNdnAbDI=;
        b=kLCpQySlMPd6q6SICfJ6G1DOHxWrNHuw2mrx45B0sdWvPZcIxz5WelxmhCq+qn5N0a
         EdGT2vsr/ALgq/efmJ+/PiV03CSGECXYZckFD/fiTYLxfvlEqJshBlBNpPOJNlyPz1V7
         Hd3xCG79iHxRoIccw8r2v6hnTSKliWcpdvcNY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VHugc8GGPGdxCmrOS5k8B9XaspbclXX1SnbY67DFPYq4vrd/9Yhf3FdtVrrj2XNA0k
         kFTzHeBRPR2ZoWOpIqHRQvCuFzKuiDCIkdAdflzmAxEcBt6qG4MAT7u3WR/ZhuzWFL6e
         BBVugqY7UhLTepIQQlfqsnLbsItKEKFAukIbU=
Received: by 10.220.85.83 with SMTP id n19mr6869320vcl.33.1246385210097; Tue, 
	30 Jun 2009 11:06:50 -0700 (PDT)
In-Reply-To: <7vd48m9m8i.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122526>

On Tue, Jun 30, 2009 at 1:09 AM, Junio C Hamano<gitster@pobox.com> wrot=
e:
>
> Specifically:
>
> =A0 =A0http://thread.gmane.org/gmane.comp.version-control.git/112077/=
focus=3D112114
>
> and its cousin
>
> =A0 =A0http://article.gmane.org/gmane.comp.version-control.git/112141

Thanks - that's exactly what I was looking for but didn't find.
