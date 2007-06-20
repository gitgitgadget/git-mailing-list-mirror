From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Debugging strange "corrupt pack" errors on SuSE 9
Date: Wed, 20 Jun 2007 14:36:26 +1200
Message-ID: <46a038f90706191936m121a94e4x1e59dff4fe217988@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>,
	jonathan.newman@catalyst.net.nz
X-From: git-owner@vger.kernel.org Wed Jun 20 04:36:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0q3Y-0005qw-I6
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 04:36:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759019AbXFTCg1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 22:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759133AbXFTCg1
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 22:36:27 -0400
Received: from wx-out-0506.google.com ([66.249.82.232]:40975 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758366AbXFTCg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 22:36:26 -0400
Received: by wx-out-0506.google.com with SMTP id t15so38769wxc
        for <git@vger.kernel.org>; Tue, 19 Jun 2007 19:36:26 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=fOLkdnyP3XY3rnoiTu0WwMeE6gXV/Cvr0l3wBACBMYwFVyUkMK/FRPHsk4/TvZDOG00XjQTCyZBNO/KKflR0tW38lmmfFHaOzxt3/Lrc1DxJp//zXkcibOPgf+HUT4P7kGCNvXEDdJaZR3/vWAIxSA6zIjOTUuO7Yq2jIu2h58A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=eYxikIUQSXolhcC3Jpon4Pp3Ns/ZPz6eRQ5XlRAgwmmoJl0q5CNtAs/zOY7+0mTmjf1JqFjcOmESg7hHw7rFZCaWUxTN5OUH4tVGqvp3Z4Z+qW4cUhmMiRwqhODtbyQ9KzVniSA27VPV0NsLkEpg3ekeaFLlSV8tNixnEs6RGwA=
Received: by 10.90.113.20 with SMTP id l20mr16908agc.1182306986213;
        Tue, 19 Jun 2007 19:36:26 -0700 (PDT)
Received: by 10.90.52.9 with HTTP; Tue, 19 Jun 2007 19:36:26 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50522>

A colleage at work is using git to manage code updates to a heavily
firewalled machine at a client site. In a nutshell, we "push" the
interesting code to a repo on usb-stick, and we pull from it on the
client's machine.

We do some coding and testing on that machine, so ocassionally we
bring some patches back.

Now the working repo on the client machine has started to die with
"corrupt pack" errors. I am trying to get my hands on the literal
error messages, and exact software versions installed. Right now all I
know is that it is SuSE 9 x86, git 1.4.x, cogito .17.x . The error
appears on git-diff, git-fsck-objects --full

We did bring a copy of the working copy with the "corrupt pack" to our
office, and here git (v1.5.1 and 1.5.2) thinks it's perfectly well.

So I am a bit puzzled - while we try to get 1.5.x on the client
machine and see what happens, is there anything that could be causing
this? Any additional tests that we should run?

cheers,


martin
