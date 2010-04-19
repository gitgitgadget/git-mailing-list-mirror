From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH v2 2/2] receive-pack: detect aliased updates which can 
	occur with symrefs
Date: Mon, 19 Apr 2010 12:31:44 -0400
Message-ID: <v2r76718491004190931rb9813deex2797a440d09b50a5@mail.gmail.com>
References: <1271694343-31876-1-git-send-email-jaysoffian@gmail.com>
	 <1271694343-31876-2-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jay Soffian <jaysoffian@gmail.com>,
	"Shawn O . Pearce" <spearce@spearce.org>,
	Junio C Hamano <junio@kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 19 18:31:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3tt5-0006mn-29
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 18:31:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755699Ab0DSQbr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 12:31:47 -0400
Received: from mail-iw0-f199.google.com ([209.85.223.199]:50256 "EHLO
	mail-iw0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755542Ab0DSQbp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 12:31:45 -0400
Received: by iwn37 with SMTP id 37so580628iwn.15
        for <git@vger.kernel.org>; Mon, 19 Apr 2010 09:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type;
        bh=+Y/ovn0cpdChIjkVFl1cEIZAHJdMsHMaZAyukyVZXus=;
        b=fIC5QEdOfhWmgu2N7npjzrAxlQXfF2ctSgC3H+Zh+oomf18bO0Ypy88Dgp2ZDPSFIH
         lZ92BZcp2be1CIBXNQRXruhLL5GQo1d0UactXVTKwBHPYnE143BtezVLJXUIjVnnhZKo
         efioJAPnkLe2/ZSOTKfj8q7AsGby6qpXxnFZk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=EXBJ9DjLp2L6O8fLvu+IGCC+4YCjm/ziyn/f7yGJPAM+jFvr78aPeLo8yw9jeVPQOk
         tazSEZJm47zQb4sV/OcHV4merN1KFTfi3ki5+hDgz12GSE7jpGqVgs1cDU2EmkSoOI3L
         Y26QfymhSMGkTLc5dYQGccQRSgBR/rB8OgYTM=
Received: by 10.231.36.9 with HTTP; Mon, 19 Apr 2010 09:31:44 -0700 (PDT)
In-Reply-To: <1271694343-31876-2-git-send-email-jaysoffian@gmail.com>
Received: by 10.231.154.68 with SMTP id n4mr1990982ibw.72.1271694704888; Mon, 
	19 Apr 2010 09:31:44 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145315>

On Mon, Apr 19, 2010 at 12:25 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
> When pushing to a remote repo the sending side filters out aliased
> updates (e.g., foo:baz bar:baz). However, it is not possible for the
> sender to know if two refs are aliased on the receiving side via
> symrefs. Here is one such scenario:

Don't receive this. There's a logic error in it. I'll send a follow up shortly.

j.
