From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Test that the 'rebase -i' "reword" command always
 cherry-picks a commit.
Date: Mon, 22 Mar 2010 17:09:29 -0500
Message-ID: <20100322220929.GA1384@progeny.tock>
References: <4BA11B23.4090801@xiplink.com>
 <1269285942-17496-1-git-send-email-marcnarc@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Mon Mar 22 23:09:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ntpoc-0007wV-Mu
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 23:09:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754992Ab0CVWJi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Mar 2010 18:09:38 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:58024 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717Ab0CVWJh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 18:09:37 -0400
Received: by ywh2 with SMTP id 2so2016375ywh.33
        for <git@vger.kernel.org>; Mon, 22 Mar 2010 15:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=7NOvir8CtH5YRRWyrafbpa4UJQO2Tuf0+oZFKf9076w=;
        b=moAY6oBjuvwTfHVRjuDixzeL/6DDDGG8jtHek4kLfvje/WD7UtkHIaVx+wL0mfD0LE
         R46u0yL1EJ0w1l+B2lhejhgwopeA0aZmV8fVptmnhL5JJ3NNih2dm5UEVqRqeStXXnUm
         jqVRjKq6N+f/t0ZW4+qFNsdzit4Fi4y7eWEzA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=deYHmeDmN9N8RVk9QXX4YTqBf5XtH3gVCUvcloHkGqaRlkKzqPlY99Z9tLfi5+JA/e
         SGPPBguDA1/0giKqYVpOWuFxWao6AJN5+bJCarWBzcIahewWnWjuKLlaWwS0Mb3igqry
         3u4ciz/2QjF7wpID5EDpo/wMBjVpnJJKhKQrk=
Received: by 10.101.132.15 with SMTP id j15mr5918115ann.96.1269295775997;
        Mon, 22 Mar 2010 15:09:35 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id co35sm842918ibb.14.2010.03.22.15.09.34
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 22 Mar 2010 15:09:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1269285942-17496-1-git-send-email-marcnarc@xiplink.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142970>

Marc Branchaud wrote:

> Is this more acceptable than adding --no-ff to rebase--interactive?

No, in my opinion the latter is better, and I suspect it will go in. :)

No one has objected to the --no-ff option.  I like it: if someone is
trying to reset the committer date on a collection of patches, I=E2=80=99=
d
rather they use rebase -f or rebase -i --no-ff than format-patch and am=
=2E
It=E2=80=99s cooking in pu for the moment, and from here the natural pr=
ogression
is to next, master, then maybe maint.

Hope that helps,
Jonathan
