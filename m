From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Out of memory error during git push
Date: Fri, 20 Aug 2010 09:50:11 -0500
Message-ID: <20100820145011.GF16190@burratino>
References: <20100820125119.GA9762@burratino>
 <23639398.583.1282314377177.JavaMail.root@hermes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
To: Thomas Jampen <jampen@kinet.ch>
X-From: git-owner@vger.kernel.org Fri Aug 20 16:52:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmSwy-0004d4-Dp
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 16:52:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753047Ab0HTOwA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 10:52:00 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42264 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849Ab0HTOv7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 10:51:59 -0400
Received: by iwn5 with SMTP id 5so913824iwn.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 07:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=c5f+kMS15uSKeaG5zKzUTSDv5LuVlER3LG0h5GhZ2rQ=;
        b=axKQ8co9wG+QyuLZ8UzgpHKQpMITBJuaeXO/cDEqpcM1f3OGHYqrYVoViLCu50u008
         dN7hMbsMN2rgi6DJw718aC1nB/1UqHk8nrEtfzQgqmaD7uMBqwKpzXqFSlOeAHR4JqfY
         mVcTzyFx+j0uA4c2Zjpdbgla9qz8WD2Cx7CPk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=WmDws9F8V0n5Dq8bnpAzhvW8jgNZwltfPR50kKcu86EA87D54kYu2WPvTQB4FCJ2gp
         Uft/u5TCMMrTHRBA7Io/DAnJtt8DbZbS4TFDqUL8svMVDrumdLYRzf+Ut01BYGREC1Zo
         I6BJfCPDpmfF8TfEaNr8i5ymiXCWmTf8xktvQ=
Received: by 10.231.39.195 with SMTP id h3mr1773028ibe.88.1282315918389;
        Fri, 20 Aug 2010 07:51:58 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id j2sm2676231iba.12.2010.08.20.07.51.57
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 07:51:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <23639398.583.1282314377177.JavaMail.root@hermes>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154047>

Thomas Jampen wrote:

> vm.overcommit_memory = 0
> 
> Do you propose to set this to '2' in order to disable overcommitting?

It might be interesting to try

 echo 1 >/proc/sys/vm/overcommit_memory

but 0 is generally the only sane setting.
