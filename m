From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: [TOY PATCH] filter-branch: add option --delete-unchanged
Date: Sun, 14 Sep 2008 19:29:59 +0300
Message-ID: <94a0d4530809140929s1728a7aevb9f4b0a0469eba0c@mail.gmail.com>
References: <1218153031-18443-1-git-send-email-trast@student.ethz.ch>
	 <1218226224-25273-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Jan Wielemaker" <J.Wielemaker@uva.nl>
To: "Thomas Rast" <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Sep 14 18:31:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeuVC-000535-Ev
	for gcvg-git-2@gmane.org; Sun, 14 Sep 2008 18:31:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753791AbYINQaB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Sep 2008 12:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753855AbYINQaA
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Sep 2008 12:30:00 -0400
Received: from rv-out-0506.google.com ([209.85.198.233]:5526 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753625AbYINQaA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2008 12:30:00 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1768271rvb.1
        for <git@vger.kernel.org>; Sun, 14 Sep 2008 09:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=x0wofxd5WIIo4ZKtqLQdXsp1LQiww3KLzLVBUcf3Urs=;
        b=eDLdc6qGS+WJz8tmPYGlGwqdNIMe5B+P2s/LdwrsT3b4h3+2p5VMwpx10Y1ySZM9rj
         jPNpMakh3f33kmodky5mEVY0zAEG3Ak2S1OG9SYspFg3ekOZ7hapJ0pD1jwfVlitSfKh
         hTvIiVd0o62hmQW9QrGPwSSv+yj6O+Cz8FQp4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Kij5VIAbfeKDgMOgMUa0JRSQ3EOkD42w0GhMvSi1QeXNCLXwlvHVWwxYdnVYDIEAKu
         x/ctcznZyrySFhiSCf32EnsjtyuoK1QAh/mvYulViE055F3KMZtwxoujyF3mZcWlDGY+
         7WJZRpvy46Z4CVdjlSKDOQBNiVJiLBQIpswYs=
Received: by 10.141.74.17 with SMTP id b17mr4138632rvl.119.1221409799533;
        Sun, 14 Sep 2008 09:29:59 -0700 (PDT)
Received: by 10.140.166.19 with HTTP; Sun, 14 Sep 2008 09:29:59 -0700 (PDT)
In-Reply-To: <1218226224-25273-1-git-send-email-trast@student.ethz.ch>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95847>

On Fri, Aug 8, 2008 at 11:10 PM, Thomas Rast <trast@student.ethz.ch> wrote:
> With --delete-unchanged, we nuke refs whose targets did not change
> during rewriting.  It is intended to be used along with
> --subdirectory-filter to clean out old refs from before the first
> commit to the filtered subdirectory.  (They would otherwise keep the
> old history alive.)
>
> Obviously this is a rather dangerous mode of operation.
>
> Note the "sort -u" is required: Without it, --all includes
> 'origin/master' twice (from 'origin/master' and via 'origin/HEAD'),
> and the second pass concludes it is unchanged and nukes the ref.

This is really useful, why isn't it merged?

Personally I use filter-branch to, duh, filter a branch, so I don't
want the commit objects that are not filtered, nor the refs to them.

-- 
Felipe Contreras
