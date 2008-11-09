From: "Caleb Cushing" <xenoterracide@gmail.com>
Subject: Re: force a merge conflict
Date: Sun, 9 Nov 2008 15:19:57 -0500
Message-ID: <81bfc67a0811091219t393ab1faj8d1c4df6de3c260c@mail.gmail.com>
References: <81bfc67a0811090709s483506c1h6f9cb0f96216ef22@mail.gmail.com>
	 <20081109183917.GA18415@euler>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Deskin Miller" <deskinm@umich.edu>
X-From: git-owner@vger.kernel.org Sun Nov 09 21:21:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzGmX-0006yE-VD
	for gcvg-git-2@gmane.org; Sun, 09 Nov 2008 21:21:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755923AbYKIUT6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2008 15:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755900AbYKIUT6
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Nov 2008 15:19:58 -0500
Received: from rv-out-0506.google.com ([209.85.198.230]:59144 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755829AbYKIUT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2008 15:19:57 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2146781rvb.1
        for <git@vger.kernel.org>; Sun, 09 Nov 2008 12:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=XdluW0WapGh/umNX1Hbl8AUHywE5I3nMCB80Lu384ds=;
        b=QKBYQ3mCz4Ofxdn1shon7jxRKNWox2hzwdSPmlDVTHxZ5rn0+8Fns3uLjQVO51ddER
         gbimboDAPt0NXKMf17v56NcWEkwo/T3WrEDpC7mfzPQn/TfMzJmLOZAXm+y9MSH/I9T2
         O+VVtvE1hJbdzZTXWrWsKYaKJVjJr1kvKO0us=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=obT1dM5jaO/5K0H3BYch/l0aGGmdLSxopXHvnPIXsA6A8BM/V2idHcKNmf2vtfxxHy
         tStoXy2ltaNE0J/On/0lonm/aBQLXgjf0aWDGqHAzGCZyKJsgcgVLmcrHU3EGmLHJJpY
         uPio4mTl+Ndi8cx76pV/vn7JBIixiHeQJP3MM=
Received: by 10.141.132.1 with SMTP id j1mr3141773rvn.282.1226261997187;
        Sun, 09 Nov 2008 12:19:57 -0800 (PST)
Received: by 10.141.34.3 with HTTP; Sun, 9 Nov 2008 12:19:57 -0800 (PST)
In-Reply-To: <20081109183917.GA18415@euler>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100468>

> I'm not sure a 'conflict' is what you want, based on what you say below;
>  rather, it seems you simply want to force a 'merge commit', i.e. a commit with
>  multiple parents.

>
> git merge --no-ff ?
>
I tried that but I don't see that it's any different than a fast
forward in this scenario. Actually I don't see any difference between
it and a fast-forward.
-- 
Caleb Cushing
