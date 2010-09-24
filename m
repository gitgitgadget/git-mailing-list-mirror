From: Bryan Drewery <bryan@shatow.net>
Subject: Re: Find out on which branch a commit was originally made
Date: Fri, 24 Sep 2010 13:26:48 -0500
Message-ID: <4C9CED68.50203@shatow.net>
References: <1jp0h7e.lgk0kp19qe5bbM%lists@haller-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stefan Haller <lists@haller-berlin.de>
X-From: git-owner@vger.kernel.org Fri Sep 24 20:25:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzCxz-0003uS-MF
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 20:25:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757288Ab0IXSZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 14:25:04 -0400
Received: from secure.xzibition.com ([173.160.118.92]:50893 "EHLO
	secure.xzibition.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754401Ab0IXSZB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 14:25:01 -0400
DomainKey-Signature: a=rsa-sha1; c=nofws; d=shatow.net; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=sweb; b=NKZGgV
	1/DJeEPa3aAKvEtxJGW16BVB+WEP+oF3pq9slCh1ZoEUq2mu1+4CXnkoNqDmKFye
	yb4S9EV0XLTisS5N5zNXXXShMId6F+LvfJZR92AzLL36cyQogbZDg7p8lrSZGBUI
	MP8FSCpCc0fM8WCTItCdVprtEIM0xye0gIcHI=
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=shatow.net; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=sweb; bh=23fRwh9avsgD
	OJCRSZzbpqF4+46G/adABGt14cdXkqQ=; b=yu4yP3haizXZGPjUoOhFhJdn+cWK
	JHI9nBxLrjZGAhVElc9cHAmk9vU++Ql71PA/JrzkMWu33if9KDUImjAVn7rJfL+S
	S+ThpGGeAaqhZ53p8WtnClFi4vWOfViuYFpaBfPyEGB9d1Ncq5f1YVsc+KLLIQZ0
	J5E/jyTGW10pGDY=
Received: (qmail 15952 invoked from network); 24 Sep 2010 13:25:00 -0500
Received: from unknown (HELO ?192.168.0.201?) (bryan@shatow.net@74.94.87.209)
  by sweb.xzibition.com with ESMTPA; 24 Sep 2010 13:25:00 -0500
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <1jp0h7e.lgk0kp19qe5bbM%lists@haller-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157034>

  On 9/18/2010 4:19 AM, Stefan Haller wrote:
> I'm trying to pursuade my co-workers to switch from Subversion to Git;
> some of them prefer Mercurial.
>
> One concern that they are raising is that in Git there doesn't seem to
> be an easy way to find out on which branch a given commit was originally
> made, after the branch is merged back and deleted. They consider this a
> show-stopper.  In Mercurial, branch information is meta data attached to
> each commit, so you can easily get this information even after a branch
> is closed.
>
Use an issue tracker? Associate the commits with ticket numbers in the 
commit msg.

git commit -m "Blah Blah Blah (refs #someticket)"

Bryan Drewery
