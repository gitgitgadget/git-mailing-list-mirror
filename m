From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 14/16] clone: support narrow checkout with --path option
Date: Mon, 15 Sep 2008 09:40:49 +0200
Message-ID: <200809150940.50579.jnareb@gmail.com>
References: <48cdd598c6cd9_12e03ff42d900428232ec@app02.zenbe.com.tmail>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 15 09:45:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kf8m7-0005rY-Lg
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 09:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146AbYIOHk5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 03:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752090AbYIOHk5
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 03:40:57 -0400
Received: from gv-out-0910.google.com ([216.239.58.189]:11587 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018AbYIOHk4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 03:40:56 -0400
Received: by gv-out-0910.google.com with SMTP id e6so966250gvc.37
        for <git@vger.kernel.org>; Mon, 15 Sep 2008 00:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=RRxINXBY0rE3sTMdECc1HWVOEEb1HLjXY5PDMJ5qk1w=;
        b=eAnZzfIvcXi3zeZuE8iFx8gv1rqKCKIpGIeoZJue4Ndvn7BKo3hpYrvIySxjexyUzC
         mp2fC7fA+DhYpLXx5H7XsTjdAiwOIBrmE5e6XNnwjNTw/+iO9PXfFQ1eSDP14YI+2A5B
         pOd5EnVsdqIZbfH5I99sP1fAsjhxhH1rVyMNY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=EynnQ+gBSaKhEaoo+Gvfkl0vurFfpqZ2Ka+jJHs6LxO2+mMEQb6D8BgPkAyvoRxBgv
         ALxcsZ8S9nCYjOa8ES9hlJRUadQ5TwDSYEQHyxzgO1WFgIOj3pB5aayhvf2OPn3/ldA7
         0lKotQKt4EDXVvaVFT/VEbNFJEh7c7PXiZPyM=
Received: by 10.86.26.11 with SMTP id 11mr5631136fgz.71.1221464455326;
        Mon, 15 Sep 2008 00:40:55 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.248.215])
        by mx.google.com with ESMTPS id 4sm16923036fgg.4.2008.09.15.00.40.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Sep 2008 00:40:54 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <48cdd598c6cd9_12e03ff42d900428232ec@app02.zenbe.com.tmail>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95889>

Duy Nguyen wrote:
> On 09/15/2008 "Jakub Narebski" <jnareb@gmail.com> wrote:

> > 
> > Second, how `--path=<narrow_spec>` interacts with `-n' (no checkout).
> > Does it even have any sense? Perhaps those options should be mutually
> > incompatibile (and --bare and this option too)?
> 
> Yes they are incompatible and won't work if either -n or --bare is provided with --path.

Perhaps that should be stated explicitly? It is quite obvious, but...
-- 
Jakub Narebski
Poland
