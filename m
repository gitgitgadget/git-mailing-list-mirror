From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: Change author in commits
Date: Mon, 22 Dec 2008 00:26:05 +1100
Message-ID: <ee77f5c20812210526p745f44b0m86ff18ffa815cea4@mail.gmail.com>
References: <1229862451693-1686491.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?=C1ngel_Eduardo?=" <arcnorj@yahoo.es>
X-From: git-owner@vger.kernel.org Sun Dec 21 14:27:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEOLF-0003AP-Jq
	for gcvg-git-2@gmane.org; Sun, 21 Dec 2008 14:27:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882AbYLUN0J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Dec 2008 08:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751869AbYLUN0J
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Dec 2008 08:26:09 -0500
Received: from wf-out-1314.google.com ([209.85.200.174]:2599 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833AbYLUN0G convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Dec 2008 08:26:06 -0500
Received: by wf-out-1314.google.com with SMTP id 27so1746823wfd.4
        for <git@vger.kernel.org>; Sun, 21 Dec 2008 05:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=59v1wkghKV9nLgZ2YGe0J6cBQIR+W3IpDP+ff76jgKg=;
        b=TgwfgmkawGIKCIo1TL8i9RKy8HxLhNm8V4KWpFG7uYnDk3q+/oVEHsn3lBEdLcVTJE
         NPyMkPmMVra92HXmwTf8ngn4UBiEyoWkuuNIZetlCx5zrXZ54VcTk9ckQFZq84s+1Rau
         +zd2oQHLJhVB1JaBIlzpuLseEQZSgNcaeX4Bs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=MUqEGq0/9PlsyThauNQ1df7v+f3NM9GAh2SuYYPsSHZ7OTlnGNPCJ/cfwfpmbhjpgt
         Y6yy9YDlrU4+gZbgdknsLTRucRKPzmD6ysWzHGpx7+TLr07+Cxx6POS/LHZzVY8dm6z9
         zwp46AdonM8KxwW/4LQwk4ASQJPDpHERXvdJo=
Received: by 10.142.134.17 with SMTP id h17mr2225138wfd.127.1229865965512;
        Sun, 21 Dec 2008 05:26:05 -0800 (PST)
Received: by 10.142.50.1 with HTTP; Sun, 21 Dec 2008 05:26:05 -0800 (PST)
In-Reply-To: <1229862451693-1686491.post@n2.nabble.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103701>

On Sun, Dec 21, 2008 at 11:27 PM, =C1ngel Eduardo <arcnorj@yahoo.es> wr=
ote:

> I've started a repository in a project of mine, but I forgot to chang=
e the
> commiter name to the nickname and email I'll use in the project along=
 with
> my teammates.
>
> So, it's there a way to change them it in the commits I've done?

If you haven't published your changes, simply rewrite your history via
git filter-branch; see its manpage for details.

If you *have* published your changes, you can't change committer
details without changing the SHA1 of the commits.


Dave.
