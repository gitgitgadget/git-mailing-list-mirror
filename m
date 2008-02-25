From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [RFC/PATCH] mergetool: clarify local/remote terminology
Date: Mon, 25 Feb 2008 15:09:04 -0500
Message-ID: <76718490802251209u240bc0b2s8e268c7f1943c3d9@mail.gmail.com>
References: <1203570776-62019-1-git-send-email-jaysoffian@gmail.com>
	 <76718490802250631p262baf1bw23873e5fdbbb7180@mail.gmail.com>
	 <20080225184648.GC15131@sigill.intra.peff.net>
	 <76718490802251107y44ff2d6ahf5446ae0408c67b0@mail.gmail.com>
	 <20080225192106.GB19666@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 25 21:10:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTjeE-0003MZ-9h
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 21:10:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755967AbYBYUJJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 15:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756395AbYBYUJJ
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 15:09:09 -0500
Received: from el-out-1112.google.com ([209.85.162.180]:62843 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755967AbYBYUJH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 15:09:07 -0500
Received: by el-out-1112.google.com with SMTP id v27so1486394ele.23
        for <git@vger.kernel.org>; Mon, 25 Feb 2008 12:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ko21NNVpi6oa63QL+qJRg7a0jG2v88NDbR3VBcqCxr4=;
        b=aZa4eRpGaaTixGjPFrNT2bWwupVhXNIKYmWG8xdzTh/UxjON7Vy6Y8htU1T2BkrI4Trnms2rP7fQbsRG5Xfl68y+twYa3hukrLkWuOLZak4OMk7T50fH0VccRWz0OXeprGiz/XVI6aWEPH8kJ2PrFW4Mh64hCTrYXSrBA3SEWDE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cZLl+1WS0jlNHIhwsweQuEplYB/eqWPESbsPwaTf+D1XwO7i4ji8is1ojxb7uofdz8omKRY3cjDrmSGZpxwafmgtz70l7Oojqx/A1LjzeiWvpsAFBaKWDGMAd9VyYGM9e1lxCQc9304pCDmUP2sJqcMRtbFCECkKfiNVxlyOG94=
Received: by 10.114.127.1 with SMTP id z1mr4177329wac.26.1203970144637;
        Mon, 25 Feb 2008 12:09:04 -0800 (PST)
Received: by 10.114.145.13 with HTTP; Mon, 25 Feb 2008 12:09:04 -0800 (PST)
In-Reply-To: <20080225192106.GB19666@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75059>

On Mon, Feb 25, 2008 at 2:21 PM, Jeff King <peff@peff.net> wrote:

>  Probably HEAD and HEAD~5 (perhaps along with their oneline logs). I
>  think the best we can do is "whatever the user said to get us here"
>  which is not something you can calculate after the fact; you have to
>  remember what the user said.

Right, so the porcelain would have to save this information somewhere
for mergetool to access (yes/no/maybe?).

Anyway, that's why the first iteration of my patch takes --left
and --right arguments so at least you can tell it how you got
there.

j.
