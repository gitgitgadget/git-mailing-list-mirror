From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: merge confusion
Date: Wed, 28 Oct 2009 16:43:53 +0100
Message-ID: <81b0412b0910280843s53af2033y7e24400dca231385@mail.gmail.com>
References: <24755682.post@talk.nabble.com> <26093419.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Tim Mazid <timmazid@hotmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 16:44:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3Agw-0000wO-Gv
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 16:44:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754653AbZJ1Pnu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 11:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754261AbZJ1Pnu
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 11:43:50 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:52431 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754138AbZJ1Pnt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 11:43:49 -0400
Received: by ewy4 with SMTP id 4so867872ewy.37
        for <git@vger.kernel.org>; Wed, 28 Oct 2009 08:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=feOFZ6qiylEdPsv9t0HMH8OldQsg+lcThImr1bORnus=;
        b=MSMPOoaGaNLYG8FUOdmz4Bkk3cMjQDZwYkXrC+h7KYvXeVarP4YRIIp8hJOkZPOOrx
         zx6KB4/NKSyqx41/hbXg4i2UMzLij65zfDOYWRlrWJCpR3X7NsT42lruqfLNH4UWBkn6
         SAAySP5ecGr5K7dZ+z3gXjEy/RWmuUSFaoodQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=GLnltcZbHR9p5kktsjofD/2iL6EFadhqELhEzBu0jGWXJg3ntKMWb3PUZ4uRN57Ra1
         XgMC1KzqT2Bxd1iICFVyrMlzZrsqURXS4lYe3JSZWbcOYPM836HJHZslfO9fHnkCUwGK
         VqxdkwGvP6APUfNNTBLzHl2FYfBo1kjcoAfcI=
Received: by 10.211.153.2 with SMTP id f2mr969929ebo.42.1256744633512; Wed, 28 
	Oct 2009 08:43:53 -0700 (PDT)
In-Reply-To: <26093419.post@talk.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131475>

On Wed, Oct 28, 2009 at 13:01, Tim Mazid <timmazid@hotmail.com> wrote:
> You can just do a 'git branch branch-to-merge COMMIT' then 'git merge
> branch-to-merge' from your feature branch. Alternatively, you could just do
> a straight 'git merge COMMIT' from your feature branch. Though I'm not sure
> of the consequences of merging a commit instead of a branch.

The only consequence is that the merge commit message (if there will be any,
fast-forward merges don't merge anything) will mention the SHA1 instead of
branch name. You can provide your own merge commit message, of course
(while merging and afterwards).
