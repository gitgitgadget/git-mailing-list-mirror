From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] git-gui: suggest gc only when counting at least 2
	objects
Date: Sun, 13 Sep 2009 20:41:50 +0200
Message-ID: <20090913184150.GA19209@localhost>
References: <20090909195158.GA12968@localhost> <20090913160637.GA15256@localhost> <7vr5uasp4a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 13 20:42:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mmu1T-0002Pl-HO
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 20:42:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752624AbZIMSlz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 14:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752452AbZIMSly
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 14:41:54 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:44746 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752197AbZIMSly (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 14:41:54 -0400
Received: by bwz19 with SMTP id 19so1681163bwz.37
        for <git@vger.kernel.org>; Sun, 13 Sep 2009 11:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:bcc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=1dQm3WwGUHeLhCwjWXOx8O1BzvvvIH2dwiVHKcRAXaU=;
        b=Q6Jbwa4SeRtgIvXQS31JZSq4I0kP5SLJmwloK2MLyW5EsTpSiR+3TryGhsFql0GNP/
         2CVadVwsCoWEyVPRKIPPpoYeF52LjM8vb19Elkf3+Ups2OpJBuS2rICyYxP6IrwKOaq2
         uboDJfP+YvuYqZpThb90jv1ZYls1fVA/HFsfM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=VY2XB0xXnxoDY6U/zld8QCmbtn7s6BYfJ9ssv20vZg6RijjNS6SkFBCPuR/YjPp4A4
         bvcUDjMAGWDSPrhCpTpup0SnEfXh5uTi70HnoonnXWhKrXEftl8vOwtEkDNE0p4qH2Qv
         En0EEoLCfuo8WkJzfQXts7lS712sFEHXUp6ik=
Received: by 10.204.34.71 with SMTP id k7mr4313836bkd.206.1252867316723;
        Sun, 13 Sep 2009 11:41:56 -0700 (PDT)
Received: from darc.lan (p549A51F1.dip.t-dialin.net [84.154.81.241])
        by mx.google.com with ESMTPS id 17sm6708655bwz.57.2009.09.13.11.41.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 13 Sep 2009 11:41:55 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1Mmu1G-0006ks-WF; Sun, 13 Sep 2009 20:41:51 +0200
Content-Disposition: inline
In-Reply-To: <7vr5uasp4a.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128382>

On Sun, Sep 13, 2009 at 10:58:45AM -0700, Junio C Hamano wrote:
> Somebody cares to explain why this threashold number has to be different
> per platform in the first place? 

I really don't know. I vaguely remember someone claim that performance on
Windows suffered from many loose objects more than on other platforms. I
can't find any discussion of it though.
