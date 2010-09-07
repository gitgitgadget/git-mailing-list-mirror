From: Marcus Comstedt <marcus@mc.pp.se>
Subject: Re: Fix for normalization of foreign idents
Date: Tue, 07 Sep 2010 21:37:10 +0200
Message-ID: <yf9sk1l73bt.fsf@chiyo.mc.pp.se>
References: <1282599032-11369-1-git-send-email-marcus@mc.pp.se>
	<20100823213531.GD2120@burratino> <yf97hjhrol5.fsf@chiyo.mc.pp.se>
	<yf9vd6j5hti.fsf@mc.pp.se> <20100906210719.GD26371@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 07 21:37:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ot3ys-0006JH-SS
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 21:37:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434Ab0IGThR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Sep 2010 15:37:17 -0400
Received: from ua-85-227-1-6.cust.bredbandsbolaget.se ([85.227.1.6]:53894 "EHLO
	bahamut.mc.pp.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932090Ab0IGThQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 15:37:16 -0400
Received: from chiyo.mc.pp.se (chiyo [192.168.42.32])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bahamut.mc.pp.se (Postfix) with ESMTPS id 0272DFAF4;
	Tue,  7 Sep 2010 21:37:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mc.pp.se; s=hedgehog;
	t=1283888233; bh=VcAX/IOyF5CpCrmBSDF4oU7gupo7cjNq7JoS7cb0e6o=;
	h=To:Cc:Subject:References:From:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=OwQFjj2tefEq5AMuM5PcXFE9VTWjqwmc8ALVA
	mJ7VsagCSmY1yx77HALcQXebZKpRHYWbYkJaPTSnQgMekkMfhplEgq3aSfpSmVJygaM
	2lfdqsTRitk94INggZ+LVtZbR+Oqpo0RKw+uDay8f5IKoE/mjIv/DEwqbrPBPDfDB+4
	=
Received: from marcus by chiyo.mc.pp.se with local (Exim 4.71)
	(envelope-from <marcus@mc.pp.se>)
	id 1Ot3yh-00028f-NS; Tue, 07 Sep 2010 21:37:11 +0200
In-Reply-To: <20100906210719.GD26371@burratino> (Jonathan Nieder's message of "Mon, 6 Sep 2010 16:07:19 -0500")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) XEmacs/21.4.22 (linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155734>


Jonathan Nieder <jrnieder@gmail.com> writes:

> If you have the time, a test and documentation might help (the former
> plays the role of an artificial user, who can describe the feature and
> will make noise if we break it with future changes).

Ok.  I'll shortly post an updated patch with some test cases.

As for documentation, I suppose that would mean documenting the
"foreign ident" concept as a whole, as I don't think there's currently
anything about that in the documentation?  Would the `ident` section
of gitattributes.txt be a suitable place for this?


Thanks


  // Marcus
