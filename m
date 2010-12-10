From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] simplify inclusion of pthread.h
Date: Fri, 10 Dec 2010 13:51:28 -0600
Message-ID: <20101210195128.GD6801@burratino>
References: <20101210114839.GA5771@burratino>
 <7vhbeleber.fsf@alter.siamese.dyndns.org>
 <20101210194637.GA6801@burratino>
 <20101210194754.GB6801@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 10 20:51:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PR90W-0006xv-0r
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 20:51:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756911Ab0LJTvs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 14:51:48 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:63274 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756066Ab0LJTvr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 14:51:47 -0500
Received: by qwa26 with SMTP id 26so4228756qwa.19
        for <git@vger.kernel.org>; Fri, 10 Dec 2010 11:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=evVcELijD6K7c8RuRy8yyrOMaii7CZQkQFdroMMfaYw=;
        b=hAdgyBIBA+pKavaYvUsXj8sXhorPC6pgPOSNfAuEVx2PBojHf0BI+zCg2a71uPZz49
         LReOMgusvBHlGiWAFQDQadPjfIXlBmBZZDNtkqfPdUJHhaj8ol7729l+kg9AtIxjvJR4
         QVZiZviE1ljj98dzy+Asp04NLOd5c4FEQYFa8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=KeDKcKooc/Esrrhsr1ZzeiSJb0n5x50AOKe0t4xuhgLjhjgbAr90ucm4x6MMWYgg8h
         uyYa5yxsSf9t6j5ZGaO5M7/t7VQiqFRbhN6x6+ytKDvu1auKwLM+oERbf0+J5qjyAz+N
         v0zFxieSHot5WON+7OEaugf1CScrM2V3ma2W8=
Received: by 10.229.88.207 with SMTP id b15mr937789qcm.187.1292010706484;
        Fri, 10 Dec 2010 11:51:46 -0800 (PST)
Received: from burratino (adsl-69-209-58-175.dsl.chcgil.ameritech.net [69.209.58.175])
        by mx.google.com with ESMTPS id t35sm2196414qco.18.2010.12.10.11.51.44
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 10 Dec 2010 11:51:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101210194754.GB6801@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163436>

Jonathan Nieder wrote:

> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

This one is of course

	From: Junio C Hamano <gitster@pobox.com>

Often enough I remind myself to include the pseudo-header but when the
rapid cutting-and-pasting time comes it is easy to forget. :/
