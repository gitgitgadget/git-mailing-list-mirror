From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: "git pull . <branch>" versus "git merge <branch>"
Date: Tue, 10 Jun 2008 22:23:46 -0700
Message-ID: <484F6162.6060606@gnu.org>
References: <484F2174.9020508@keyaccess.nl> <ee77f5c20806101806u6dc04152rb8307eb12a6167c@mail.gmail.com> <484F26C9.9080608@keyaccess.nl> <20080611015608.GD29404@genesis.frugalware.org> <484F32B1.4050506@gnu.org> <484F33E9.1060205@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	David Symonds <dsymonds@gmail.com>, git <git@vger.kernel.org>
To: Rene Herman <rene.herman@keyaccess.nl>
X-From: git-owner@vger.kernel.org Wed Jun 11 07:25:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6IpT-00026B-E4
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 07:25:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbYFKFYK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 01:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751510AbYFKFYJ
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 01:24:09 -0400
Received: from qb-out-0506.google.com ([72.14.204.226]:56121 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255AbYFKFYI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 01:24:08 -0400
Received: by qb-out-0506.google.com with SMTP id d8so1028871qbc.37
        for <git@vger.kernel.org>; Tue, 10 Jun 2008 22:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=D21OfCawngzwVNKId6glP9lqwCmeXkoG35QhEF02VxQ=;
        b=jPVdFj6LmSwb/hXeiGLjXNhos57WnvCHRhAxH+rdj2htRe5unrAuq02A8Ew+JxOMAj
         XNJGGs53QByxF0dxPBQvHLojPyu0Se+7DO4aten93OvYVTHTIXaWz1V6wvrFyCb3irRd
         Wtbk8kl1aMF+MvLWONy38+NunnXzXFNo2X4fE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:sender;
        b=DYS/gXBNkilbrWKLhtp/+UKzce9hr51k8K+ofIQqIKh5AQuwDaapKCMs3on7lyWdKc
         hQZw1Yo0l8thlSpepdrY7rnoe0vZ7fHN6+RfLnZsM23RQRax1LfU2fMbPbXUyJBkPJDv
         7sNr+pYMcAMud1cahjRx7PNTTEIsrx7GqvPW8=
Received: by 10.114.127.1 with SMTP id z1mr5961046wac.94.1213161846553;
        Tue, 10 Jun 2008 22:24:06 -0700 (PDT)
Received: from scientist-2.local ( [65.248.49.163])
        by mx.google.com with ESMTPS id q18sm17818371pog.2.2008.06.10.22.24.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Jun 2008 22:24:05 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Macintosh/20080421)
In-Reply-To: <484F33E9.1060205@keyaccess.nl>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84588>


>>> There is no difference, but you really want to use git merge and not git
>>> pull in such a case, I guess the git pull form is supported mainly to
>>> keep backwards compatibility.
>>
>> However, when you're on a tracking merge
> 
> On a what? :)

Tracking *branch*, sorry.  A branch that has configuration options like

	[branch "foo"]
		remote = origin
		merge = next

so that git knows that, when you're on branch foo, "git pull" is 
actually equivalent to "git pull origin next:foo".

Paolo
