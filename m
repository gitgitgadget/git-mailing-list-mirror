From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH v2] Re: mailinfo: allow individual e-mail files as input
Date: Fri, 7 Aug 2009 03:52:38 +0200
Message-ID: <20090807015238.GF12924@vidovic>
References: <COrzR9ThNBy5SQ7chsXyUB30jVGIijxZQ3LI9L_y7Ab5vWcDcy_HolvjjuHTC7DHI9ntV-eR_v0@cipher.nrlssc.navy.mil> <fmF7fF0TYh9QnFuUzmi-Zw9fKRhYn2-S-kCVb2e-d84D87BPqjfwrwFursOoLGkB99qKJmb_oRs@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, giuseppe.bilotta@gmail.com, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Aug 07 03:52:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZEdY-0007u6-U3
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 03:52:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754079AbZHGBwn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 21:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752371AbZHGBwn
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 21:52:43 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:34605 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166AbZHGBwn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 21:52:43 -0400
Received: by ewy10 with SMTP id 10so1245100ewy.37
        for <git@vger.kernel.org>; Thu, 06 Aug 2009 18:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=3f0GFIop7Zd0eAyR0VC6JODMsaamQpqKa6Hyie9CI+o=;
        b=PhjeD1nuTTnJNRUU/MwfFYOk3EwIdgM0D/XYeKLhMcWeaZLVavC+RfF3PyB6DRUd1k
         I6DR5m3jeX4oT7LP967UoMbkOeo0DajcK3h+/6pgqLL5y8tYXjyFHEbPzZrFVPhwe88O
         Qf9QXV+tMbyOge+iIw4i7c8us5hF0nFY5Pn4k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=GaiyM+J6EzIN8nx+DKUKAGNTgKiEHUtXuWoiNKuEoVRzimF7tQq5V8p5E9YN7oylCu
         Yt9fe3rqkolvdwRwkOl6X6ke/9UBifduArQ1y5nS82VN9p8xSgJotDp3UbxZyqCxLfH4
         i9cOeXQONG8u/vuw1K3psgCRciywo1vRDWC2A=
Received: by 10.210.56.3 with SMTP id e3mr211169eba.99.1249609962068;
        Thu, 06 Aug 2009 18:52:42 -0700 (PDT)
Received: from @ (91-164-149-117.rev.libertysurf.net [91.164.149.117])
        by mx.google.com with ESMTPS id 28sm1383166eye.54.2009.08.06.18.52.40
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 06 Aug 2009 18:52:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <fmF7fF0TYh9QnFuUzmi-Zw9fKRhYn2-S-kCVb2e-d84D87BPqjfwrwFursOoLGkB99qKJmb_oRs@cipher.nrlssc.navy.mil>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125157>

The 06/08/09, Brandon Casey wrote:

> diff --git a/git-am.sh b/git-am.sh
> index d64d997..49f2be4 100755
> --- a/git-am.sh
> +++ b/git-am.sh

<...>

> +			{
> +				echo "$l1"
> +				echo "$l2"
> +				echo "$l3"
> +				cat

UUOC, I guess.

> +			} | sed -n -e '/^$/q' -e '/^[ 	]/d' -e p "$1" |
                                                   ^^

Is it still needed?

-- 
Nicolas Sebrecht
