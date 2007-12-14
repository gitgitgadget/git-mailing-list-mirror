From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: StGIT: "stg refresh -e/--edit" to refresh patch and edit description no longer works
Date: Fri, 14 Dec 2007 14:26:40 +0000
Message-ID: <b0943d9e0712140626w3a2f55b1i83c33f93d7f8af2f@mail.gmail.com>
References: <200712141507.01552.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 15:27:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3BVK-0001fa-Se
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 15:27:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752109AbXLNO0n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 09:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751636AbXLNO0n
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 09:26:43 -0500
Received: from rv-out-0910.google.com ([209.85.198.190]:60425 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751567AbXLNO0m (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 09:26:42 -0500
Received: by rv-out-0910.google.com with SMTP id k20so958681rvb.1
        for <git@vger.kernel.org>; Fri, 14 Dec 2007 06:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=34Xf5khmVObxmDuwjZo9ob1fYayjsUJdkfVcAY73z/s=;
        b=sgDtklvLNpw7Jye+p4NHwcgMJhf04IZEdL5+7CTK9jqjGEuzTF1BFkSZBC/Q0hqHaeAKqxK0yokmbRWCPd3N87+bX0FliTEADFTaO0xZzT7A5y0ap2RHWBD0PQzVeKaFIoG7UZsAvH97OghlcWwNqJc0BHgfsionV7s/Zsziyl0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rFJJSvy/mTHleRG/NwUrE5X0yLUY9/A3VrflRcmNXn7iUId+fAdiaCdn7IJM8DcsgI/TGtH6awK88HEtNuu3GnJMXMOQd9uGepU5wcLLWcRlZR7Z5aWwWTcfDAtpbJlWKLwkGJN/O6EnkvIFj2XNTyXPn/sBAJzbuFij8VW+aAI=
Received: by 10.140.133.16 with SMTP id g16mr1887893rvd.231.1197642401019;
        Fri, 14 Dec 2007 06:26:41 -0800 (PST)
Received: by 10.141.186.5 with HTTP; Fri, 14 Dec 2007 06:26:40 -0800 (PST)
In-Reply-To: <200712141507.01552.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68309>

On 14/12/2007, Jakub Narebski <jnareb@gmail.com> wrote:
> The command I used quite often in my StGIT workflow, namely
> "stg refresh -e", which used to refresh patch and launch editor to edit
> commit (patch) description no longer works in Stacked GIT 0.14.1.
>
> I used it when new (refreshed) changes needed also changes in commit
> description (commit message). Now I have to run two commands:
> "stg refresh" and "stg edit".

Well, people complained that 'refresh -e' is misleading and a separate
command is needed. It's not difficult to move the editing
functionality out of stgit.commands.edit and re-add the --edit option
to refresh (while also keeping the separate edit command).

I'm a bit busy with home/family commitments until the new year.

-- 
Catalin
