From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: scan entire repo for changes to file
Date: Thu, 11 Nov 2010 20:35:39 -0500
Message-ID: <AANLkTi=uKhrvAS6ApnmCZnfbFboYU77rNcKDpaSBn1id@mail.gmail.com>
References: <ibi59v$pjg$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Neal Kreitzinger <neal@rsss.com>
X-From: git-owner@vger.kernel.org Fri Nov 12 02:35:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGiYL-00006L-Sp
	for gcvg-git-2@lo.gmane.org; Fri, 12 Nov 2010 02:35:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756845Ab0KLBfl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 20:35:41 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:41508 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755068Ab0KLBfk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 20:35:40 -0500
Received: by qyk12 with SMTP id 12so512692qyk.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 17:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=spweKEF44dF8mKQN+G8R3hcYneClcHyrRFicni7OpbE=;
        b=bSQFOsQBYvCUYxSwZp6uyhLyCfQtLlkQxSCJqhMShDIweU/CCYIUv/Q3+stT3pGwgG
         qEyVYXKBuZ/z+Hc3rrzMp9PsYmDVPqffXQe8ZDtKrFMp07CYdSCDndeqGovTRcyhV2gO
         qaxhDCJsGufXrLdNlJJkdAVzSkDjvys4TfT3I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=LSEGKi9SfQBJ4oZDOd7aE6EzNVtZA1S6r12AJm/Clp9NZWysrsU2OYM/3HFxfGjoP+
         o+Zq9i9lpPoSaSI2ZubYdTqC5+cdvL29di9Z/imwda9+fNeP0WHxcFmdjUD2MfarJsPc
         PT+dhh4iP7nXEvgb0in+4SIP6x5ruCbTxaxlM=
Received: by 10.224.60.136 with SMTP id p8mr150991qah.175.1289525739654; Thu,
 11 Nov 2010 17:35:39 -0800 (PST)
Received: by 10.224.138.5 with HTTP; Thu, 11 Nov 2010 17:35:39 -0800 (PST)
In-Reply-To: <ibi59v$pjg$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161314>

On Thu, Nov 11, 2010 at 8:28 PM, Neal Kreitzinger <neal@rsss.com> wrote:
> Is there a way to scan my entire repo (many unmerged branches) for any
> changes to a file?
> e.g.
> $ git log * -- somepath/myblob
> would return all commits in the repo that changed myblob.
>
> v/r,
> Neal

Might replacing '*' by '--all' give you what are looking for?
