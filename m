From: "Brett Simmers" <swtaarrs@gmail.com>
Subject: Re: force a merge conflict
Date: Mon, 10 Nov 2008 14:11:29 -0500
Message-ID: <e32b7bb40811101111o8c4334dj49a0c56c6dac6d15@mail.gmail.com>
References: <81bfc67a0811090709s483506c1h6f9cb0f96216ef22@mail.gmail.com>
	 <20081109183917.GA18415@euler>
	 <81bfc67a0811091219t393ab1faj8d1c4df6de3c260c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Deskin Miller" <deskinm@umich.edu>, git@vger.kernel.org
To: "Caleb Cushing" <xenoterracide@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 10 20:13:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzcBr-0006YW-9A
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 20:12:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbYKJTLc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 14:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbYKJTLc
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 14:11:32 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:34573 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773AbYKJTLb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 14:11:31 -0500
Received: by ey-out-2122.google.com with SMTP id 6so1005275eyi.37
        for <git@vger.kernel.org>; Mon, 10 Nov 2008 11:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=kIYu4Y/nYtR4R4e1ZgiuwhqRn+MELX4iBT1vQy8uAac=;
        b=gwpoGVDkcDTjHaGZ2uxao/KXomXw10IDDn3rYKPLOCmaFv0wNgTRzA35WBz7vAN/aO
         Ku0FST9wfVKEMKMHn1vGYlcrCIJlf87dtUju4ZL3JwBLXJLhUaPDrqgg+pUAnUaNggW9
         ECP0NS5oz2ul9vnp9AilHzEWaVMI1Niw1U0aQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=wEc9FOnCgkwKu/rClbzTnwFAVohXbWNF98OcX52o1q/dMi76HEW5C4BK2sMGFbsFZ0
         qrkgTwAT2axaCDad7mqhHKVfhz1OgTncOvThSBD4SnhTsKk3X+pvs6ewpzpMXTlA+MLc
         +Jb1FIM/s3/WZMzZXTQxsT1+hZ9iV1GCcP6rE=
Received: by 10.103.217.7 with SMTP id u7mr3960383muq.73.1226344289649;
        Mon, 10 Nov 2008 11:11:29 -0800 (PST)
Received: by 10.103.92.17 with HTTP; Mon, 10 Nov 2008 11:11:29 -0800 (PST)
In-Reply-To: <81bfc67a0811091219t393ab1faj8d1c4df6de3c260c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100547>

> I tried that but I don't see that it's any different than a fast
> forward in this scenario. Actually I don't see any difference between
> it and a fast-forward.

If you want to be given a chance to edit the result before the merge
commit, you probably want 'git merge --no-commit'.

-Brett
