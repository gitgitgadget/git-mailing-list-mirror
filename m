From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/4] fast-import: let importers retrieve blobs
Date: Fri, 3 Dec 2010 13:06:43 -0600
Message-ID: <20101203190643.GC14049@burratino>
References: <1287147256-9457-1-git-send-email-david.barr@cordelta.com>
 <20101128194131.GA19998@burratino>
 <20101128194501.GD19998@burratino>
 <201012031130.06008.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Dec 03 20:07:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POayG-0001t9-UE
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 20:07:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753937Ab0LCTHA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 14:07:00 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:38964 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753905Ab0LCTG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 14:06:59 -0500
Received: by vws16 with SMTP id 16so1926923vws.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 11:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=IgNhGbPvWYYdImnGgjn7LCwikFzQVOeE3F4ZAESpfCI=;
        b=JBk4epyoScXOctIZfns3/KtbcM0HL404j6hugElK3vjWqLnwNnWSYYeCO1cs01NgWc
         gcE2JzL77CH2EjPlvj7h9cNerqkUx5uX1XDurJ5Nc/T2oHuWDtf2f7VwlCWbYrxHUzcz
         cyFOEUq8Ve19vpgahWyhT86fb5Z2kqe1k0gqc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ofSwB91QKwzwnptMWo8Ogz0bhKPYBlzUAETcxrkmDym9k8KsUf68CJ9ESu5DZfSpAd
         Oi52Lbi0+45IoJ6EMv9gDKuWfMnYus77WFGD55neINhoFM+/Xv8zRplukq6noWj+yVTV
         0Dnw72IfXeGh5KEhC9jqYfjG79SkJTcOwhrOE=
Received: by 10.220.180.193 with SMTP id bv1mr513089vcb.12.1291403218525;
        Fri, 03 Dec 2010 11:06:58 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.sbcglobal.net [68.255.109.73])
        by mx.google.com with ESMTPS id e18sm366150vcf.36.2010.12.03.11.06.55
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 03 Dec 2010 11:06:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201012031130.06008.trast@student.ethz.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162828>

Thomas Rast wrote:

> In any case I cannot see a reason to use this construct: 'dd' reads
> from stdin by default, so you could just leave away the option.

Yes, sorry about that.  I had confused dd with 'tar' which defaults to
rmt0 on some systems.  Fixed locally.
