From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: renames in StGIT
Date: Mon, 23 Oct 2006 17:47:06 +0100
Message-ID: <b0943d9e0610230947j79449a4dm8736f480f039c230@mail.gmail.com>
References: <20061022013943.GA16341@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 23 18:48:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc2xl-0003lZ-6t
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 18:47:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbWJWQrm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 23 Oct 2006 12:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWJWQrm
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 12:47:42 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:65116 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932160AbWJWQrl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Oct 2006 12:47:41 -0400
Received: by py-out-1112.google.com with SMTP id z74so84415pyg
        for <git@vger.kernel.org>; Mon, 23 Oct 2006 09:47:08 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KKi8YgJclEu0J8QtakT1X0aCK/Idory7qHf7DjnE3qCTFoNzyk0XhpRilqPLigMXSKDvPYwcHQ8vHBi0XuPTAt8biO1tSGdnuh02OJDw9R9IzhWIbZxpTVO61INeOu8J619FEmO8seIzfZi/L18F0ZYIAXMGMI7aFmYn5hr0aPw=
Received: by 10.35.60.15 with SMTP id n15mr6894231pyk;
        Mon, 23 Oct 2006 09:47:07 -0700 (PDT)
Received: by 10.35.103.18 with HTTP; Mon, 23 Oct 2006 09:47:06 -0700 (PDT)
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
In-Reply-To: <20061022013943.GA16341@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29846>

On 22/10/06, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> It doesn't seem like StGIT uses any of git's rename tracking stuff.
> Specifically, pushing patches doesn't seem to use rename-aware
> merging, and there is no way to tell diff to detect renames and
> copies.

They are indeed not supported by StGIT. One of the reasons is that the
push operation would probably take (much) longer (I haven't looked at
the algorithm in detail but some comments in the git-diff
documentation suggest that this is very expensive). Another reason is
that I (used to) send patches to people not using GIT and therefore
renames in the diff output were not welcomed.

> Should this perhaps be an item in the TODO list?

Only if it doesn't drastically affect the performance.

--=20
Catalin
