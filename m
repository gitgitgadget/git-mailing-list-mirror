From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Oddities cloning over http
Date: Wed, 11 Apr 2007 00:40:48 +1200
Message-ID: <46a038f90704100540y33c64a9au762fd927fb906f3d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 10 17:50:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbFeb-0005ww-DV
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 14:40:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965388AbXDJMku (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 08:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965418AbXDJMku
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 08:40:50 -0400
Received: from wx-out-0506.google.com ([66.249.82.224]:3982 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965388AbXDJMkt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 08:40:49 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1865940wxd
        for <git@vger.kernel.org>; Tue, 10 Apr 2007 05:40:48 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=t7N6zsv9zEoVGhCzEZT0vR3oMVHS87Pl8tmDvZBskL6NuaAfi2l7SYjkxgJ8Tkmc2+JmXyEqW11WQUxlEx0bQPuOIPEig6NFTmdlh5gV356Bmouhy4Kj4VeINUtuWZ94Nu47106FB7de6ggbVWgMhc+V3gC/sN1qUv4qnNQDSvk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Yd3Dxv+tDrp6DjgRRLCeAEDGJJnxwOVHY8325e0At+JLcBwXHLupxVrpigSAW4Q0Z2GTo0lStPOBVu+LlzLFvwaIzaKteC+Vb9vPpk+tiYEIFYiS4haTALTOdFyjdNC0rvYqb/kAEl1MYHbvVrEtqC072/O33lSVDHQNzfR+M6E=
Received: by 10.90.90.16 with SMTP id n16mr5116648agb.1176208848247;
        Tue, 10 Apr 2007 05:40:48 -0700 (PDT)
Received: by 10.90.120.11 with HTTP; Tue, 10 Apr 2007 05:40:48 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44126>

Cloning over http this repo, using git v1.5.0.5 and v1.5.1.106.ga32037

  http://git.catalyst.net.nz/git/moodle-r2.git

The clone doesn't complete successfully.

 - I don't get a checkout
 - It never creates .git/branches/origin
 - It never creates .git/refs/heads/master

OTOH, it does fetch all the packfiles, and creates all the refs for
the remote branches under .git/refs/remotes/origin/

hmmm...? I did run git-update-server-info on the server...


martin
