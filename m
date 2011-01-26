From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v2] fast-import: treat filemodify with empty tree as delete
Date: Wed, 26 Jan 2011 23:45:44 +0100
Message-ID: <AANLkTimNWLFgTk0Bueiscw-WkAX53v0Xsepn9esXOt7+@mail.gmail.com>
References: <1291286420-13591-1-git-send-email-david.barr@cordelta.com>
 <20110103080130.GA8842@burratino> <20110103082458.GC8842@burratino> <20110126224104.GA20388@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <david.barr@cordelta.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 26 23:46:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiE7x-0000Xb-Nf
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 23:46:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753481Ab1AZWqH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jan 2011 17:46:07 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49749 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728Ab1AZWqF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jan 2011 17:46:05 -0500
Received: by iyj18 with SMTP id 18so862068iyj.19
        for <git@vger.kernel.org>; Wed, 26 Jan 2011 14:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=/s+sNzzCj6136HiV/B2KpoOio1AY4o9TxnMNJI1VR88=;
        b=CRgLk2S88XwUwBkWkBX2gEyH5NDpu0iZOTJefxYe1O5W/9mAq6xGbKoUndVIORmwod
         9cDeDKvCRlLz1E0b0htBOZGYE/i09FmUEW+5r1wlHBJfCyi6Q/uCbAPWGbOHXH+RwiE+
         kreP6wGeXqZJDtPQJQfTDjBuqb/GSTL8NEvv8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Vjugwnzqkk8k3MGxxBO6Nd5DelyG5GNPo7HNFyRgGYwbgUQS5ylZZgd74oFiTkJDaX
         pyFE38Sya7/h8VUS0hJPdfckxT409nJYcvwRmOe+yNv50xqUAfNVO8p2Ob4Mmudgqys+
         k2q+JvSW5GKuw7r1FUrJBSV7gOgkPaCUtIX/Q=
Received: by 10.231.207.71 with SMTP id fx7mr31795ibb.127.1296081965127; Wed,
 26 Jan 2011 14:46:05 -0800 (PST)
Received: by 10.231.39.140 with HTTP; Wed, 26 Jan 2011 14:45:44 -0800 (PST)
In-Reply-To: <20110126224104.GA20388@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165560>

Heya,

On Wed, Jan 26, 2011 at 23:41, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Seems to work okay. :)

Should it go on maint now that it's factored out, since it shipped in
1.7.3, or just master?

-- 
Cheers,

Sverre Rabbelier
