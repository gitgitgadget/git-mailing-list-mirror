From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git-push through git protocol
Date: Mon, 22 Jan 2007 12:49:02 +1300
Message-ID: <46a038f90701211549v1e3dbb9dgf4eb810c8756b5d7@mail.gmail.com>
References: <17843.29798.866272.414435@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 22 00:49:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8mR1-00050c-Iv
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 00:49:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796AbXAUXtG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 18:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbXAUXtG
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 18:49:06 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:7856 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751796AbXAUXtD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 18:49:03 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1146744nfa
        for <git@vger.kernel.org>; Sun, 21 Jan 2007 15:49:02 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=J8B9A7/vyFrWqojKEe27fZHR3CiEO5hLYJgiJcV/TRUvJziAPOUusexliz327YwGgbsAAm7eLMt4zP+sOxh5Gneyi6MlI+4IFLK1TwPbVisW9bSzKDHvrWA33o7Oy453n4SOWOL5TTDEFCX/EusgSe8K+ym26NfAYet5/XZMFOQ=
Received: by 10.49.57.12 with SMTP id j12mr5749852nfk.1169423342235;
        Sun, 21 Jan 2007 15:49:02 -0800 (PST)
Received: by 10.49.35.7 with HTTP; Sun, 21 Jan 2007 15:49:02 -0800 (PST)
To: "Bill Lear" <rael@zopyra.com>
In-Reply-To: <17843.29798.866272.414435@lisa.zopyra.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37366>

On 1/22/07, Bill Lear <rael@zopyra.com> wrote:
> 2) we have run into problems
> with developers having different umasks ---

This is a non-issue. Just do git-repo-config core.sharedrepository 1
on each repo.

> 3) we would prefer a single protocol instead of sometimes pulling with
> git and pushing with ssh.

Internally we always use ssh+git. No problem.

cheers



m
