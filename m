From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/4] fmt-merge-msg: Update fmt-merge-msg and
 merge-config documentation
Date: Fri, 20 Aug 2010 20:30:21 +0530
Message-ID: <20100820150019.GF9448@kytes>
References: <1282307041-19681-1-git-send-email-artagnon@gmail.com>
 <1282307041-19681-4-git-send-email-artagnon@gmail.com>
 <20100820123935.GB9448@kytes>
 <4C6E78CB.1090907@viscovery.net>
 <20100820131218.GC9448@kytes>
 <20100820141035.GD16190@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>,
	Yaroslav Halchenko <debian@onerussian.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 20 17:02:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmT72-0002mC-UB
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 17:02:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752475Ab0HTPCK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 11:02:10 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:35674 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752200Ab0HTPCJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 11:02:09 -0400
Received: by pzk26 with SMTP id 26so1256127pzk.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 08:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=REKIWhUzAuweDW+/82SNFcKVT6rbb2hUPG1mPa0mecY=;
        b=Xg/XIKkmjTySI2Wt7HjkSY7j3t6OtyYEWYDHW/43okBS3If1jNusGByTG5UiHGfLST
         sRCqU8MzPdS4ezvd1JbB+ZC7gk/7QYBqhY1MdIRrFwMu2NM6T7fwePzWuuwymi0OkDUU
         X5xZP8TXqB4CWiufPN1pQE6x/3pmVTY2okRCI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=WmEZuZrQZ33+8sNxiRAU9afK0MfawdVAp6v87+n71sGNcE/iNOnJFnX9Eq4hhEuJoj
         LInGEdrBSnAxpDBWKoH17ji8WhTHK4fQ27KcpBzeOEBB9ottBUif17e00nOYT2QYWVQy
         8T8OPMP4vUyex/RAOfrPudWn3GomDvLQakCvs=
Received: by 10.114.126.2 with SMTP id y2mr1644635wac.57.1282316529212;
        Fri, 20 Aug 2010 08:02:09 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id s5sm5044749wak.0.2010.08.20.08.02.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 08:02:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100820141035.GD16190@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154048>

Hi Jonathan,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
> 
> > I noticed that the command-line parsing framework has only OPT_BOOLEAN
> > and OPT_INTEGER, but no OPT_BOOLEAN_OR_INTEGER.
> 
> --no-<foo> works already with OPT_INTEGER.  But for --<foo>, one
> needs the
> 
>  { OPTION_INTEGER, short, long, &var, "n", description,
>    PARSE_OPT_OPTARG, NULL, 20 },
> 
> form.

Thanks, I'll re-roll with this fix.

-- Ram
