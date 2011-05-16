From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Bikeshedding advice on the ab/i18n-scripts series
Date: Mon, 16 May 2011 16:26:41 -0500
Message-ID: <20110516212641.GB15150@elie>
References: <BANLkTi==pxyy7OeZT0mn33iJHrc5R7vHBw@mail.gmail.com>
 <7vboz2l6h1.fsf@alter.siamese.dyndns.org>
 <7v62pal5v7.fsf@alter.siamese.dyndns.org>
 <BANLkTimuA6-jLAUAMuhVf6FfJ2eNp8ROZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Erik Faye-Lund <kusmabite@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 16 23:26:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QM5JV-000559-CL
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 23:26:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756076Ab1EPV0s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 May 2011 17:26:48 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40723 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754716Ab1EPV0r convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 May 2011 17:26:47 -0400
Received: by iwn34 with SMTP id 34so4281678iwn.19
        for <git@vger.kernel.org>; Mon, 16 May 2011 14:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=7S2pyc+6VyAuJKs8vnhJfPmZY5QpKRi/ZPdyIe49lJQ=;
        b=iHo+DV0qGfIB7fXyPuXT1Suvlv29hHWC8dp6k2V8sCCG2CzvWloMXf8UL4JYcLhssu
         eRl8upycxFiFG/uunO+kFztiqyETtDbOK7qk7YZ4xuNMwLI0tyCu5roCD8nlTr9rq2IL
         Y8zNgaEDVM3RYq2ComvxXdJfgzJR6lls4y1Vs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=g1fViadB6UJJFKe6jctqGKlpyKQIgC/G34xyZDiadn5jygQssCP+AAXgcFSa4YbJ/v
         Qi4oBsK5GnruujC3+bvsJb/gW8f+DC5FkXUfbmMx+8sk9pzSqey4g6IugKpBK3o85lKC
         WsdnCwLsWK7wo45hK8XGrNTO9XGLvDKr0IQaY=
Received: by 10.42.196.67 with SMTP id ef3mr1338005icb.506.1305581207162;
        Mon, 16 May 2011 14:26:47 -0700 (PDT)
Received: from elie (adsl-69-209-63-133.dsl.chcgil.ameritech.net [69.209.63.133])
        by mx.google.com with ESMTPS id i3sm2351694iby.57.2011.05.16.14.26.45
        (version=SSLv3 cipher=OTHER);
        Mon, 16 May 2011 14:26:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTimuA6-jLAUAMuhVf6FfJ2eNp8ROZw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173763>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> That would require us to start extracting strings from all "say"
> functions. The reason we have only "gettext" and "eval_gettext" is so
> xgettext can extract them.

Isn't that what the xgettext -k parameter is for?
