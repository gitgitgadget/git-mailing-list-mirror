From: Adam Monsen <haircut@gmail.com>
Subject: Re: [PATCH v4] Documentation fix: git log -p does not imply -c.
Date: Tue, 08 Mar 2011 12:46:33 -0800
Message-ID: <4D7695A9.8070403@gmail.com>
References: <7vsjuyzckd.fsf@alter.siamese.dyndns.org> <1299545378-22036-1-git-send-email-haircut@gmail.com> <7vmxl5e6ur.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 21:52:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Px3tY-0001ko-FO
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 21:52:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756495Ab1CHUwf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 15:52:35 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:50779 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755628Ab1CHUwe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 15:52:34 -0500
Received: by pvg12 with SMTP id 12so937410pvg.19
        for <git@vger.kernel.org>; Tue, 08 Mar 2011 12:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=0BPaqsvrivDBx1buWiQsUVXtIZJD/soNd0KEl95Pq3U=;
        b=VfvBW5UIGmQZDEHYCrkMzXhPI2jD46Vr9r2inh/X+MZrB/RHdjFEQQljMU2hHfppi1
         mzP5dBQg6dKj0/ox3TlpiZ4bE//tJtDj/0Se7u1bBUuiFt1IWNpzxgdOnJ3WkHf2ktw2
         vL/w3rF03JSttwstpUmVUsBu60BbB38WzVVDs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=VNqx7MXKb1K6EomU5wk6DOaFZNAv6IRZ3hCxVQ3dVV+9bH3WxdUa7eZsoB5gCTx1Af
         3bL9v3GAxOZSwxw79Yp0Hkabhlw/IJMAqtNhKYu0Gp9S/20Ep5sAJLlI0WK9c5rhbZE+
         7L+Zq6qK+RoDd0EGxl11CViLiSiD/BZcCFhbo=
Received: by 10.142.52.5 with SMTP id z5mr568768wfz.404.1299617198050;
        Tue, 08 Mar 2011 12:46:38 -0800 (PST)
Received: from [192.168.13.8] (c-67-183-136-182.hsd1.wa.comcast.net [67.183.136.182])
        by mx.google.com with ESMTPS id 25sm1444500wfb.10.2011.03.08.12.46.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 Mar 2011 12:46:37 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.15) Gecko/20110303 Lightning/1.0b2 Thunderbird/3.1.9
In-Reply-To: <7vmxl5e6ur.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168689>

Junio C Hamano wrote:
> Log messages should be sufficiently understandable offline without 
> having the web access.

Ok! Makes sense.

I read some stuff before writing it (like
Documentation/SubmittingPatches), but what I should have done is just
thumb through the log. Many commit messages are as you say they should be.

> Something like ...<snipped>... should be sufficient.

Thanks, I'll use that. It includes history and code details I didn't know.

This is good advice about how to fit in to the git community... would
you like a "commit message guide"? I did something like this for another
community (Mifos), and they found it helpful. Here's a rough draft:

-----------8<-----------

Commit message guide
====================

The suggested *format* of a commit message is covered in DISCUSSION in
git-commit(1). This guide covers philosophy of commit messages.

- Read previous commit messages. Emulate the best ones.
- Reveal your intentions.
- Answer questions you anticipate others will ask.
- Imagine you are reading this same commit message 10 years from now.
  What would be most helpful for you to quickly recall why these
  changes were made?
- Imagine someone else is reading this same commit message 10 years
  from now. What would be most helpful for them to quickly understand
  what this commit changes and why it was done?
- Commit messages should be sufficiently understandable without access
  to any online content.
- Be verbose!
- This is your chance to use time- and context-sensitive information
  relevant to code changed.
- Refer to related content.
  - other commits
  - mailing list discussions (but not in lieu of a proper description)

----------->8-----------

If you want a guide like this, some questions:
* do you want asciidoc, something else, or don't care?
* name it Documentation/CommitMessageGuide ? or something else?
