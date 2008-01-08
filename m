From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Cover letter
Date: Tue, 8 Jan 2008 13:52:16 +0100
Message-ID: <4d8e3fd30801080452g71c3d3dx39f2ec805239ef01@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 08 13:52:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCDwk-0008Tf-EE
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 13:52:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184AbYAHMwT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 07:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752605AbYAHMwS
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 07:52:18 -0500
Received: from nz-out-0506.google.com ([64.233.162.230]:40702 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575AbYAHMwS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 07:52:18 -0500
Received: by nz-out-0506.google.com with SMTP id s18so1796734nze.1
        for <git@vger.kernel.org>; Tue, 08 Jan 2008 04:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=6hwQHUO0hHI4Neh5Tl8kJ4k1A+GTO44NMKkP3yKqLps=;
        b=vOorn+ZJWJvuSWxw4Md7KhHytVsfOA6FMa8iq4KTlvx0wNSf//jrRzuzs3EQokzyeS2N3WaH93eM4by8QAWB99IMKwK2/HJGYbBJUYfbClvww7XJzr9HhpTOcEGVYWvMUdVw18zX4M6ulQn3rd3HSaUtXJAESv9Ond2hUKOzr9o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=FGOHD8/Oseq2003mzR7A3oQ9MkkBhNH1g84KLCxYzXgWSxqhaLkMoPbK+y5rX231UVZvYvm6yQ2GYOg57WjQM8T0cf2ZWSblRPnsq0dLlql2sQcLcjMEzNOBwCR10zab7iJ6NpCYK0dit9lkJu4JHUNPL/Kb2+FNgi5S8G+4QyY=
Received: by 10.142.106.18 with SMTP id e18mr156247wfc.33.1199796736486;
        Tue, 08 Jan 2008 04:52:16 -0800 (PST)
Received: by 10.143.162.9 with HTTP; Tue, 8 Jan 2008 04:52:16 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69872>

Hi all,
I'm going to experiment the git-send-email command quite soon and I
have a doubt
that I would like to clarify.

I'm used to the following work flow:
- git branch trivial
- git checkout trivial
- work work work
- git gui to commit all the changes
- git-format-patch -n -o /home/paolo/patches
- open the MUA
- write the cover letter
- import the N patches
- send all the patches
- collect feedback
- work work work
- git rebase -i
- back to the git gui to commit all the changes line


This is working fine but since I'm going to push out a queue of patches
it would be nicer to script everything with git-send-email.

I know I have to configure git in order to use the gmail's smtp server,
I know how to tell git-send-email where to pick up the patches but I fail
to understand how I can write a cover letter and let it be part of the patch
queue.

Any hint?

Thanks in advance.
-- 
Paolo
http://paolo.ciarrocchi.googlepages.com/
