From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [RFC] "needs update" considered harmful
Date: Mon, 21 Jul 2008 14:17:22 -0400
Message-ID: <76718490807211117t3c1d1194tee1c5dca686df8be@mail.gmail.com>
References: <7vtzelf4mf.fsf@gitster.siamese.dyndns.org>
	 <7vk5fhf35p.fsf@gitster.siamese.dyndns.org>
	 <7v3am5f20f.fsf@gitster.siamese.dyndns.org>
	 <7v1w1pdmi8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 20:18:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKzxn-0003qu-4k
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 20:18:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783AbYGUSRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 14:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751660AbYGUSRX
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 14:17:23 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:31285 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751189AbYGUSRW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 14:17:22 -0400
Received: by yx-out-2324.google.com with SMTP id 8so258928yxm.1
        for <git@vger.kernel.org>; Mon, 21 Jul 2008 11:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=eIMmTtu9SZRXoUvy1aqOfGlWKlvGgEjG/19MBd2YSGk=;
        b=eEBTeDC4WPAv06VipzH3ccNYRHFnypvJz9bhQo0+A8fJuTFEQViNnLAWSnCEi4DJWU
         72KjNZNQFW0vJnk+eQ3HE9EAtZp/duVclxOgd/RPxP/FHy4Uvomx7odN8ocSRWgdDt3L
         79EqEeQo9FScNY7pXSG3NoROXiorwx2hKLDDA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=RqiORkhV7Fy1MJTx2tZLmpZ7o/36Mf6g1C44Bb+/kpSUMxl3mr+ZkjHDyxfKQo6GQn
         JLQuIb6sHfI8nnzq1W7w8DclGLqp/EfcbdFqerZj4di1EfblpaVmX4fSz6uE+ADtWRwi
         A/fpKOQ9fdULX/ozU+4lMecsXHSLHDk22+sSg=
Received: by 10.151.155.19 with SMTP id h19mr4201849ybo.36.1216664242011;
        Mon, 21 Jul 2008 11:17:22 -0700 (PDT)
Received: by 10.150.149.15 with HTTP; Mon, 21 Jul 2008 11:17:22 -0700 (PDT)
In-Reply-To: <7v1w1pdmi8.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89376>

On Sun, Jul 20, 2008 at 3:48 AM, Junio C Hamano <gitster@pobox.com> wrote:
> The previous two variants both aim to reword the somewhat unpopular "needs
> update" message to easier "locally modified".

As a git beginner I would still be a confused. I think git beginners
need to understand three concepts very early:

- committed changes
- staged changes
- unstaged changes

I think saying "unstaged changes" instead of "locally modified" would
be consistent with the git add and rm man pages and less confusing.

On a related note, I don't understand the need for two different messages here:

$ echo stuff >> foo
$ git co master
error: You have local changes to 'foo'; cannot switch branches.
$ git add foo
$ git co master
error: Entry 'foo' would be overwritten by merge. Cannot merge.

A single message "You have uncommitted changes to 'foo'; cannot switch
branches." would suffice, no?

$0.02.

j.
