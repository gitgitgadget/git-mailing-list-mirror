From: Chris Packham <judge.packham@gmail.com>
Subject: ssh username environment variable
Date: Fri, 8 Jan 2010 15:24:12 -0500
Message-ID: <a038bef51001081224l33164526y51e5ca064b82b73a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 08 21:24:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTLNZ-0007H5-Mu
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 21:24:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752550Ab0AHUYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 15:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752437Ab0AHUYN
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 15:24:13 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:47175 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408Ab0AHUYN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 15:24:13 -0500
Received: by pwj9 with SMTP id 9so240784pwj.21
        for <git@vger.kernel.org>; Fri, 08 Jan 2010 12:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=7MdJ9KnSk59CFOdOzRGfZKMvv1CaSTegWS90gLAw1qc=;
        b=Uy7/BqFS2Do7krGwNjLfRmzyy/GZS6laJm1f11TLaQgfC2RwBVsVqmYQTn8L/uP6OX
         Y1U6c+HN72ax3n3oJz91FZuwvXQjVnBIwXB8suF2kfHWAqG4GY5WEzLISy6hNYjlfcw2
         AhUkYz1qnzsGPDm8qlqc7B91L7iy+RjE+DJ/o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=xT3CjcyjMZaiLiFyqq28+LSRAJxLD4eHzm8ZZmLChy4JP2OihiBAte55MBe8gyxBYj
         arRuR9XVC00j1iy7Qr+7wUGPxnG3D+v9U2WpoA73trVQDvB7Bt6rhBWpq1Uhrlec9zKg
         BWWnFrYudNR+Y+zGOU7Uek4j/y7IModoIdKBY=
Received: by 10.115.135.23 with SMTP id m23mr18964205wan.136.1262982252366; 
	Fri, 08 Jan 2010 12:24:12 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136470>

Hi List,

Just wondering if there is an environment variable I can use to tell
git or ssh what user name to use for the ssh transport?

I would normally use
  git clone ssh://myname@example.com/repo.git

but I'm cloning to a relatively public network drive  (corporate
overlords don't want git no mater what I say) so I want to do
something like
  GIT_SSH_USER=myname  git clone ssh://example.com/repo.git

So that my user name doesn't show in the resulting remote.origin.url

I know I can probably just remove my user name from the config after
the the fact but I have to do this for a few repos so I thought I'd
ask if there was a magic environment variable I could set.

Thanks.
