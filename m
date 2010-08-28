From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Git-SVN & subdirectory branches
Date: Fri, 27 Aug 2010 20:45:08 -0500
Message-ID: <20100828014508.GC2004@burratino>
References: <F393D37F-9BDE-4F29-94E9-806AF88D1A30@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Wong <normalperson@yhbt.net>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Sat Aug 28 03:47:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpAVq-0002ax-ES
	for gcvg-git-2@lo.gmane.org; Sat, 28 Aug 2010 03:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752596Ab0H1Bq6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Aug 2010 21:46:58 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33447 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752350Ab0H1Bq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Aug 2010 21:46:57 -0400
Received: by iwn5 with SMTP id 5so3107852iwn.19
        for <git@vger.kernel.org>; Fri, 27 Aug 2010 18:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Xi55BTmiLYyD5PTstaFhdjX4ZPDcol6afbQe1y7gDpI=;
        b=MU+SbLgRYX26e6/2DBRyXZSkD6mb1vEN3xR6fpuBJA1xArV4hh3XrEcX/+YFqlrz+a
         TmjNqrS6HzxEfMGMMjclMdYVTcsUI3BMb4i1ijtwLk9lgX+Jw1KYDatOFsz4pSuoHNh6
         fHRIDl8kCcvieQRzpYOo/dZDv8suflmReGCPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ZNCTsYM7JMlcj3zQWOyCBV6EkLGkyGdm38mKazkn8hbcmKSwKdCjbW9hZR1AQz2cA6
         rXXtEQyhF0vBi9ujw2M6F0ZT2EPwTSEIWhUWO5k4pf8DJrxxmmg4Dk++BSqak4DBS2qf
         kXWYbk/0BdVV8+nehGcUzRL3/xg5lDa7DxPQg=
Received: by 10.231.192.80 with SMTP id dp16mr2055128ibb.39.1282960016700;
        Fri, 27 Aug 2010 18:46:56 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id h8sm4234670ibk.15.2010.08.27.18.46.55
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 27 Aug 2010 18:46:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <F393D37F-9BDE-4F29-94E9-806AF88D1A30@gernhardtsoftware.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154626>

Hi,

Brian Gernhardt wrote:

> For visual learners:
> 
> /trunk
>   /bigports
>   /src
>     /boot
>     /commands
>     ...
> /branches
>   /R3.1.0
>     /bigports
>     /src
>   /R3.1.7
>     /boot
>     /commands
>     ...

Right, I don't think git svn has any logic for this.  If you want to track
branches like R3.1.7 keeping the layout of trunk, you'll have to patch
git svn.
