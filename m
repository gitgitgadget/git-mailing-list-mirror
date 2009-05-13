From: Esko Luontola <esko.luontola@gmail.com>
Subject: Re: Cross-Platform Version Control
Date: Wed, 13 May 2009 08:34:19 +0300
Message-ID: <4A0A5BDB.9030602@gmail.com>
References: <419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com> <20090512151403.GS30527@spearce.org> <alpine.DEB.1.00.0905121808480.4447@intel-tinevez-2-302> <D1E08DA2-8D8E-4D45-A50A-F32E3448D6E9@gmail.com> <alpine.DEB.1.00.0905122237230.27348@pacific.mpi-cbg.de> <4A09E719.4090205@gmail.com> <alpine.DEB.1.00.0905130222460.27348@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 13 07:34:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4770-0003p2-Gn
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 07:34:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751948AbZEMFe3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 01:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbZEMFe3
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 01:34:29 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:47960 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214AbZEMFe2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 01:34:28 -0400
Received: by ewy24 with SMTP id 24so528481ewy.37
        for <git@vger.kernel.org>; Tue, 12 May 2009 22:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=7M3/mMUf3+4QniRa/9Pp+65MdrvKkjiiFfCde7oOp9s=;
        b=rbSuG9P1rIYohDdrcTpdRekrlqnEReXzUKtzoY77+apc7ohkxwhgBt3VApq6hsxr4n
         Mj9rVtFw24xQvppThAYLOd4dBv6a8OrDbnQgol2EnHQj5wK6xBwDjCTqgFtP8FwQvbT6
         cHZ36E9fVbkING/KzjQHsfCyI1i2ltKhdq1QY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=lVLAZFm949XewNdqzkCeC35dwhsdgXwrl7wWE+Tdntz4DkR5z1jmK4efnlhrTi83fb
         HE41ZXgj1MBskoaTypmhB5jVB1dnYBUuRB2YGquRtCYYOnbuka5Jifu1uLYBvGkZ+GoV
         INz6nxoxceJ2Cq2LyKsAWnSBUmH/9nA1a4qyg=
Received: by 10.210.43.11 with SMTP id q11mr144217ebq.37.1242192867824;
        Tue, 12 May 2009 22:34:27 -0700 (PDT)
Received: from ?10.0.0.2? ([88.195.117.100])
        by mx.google.com with ESMTPS id 28sm748351eyg.34.2009.05.12.22.34.27
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 12 May 2009 22:34:27 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <alpine.DEB.1.00.0905130222460.27348@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118983>

Johannes Schindelin wrote on 13.5.2009 3:23:
> Well, that rather settles things, no?
> 

There is need for the feature, but it's unfortunate that the Git 
developers do not see its value. There are many users for whom using 
non-ASCII names is necessary (for example all of Asia and most of 
Europe), but now it seems that Bazaar is the only DVCS that handles 
encodings correctly: 
http://stackoverflow.com/questions/829682/what-dvcs-support-unicode-filenames

Let's see if I have time later this or next year to work on it. At least 
it would be good practise in getting acquainted with a new codebase and 
learning C. But it would be better for someone else do it, to get it 
done within a reasonable amount of time.

I see that there are some tests in the /t directory. Which command will 
run all of them, how good coverage do the tests have, how reproducable 
and isolated they are, how many seconds does it take to run all the 
tests? Is there some high-level documentation for new developers?

-- 
Esko Luontola
www.orfjackal.net
