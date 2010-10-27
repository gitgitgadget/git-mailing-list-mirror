From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Create a new commit from patches without using any worktree?
Date: Tue, 26 Oct 2010 21:58:16 -0500
Message-ID: <20101027025816.GA1338@burratino>
References: <AANLkTi=Xi13_0+bC-TVRP3uVDmGWVdM3a708=SSzCR88@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Klas Lindberg <klas.lindberg@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 27 04:59:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAwEE-00086d-KJ
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 04:59:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757354Ab0J0C6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Oct 2010 22:58:35 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:58999 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753799Ab0J0C6f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Oct 2010 22:58:35 -0400
Received: by qwk3 with SMTP id 3so208228qwk.19
        for <git@vger.kernel.org>; Tue, 26 Oct 2010 19:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=121tHjz98yFHM50qy1XJfzoJerGzGdboYgqj9axT6p4=;
        b=KQoNjId2ADLsXgVYak6VVYkoF9YhbLbD9YURQPRSYARMuxz70UP+BR/8r0outXmXka
         jt1uFwCEM80yt0W11XlUh4buxBpvtJx0zbQB9+JCDh8Un76fEwhrxf7AuhUWPaYcXzVE
         FzrAOpUac78vxOrtcUAlt1QrFAezI6yFd1QxY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=pC7MGEpjH9u9YDIutzn2CRVzfSwUpq9UM8YzTc3K5PLE1zlq5OkHwsFeqZFrWj0FkA
         l9D9c4AMrj5GKi7wQ3vypmYaIJ/1hN1kRN1bOrWbhGGTBp8Xak56wPEErwNOcq6AFOTE
         xi+AgsxhSppqlebEYiarxakmBPCXyEWK3EW9I=
Received: by 10.229.226.149 with SMTP id iw21mr8245671qcb.50.1288148314622;
        Tue, 26 Oct 2010 19:58:34 -0700 (PDT)
Received: from burratino (72-254-120-86.client.stsn.net [72.254.120.86])
        by mx.google.com with ESMTPS id mz11sm8100051qcb.39.2010.10.26.19.58.32
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 26 Oct 2010 19:58:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=Xi13_0+bC-TVRP3uVDmGWVdM3a708=SSzCR88@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160018>

Hi Klas,

Klas Lindberg wrote:

> Is there any way to record a new commit based on contents in a patch
> without going through a worktree?

Not sure if there a user-friendly way to do this, but if you are
scripting, I'd suggest looking into "git read-tree", "git apply
--cached", "git write-tree", "git commit-tree", and GIT_INDEX_FILE.

Hope that helps,
Jonathan
