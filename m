From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 01/18] (trivial) notes.h: Minor documentation fixes to
 copy_notes()
Date: Tue, 5 Oct 2010 10:26:51 -0500
Message-ID: <20101005152651.GF12797@burratino>
References: <1285719811-10871-1-git-send-email-johan@herland.net>
 <1285719811-10871-2-git-send-email-johan@herland.net>
 <20101005145543.GD12797@burratino>
 <201010051722.21081.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, bebarino@gmail.com, gitster@pobox.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Oct 05 17:30:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P39TC-00029N-PF
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 17:30:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754465Ab0JEPaO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 11:30:14 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60263 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754366Ab0JEPaM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 11:30:12 -0400
Received: by fxm4 with SMTP id 4so477763fxm.19
        for <git@vger.kernel.org>; Tue, 05 Oct 2010 08:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=IJNe91rFbfw4vi4mq//Rhj6LKbARztdP4JeVj8FEyj0=;
        b=o6Lx/RCR7MJyZ+3V2FOdeeOqDc82wDfHQzPiY68hsVyuwKyHC7ht3lcVWp/Qq1zd5W
         HIeqwhab+hF5zJtixbW09IbgL37KbINxDOe8eucI3ZnnmMpKU4qMUKEtViXTes4obkF5
         w8/1K5LgdeQeDLD0XNPNEiixON7Wl1VT9CTO8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=VdQiRzQqoDDu+1i/OCvqZZgZszF0AdMOR7nOzL67IOJF4JE1oCgY5GeRFkIIr2nYbg
         3sRRwuJP7ZEAlP2YUommhN9v4xkOTNYMGq5zYVo2Q8qed0q92Yl0KvV9jvpKInEFapai
         crT9bOOjQkNUOJw77hIsTEeBHYGZ/YjJNrHtE=
Received: by 10.223.106.204 with SMTP id y12mr2699127fao.9.1286292611640;
        Tue, 05 Oct 2010 08:30:11 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id j14sm2950061faa.23.2010.10.05.08.30.09
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 05 Oct 2010 08:30:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201010051722.21081.johan@herland.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158204>

Johan Herland wrote:

> I thought studying the notes.h file and its comments was a sufficient
> introduction on how to work with notes in code.

Yeah, I took most of the explanation from notes.h.  But it can be nice
to have the high-level "here are the functions you have to call"
information in one place without hunting around for it.

> This looks like a good start.

Thanks.
