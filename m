From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 3/3] git-remote-ext
Date: Thu, 30 Sep 2010 19:30:22 -0500
Message-ID: <20101001003022.GA16234@burratino>
References: <1285847579-21954-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1285847579-21954-4-git-send-email-ilari.liusvaara@elisanet.fi>
 <20100930134552.GF4850@burratino>
 <7vfwwrhud1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 01 02:33:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1TZJ-0003qA-8u
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 02:33:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753849Ab0JAAdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Sep 2010 20:33:37 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:59968 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752743Ab0JAAdg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 20:33:36 -0400
Received: by qyk9 with SMTP id 9so83316qyk.19
        for <git@vger.kernel.org>; Thu, 30 Sep 2010 17:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=P6zpv+QcR4A5zPAD+FAZSytB7T+OYC4YF/pYPaWaS98=;
        b=IaP6YGoi+dHWi7MAOIVlmjst52/cZETumtsCDsPC3xpEH+sRU00WnxHnro3pr+srlR
         Mhaor8X3WZl3xBedOKHgd7K0/yLRVkPGa+xziN9+1QP2LtTDF9x5200jFhxXJLNuH3SK
         Mz6mcst0BedOJfmRQ2YkY16n+xohwr/CCfh2g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=kECPySwj4T6KNkN0s6sJ9/a42qtgVCnO46iCmmVad+I0NZNEiPytzG9Fz5sziKFiL3
         aZ1C6I5/B0iw3qBu7whgb+pxYaGcbaFgAFj2rOCNfyS73QzGvs0KDmRPRGsfiNlHUuvl
         xtl93o1DYtY70csTdTQTTWd7kW7wWLK8GiFW4=
Received: by 10.220.87.70 with SMTP id v6mr1199222vcl.86.1285893215252;
        Thu, 30 Sep 2010 17:33:35 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id l9sm536257vbp.11.2010.09.30.17.33.33
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 30 Sep 2010 17:33:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vfwwrhud1.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157723>

Junio C Hamano wrote:

> Is it just me who finds the placeholders with backslashes somewhat out of
> place where most other placeholders in git are per-cent prefixed?

"\ " and "\\" seemed sane to me but the other ones left me more
puzzled.

It would be nicer when reading the code if it used strbuf_expand(),
too.
