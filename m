From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2 0/8] gitweb: Faster and improved project search
Date: Wed, 22 Feb 2012 23:09:58 +0100
Message-ID: <201202222309.58678.jnareb@gmail.com>
References: <1329338332-30358-1-git-send-email-jnareb@gmail.com> <7v4numnfqq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 22 23:10:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0KO2-0005kB-Dg
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 23:10:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755729Ab2BVWKD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 17:10:03 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:34170 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755399Ab2BVWKC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 17:10:02 -0500
Received: by eaah12 with SMTP id h12so257370eaa.19
        for <git@vger.kernel.org>; Wed, 22 Feb 2012 14:10:01 -0800 (PST)
Received-SPF: pass (google.com: domain of jnareb@gmail.com designates 10.14.100.80 as permitted sender) client-ip=10.14.100.80;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jnareb@gmail.com designates 10.14.100.80 as permitted sender) smtp.mail=jnareb@gmail.com; dkim=pass header.i=jnareb@gmail.com
Received: from mr.google.com ([10.14.100.80])
        by 10.14.100.80 with SMTP id y56mr16675740eef.68.1329948601085 (num_hops = 1);
        Wed, 22 Feb 2012 14:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=8wlum3PALMUWMONCkSKdQ1Q+u8SIA/SyOFGeSCLTl0g=;
        b=TQP0Qx4uUR0wbS/lJWLc9h4A/LJIF88iPuGbukHRCW3VTLZwaTnYKVPHf5UpkAcaHM
         cnGdbwsi2rnuSstVh8eARAdLe29EA+jO0NOTWC7ogQ+80s+km3ajonSvDjo4fP6/0Noj
         GeXHGWE7g8POyxayPcEXQfp0CHDbivrAkEipw=
Received: by 10.14.100.80 with SMTP id y56mr13361882eef.68.1329948600929;
        Wed, 22 Feb 2012 14:10:00 -0800 (PST)
Received: from [192.168.1.13] (abvp35.neoplus.adsl.tpnet.pl. [83.8.213.35])
        by mx.google.com with ESMTPS id u9sm90255443eem.11.2012.02.22.14.09.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 22 Feb 2012 14:10:00 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7v4numnfqq.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191295>

On Mon, 20 Feb 2012, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > [Cc-ing Junio because of his involvement in discussion about first
> >  patch in previous version of this series.]
> >
> > First three patches in this series are mainly about speeding up
> > project search (and perhaps in the future also project pagination).
> > Well, first one is unification, refactoring and future-proofing.
> > The second and third patch could be squashed together; second adds
> > @fill_only, but third actually uses it.
> 
> I'll queue these three separately to a topic jn/gitweb-search-optim,
> and fork another topic jn/gitweb-hilite-regions from there.  I haven't
> looked the latter closely, though.

O.K., when rerolling the series I will resend those in separate patch
series: one for performance improvements for project search (less calls
to git commands), one for match highlighting in project search ('grep',
'commit' and other per-project searches already highlight their matches,
though in suboptimal way), and perhaps one for using esc_html_match_hl()
thorough gitweb,... though with only one patch in this series for now
perhaps it be better joined with match highlighting for project search.

-- 
Jakub Narebski
Poland
