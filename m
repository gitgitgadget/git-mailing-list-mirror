From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git describe weird behaviour
Date: Wed, 10 Nov 2010 15:24:10 -0600
Message-ID: <20101110212410.GA13782@burratino>
References: <20101110010016.GC22105@genesis.frugalware.org>
 <7vaalhhstp.fsf@alter.siamese.dyndns.org>
 <20101110204034.GO22105@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Nov 10 22:24:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGIA4-0006MC-7A
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 22:24:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756920Ab0KJVYj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 16:24:39 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:53783 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756598Ab0KJVYf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 16:24:35 -0500
Received: by eye27 with SMTP id 27so728330eye.19
        for <git@vger.kernel.org>; Wed, 10 Nov 2010 13:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=P4xGcDXPleDi0btgvB1k2dthupwFd8PNOzQX2/zjfhw=;
        b=eDbCLoovwjDNkWy5ZqNTKXtZVUPtzXNhVkc+jg5LDIJswfYqy8i/LAnSyEpd/zPlSh
         Ulvs3lKwxStFVfWxevmaZGP9H0paOJobLSZhw0FuxW6jG4KTNb2cX8mOgBnR6z6By+7c
         cLbbAlzCftWOIegEFDEGIumyX3axB3W35d12s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=KeSGxLD2ZDAYLnh9z2jjr1n3hue9d1WU5FolY0QL7UTXQlXckPcktZptJSRcvsU6HH
         aXgOZ6w/sosmY2fRdzjdFzI8jmqqoJUY8z4zz+kufcDU6AmdOYzMwc53AHpXHdEOn/5N
         H9YhoQfFVFRWmMvak06k9aQPdtihvQd6SmVtg=
Received: by 10.216.176.20 with SMTP id a20mr8829047wem.14.1289424272848;
        Wed, 10 Nov 2010 13:24:32 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id p4sm773297wer.29.2010.11.10.13.24.30
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 10 Nov 2010 13:24:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101110204034.GO22105@genesis.frugalware.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161186>

Miklos Vajna wrote:

> But I think the approach to follow the first parent only would solve the
> problem outlined in the commit message of 80dbae0 as well: I think it's
> pretty rare to tag a commit in a feature branch, then merge it.

Doesn't that happen in linux-2.6 history fairly often (subsystem trees
syncing with upstream)?
