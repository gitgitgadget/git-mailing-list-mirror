From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCHv5 00/14] git notes
Date: Tue, 8 Sep 2009 23:36:36 +0200
Message-ID: <fabb9a1e0909081436x72c71b0bv51d8f198cd82f289@mail.gmail.com>
References: <1252376822-6138-1-git-send-email-johan@herland.net> 
	<200909080512.34634.johan@herland.net> <7vd462qdeg.fsf@alter.siamese.dyndns.org> 
	<200909081054.02523.johan@herland.net> <alpine.DEB.1.00.0909081100020.4330@intel-tinevez-2-302> 
	<7vocplxjov.fsf@alter.siamese.dyndns.org> <20090908211046.GV1033@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Sep 08 23:37:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ml8ND-0007c1-Is
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 23:37:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751864AbZIHVgz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 17:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751528AbZIHVgz
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 17:36:55 -0400
Received: from mail-ew0-f227.google.com ([209.85.219.227]:32995 "EHLO
	mail-ew0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284AbZIHVgy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 17:36:54 -0400
Received: by ewy27 with SMTP id 27so4071888ewy.40
        for <git@vger.kernel.org>; Tue, 08 Sep 2009 14:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=H0Ma0fatHzAaS5Okb9XfaErff0b0D+4Y4a6i5Qm8ElM=;
        b=W8UQ0peb2rm4Ok4tDxU/T8EPqWfZ/57VvY44YZE/tz2qJ2VCfmUlDAdtiNGUgRWnml
         1adElM6iZj3O9MOLWjgRVDN9R/LN2a+cv/JotXyA/4J26px0goQWZjedfZIAZG2x8668
         iwD2uBbYML3VjcXTa4Fgt4oLVWjko1j+5Jggc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ovr4Vc34yxm5PFQohDAVT+PYWHqQmXe+VjKnNwqQdT2rqxY6O5r84LodF/7d4bHypl
         87xFsaP7kVNIMOEiz8QSR05rJnoYDqlvCFLDueEEJ1l91YAHpb2ZpPoh0xPiZZq4F5CN
         1kl4cWI5FOQ9sCANUFG37mNrIOSZejfwD3FcQ=
Received: by 10.216.45.78 with SMTP id o56mr3317862web.152.1252445816140; Tue, 
	08 Sep 2009 14:36:56 -0700 (PDT)
In-Reply-To: <20090908211046.GV1033@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128039>

Heya,

On Tue, Sep 8, 2009 at 23:10, Shawn O. Pearce<spearce@spearce.org> wrote:
> So most commits (66%) would have only 1 version (and 1 note)
> related to them in the note tree, but if I use the same note tree
> for final commits as individual revisions considered, at least 18%
> of the commits in the final history of the project would actually
> have two notes, and 7.5% would have 3 notes.

You could however store all that information in one note, yes? Since
the 'latest version' is the one committed, you can include the notes
for all the previous ones at commit time?

-- 
Cheers,

Sverre Rabbelier
