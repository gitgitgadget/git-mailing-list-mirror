From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Fixing a broken GIT repo
Date: Fri, 18 Nov 2011 14:54:46 +0200
Message-ID: <CAMP44s2N3WU_vzW9+7cRm+kvKGsoaMbhtuoX6yuNx58EixTkqw@mail.gmail.com>
References: <ja5dgo$nlf$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Bart van den Burg <bart@burgov.nl>
X-From: git-owner@vger.kernel.org Fri Nov 18 13:54:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRNy1-0002y0-AS
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 13:54:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756867Ab1KRMys (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Nov 2011 07:54:48 -0500
Received: from mail-pz0-f42.google.com ([209.85.210.42]:63825 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755940Ab1KRMyr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2011 07:54:47 -0500
Received: by pzk36 with SMTP id 36so5869145pzk.1
        for <git@vger.kernel.org>; Fri, 18 Nov 2011 04:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Ry53AR9s01aCjEdFFMEVWiN/n7bmRjiKIdMrL53qhQo=;
        b=sp2dBm86wROXIp+q0k1UdpRZ4bW8UuG1pOlF/2O6rMlR1sDu3aF9FWOEdFQib4O8Si
         NDcRpyVe99H3a5hA/GFXlkropvO4LNZC463K4C3idx4dWrbYZGtb9BqPOpa6IHFmcaYk
         SOABkb7QxQSOgvgbgb/HdyebelbMydKuPSvHI=
Received: by 10.68.72.168 with SMTP id e8mr9281471pbv.127.1321620886920; Fri,
 18 Nov 2011 04:54:46 -0800 (PST)
Received: by 10.68.58.38 with HTTP; Fri, 18 Nov 2011 04:54:46 -0800 (PST)
In-Reply-To: <ja5dgo$nlf$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185656>

On Fri, Nov 18, 2011 at 12:54 PM, Bart van den Burg <bart@burgov.nl> wrote:
> Needless to say, the mentioned object in fact does exist on the server:
> git@server:~/shifter_rai.git$ ls -la
> objects/85/d1ee957c65485ed9c937a4f1bfdd44fda4ea35
> -r--r--r-- 1 git git 153 Nov 18 11:39
> objects/85/d1ee957c65485ed9c937a4f1bfdd44fda4ea35
>
> Can anyone tell me what is happening here, and how I can fix it?

Well, if you can't find that object on the server or your local box,
then you would have to find the last commit that worked, and reset the
'master' branch to that.

-- 
Felipe Contreras
