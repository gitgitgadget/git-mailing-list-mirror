From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Archiving off old branches
Date: Wed, 23 Apr 2014 10:58:20 -0700
Message-ID: <20140423175820.GE15516@google.com>
References: <20140423120850.3f6fb535@bigbox.christie.dr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tim Chase <git@tim.thechases.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 19:58:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd1RF-0000Li-Ab
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 19:58:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754743AbaDWR6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 13:58:25 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:61512 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753564AbaDWR6X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 13:58:23 -0400
Received: by mail-pd0-f169.google.com with SMTP id y13so82068pdi.0
        for <git@vger.kernel.org>; Wed, 23 Apr 2014 10:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=tus8WlkXHj9gsnURVsxfOBM9mioJ2lvDBRStHPDSnS4=;
        b=I+u+U21mwoySf3Pj6ZMCTm2IPICU38ySXYBqSgEEbR/So3MM3Ov4fsg1AW7/zlKG2R
         VXy+frGpehPODZaIFlVVa5pXoaqqjieWWKsTh8vRh8r0pGH199ZyJgA0VDPKUXEU9mdA
         00iF+bIFM1wmQRO6dYB/WLEBH+LOYycTcpHUhMkVQny+5FyJVmgjxHdBkeS2wnUh6Ktw
         gADQ8rBSrgY7wxp5gJZVTbhPi3ZjrrGYF2i29O657gsI8D24Fs3RXnTZohmjOWRRo8A3
         Tk/ipePBUPUCNTmpntEHSVP0e60Qat6t6zr7Kk8ZbirvIKLDqJbCx9ecrhYrkBMb7r7Z
         JhNA==
X-Received: by 10.68.226.197 with SMTP id ru5mr57668492pbc.77.1398275902980;
        Wed, 23 Apr 2014 10:58:22 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id su8sm3814946pbc.72.2014.04.23.10.58.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 23 Apr 2014 10:58:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140423120850.3f6fb535@bigbox.christie.dr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246860>

Hi,

Tim Chase wrote:

>   cd .git/refs
>   mkdir -p closed
>   mv heads/BUG-123 closed

That breaks with packed refs (see git-pack-refs(1)), which are a normal
thing to encounter after garbage collection.

Hope that helps,
Jonathan
