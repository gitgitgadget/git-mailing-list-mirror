From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 0/3] apply: handle traditional patches with space in
 filename
Date: Fri, 20 Aug 2010 01:26:57 -0500
Message-ID: <20100820062657.GA24678@burratino>
References: <7vlj8cvi2e.fsf@alter.siamese.dyndns.org>
 <201008142037.50833.j6t@kdbg.org>
 <20100819014516.GA7175@burratino>
 <201008192156.08529.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Greg Brockman <gdb@mit.edu>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Elijah Newren <newren@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Aug 20 08:28:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmL5v-0004Mg-4t
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 08:28:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213Ab0HTG2q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 02:28:46 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:41788 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926Ab0HTG2p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 02:28:45 -0400
Received: by iwn5 with SMTP id 5so475172iwn.19
        for <git@vger.kernel.org>; Thu, 19 Aug 2010 23:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=qdv0xBaWAULph7HS8DrbsGbUrOtZqwcK7ottjDy2r0c=;
        b=WV8Ti0gY1Bes3rWiE6j/iUc28+ivdzQ8JgRI7het6Fgj+52Lr3IkI+K3kQTwTjB+Pl
         I+fxqjzDzmV7tEROFRme8DiTBoV/o8O58Dfq27cNh/GfRc622e9mgpGP5xyRatsB/0qF
         eWXdkVLef38LNPiwvLMlejENEA381Ldoqe9RE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=TFwNDgWGgwqUE0BA+P+9ELCvzZCdLw8zzur14kqAJcrixRmOBv4CY8TigLYg6ae/d1
         RIMyqjaH3b1u246tOUPknekTNNIwnknfDv2MRyDGl6rRFhXboGi4d75GWCTwfeOCOPGV
         r7bPo6uEI4PB+5ZFBlNg20tulLHpsa/MVc6RE=
Received: by 10.231.79.213 with SMTP id q21mr1022083ibk.137.1282285724617;
        Thu, 19 Aug 2010 23:28:44 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id r3sm2272185ibk.7.2010.08.19.23.28.43
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 19 Aug 2010 23:28:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201008192156.08529.j6t@kdbg.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153976>

Johannes Sixt wrote:

> The series passes the test suite on Windows.

That was fast.  Thanks for checking.
