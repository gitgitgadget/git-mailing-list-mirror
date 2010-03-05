From: John Tapsell <johnflux@gmail.com>
Subject: Re: Question about scm security holes
Date: Fri, 5 Mar 2010 03:00:10 +0000
Message-ID: <43d8ce651003041900x66000be4s9a15ab0cde3a0fe7@mail.gmail.com>
References: <hmp427$d6h$1@dough.gmane.org>
	 <32541b131003041803q9abf6baq4cf9ffcca990b51c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 05 04:20:02 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnO2n-0000Ey-Ci
	for gcvg-git-2@lo.gmane.org; Fri, 05 Mar 2010 04:17:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755013Ab0CEDAN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Mar 2010 22:00:13 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:53445 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754872Ab0CEDAM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Mar 2010 22:00:12 -0500
Received: by pwj8 with SMTP id 8so2106671pwj.19
        for <git@vger.kernel.org>; Thu, 04 Mar 2010 19:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=Jxgt7/1HsAKctHS88IYdWdzH5zv/qN7C4Yyc74cp07I=;
        b=cRW1zUgN+mMNzZhY3JkmemJ6U6iGeRtXSYGjPzJsY/kgMWk6zeeF/atXhEzRkJhZyF
         ckX4btlTD4n3ttIAJRlyv/LGJCX335FNQEBfMhU078Q96XTK+kM4G7ZuYzCQiimtXL9O
         y0oGFINAj5D3dZGxbTp7HlvXEWzJ3RNAY+J+U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=l56Npcb+4lGZwZF734Ea8dV4ZoQ+LwKeRaaimHgwaPIpQhwsAUai5fKcfmj0wdmL0I
         Y/6JCNCy4lnKKceafO9BS0SNSm/61HyllK/BC+hruU8AdSvJjhvneN3LkTxXrSlWGJoa
         H7f+aCWyvV0MBYPO9p+5AhZs7sd0gFn8pOnSE=
Received: by 10.114.252.34 with SMTP id z34mr267061wah.224.1267758010774; Thu, 
	04 Mar 2010 19:00:10 -0800 (PST)
In-Reply-To: <32541b131003041803q9abf6baq4cf9ffcca990b51c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141554>

On 5 March 2010 02:03, Avery Pennarun <apenwarr@gmail.com> wrote:
> modified code would be a little more interesting. =C2=A0git makes thi=
s sort
> of thing pretty much impossible to do without it being *noticeable* a=
t
> least. =C2=A0Traceable, not so much, because you can create a commit =
with
> whatever committer/author names you want and then push them in.

Which is why you simply record the username of whoever pushed them in.
 This is what gitorious.org does etc.

John
