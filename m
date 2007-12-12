From: "=?ISO-8859-1?Q?Eirik_Bj=F8rsn=F8s?=" <eirbjo@gmail.com>
Subject: Re: Efficient retrieval of commit log info
Date: Wed, 12 Dec 2007 16:50:15 +0100
Message-ID: <34660cca0712120750p103e0989n80bd1a6a1f0ffa2c@mail.gmail.com>
References: <34660cca0712120636w149e2a82h84609f8ac7c958a9@mail.gmail.com>
	 <Pine.LNX.4.64.0712121453150.27959@racer.site>
	 <alpine.LFD.0.99999.0712121001430.555@xanadu.home>
	 <34660cca0712120719p2d7cda44s97ab770abd648742@mail.gmail.com>
	 <9e4733910712120734r2618e882w1e6f930c74f3065a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jon Smirl" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 16:51:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2TrM-0003t9-Lv
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 16:50:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751941AbXLLPuU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 10:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbXLLPuT
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 10:50:19 -0500
Received: from rv-out-0910.google.com ([209.85.198.189]:37504 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751428AbXLLPuR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 10:50:17 -0500
Received: by rv-out-0910.google.com with SMTP id k20so242879rvb.1
        for <git@vger.kernel.org>; Wed, 12 Dec 2007 07:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=JZP6kkwZGxo0hePm53HmU8aQWe/rDX0h3RohTOz2x3k=;
        b=sXGgjkUWq7Uy44EinD3W5ddcgkCubkNtMPxZhB0WijG5Aj1Zd+6BQ2Q1HO0+6G1mDnABuXb/W1E2AMCHi+aDKl2lRGgKapLPvv8rM2Vh2WXD4jGJ5Y39KWqFZiMWbKAR70pSyuHqRjh1i1508RWgT3kPhsJCXQWH2G+l/HISQJw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hmIC39HFQi4nRREAKPoWahioLiGt78bcd0Z1CAjG+/SAC3zfcIokpU6Y9XEaCnTU0HJhLrc72jmKpkx0qbO7tJuqJJZJQ7QiZZd34QX3TxOmOGGcfSM9tjZdCjIUvVkj4GwOGLiFF61+NK+F4YlB3wIudrssn2r2wX2YoAjUcfY=
Received: by 10.140.88.42 with SMTP id l42mr431240rvb.95.1197474615221;
        Wed, 12 Dec 2007 07:50:15 -0800 (PST)
Received: by 10.140.207.1 with HTTP; Wed, 12 Dec 2007 07:50:15 -0800 (PST)
In-Reply-To: <9e4733910712120734r2618e882w1e6f930c74f3065a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68055>

> Write a script the runs the command locally on the remote sever and
> emails you the info. Or ssh to the remote server and run the commands
> locally.

Hi Jon,

Unfortunately that won't work for my use case since I'm fetching
change metadata from remote repositories that I don't have any kind of
control over.

Eirik.
