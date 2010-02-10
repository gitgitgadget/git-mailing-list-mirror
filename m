From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] blame: allow -L n,m to have an m bigger than the file's 
	line count
Date: Wed, 10 Feb 2010 14:51:58 -0500
Message-ID: <76718491002101151x20ff88aev8a5d2de806f71a73@mail.gmail.com>
References: <1265786864-5460-1-git-send-email-bebarino@gmail.com>
	 <76718491002100537h521fcc26gb267ed7cd2b8db6f@mail.gmail.com>
	 <7vwrykapfp.fsf@alter.siamese.dyndns.org>
	 <76718491002101139m4061fb90qcee7d34fca9f242f@mail.gmail.com>
	 <7v8wb098kv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 20:52:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfIbY-0001D4-R9
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 20:52:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755715Ab0BJTwA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 14:52:00 -0500
Received: from mail-iw0-f185.google.com ([209.85.223.185]:56012 "EHLO
	mail-iw0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847Ab0BJTv7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 14:51:59 -0500
Received: by iwn15 with SMTP id 15so431657iwn.19
        for <git@vger.kernel.org>; Wed, 10 Feb 2010 11:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=v4Ihr3pW+xMkp7PkkSKryMAEQmdikiRwwIKAxHCmPeY=;
        b=AgR3BvP96dCCekz+ubhyLYAJC0tM8S/ycC+QqQBQ+mGCxbkaLSbRhD+BHTo4Fc2bsO
         kkEwawRf3cxlxN+xx90OgKN9AY5xOFTazHIRnLvko21+6U6MRyvHTDgYewxb46owjiF6
         dKNOI2xq7c9qyUK37z4UiOThcCMumR9TItHTg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=ku5ig868RGF0Kf+fcVhzig9gruTE9jvIr/d+tUSwYOPibYtwqvxx2T+5Q7OcpNgcvQ
         j70QUJzCWB4cWLp4Rjbw54UAZL0rFeTCqEGFH2BrtJQLMeYz4rEAKbEzDXyUnzPv549t
         IrZjgYaG9KNq0M23go/KVEqYu5lmlC3Te6CEc=
Received: by 10.231.150.4 with SMTP id w4mr1212910ibv.58.1265831518926; Wed, 
	10 Feb 2010 11:51:58 -0800 (PST)
In-Reply-To: <7v8wb098kv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139540>

On Wed, Feb 10, 2010 at 2:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
> That is extremely sad.

For you, I'll see what I can do. I don't like the maintainer to be grumpy. :-)

j.
