From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [WIP PATCH 1/7] Add skeleton RA svnclient
Date: Fri, 25 Jun 2010 08:34:56 -0500
Message-ID: <20100625133456.GA1495@burratino>
References: <1277310140-16891-1-git-send-email-artagnon@gmail.com>
 <1277310140-16891-2-git-send-email-artagnon@gmail.com>
 <20100625001427.GA4683@burratino>
 <alpine.561.2.00.1006251156180.2064@daniel2.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Daniel Shahaf <daniel@shahaf.name>
X-From: git-owner@vger.kernel.org Fri Jun 25 15:35:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OS93s-0004U4-MK
	for gcvg-git-2@lo.gmane.org; Fri, 25 Jun 2010 15:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756174Ab0FYNfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jun 2010 09:35:10 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61361 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755863Ab0FYNfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jun 2010 09:35:09 -0400
Received: by iwn41 with SMTP id 41so2003580iwn.19
        for <git@vger.kernel.org>; Fri, 25 Jun 2010 06:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=bOGeFWMFDcK5Yq0B5m6kk8ACdAYS7DVD2LhbKfcsuDw=;
        b=mKWgRSuHn/KYpOxrCA2fj26h3b9sxb804agd49bBsq++Yf3n6+jjE/E/hdTCFlDTRT
         fxT+ACIvxE1gvl5jCg3MedU9sWAiL19Vm2o7E0Kbv93g4IlxcS6U4kvdKhLWOhU2ZF4z
         DCmfyuimy6Scc+ucHlf3vWspFsbVlb42gF0A0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=UuAhnygiJ/WmVtE4h0GpZ+1bv9MIBBLMwWIdXbMi80BbisArs7RAsVNmqweWy39d7Y
         EOmJs5scMUXd+NKJGz5MbG55u9hzR3yvTuBEqywp0BVlOrto2CQrYoE1N6L3DStWfwh8
         3CHj7AZLvRkAN8bdI4L/96CN9Aj7wBZyGF3NQ=
Received: by 10.231.152.71 with SMTP id f7mr729957ibw.128.1277472908217;
        Fri, 25 Jun 2010 06:35:08 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id v23sm708605ibp.9.2010.06.25.06.35.07
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 25 Jun 2010 06:35:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.561.2.00.1006251156180.2064@daniel2.local>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149683>

Daniel Shahaf wrote:

> I don't understand.  It seems that the fields here appear in the same
> order as in the definition of struct svn_delta_editor_t.

Embarrassingly, I was just confused.  Thanks for the answers!

Jonathan
