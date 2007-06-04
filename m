From: "Dana How" <danahow@gmail.com>
Subject: Re: git-p4import.py robustness changes
Date: Sun, 3 Jun 2007 23:09:12 -0700
Message-ID: <56b7f5510706032309w4aee791dnd3bf5d46974bdaba@mail.gmail.com>
References: <4ACE2ABC-8D73-4097-87AC-F3B27EDA97DE@slamb.org>
	 <0EDF1E14-3682-4B1E-A7D2-F82388F752AA@slamb.org>
	 <7vzm3inisa.fsf@assigned-by-dhcp.cox.net>
	 <200706031511.31157.simon@lst.de>
	 <839AEF71-ED29-4A79-BE97-C79EAFEDC466@slamb.org>
	 <20070604055433.GD4507@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Scott Lamb" <slamb@slamb.org>, "Simon Hausmann" <simon@lst.de>,
	"Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org,
	danahow@gmail.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jun 04 08:09:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hv5kl-0001TR-Sj
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 08:09:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998AbXFDGJP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 02:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752002AbXFDGJP
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 02:09:15 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:42031 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751998AbXFDGJO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 02:09:14 -0400
Received: by ug-out-1314.google.com with SMTP id j3so664293ugf
        for <git@vger.kernel.org>; Sun, 03 Jun 2007 23:09:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MC5ZzANH/Z420Z3uJeLdtyGlJ2N1GVPewvhHYoCOWucq7S6Fc5BWx8xy06zTs280EKUnEFzGNdvQIwPdWd4oztdWD6y0rdaC483iYedmRv/KFRpRa7f2oyK9kpu6JxTKyg7WLuqNDZfS15kRmUCq8vHwv+ZiIWgWZPL254DATxA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=utHQfwC0Hr/vuXEMuv+D3pLA1hEK08jJQtFOkh/T5LNErH0VBBLsZOZXJSvGC/VgaPZPeR/L4u9g4TkKxvuN+ROJFDkVlIDGrfIBhras3zWJNjREfr0Sy7/FK/HHe/dV1F1jL9JlsC0WKYWvX3aQMbYAh2RHRPLS3t8HRjy9aas=
Received: by 10.78.131.8 with SMTP id e8mr1866116hud.1180937352887;
        Sun, 03 Jun 2007 23:09:12 -0700 (PDT)
Received: by 10.78.90.18 with HTTP; Sun, 3 Jun 2007 23:09:12 -0700 (PDT)
In-Reply-To: <20070604055433.GD4507@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49068>

On 6/3/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> I think writing data to fast-import is much easier than running
> the raw Git commands, especially when you are talking about an
> import engine where you need to set all of the special environment
> variables for git-commit-tree or git-tag to do its job properly.
> Its a good tool that simply doesn't get enough use, partly because
> nobody is using it...

Well,  perhaps they use it *once*,  in that they write a wrapper script for
it and then forget about it.  At least that's what I did.  And the _only_
annoyance was the trailing NL requirement on the delimited "data" statement,
so you don't get much noise/complaints when people use it.

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
