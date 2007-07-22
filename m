From: "Matt McCutchen" <hashproduct@gmail.com>
Subject: Re: [PATCH] gitweb: Fix support for legacy gitweb config for snapshots
Date: Sun, 22 Jul 2007 19:10:43 -0400
Message-ID: <3bbc18d20707221610q757536eet213a6d08b810b280@mail.gmail.com>
References: <3bbc18d20707171103q262eaa8amb319ca9f835dbf67@mail.gmail.com>
	 <7vd4ylt3eh.fsf@assigned-by-dhcp.cox.net>
	 <3bbc18d20707220805hd95c4ccsc48f140888403391@mail.gmail.com>
	 <200707222341.21538.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Petr Baudis" <pasky@suse.cz>, "Luben Tuikov" <ltuikov@yahoo.com>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 01:11:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICkaJ-0003Ua-0s
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 01:11:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbXGVXKr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 19:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765940AbXGVXKr
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 19:10:47 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:39199 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765531AbXGVXKp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 19:10:45 -0400
Received: by py-out-1112.google.com with SMTP id d32so3004339pye
        for <git@vger.kernel.org>; Sun, 22 Jul 2007 16:10:44 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uDpAkRvvcSXQXz/kxdcwzvUUnbunkdq4FpnIF1cBNEOwrINoE/7W8UcUBL67O9BT72i1ysxu0+SA/kXd1w4fl4yo0F50pAeohmAMGG+H3WJWswP5DzwAxazccHlpIH+8MubriQdTHeOk2D0XLs1WQfZGLQZIZGycedP7vQkCYGo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DetoUuAV2uY65/Kb8EVeSgIK/gbrcNG2xPGzom5MXqS0M1Z9txg++fUY7BPeOITL8GsuUynUSK73+RX+aUSkj8X8XUh+oOSzRvraSEy+TRRqu/3NkFbDKi67D4RntW2h17AzKQBzJSPpWZKz1hVbifd10a10Tm2gCT/zhlh8rYw=
Received: by 10.142.132.2 with SMTP id f2mr184836wfd.1185145843994;
        Sun, 22 Jul 2007 16:10:43 -0700 (PDT)
Received: by 10.143.30.9 with HTTP; Sun, 22 Jul 2007 16:10:43 -0700 (PDT)
In-Reply-To: <200707222341.21538.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53365>

On 7/22/07, Jakub Narebski <jnareb@gmail.com> wrote:
> This commit moves legacy configuration support out of feature_snapshot
> subroutine to separate filter_snapshot_fmts subroutine. The
> filter_snapshot_fmts is used on result on result of

There's a typo: "on result" appears twice.

> On Sun, 22 July 2007, Matt McCutchen wrote:
>
> > That said: the backward compatibility code for gitweb _site_
> > configuration is broken because it is inside an if statement that only
> > runs for gitweb _repository_ configuration.
>
> Sorry for sending not fully tested code. This should fix that.
> This commit _is_ rudimentally tested.

I tested it too and it worked.  I like the approach of using
filter_snapshot_fmts.

Matt
