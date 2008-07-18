From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH 2/5] Log subproces activity to a file
Date: Fri, 18 Jul 2008 22:45:53 +0100
Message-ID: <b0943d9e0807181445l146bd90akb8f8c14d602d401e@mail.gmail.com>
References: <20080717204133.23407.34264.stgit@yoghurt>
	 <20080717204233.23407.59842.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 23:46:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJxmv-00032A-AL
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 23:46:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756392AbYGRVpy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jul 2008 17:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755659AbYGRVpy
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 17:45:54 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:45572 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755290AbYGRVpx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Jul 2008 17:45:53 -0400
Received: by wa-out-1112.google.com with SMTP id j37so236724waf.23
        for <git@vger.kernel.org>; Fri, 18 Jul 2008 14:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Z855g7WuYtlh95Bp4iOYEbVIRMwEPJfjY2SQZcLV3Wk=;
        b=WG0flfe59KHHHania/YVILYKch96tbdwyDepWD3imrA7uuA8i9T3Ce3g/sZWFC4fBd
         cK4Ok+YC+8GPv4F2OsswRUHmhYN76Xo1U0cHsQOh8xMnujgIbWKWub9CI6cGycPhAVw+
         nDNW6IaBVbYh0Lo8PO6Hq0ZA96WLVHJowF8mk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=yELX0im0uxx79hv/Wg2Dt8RLw5hNX4erdyAaHit+lp3wrrdRmAkpdr/kxnu/l9vTZc
         az+5EwcgVGqOj+6ZjrPAR4JY6E9PEY+g+MGt0fmzRw6DeCmQcoPnTb2Aj0HZoGbBLt6v
         A1ndsrAsH7cvX1B3oD6PctLglGcFsrSab5yTA=
Received: by 10.114.169.2 with SMTP id r2mr504521wae.132.1216417553182;
        Fri, 18 Jul 2008 14:45:53 -0700 (PDT)
Received: by 10.114.193.12 with HTTP; Fri, 18 Jul 2008 14:45:53 -0700 (PDT)
In-Reply-To: <20080717204233.23407.59842.stgit@yoghurt>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89080>

2008/7/17 Karl Hasselstr=F6m <kha@treskal.com>:
> If the user sets $STGIT_SUBPROCESS_LOG to a log mode followed by a
> colon and a file name, append the log to that file instead of writing
> it to stdout.

OK.

--=20
Catalin
