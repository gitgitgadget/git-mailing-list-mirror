From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: User's mailing list? And multiple cherry pick
Date: Wed, 4 Jun 2008 11:47:52 +0200
Message-ID: <200806041147.53523.jnareb@gmail.com>
References: <18c1e6480806032355q2002fe0ej1f37dbd7dbd4802b@mail.gmail.com> <200806041050.09701.jnareb@gmail.com> <18c1e6480806040237m1f85c3f2s98ddb35ee1598ab2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David <wizzardx@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 11:49:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3pc7-0001Wv-Ky
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 11:49:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752649AbYFDJsJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 05:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751930AbYFDJsJ
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 05:48:09 -0400
Received: from wx-out-0506.google.com ([66.249.82.224]:32554 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853AbYFDJsH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 05:48:07 -0400
Received: by wx-out-0506.google.com with SMTP id h29so7764wxd.4
        for <git@vger.kernel.org>; Wed, 04 Jun 2008 02:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Uy+n7habRRAgylLw90apfssQQAo8A4w8dfS7ALnJ9aQ=;
        b=OsIJE0om603Nkpkp0snzWhcD4KpNdvPXD5BZfNhto2QJI5/p8+liwIyxZSX0ySl4GF
         WUpt4dWQvttx8fT48RjP9teYBnw4Itvog6eI4AJdiU4F5fhxPzKTa7CKv7dbHftplJ7w
         vJavdd4wjpajQnhfqVQ2PJkeCDPpQVW/y3N68=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=wowMOX+DDw4dAKTkQrKEAjlu67F9BC3/N/VXCaeJhSp/RWLeueMc9SqS54YYtYj71n
         Tn7ZxLEzTEZO0xxr/zYDOwA+0+1CHqDxLR3IE6nauJ40PdXRi3Hcpi3K9fJEAsIF753M
         GMH1FJDLwudy/z2W4NmvdjLynjBGviv2MBxSg=
Received: by 10.103.227.10 with SMTP id e10mr6945397mur.38.1212572884545;
        Wed, 04 Jun 2008 02:48:04 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.210.131])
        by mx.google.com with ESMTPS id y6sm5142669mug.15.2008.06.04.02.48.01
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 04 Jun 2008 02:48:02 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <18c1e6480806040237m1f85c3f2s98ddb35ee1598ab2@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83767>

David wrote:

[...]
> In your example, you still have a TMP "rollback" point if you need to
> rewind master in the event that the merge into master goes badly.

And you have ORIG_HEAD and reflog (master@{1}, master@{2} etc.) as 
safety net.  Reflog is now enabled by default.

Besides unless you run prune in the meantime, even without reflogs you 
would be able to recover using lost-found / git-fsck output.
-- 
Jakub Narebski
Poland
