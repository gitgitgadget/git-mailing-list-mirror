From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Will git have a baseline feature or something alike?
Date: Sat, 1 Mar 2008 19:00:35 +0100
Message-ID: <200803011900.36723.jnareb@gmail.com>
References: <f17812d70802290123raa099bag17a6f7b89de65dd4@mail.gmail.com> <200803011641.49874.jnareb@gmail.com> <8384AA89-4ECF-4BB8-8A3B-6A656F2D2903@orakel.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "eric miao" <eric.y.miao@gmail.com>, git@vger.kernel.org
To: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
X-From: git-owner@vger.kernel.org Sat Mar 01 19:02:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVW1u-00061D-QW
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 19:01:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757645AbYCASAm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 13:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757632AbYCASAl
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 13:00:41 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:25018 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755319AbYCASAl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 13:00:41 -0500
Received: by ug-out-1314.google.com with SMTP id z38so962884ugc.16
        for <git@vger.kernel.org>; Sat, 01 Mar 2008 10:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=aF585riufRTrlMBIWveZ+Tk9BLWWAQtXUevqvPyexSc=;
        b=UysR1pWPzvFVQ0gXfR+tlCQPuFwG0/Qy1pxJkMPYIBm6j5Bxu5HLBvLcMfp/pdvwlJN/WuJFsws/NaR+/v0poTjoIHcOf9wvTnfh3us+AhgRu8H2x8WTPdaT5ROq2/fxvvxoC6BfEuQvBocCkfKm1Ll2zKAHHJB/5hZ4SphxF4U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=bHuyzde6H4ujhY/AZKlGw1a/snOYW0uogUaIr1n8n3mST+rO1PUWoAhSH0vve3WJ5S7+V5eXRdAe2D1Q2VhFUcyakazLbs/cudnue3yOjxEFYvL1a3UFvo/tw/LMm7ei3dsJn69VoJq5GA2lO6cMcgpWM/3ROghArW/HGqs18Bw=
Received: by 10.66.242.5 with SMTP id p5mr3041955ugh.87.1204394439703;
        Sat, 01 Mar 2008 10:00:39 -0800 (PST)
Received: from ?192.168.1.15? ( [83.8.199.142])
        by mx.google.com with ESMTPS id k1sm3942606ugf.29.2008.03.01.10.00.37
        (version=SSLv3 cipher=OTHER);
        Sat, 01 Mar 2008 10:00:38 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <8384AA89-4ECF-4BB8-8A3B-6A656F2D2903@orakel.ntnu.no>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75689>

Eyvind Bernhardsen wrote:
>
> Okay, as a git n00b I'm probably on completely the wrong track, but if  
> you made a git repository out of a kernel tarball (cd linux-2.6.24 &&  
> git init && git add .) and then did a shallow fetch from kernel.org  
> into that repository, wouldn't the blobs you added get reused  
> (assuming the tarball you downloaded was fairly recent), thus reducing  
> the amount of data fetch has to transfer?

I think it wouldn't. If I understand it correctly, the fetching engine
deals only with commits. If you have commit, it assumes that you have 
tree, blobs, and ancestors. If you don't have commit, it assumes that 
you don't have tree and blobs.

-- 
Jakub Narebski
Poland
