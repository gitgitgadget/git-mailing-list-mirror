From: Marco Maggesi <marco.maggesi@gmail.com>
Subject: New to git
Date: Fri, 8 Apr 2011 21:43:09 +0200
Message-ID: <BANLkTimy-95OJGxU9XzcaR=0jTJWXOwsDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 08 21:43:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8HaO-0007fG-Ri
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 21:43:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757778Ab1DHTnL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 15:43:11 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:62743 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756811Ab1DHTnK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2011 15:43:10 -0400
Received: by qyg14 with SMTP id 14so2721937qyg.19
        for <git@vger.kernel.org>; Fri, 08 Apr 2011 12:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=PesjdMclYu62M4MfdoDKAA/WgPOuTLbewhVL5Q4NChQ=;
        b=VkZLlg1NNMbxTWD/Z4zLkBRsFBlgE41al7Sm2v87odps+o/XGfyLXYjOPS7w/y3yuW
         ClyIuhVQrsVAhShYLZQOi8eS9f8kCg3Pfue+MgiNLqb2Dty2tQeigbVWl/JNavEHyq2E
         hmYdDQezIYwHEarFFflNogXFjfeYoNSFQbcms=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=res6jb8i7+Vr+yhqzBAkbDSLKV5uV9cfNHMQQO6xzXDINNDtjFo6S8K8R7I/klNaUG
         /+gop2YYV0HlNRdolNFRvwe5qexL5XcFKdul+KXyHm1YuJZ8W+jGCdCoeww3mMiBIaHn
         6SSKkJGZN8wz4SEk42OxCQvUJhUuxYP4RkWd8=
Received: by 10.224.192.4 with SMTP id do4mr2020491qab.241.1302291789059; Fri,
 08 Apr 2011 12:43:09 -0700 (PDT)
Received: by 10.224.208.6 with HTTP; Fri, 8 Apr 2011 12:43:09 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171149>

Hi,
I'm considering to use git to track my sources.
So far I was able to use git on a single machine and play with its
basic features.

Now I would like to setup a repository on a server and use it as a
central point of distribution for a few other computers.
As far as I can understand, the default mechanism for push / pull
requires that git is installed on every machine, including the server.

My problem is that I can hardly install git on the server for several
reasons that I will not explain here (also I'm not the administrator
of the server).
So I am looking for other solutions.

For the moment I came only to the following idea: mount the remote
repository via fuse-ssh and use the local installation of git to push
/ pull changes.
Surely it is inefficient but I don't care too much (my repositories
are small enough I think).
Can you see other drawbacks of this solution?

Also I wonder if other kind of synchronizations are possible (rsync,
unison, ...).

Are there other obvious solutions that I'm missing?

Thanks,
Marco
