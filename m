From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] merge-recursive: option to specify rename threshold
Date: Mon, 27 Sep 2010 19:08:37 -0500
Message-ID: <20100928000837.GH11957@burratino>
References: <A0604F16-CA84-4A84-B74B-CE8AB455DF77@sb.org>
 <1285202724-52474-1-git-send-email-kevin@sb.org>
 <7vk4m7n7uo.fsf@alter.siamese.dyndns.org>
 <D5046A0E-7A35-421D-856F-5278FBE02914@sb.org>
 <7vocbj3gjk.fsf@alter.siamese.dyndns.org>
 <FFDB2371-6C96-472C-A650-412546636450@sb.org>
 <20100927235355.GG11957@burratino>
 <385B97D7-03F5-4698-A659-15D5D1FA939B@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Tue Sep 28 02:11:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0NnQ-00062K-LQ
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 02:11:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759805Ab0I1ALn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Sep 2010 20:11:43 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:61851 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754256Ab0I1ALm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Sep 2010 20:11:42 -0400
Received: by qwh6 with SMTP id 6so3714250qwh.19
        for <git@vger.kernel.org>; Mon, 27 Sep 2010 17:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=sqc4FYQVDFPnIkoNyk9oZFq/1WtmsxgX05oC4WxBmHc=;
        b=LtQpMoILICudMN8cGH+aiEdO7EKfHuDjGREnCthRtSodrzOC/fLVMpi9nJy/hiOZ1a
         1+/vnjgOtVSDi+QfurP5h937J45+pgnGR39yvkdE0d5tojqGKG/pIbBHk1VgZXT2j+gW
         nFQkg9KQMLSErHPsOpEL/uWDwvneCEvUp+DLY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=bSlwRkfXBnORJi0h24sWHeYiiGeeo493EQLw5RVw/OpQrIdX+UjXSgDC0kicnsXXlh
         5NLMu/73b2EMSMZHLfwGOTG92Pn3fWiR+JxKO/8ryPE8jM1M0TNTFGfQAjPF2PUPJ4jK
         MKSqjQCa47M32Dg7XqiOqb1GmTR49Hhe138RM=
Received: by 10.229.51.214 with SMTP id e22mr6115967qcg.233.1285632700781;
        Mon, 27 Sep 2010 17:11:40 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id r36sm7276687qcs.15.2010.09.27.17.11.39
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 27 Sep 2010 17:11:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <385B97D7-03F5-4698-A659-15D5D1FA939B@sb.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157380>

Kevin Ballard wrote:

> Good timing, I just sent out a patch that does almost exactly this,
> though I went with --break-rewrites instead of --detect-rewrites.

Both new patches look good to me, for what it's worth (though it
would be nicer to have tests, of course :)).
