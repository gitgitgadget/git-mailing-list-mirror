From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v8] Detection of directory renames
Date: Thu, 28 Oct 2010 20:05:04 -0500
Message-ID: <20101029010504.GA28984@burratino>
References: <1288303712-14662-1-git-send-email-ydirson@altern.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Fri Oct 29 03:05:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBdPI-0004gM-Su
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 03:05:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756359Ab0J2BFQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 21:05:16 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:34972 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755196Ab0J2BFO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 21:05:14 -0400
Received: by qyk10 with SMTP id 10so2787500qyk.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 18:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=swXZnGsev7vs05BBzHWP4/ILE2zHTQhFD08WxGiHTcg=;
        b=RfgUR7h8Aic8URNHfPuV13haHfsX76d6rElZ8CfUTWUmpMm8i8DBcAC1ClmmY0upib
         Hnu+eBSX73UlDGxLzfwCKOPSafRRD0nZJM2gafLSa6chimt1Z0q/XTX6elasXk5H/3mN
         G5VKXBep0du8rKjUZEEEsfpub55lFB0VsO5Lg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=lnv4ksWuzHp16tUyKoH7wgqdh/vn9OeFIDf/msEJO1mMOVMgHUqKxVsk1WYDmR3mSe
         fM4kGAAB2UflW/vMmyqYPy3eShOKkn0VOsU9tTT3ixG3hTpkjkg2f1arcT6FXwLLMIOn
         wYyvyZWkobmC40yO5It9AsskgYD0KFFoFoCjg=
Received: by 10.229.219.136 with SMTP id hu8mr6737386qcb.171.1288314313373;
        Thu, 28 Oct 2010 18:05:13 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id s28sm1677692qcp.33.2010.10.28.18.05.10
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 18:05:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1288303712-14662-1-git-send-email-ydirson@altern.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160258>

Yann Dirson wrote:

> Changes since v7:

More history for new readers:

 - v7: http://thread.gmane.org/gmane.comp.version-control.git/159825
 - v6: http://thread.gmane.org/gmane.comp.version-control.git/159081
 - v5: http://thread.gmane.org/gmane.comp.version-control.git/158623
 - v1-4: http://thread.gmane.org/gmane.comp.version-control.git/157917/focus=157981
