From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Google Summer of Code 2013 (GSoC13)
Date: Tue, 19 Feb 2013 08:17:42 +0700
Message-ID: <CACsJy8CCotnPo0C_o_0721O2w3dqXUWAYjCjgeEYQzq-CdX14g@mail.gmail.com>
References: <87ehgd1qq2.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Shawn Pearce <spearce@spearce.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>,
	=?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Feb 19 02:18:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7bqv-0000kM-Pk
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 02:18:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757854Ab3BSBSN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 20:18:13 -0500
Received: from mail-ob0-f180.google.com ([209.85.214.180]:53303 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757526Ab3BSBSM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 20:18:12 -0500
Received: by mail-ob0-f180.google.com with SMTP id ef5so5999436obb.25
        for <git@vger.kernel.org>; Mon, 18 Feb 2013 17:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=q2/SREYeMLcafcMBHsn1zVwOsMFwgEVLNe4hlLyYa2M=;
        b=VH4uG6Zh7jfVy9cPTOHl3Ry397bq9YN+ohuySlt5Oa5peby0qbxPdgdMTRAXzI47ug
         OszU3NQA7l8X4ROn0QM9IvZ6685qk+cN0gdk2yY3lbkcIiif0to9PtmArX5iVnH0hOZC
         RH0ThCzKUGXUxJjqHNAQ+EVZZTx8aOPEJe+lfavOgk6iKm+sI1rKMaxxVA7ILkigPhqY
         2kDXW5Cz9x1qbGJqFdhCmMqRf0JgnkBnXa87yk/Z9liNBE6SalBLAmA2lxwGavmhP3CS
         vt5evPI/Q+19nGuACwqbj7JcMPmQGX4XH0Le7Tq1RhNE97ygwlT8w+WgZYFkc7FUGndH
         Cgaw==
X-Received: by 10.60.32.67 with SMTP id g3mr6746749oei.77.1361236692415; Mon,
 18 Feb 2013 17:18:12 -0800 (PST)
Received: by 10.76.154.197 with HTTP; Mon, 18 Feb 2013 17:17:42 -0800 (PST)
In-Reply-To: <87ehgd1qq2.fsf@pctrast.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216552>

On Tue, Feb 19, 2013 at 12:23 AM, Thomas Rast <trast@inf.ethz.ch> wrote:
> * Naturally that ideas page is a bit stale now, and three projects
>   shorter.  Please propose new ideas and refresh or delete the old ones!
>   In particular some projects spawned long discussions on the list, and
>   the results of those discussions should be integrated to avoid deja
>   vus.

A proposal from what I've been involved lately: inotify support to
eliminate lstat and readdir syscalls. The scope may be small. But we
could aim to get it merged in master or at least next by the end of
GSoC. Or extend to another platform besides Linux, it helps ensure we
have good abstraction. My free time goes up and down unexpectedly, not
sure if I can commit to be a mentor. But I'm definitely interested and
will support whenever I can.
-- 
Duy
