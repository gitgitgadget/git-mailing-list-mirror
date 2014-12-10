From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [wish] Revert changes in git gui
Date: Wed, 10 Dec 2014 08:42:45 +0100
Message-ID: <CAKPyHN2OSARgsYtC0MAxXqe=LZnBC9eq9BxkGme0QTRhnH9a1g@mail.gmail.com>
References: <54875263.1010407@grueninger.de>
	<548759C2.5030909@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Christoph_Gr=C3=BCninger?= <foss@grueninger.de>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Dec 10 08:42:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XybvA-0005Mu-8A
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 08:42:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843AbaLJHms convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Dec 2014 02:42:48 -0500
Received: from mail-la0-f50.google.com ([209.85.215.50]:40134 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751518AbaLJHmr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Dec 2014 02:42:47 -0500
Received: by mail-la0-f50.google.com with SMTP id pn19so1894572lab.23
        for <git@vger.kernel.org>; Tue, 09 Dec 2014 23:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=N21B7QArj+fCnE0oulMpnZgew59nj4c7E6pzrNSLEOE=;
        b=hhz2BpvQlgCNbkce7zlmPl5sd+SRKVcmHmbP2c1Ox1DFObWLgvlT99Qu+7JXSOL0pB
         DLUSOiyaBvzdVtF+GHcTEpCoVrcDe5wLB7m+IfjJKakYgZ0NXK7k3pNmXcwdl0ONaOJK
         mH/6O0ziXLNNDfdVRnIWpumzRglrGxPt9NDM9d5dBjHJVv815WU/B+zIX3Q4cypSRyvg
         41IORofXE4xk3scxv7HE8JFddIquhFBTkGZHGPBsGR15HSh9uJDHpgDR/EM4jRos2feQ
         H0K4xRCKEKSQNXvxfN3yd9BWSfkm2hSxAZB+STbJbHosn1wU/yVL1AJGYJtff4iV7rGZ
         9wwg==
X-Received: by 10.152.27.41 with SMTP id q9mr2519843lag.69.1418197365693; Tue,
 09 Dec 2014 23:42:45 -0800 (PST)
Received: by 10.112.43.176 with HTTP; Tue, 9 Dec 2014 23:42:45 -0800 (PST)
In-Reply-To: <548759C2.5030909@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261192>

On Tue, Dec 9, 2014 at 9:21 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 09.12.2014 um 20:49 schrieb Christoph Gr=C3=BCninger:
>> While browsing the changes, it is very easy to add (or remove) lines=
 or
>> hunks for commit via the context menu. I would like to revert the
>> changes of a line or a hunk in a similar way. I have often white-spa=
ce
>> or formatting changes I don't want to commit but want them reverted
>> immediately.
>
> I'm using this patch series since it was posted:
>
> http://thread.gmane.org/gmane.comp.version-control.git/188170/focus=3D=
188171

Maybe this is easier to apply:

http://repo.or.cz/w/git-gui/bertw.git/commit/5d7a81b626c34a94c6c43937d8=
a64572b6231196

Bert
