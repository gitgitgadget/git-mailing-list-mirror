From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC] Possibility to choose ~/.config/git/config instead of ~/.gitconfig
Date: Sat, 26 May 2012 12:45:52 +0200
Message-ID: <CAMP44s32GKrmXDND3_iO6CTOgHTfeuBeXYEOjcET5bBZ067pFQ@mail.gmail.com>
References: <20120525181526.Horde.VibLf3wdC4BPv7AeKacSMiA@webmail.minatec.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, matthieu.moy@grenoble-inp.fr,
	Valentin DUPERRAY <Valentin.Duperray@phelma.grenoble-inp.fr>,
	Franck JONAS <Franck.Jonas@phelma.grenoble-inp.fr>,
	Lucien KONG <Lucien.Kong@phelma.grenoble-inp.fr>,
	Thomas NGUY <Thomas.Nguy@phelma.grenoble-inp.fr>,
	Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@phelma.grenoble-inp.fr>
To: nguyenhu@minatec.inpg.fr
X-From: git-owner@vger.kernel.org Sat May 26 12:46:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYEVT-0000yA-9E
	for gcvg-git-2@plane.gmane.org; Sat, 26 May 2012 12:45:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546Ab2EZKpz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 May 2012 06:45:55 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:51163 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752440Ab2EZKpy (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 May 2012 06:45:54 -0400
Received: by lahd3 with SMTP id d3so1144130lah.19
        for <git@vger.kernel.org>; Sat, 26 May 2012 03:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vjikuE3un317pysOR7tSQcE1w9SWXwb2TdyNcRzafvQ=;
        b=Dy5av3JRrX+JbzHKNrxzXLsa1gI+5CS9LJArGDLbAbDarGmP4cEw9j1GpYHUAVPij0
         fRCTNhPqYciqSI42FBtdtiEJ97jsBMnvVwl5xoa6Mr3YUG7eYC/1u4r6n/4Tfkf2yLHf
         ZjFHQCuvYB+pK14S2SqlxbNl8V+tgz3jJM0xUVT5z4sUpjgLSNj2cj2ef0G6ufqLNelo
         R4hw/8yk2iUjJoEV87GmMIq06ctVVGQZOw4wkobZJjCQxfxbFltyyoKAoz/JvJeieiRO
         kBJ3gK2ASuYMa5aoBbDhogXf1waobJ2e9AvUOhdsxXbpQNxFJBoSkQb7tnO71Hx2FMfu
         f/OA==
Received: by 10.152.108.38 with SMTP id hh6mr1976789lab.28.1338029152923; Sat,
 26 May 2012 03:45:52 -0700 (PDT)
Received: by 10.112.107.65 with HTTP; Sat, 26 May 2012 03:45:52 -0700 (PDT)
In-Reply-To: <20120525181526.Horde.VibLf3wdC4BPv7AeKacSMiA@webmail.minatec.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198551>

On Fri, May 25, 2012 at 6:15 PM,  <nguyenhu@minatec.inpg.fr> wrote:

> As you know, git stores its configuration in ~/.gitconfig file and in other
> hidden files at the root of the user's directory.
>
> We would like to have a configuration directory instead of all these
> configuration files by following the XDG specification because:
> - not a lot of hidden files at the root, so better view
> - one directory per software in ~/.config
>
> We would like to give to users the possibility to store configuration in
> ~/.config/git/config file.

I like this, but it shouldn't be "~/.config", it should be $XDG_CONFIG_HOME.

-- 
Felipe Contreras
