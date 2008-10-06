From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv4] gitweb: generate parent..current URLs
Date: Mon, 6 Oct 2008 02:17:34 +0200
Message-ID: <200810060217.36233.jnareb@gmail.com>
References: <1222906234-8182-1-git-send-email-giuseppe.bilotta@gmail.com> <1222906234-8182-6-git-send-email-giuseppe.bilotta@gmail.com> <1222906234-8182-7-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 06 02:18:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmdoJ-0002lb-Or
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 02:18:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbYJFARk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Oct 2008 20:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbYJFARk
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 20:17:40 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:9002 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214AbYJFARj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Oct 2008 20:17:39 -0400
Received: by ey-out-2122.google.com with SMTP id 6so764079eyi.37
        for <git@vger.kernel.org>; Sun, 05 Oct 2008 17:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=NmRpvLPVlIXSEA6s0rr+/fsWY4A7stV9AtbN+xBfaQs=;
        b=hzFj0REA28bG3qE6hMxyl1kW0KQZKcv+V5jS2/VRC796SbjbeJBFPk1GPCyB6qqVVj
         /YYHG0d4Gkm7MTxuhjXRJ8YlUsJGTmzN/nMVeIfItNXdS4jjV+2TZ86FyC0L35eL5l2Z
         IG12kkHOA7kv+a3PE6+V1L1CnS5e/kkVgnXfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=RzZg8qydGdaQATVC8qgFNcOY9VDDHmBMSToaDSN8yUuCP9luX5009PnTcDvx/nG9qo
         UknhZZq43BudyyxF9ZxEvyeypAEP7TuLpbADyZTYInbjG5s5bHGxRCnj/PD/0kgDfh2D
         sOsqxH5NpgIF6jYcz6XEW4naCrB7lXYjt2IsQ=
Received: by 10.210.23.3 with SMTP id 3mr5440862ebw.54.1223252258140;
        Sun, 05 Oct 2008 17:17:38 -0700 (PDT)
Received: from ?192.168.1.11? (abwo50.neoplus.adsl.tpnet.pl [83.8.238.50])
        by mx.google.com with ESMTPS id u7sm11147469uge.40.2008.10.05.17.17.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 05 Oct 2008 17:17:36 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1222906234-8182-7-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97555>

On Thu, 2 Oct 2008, Giuseppe Bilotta wrote:

> If use_pathinfo is enabled, href now creates links that contain paths in
> the form $project/$action/oldhash:/oldname..newhash:/newname for actions
> that use hash_parent etc.
[cut]

>From the first glance, it looks good. I just worry a bit about
complicated issue of hash_parent vs hash_parent_base etc.

-- 
Jakub Narebski
Poland
