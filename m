From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] git-cvsserver: handle change type T
Date: Mon, 17 Mar 2008 20:47:34 +0100
Message-ID: <47DECAD6.9060606@gnu.org>
References: <E1Jay7s-0000dO-IX@fencepost.gnu.org>	 <7v63vmicvf.fsf@gitster.siamese.dyndns.org> <47DD9890.3060005@gnu.org>	 <7vve3lbwz9.fsf@gitster.siamese.dyndns.org> <46a038f90803171234m7e3f1cbfgb65311bfb64e6e0d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	beuc@gnu.org, Martin Langhoff <martin@catalyst.net.nz>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 20:49:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbLJp-0000lx-EF
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 20:48:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752978AbYCQTro (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 15:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752560AbYCQTro
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 15:47:44 -0400
Received: from fk-out-0910.google.com ([209.85.128.189]:36650 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752475AbYCQTrn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 15:47:43 -0400
Received: by fk-out-0910.google.com with SMTP id 19so2001659fkr.5
        for <git@vger.kernel.org>; Mon, 17 Mar 2008 12:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=N+aLlbBwePuzbbn4pYGb1izCk3fzmBJAnLOSVt+Ljnk=;
        b=ssnBDFRV8OnJX+UhaJ6Wn4/L6Tk14Ge0aLjaT2GeQRyw8sCFqaIsD6hmHGjNn71LKgE83INF4k4WvK0FudU3T/Q5CT4UOIVSelJkPfukr8p6FIADpitISejNTb939RdZDnfPmuLV8fckuITfgp6egn1IErWz2ObYqapksx/SlUc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        b=O5dfdMFU4uh5840ri3eR2QGWanO0vjJZl3s9K4pFy4QKfM1ips8v4PQoFjT4XUJqT6XnV5ocfmxYzRQLFjvWUwlMgOJJ7oGDFm9JOJPpwcOBfd2rxjw3leu3E9TL2mt9668ywEuaYK4dEdi7oTyNxwCJ14zdSiGC64veQtYNrwM=
Received: by 10.82.177.3 with SMTP id z3mr341066bue.23.1205783257440;
        Mon, 17 Mar 2008 12:47:37 -0700 (PDT)
Received: from scientist-2.lan ( [213.140.22.65])
        by mx.google.com with ESMTPS id 4sm19834704fge.3.2008.03.17.12.47.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 Mar 2008 12:47:36 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
In-Reply-To: <46a038f90803171234m7e3f1cbfgb65311bfb64e6e0d@mail.gmail.com>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77460>

> I have never used symlinks with either git or cvs, so I am unsure as
> to whether their handling is compatible. Do either of them perform any
> sanity checks on the targetof the symlink?

I doubt that CVS actually supports symlinks.  git makes no sanity checks.

Paolo
