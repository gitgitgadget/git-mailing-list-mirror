From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] shell: new no-interactive-login command to print a
 custom message
Date: Sat, 9 Mar 2013 21:21:06 -0800
Message-ID: <20130310052106.GA7289@elie.Belkin>
References: <CAE_TNikk-9sYVRQRwRecNpp3otQ+oc=uV9SPu+7pAkCUNbcUoQ@mail.gmail.com>
 <20130309215237.GA24777@elie.Belkin>
 <20130309220011.GC24777@elie.Belkin>
 <7v38w3etfw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ethan Reesor <firelizzard@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Brockman <gdb@mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 10 06:21:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEYhe-0003vu-IZ
	for gcvg-git-2@plane.gmane.org; Sun, 10 Mar 2013 06:21:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872Ab3CJFVR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 00:21:17 -0500
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52176 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750815Ab3CJFVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 00:21:16 -0500
Received: by mail-pb0-f46.google.com with SMTP id uo15so2591997pbc.5
        for <git@vger.kernel.org>; Sat, 09 Mar 2013 21:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=f4NhomoLHSiTKzUadcRvBtwwcPse9gPkK0NPU2MhP9o=;
        b=gVksf1SBOUHrlU2IykRWkR403zjrdZXt0t55gCQ8gsVUTiw4sTu/ZYe0PxwEkJ52ui
         WIw6kifFA/2d4UkRltiFJxV7GJtPU5zTMUXVBmWQ/6WYznbcz+n3fQKuPyPXMUi006wn
         awI4WXN/tC5WKvccXqz/0NsCcNxMBftUvy1VhJ3fkLDozGkJDL94ajZIHd6aOC/5isO/
         t4ZN7xrmHCKmwTOFLt6pOS/VLTea/hZfgrCkHbtKucjLxLivpi78OPlfUOmaYO9eVtTW
         FFbBRLQiyWa9KL3YZIrOAdOnZoOB50my7dCn14uU3wlgjmU7EAhBETHX9HCSO2kURKKo
         4zlA==
X-Received: by 10.68.204.234 with SMTP id lb10mr17105646pbc.64.1362892875904;
        Sat, 09 Mar 2013 21:21:15 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id ol7sm13643622pbb.14.2013.03.09.21.21.13
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 09 Mar 2013 21:21:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7v38w3etfw.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217779>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> If I disable git-shell's interactive mode by removing the
>> ~/git-shell-commands directory, attempts to use 'ssh' in produce a
>> message intended for the administrator:
>
> Sorry, but -ECANTPARSE.  s/in produce/produces/ perhaps?  Or if you
> meant "ssh in" as a verb, then "attempts to ssh in to the service
> produces a message".  I dunno.

Sloppy of me.  Yes, it should say something like this:

	If I disable git-shell's interactive mode by removing the
	~/git-shell-commands directory, attempts to ssh in to the service
	produce a message intended for the administrator:
