From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Adding a commit message to the index
Date: Sun, 19 Sep 2010 06:38:32 -0700 (PDT)
Message-ID: <m362y1luqg.fsf@localhost.localdomain>
References: <3347.4c955dd6.4a79e@getafix.xdna.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Cameron Hutchison <lists@xdna.net>
X-From: git-owner@vger.kernel.org Sun Sep 19 15:38:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxK6K-0004mo-O1
	for gcvg-git-2@lo.gmane.org; Sun, 19 Sep 2010 15:38:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754360Ab0ISNif (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Sep 2010 09:38:35 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:45881 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754304Ab0ISNie (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Sep 2010 09:38:34 -0400
Received: by wwb39 with SMTP id 39so2569604wwb.1
        for <git@vger.kernel.org>; Sun, 19 Sep 2010 06:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=1u1qZ7wgNeMQVCPlR5cubwfN+XvH5Z1XI2Xs0dkdWfM=;
        b=IrxCBrHbrLQxxO14eHhUI4YJqy6xZoSi5JetFTxlkJkVL5akQFXncZZrPl2BXIGwb2
         VXqYjtbJSbQ3ZMI1OhoAsgXaqdwUT4+XqyS3zhW0Q0Q3XHhN+00ly/Ir460fImj8ctfQ
         P/5F0PfZVEKlsTW47KbOyaogeYUB7491t53NA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=w79cR4cO9Q70tH04l7cnvaZjTappP5xu0otQ20pPAB5TN4SCrfnCKjvway+Ip7Z6rp
         j+bEbmvVnSoNQngf1DeM0tH0Aekc5CkaciHE3DHeAG1GveJIqiTOMoK3e8EqN0Xnxa0X
         968NrQcOYl0ebPSnPRGMZuVllURucKkmAv49o=
Received: by 10.227.128.19 with SMTP id i19mr761886wbs.104.1284903513531;
        Sun, 19 Sep 2010 06:38:33 -0700 (PDT)
Received: from localhost.localdomain (abwb127.neoplus.adsl.tpnet.pl [83.8.225.127])
        by mx.google.com with ESMTPS id m25sm4981792wbc.7.2010.09.19.06.38.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Sep 2010 06:38:32 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o8JDc2Ql026257;
	Sun, 19 Sep 2010 15:38:13 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o8JDbiXT026253;
	Sun, 19 Sep 2010 15:37:44 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <3347.4c955dd6.4a79e@getafix.xdna.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156496>

Cameron Hutchison <lists@xdna.net> writes:

> Is it possible to add a commit message to the index, and have it used as
> the final commit message, or as the template for the final commit
> message?
[...]

Why not use commit message templates?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
