From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Custom git completion
Date: Fri, 29 Jan 2010 07:11:27 -0800
Message-ID: <20100129151127.GA21821@spearce.org>
References: <9b69cfcf1001290457s6b7fad6cs5a915f16a11f5782@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Rhodes Clymer <david@zettazebra.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 16:11:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NasVV-0008DE-3U
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 16:11:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755926Ab0A2PLc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 10:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755808Ab0A2PLb
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 10:11:31 -0500
Received: from mail-qy0-f182.google.com ([209.85.221.182]:63292 "EHLO
	mail-qy0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755734Ab0A2PLb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 10:11:31 -0500
Received: by qyk12 with SMTP id 12so895916qyk.21
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 07:11:30 -0800 (PST)
Received: by 10.229.107.29 with SMTP id z29mr338803qco.42.1264777890669;
        Fri, 29 Jan 2010 07:11:30 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 22sm1488003qyk.2.2010.01.29.07.11.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 29 Jan 2010 07:11:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <9b69cfcf1001290457s6b7fad6cs5a915f16a11f5782@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138322>

David Rhodes Clymer <david@zettazebra.com> wrote:
> Unless I read it incorrectly, the completion script included with
> git-core does not make it easy for users to write completion scripts
> for custom git commands. I can extend git itself by creating a command
> "git-foo", and placing it in my path.

git config --global alias.foo /home/me/bin/my-git-foo

git foo will now complete correctly.  No need to modify the
completion code.

-- 
Shawn.
