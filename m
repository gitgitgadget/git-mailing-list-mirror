From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] cache-tree: do not cache empty trees
Date: Wed, 16 Feb 2011 15:29:58 +0100
Message-ID: <201102161530.01017.jnareb@gmail.com>
References: <1296899427-1394-1-git-send-email-pclouds@gmail.com> <20110208043000.GA6375@elie> <20110215111926.5fdafa1d@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	"Dmitry S. Kravtsov" <idkravitz@gmail.com>,
	Shawn Pearce <spearce@spearce.org>
To: Yann Dirson <dirson@bertin.fr>
X-From: git-owner@vger.kernel.org Wed Feb 16 15:30:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpiOh-0000dm-Et
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 15:30:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755708Ab1BPOaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 09:30:20 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53875 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755658Ab1BPOaS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 09:30:18 -0500
Received: by fxm20 with SMTP id 20so1435980fxm.19
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 06:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=/sf5LHuzwakhfEKUcXGXdzz7lH4ztGtDYZyMXYwP0fY=;
        b=NDjV6l7EpwM+xbl0+dTRUO3PKsMn7M5rCBawMEZhPSMaI2zJBxjTheIdhTzNi5Anmv
         S5yq0SGHUVbTfi4tZ4YQM4zmYuUGdT98izel43AqJLYf7FgD7iTj64ANfMt0yB74luOs
         p6J5UvJje/QAIEK0npCxQZ8qpFM1iYtxZnkFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=o7TpuKv9O+pCxG6RPTaiVImy+bVurScbM96nEAWbb4WuGS/ZNSOo+IG1opBXFdHm6C
         fn69iu4A2aRyRMNEDwg8+eDE8XTf597zWqvekdyXYRjhMggGEe9DsaY5wvkqnIIVDuOT
         NmnaLMgzSh0qUYai3ruwDV8XIox5fLyTYTUOQ=
Received: by 10.223.78.135 with SMTP id l7mr815731fak.116.1297866613293;
        Wed, 16 Feb 2011 06:30:13 -0800 (PST)
Received: from [192.168.1.13] (abvl215.neoplus.adsl.tpnet.pl [83.8.209.215])
        by mx.google.com with ESMTPS id 11sm54590faw.20.2011.02.16.06.30.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Feb 2011 06:30:09 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20110215111926.5fdafa1d@chalon.bertin.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166966>

On Tue, 15 Feb 2011, Yann Dirson wrote:
> On Mon, 07 Feb 2011 22:30:00 -0600
> Jonathan Nieder <jrnieder@gmail.com> wrote:

> > For storage of empty subtrees in repos imported from svn, Yann's idea
> > of using .gitattributes somehow (maybe in the parent directory or
> > maybe in the subdir itself) seems oddly appealing.
> 
> In fact, I was mostly thinking about only using the
> toplevel .gitattributes, if only to avoid the same sort
> of clutter caused by the .gitignore-trick.

I was thinking about configuration variable (to keep or automatically
delete empty directories), overridable per-pathname basis with 
.gitattributes, similarly to 'eof' situation.

-- 
Jakub Narebski
Poland
