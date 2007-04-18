From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH] Add "stg bury" command, with the functionnality of contrib/stg-sink.
Date: Wed, 18 Apr 2007 01:02:46 +0100
Message-ID: <b0943d9e0704171702j1bced65cja7a1f2e55a5b96d9@mail.gmail.com>
References: <20070410182701.9362.68038.stgit@gandelf.nowhere.earth>
	 <4625314E.2050103@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Yann Dirson" <ydirson@altern.org>, git@vger.kernel.org
To: "Sam Vilain" <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Apr 18 02:03:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdxdR-0001lD-KQ
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 02:02:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752784AbXDRACu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 20:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752906AbXDRACu
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 20:02:50 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:13287 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752784AbXDRACs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 20:02:48 -0400
Received: by ug-out-1314.google.com with SMTP id 44so296135uga
        for <git@vger.kernel.org>; Tue, 17 Apr 2007 17:02:47 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jUW3GrLFHA19ghSysmSChZs/1SwSraO02A2t2xnR6Fi+F5PK5yqzELuSfM934u5Lv5Z1mJwDLV68Th+fhFEA2OVsS5oCBoEFHHEhGtd/NhKVqxFpuNunx7Ie4fnliiv1hAAjPCiA2WBvOZwbRSEtQMwz5TlbMtsM9hqmwrhFY1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Sn1c04DASPkja7Ctsc1F+OYUtgvEFNPm3CZos2BLsOz1BCHdOXZanYd+dWiDhth6C2Cs+6p22s92WQoM8sRTqel/OyjjFpik1rtJ7QUuM1zzTAjkego7UcqTL7q3kB+LG48vv6ZMPy3lCXw9RIbx5U5snN7vXIEzYT5OI2uTdgQ=
Received: by 10.67.27.15 with SMTP id e15mr823858ugj.1176854566444;
        Tue, 17 Apr 2007 17:02:46 -0700 (PDT)
Received: by 10.66.255.4 with HTTP; Tue, 17 Apr 2007 17:02:46 -0700 (PDT)
In-Reply-To: <4625314E.2050103@vilain.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44844>

On 17/04/07, Sam Vilain <sam@vilain.net> wrote:
> Yann Dirson wrote:
> > This is the rewrite in python of by stg-sink written in perl.
> >
> > I changed the name to "bury" since it seems more descriptive of what
> > it does, despite being less of an opposite to "float" than "sink" was.
>
> But 'bury' means to hide or even kill.
>
> How about "raise" and "lower" ?

Or "immerse" ("immerge"?) as another opposite of "float" :-)

I don't have any opinion on this, it's up to Yann to argue.

-- 
Catalin
