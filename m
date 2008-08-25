From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v5] gitweb: ref markers link to named shortlogs
Date: Mon, 25 Aug 2008 20:42:24 +0200
Message-ID: <200808252042.29171.jnareb@gmail.com>
References: <200808221501.54908.jnareb@gmail.com> <200808250444.23305.jnareb@gmail.com> <7vvdxpivig.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 20:43:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXh2Z-0003Le-GY
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 20:43:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754096AbYHYSmn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 14:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754070AbYHYSmm
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 14:42:42 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:6567 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769AbYHYSmm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 14:42:42 -0400
Received: by nf-out-0910.google.com with SMTP id d3so793649nfc.21
        for <git@vger.kernel.org>; Mon, 25 Aug 2008 11:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=IlCZZoyXtspJzDBi2kYwRoNHi7dXI1SBp697Uu/QPpM=;
        b=iIGcgrAciezxj4jS027Cg+vPYVLbqgy2s/onSLNx1bcFw75Z89bNMTlWJZrFI82CFK
         8IEKrssXp+n389EOJH80cn4qhsBsqSpnsQ/bnTMWWBVxYpt2b/QDZ/cD2WwMcPLmLbBO
         pFeQOEdOyf5eCJ26PSE9qDckl18UsIHIqA1NI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=DRBH0WIdeUWIXtWsQ5Nj19K6Ox8ZlzBhm7dgv0ZPEByeAQIvp5g3PeYgJ2A/zNpu7u
         IMOmbGs3w2dSPSuIIFCW1KwxumaTqpudy7IpZLZQ4M6/LvROPBVi/yBuWLXLxeGXDUwm
         HdyLF8m3/kPjWctmdfI3xKoed0kAQu7ruy+iA=
Received: by 10.210.76.12 with SMTP id y12mr7014581eba.151.1219689756272;
        Mon, 25 Aug 2008 11:42:36 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.216.72])
        by mx.google.com with ESMTPS id z34sm4453139ikz.9.2008.08.25.11.42.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 Aug 2008 11:42:34 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vvdxpivig.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93654>

On Mon, 25 Aug 2008, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > +                     $markers .= " <span class=\"$class\" title=\"$ref\">" .
> > +                             $cgi->a({-href => href(action=>( $indirect ? "tag" : "shortlog"),
> > +                                                    hash=>"refs/$ref")}, $name) .
> > +                             "</span>";
> >
> > or equivalent (not stripping "refs/" in git_get_references).
> 
> If you mean by "hash => $it", I think it is only used as the URL the
> anchor points at, and it is much more preferable to use the canonical
> form.  "...?h=refs/heads/master" and "...h=heads/master" might produce the
> same output, but then it is better for smart caching layer if you always
> used canonical form, isn't it?

Will you do the change, or do you need resend from Giuseppe?

I like the feature that this patch introduces, and this time I don't
have any reservations to the code. So, FWIW, Ack from me.

-- 
Jakub Narebski
Poland
