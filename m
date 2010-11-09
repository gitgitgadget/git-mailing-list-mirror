From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: first para of man gitignore should refer to 'git rm --cached'
Date: Tue, 9 Nov 2010 13:29:13 -0600
Message-ID: <20101109192913.GA21320@burratino>
References: <AANLkTim=QCcJDb0600Je-jePvXSXfFMe7FAQ0WMhZKn7@mail.gmail.com>
 <20101107191425.GA32302@kytes>
 <AANLkTinznLY3M4z7k-WeeFhGSR1xWHXj_zOrwMvZDfLQ@mail.gmail.com>
 <7vbp5zpo2d.fsf@alter.siamese.dyndns.org>
 <AANLkTimwNtih94GENv=RqTCYtTWC7koLV_=WTX-B3MDu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 09 20:29:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFtsx-0005qs-Mz
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 20:29:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753621Ab0KIT3f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 14:29:35 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:47862 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972Ab0KIT3e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 14:29:34 -0500
Received: by vws13 with SMTP id 13so3427304vws.19
        for <git@vger.kernel.org>; Tue, 09 Nov 2010 11:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=JDVGLHfimgBiE3122BsVv95y4uPGEN9MFInsQ322Tmc=;
        b=GQxoUmKzsA8h7kJmyB3QmRCvKbbx9sR4MiFP4VlstZh1ddZypPXlp5Esbr/gDpGBNv
         uIRw8XeDWK554+2mQoG9wJxghC5lsGpt7tciFWhc5SHuiRsZgqHdhbth6D9aBE11Ydqm
         PrPnJOf/b8kB4tphytpiP1Mm/KVKFDdMjY2Cc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=b4loozrdVsOAQTMObxoAA37k23w2fYGsOJurl2TFQ01hI02Pw9WM+8abmkM5qutSZv
         Mdv9Z+iAV9GLp9GLDYVJyYjCU7bQJvNuU6VxTmb0McMHVa9nfX2Fm7C/iuTEbgaIwSw+
         JwVyTl6OQFzoJZteBcLURym4opwHWwOq77u6M=
Received: by 10.223.102.79 with SMTP id f15mr5473805fao.134.1289330972534;
        Tue, 09 Nov 2010 11:29:32 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id l23sm888992fam.19.2010.11.09.11.29.30
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 09 Nov 2010 11:29:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTimwNtih94GENv=RqTCYtTWC7koLV_=WTX-B3MDu@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161067>

Sitaram Chamarty wrote:

> Perhaps it's the difference between the folks that come to #git and
> those that come to the mailing list.
> 
> But case closed I guess...

Case closed?  I thought you were suggesting an enhancement to the
manual page, to answer the following question (frequently asked or
not):

	If git is already tracking a file, how can I tell git
	it is not supposed to be tracked any more?

And perhaps a bonus question:

	What will happen when I switch between revisions in
	which the file is tracked and not tracked?

I think at least an EXAMPLES section explaining this would be would
be nice.
